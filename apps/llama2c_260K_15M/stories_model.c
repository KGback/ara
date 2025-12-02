#include "stories_model.h"
#include <stdlib.h>
#include <string.h>
#include "util.h"
#include "printf.h"
#include "memory.h"
#include "main.h"
#include <math.h>

int GS = 0; // group size global for quantization of the weights

void malloc_run_state(RunState* s, Config* p) {
    // we calloc instead of malloc to keep valgrind happy
    int kv_dim = (p->dim * p->n_kv_heads) / p->n_heads;
    s->x = (float *)            malloc(p->dim * sizeof(float));
    s->xb = (float *)           malloc(p->dim * sizeof(float));
    s->xb2 = (float *)          malloc(p->dim * sizeof(float));
    s->hb = (float *)           malloc(p->hidden_dim * sizeof(float));
    s->hb2 = (float *)          malloc(p->hidden_dim * sizeof(float));
    s->q = (float *)            malloc(p->dim * sizeof(float));
    s->key_cache = (float *)    malloc(p->n_layers * p->seq_len * kv_dim * sizeof(float));
    s->value_cache = (float *)  malloc(p->n_layers * p->seq_len * kv_dim * sizeof(float));
    s->att = (float *)          malloc(p->n_heads * p->seq_len * sizeof(float));
    s->logits = (float *)       malloc(p->vocab_size * sizeof(float));
    // ensure all mallocs went fine
    if (!s->x || !s->xb || !s->xb2 || !s->hb || !s->hb2 || !s->q
     || !s->key_cache || !s->value_cache || !s->att || !s->logits) {
        printf( "malloc failed!\r\n");
        exit(EXIT_FAILURE);
    }
}

void free_run_state(RunState* s) {
    free(s->x);
    free(s->xb);
    free(s->xb2);
    free(s->hb);
    free(s->hb2);
    free(s->q);
    free(s->att);
    free(s->logits);
    free(s->key_cache);
    free(s->value_cache);
}

void free_transformer(Transformer* t) {
    // close the memory mapping
    // if (t->data != MAP_FAILED) { munmap(t->data, t->file_size); }
    // if (t->fd != -1) { close(t->fd); }
    // free the RunState buffers
    free_run_state(&t->state);
}

void memory_map_weights_ST260K(TransformerWeights *w, int shared_weights) {
    // make sure the multiplications below are done in 64bit to fit the parameter counts of 13B+ models
    w->token_embedding_table                            = ST260K_weight_tok_embeddings;
    w->rms_att_weight                                   = ST260K_weight_attention_norm;
    w->wq                                               = ST260K_weight_wq;
    w->wk                                               = ST260K_weight_wk;
    w->wv                                               = ST260K_weight_wv;
    w->wo                                               = ST260K_weight_wo;
    w->rms_ffn_weight                                   = ST260K_weight_ffn_norm;
    w->w1                                               = ST260K_weight_1;
    w->w2                                               = ST260K_weight_2;
    w->w3                                               = ST260K_weight_3;
    w->rms_final_weight                                 = ST260K_weight_final_norm;
    w->wcls = shared_weights ? w->token_embedding_table : ST260K_weight_output;
}

void read_checkpoint_ST260K(Config* config, TransformerWeights* weights) {
    config->dim =           ST260K_DIM;
    config->hidden_dim =    ST260K_HIDDEN_DIM;
    config->n_layers =      ST260K_N_LAYERS;
    config->n_heads =       ST260K_N_HEADS;
    config->n_kv_heads =    ST260K_N_KV_HEADS;
    config->vocab_size =    ST260K_VOCAB_SIZE;
    config->seq_len =       ST260K_MAX_SEQ_LEN;
    int shared_weights = config->vocab_size > 0 ? 1 : 0;
    config->vocab_size = abs(config->vocab_size);
    memory_map_weights_ST260K(weights, shared_weights);
}

void build_transformer_ST260K(Transformer *t) {
    // read in the Config and the Weights from the checkpoint
    read_checkpoint_ST260K(&t->config, &t->weights);
    // allocate the RunState buffers
    malloc_run_state(&t->state, &t->config);
}


void memory_map_weights_ST15M(TransformerWeights *w, int shared_weights) {
    // make sure the multiplications below are done in 64bit to fit the parameter counts of 13B+ models
    w->token_embedding_table                            = ST15M_weight_tok_embeddings;
    w->rms_att_weight                                   = ST15M_weight_attention_norm;
    w->wq                                               = ST15M_weight_wq;
    w->wk                                               = ST15M_weight_wk;
    w->wv                                               = ST15M_weight_wv;
    w->wo                                               = ST15M_weight_wo;
    w->rms_ffn_weight                                   = ST15M_weight_ffn_norm;
    w->w1                                               = ST15M_weight_1;
    w->w2                                               = ST15M_weight_2;
    w->w3                                               = ST15M_weight_3;
    w->rms_final_weight                                 = ST15M_weight_final_norm;
    w->wcls = shared_weights ? w->token_embedding_table : ST15M_weight_output;
}

void read_checkpoint_ST15M(Config* config, TransformerWeights* weights) {
    config->dim =           ST15M_DIM;
    config->hidden_dim =    ST15M_HIDDEN_DIM;
    config->n_layers =      ST15M_N_LAYERS;
    config->n_heads =       ST15M_N_HEADS;
    config->n_kv_heads =    ST15M_N_KV_HEADS;
    config->vocab_size =    ST15M_VOCAB_SIZE;
    config->seq_len =       ST15M_MAX_SEQ_LEN;
    int shared_weights = config->vocab_size > 0 ? 1 : 0;
    config->vocab_size = abs(config->vocab_size);
    memory_map_weights_ST15M(weights, shared_weights);
}

void build_transformer_ST15M(Transformer *t) {
    // read in the Config and the Weights from the checkpoint
    read_checkpoint_ST15M(&t->config, &t->weights);
    // allocate the RunState buffers
    malloc_run_state(&t->state, &t->config);
}



// ----------------------------------------------------------------------------
// Quantization functions

void dequantize(QuantizedTensor *qx, float* x, int n) {
    for (int i = 0; i < n; i++) {
        x[i] = qx->q[i] * qx->s[i / GS];
    }
}

void quantize(QuantizedTensor *qx, float* x, int n) {
    int num_groups = n / GS;
    float Q_MAX = 127.0f;

    for (int group = 0; group < num_groups; group++) {

        // find the max absolute value in the current group
        float wmax = 0.0;
        for (int i = 0; i < GS; i++) {
            float val = fabs(x[group * GS + i]);
            if (val > wmax) {
                wmax = val;
            }
        }

        // calculate and write the scaling factor
        float scale = wmax / Q_MAX;
        qx->s[group] = scale;

        // calculate and write the quantized values
        for (int i = 0; i < GS; i++) {
            float quant_value = x[group * GS + i] / scale; // scale
            int8_t quantized = (int8_t) round(quant_value); // round and clamp
            qx->q[group * GS + i] = quantized;
        }
    }
}


/* initialize `n` x quantized tensor (with `size_each` elements), starting from memory pointed at *ptr */
QuantizedTensor *init_quantized_tensors(void *ptr_q, void *ptr_s, int n, int size_each) {
    void *ptr_q_ = ptr_q;
    void *ptr_s_ = ptr_s;
    QuantizedTensor *res = malloc(n * sizeof(QuantizedTensor));
    for(int i=0; i<n; i++) {
        /* map quantized int8 values*/
        res[i].q = (int8_t*)ptr_q_;
        ptr_q_ = (int8_t*)ptr_q_ + size_each;
        /* map scale factors */
        res[i].s = (float*)ptr_s_;
        ptr_s_ = (float*)ptr_s_ + size_each / GS;
    }
    return res;
}

void malloc_run_state_Q(RunState_Q* s, Config* p) {
    // we calloc instead of malloc to keep valgrind happy
    int kv_dim = (p->dim * p->n_kv_heads) / p->n_heads;
    s->x            = (float *) malloc(p->dim * sizeof(float));
    s->xb           = (float *) malloc(p->dim * sizeof(float));
    s->xb2          = (float *) malloc(p->dim * sizeof(float));
    s->hb           = (float *) malloc(p->hidden_dim * sizeof(float));
    s->hb2          = (float *) malloc(p->hidden_dim * sizeof(float));
    s->xq           = (QuantizedTensor) { .q = (int8_t *) malloc(p->dim * sizeof(int8_t)),        .s = (float *) malloc(p->dim * sizeof(float)) };
    s->hq           = (QuantizedTensor) { .q = (int8_t *) malloc(p->hidden_dim * sizeof(int8_t)), .s = (float *) malloc(p->hidden_dim * sizeof(float)) };
    s->q            = (float *) malloc(p->dim * sizeof(float));
    s->k            = (float *) malloc(kv_dim * sizeof(float));
    s->v            = (float *) malloc(kv_dim * sizeof(float));
    s->att          = (float *) malloc(p->n_heads * p->seq_len * sizeof(float));
    s->logits       = (float *) malloc(p->vocab_size * sizeof(float));
    s->key_cache    = (float *) malloc(p->n_layers * p->seq_len * kv_dim * sizeof(float));
    s->value_cache  = (float *) malloc(p->n_layers * p->seq_len * kv_dim * sizeof(float));
    // ensure all mallocs went fine
    if (!s->x || !s->xb || !s->xb2 || !s->hb || !s->hb2 || !s->q
     || !s->k || !s->v || !s->att || !s->logits || !s->key_cache
     || !s->value_cache) {
        printf("malloc failed!\r\n");
        exit(EXIT_FAILURE);
    }
}
// ST260K build transformer
void memory_map_weights_ST260KQ(TransformerWeights_Q *w, Config* p,  uint8_t shared_classifier) {
    int head_size = p->dim / p->n_heads;
    // first are the parameters that are kept in fp32 (the rmsnorm (1D) weights)
    w->rms_att_weight   = ST260K_Q_weight_attention_norm;
    w->rms_ffn_weight   = ST260K_Q_weight_ffn_norm;
    w->rms_final_weight = ST260K_Q_weight_final_norm;

    // now read all the quantized weights
    w->q_tokens = init_quantized_tensors(ST260K_Q_weight_tok_embeddings_q, ST260K_Q_weight_tok_embeddings_s, 1,p->vocab_size * p->dim);
    // dequantize token embedding table
    w->token_embedding_table = malloc(p->vocab_size * p->dim * sizeof(float));
    dequantize(w->q_tokens, w->token_embedding_table, p->vocab_size * p->dim);

    w->wq = init_quantized_tensors(ST260K_Q_weight_wq_q, ST260K_Q_weight_wq_s, p->n_layers, p->dim * (p->n_heads * head_size));
    w->wk = init_quantized_tensors(ST260K_Q_weight_wk_q, ST260K_Q_weight_wk_s, p->n_layers, p->dim * (p->n_kv_heads * head_size));
    w->wv = init_quantized_tensors(ST260K_Q_weight_wv_q, ST260K_Q_weight_wv_s, p->n_layers, p->dim * (p->n_kv_heads * head_size));
    w->wo = init_quantized_tensors(ST260K_Q_weight_wo_q, ST260K_Q_weight_wo_s, p->n_layers, (p->n_heads * head_size) * p->dim);
    w->w1 = init_quantized_tensors(ST260K_Q_weight_w1_q, ST260K_Q_weight_w1_s, p->n_layers, p->dim * p->hidden_dim);
    w->w2 = init_quantized_tensors(ST260K_Q_weight_w2_q, ST260K_Q_weight_w2_s, p->n_layers, p->hidden_dim * p->dim);
    w->w3 = init_quantized_tensors(ST260K_Q_weight_w3_q, ST260K_Q_weight_w3_s, p->n_layers, p->dim * p->hidden_dim);

    w->wcls = shared_classifier ? w->q_tokens : init_quantized_tensors(ST260K_Q_weight_output,ST260K_Q_weight_output, 1, p->dim * p->vocab_size);
}

void read_checkpoint_ST260KQ(Config* config, TransformerWeights_Q* weights) {
    config->dim =           ST260K_Q_DIM;
    config->hidden_dim =    ST260K_Q_HIDDEN_DIM;
    config->n_layers =      ST260K_Q_N_LAYERS;
    config->n_heads =       ST260K_Q_N_HEADS;
    config->n_kv_heads =    ST260K_Q_N_KV_HEADS;
    config->vocab_size =    ST260K_Q_VOCAB_SIZE;
    config->seq_len =       ST260K_Q_MAX_SEQ_LEN;
    int group_size; // the group size used in quantization
    group_size =            ST260K_Q_GROUP_SIZE;
    GS = group_size; // set as global, as it will be used in many places
    int shared_classifier = ST260K_Q_SHARED_CLASSIFIER;
    memory_map_weights_ST260KQ(weights, config, shared_classifier);
}

void build_transformer_ST260KQ(Transformer_Q *t) {
    // read in the Config and the Weights from the checkpoint
    read_checkpoint_ST260KQ(&t->config, &t->weights);
    // allocate the RunState buffers
    malloc_run_state_Q(&t->state, &t->config);
}

// ST15M build transformer
void memory_map_weights_ST15MQ(TransformerWeights_Q *w, Config* p,  uint8_t shared_classifier) {
    int head_size = p->dim / p->n_heads;
    // first are the parameters that are kept in fp32 (the rmsnorm (1D) weights)
    w->rms_att_weight   = ST15M_Q_weight_attention_norm;
    w->rms_ffn_weight   = ST15M_Q_weight_ffn_norm;
    w->rms_final_weight = ST15M_Q_weight_final_norm;

    // now read all the quantized weights
    w->q_tokens = init_quantized_tensors(ST15M_Q_weight_tok_embeddings_q, ST15M_Q_weight_tok_embeddings_s, 1,p->vocab_size * p->dim);
    // dequantize token embedding table
    w->token_embedding_table = malloc(p->vocab_size * p->dim * sizeof(float));
    dequantize(w->q_tokens, w->token_embedding_table, p->vocab_size * p->dim);

    w->wq = init_quantized_tensors(ST15M_Q_weight_wq_q, ST15M_Q_weight_wq_s, p->n_layers, p->dim * (p->n_heads * head_size));
    w->wk = init_quantized_tensors(ST15M_Q_weight_wk_q, ST15M_Q_weight_wk_s, p->n_layers, p->dim * (p->n_kv_heads * head_size));
    w->wv = init_quantized_tensors(ST15M_Q_weight_wv_q, ST15M_Q_weight_wv_s, p->n_layers, p->dim * (p->n_kv_heads * head_size));
    w->wo = init_quantized_tensors(ST15M_Q_weight_wo_q, ST15M_Q_weight_wo_s, p->n_layers, (p->n_heads * head_size) * p->dim);
    w->w1 = init_quantized_tensors(ST15M_Q_weight_w1_q, ST15M_Q_weight_w1_s, p->n_layers, p->dim * p->hidden_dim);
    w->w2 = init_quantized_tensors(ST15M_Q_weight_w2_q, ST15M_Q_weight_w2_s, p->n_layers, p->hidden_dim * p->dim);
    w->w3 = init_quantized_tensors(ST15M_Q_weight_w3_q, ST15M_Q_weight_w3_s, p->n_layers, p->dim * p->hidden_dim);

    w->wcls = shared_classifier ? w->q_tokens : init_quantized_tensors(ST15M_Q_weight_output,ST15M_Q_weight_output, 1, p->dim * p->vocab_size);
}

void read_checkpoint_ST15MQ(Config* config, TransformerWeights_Q* weights) {
    config->dim =           ST15M_Q_DIM;
    config->hidden_dim =    ST15M_Q_HIDDEN_DIM;
    config->n_layers =      ST15M_Q_N_LAYERS;
    config->n_heads =       ST15M_Q_N_HEADS;
    config->n_kv_heads =    ST15M_Q_N_KV_HEADS;
    config->vocab_size =    ST15M_Q_VOCAB_SIZE;
    config->seq_len =       ST15M_Q_MAX_SEQ_LEN;
    int group_size; // the group size used in quantization
    group_size =            ST15M_Q_GROUP_SIZE;
    GS = group_size; // set as global, as it will be used in many places
    int shared_classifier = ST15M_Q_SHARED_CLASSIFIER;
    memory_map_weights_ST15MQ(weights, config, shared_classifier);
}

void build_transformer_ST15MQ(Transformer_Q *t) {
    // read in the Config and the Weights from the checkpoint
    read_checkpoint_ST15MQ(&t->config, &t->weights);
    // allocate the RunState buffers
    malloc_run_state_Q(&t->state, &t->config);
}



void free_run_state_Q(RunState_Q* s) {
    free(s->x);
    free(s->xb);
    free(s->xb2);
    free(s->hb);
    free(s->hb2);
    free(s->xq.q);
    free(s->xq.s);
    free(s->hq.q);
    free(s->hq.s);
    free(s->q);
    free(s->k);
    free(s->v);
    free(s->att);
    free(s->logits);
    free(s->key_cache);
    free(s->value_cache);
}



void free_transformer_Q(Transformer_Q* t) {
    // close the memory mapping
    // if (t->data != MAP_FAILED) { munmap(t->data, t->file_size); }
    // if (t->fd != -1) { close(t->fd); }
    // free the RunState_Q buffers
    free_run_state_Q(&t->state);
}


void matmul(float* xout, float* x, float* w, int n, int d) {
    // W (d,n) @ x (n,) -> xout (d,)
    // by far the most amount of time is spent inside this little function
    int i;

    for (i = 0; i < d; i++) {
        float val = 0.0f;
        for (int j = 0; j < n; j++) {
            val += w[i * n + j] * x[j];
        }
        xout[i] = val;
    }
}

// =============================
//          Float
// =============================

float* forward(Transformer* transformer, int token, int pos) {

    // a few convenience variables
    Config* p = &transformer->config;
    TransformerWeights* w = &transformer->weights;
    RunState* s = &transformer->state;
    float *x = s->x;
    int dim = p->dim;
    int kv_dim = (p->dim * p->n_kv_heads) / p->n_heads;
    int kv_mul = p->n_heads / p->n_kv_heads; // integer multiplier of the kv sharing in multiquery
    int hidden_dim =  p->hidden_dim;
    int head_size = dim / p->n_heads;

    // copy the token embedding into x
    float* content_row = w->token_embedding_table + token * dim;
    memcpy(x, content_row, dim*sizeof(*x));

    // forward all the layers
    for(unsigned long long l = 0; l < p->n_layers; l++) {

        // attention rmsnorm
        rmsnorm(s->xb, x, w->rms_att_weight + l*dim, dim);

        // key and value point to the kv cache
        int loff = l * p->seq_len * kv_dim; // kv cache layer offset for convenience
        s->k = s->key_cache + loff + pos * kv_dim;
        s->v = s->value_cache + loff + pos * kv_dim;

        // qkv matmuls for this position
        matmul(s->q, s->xb, w->wq + l*dim*dim, dim, dim);
        matmul(s->k, s->xb, w->wk + l*dim*kv_dim, dim, kv_dim);
        matmul(s->v, s->xb, w->wv + l*dim*kv_dim, dim, kv_dim);

        // RoPE relative positional encoding: complex-valued rotate q and k in each head
        for (int i = 0; i < dim; i+=2) {
            int head_dim = i % head_size;
            float freq = 1.0f / powf(10000.0f, head_dim / (float)head_size);
            float val = pos * freq;
            float fcr = cosf(val);
            float fci = sinf(val);
            int rotn = i < kv_dim ? 2 : 1; // how many vectors? 2 = q & k, 1 = q only
            for (int v = 0; v < rotn; v++) {
                float* vec = v == 0 ? s->q : s->k; // the vector to rotate (query or key)
                float v0 = vec[i];
                float v1 = vec[i+1];
                vec[i]   = v0 * fcr - v1 * fci;
                vec[i+1] = v0 * fci + v1 * fcr;
            }
        }

        // multihead attention. iterate over all heads
        int h;
        
        for (h = 0; h < p->n_heads; h++) {
            // get the query vector for this head
            float* q = s->q + h * head_size;
            // attention scores for this head
            float* att = s->att + h * p->seq_len;
            // iterate over all timesteps, including the current one
            for (int t = 0; t <= pos; t++) {
                // get the key vector for this head and at this timestep
                float* k = s->key_cache + loff + t * kv_dim + (h / kv_mul) * head_size;
                // calculate the attention score as the dot product of q and k
                float score = 0.0f;
                for (int i = 0; i < head_size; i++) {
                    score += q[i] * k[i];
                }
                score /= sqrtf(head_size);
                // save the score to the attention buffer
                att[t] = score;
            }

            // softmax the scores to get attention weights, from 0..pos inclusively
            softmax(att, pos + 1);

            // weighted sum of the values, store back into xb
            float* xb = s->xb + h * head_size;
            memset(xb, 0, head_size * sizeof(float));
            for (int t = 0; t <= pos; t++) {
                // get the value vector for this head and at this timestep
                float* v = s->value_cache + loff + t * kv_dim + (h / kv_mul) * head_size;
                // get the attention weight for this timestep
                float a = att[t];
                // accumulate the weighted value into xb
                for (int i = 0; i < head_size; i++) {
                    xb[i] += a * v[i];
                }
            }
        }

        // final matmul to get the output of the attention
        matmul(s->xb2, s->xb, w->wo + l*dim*dim, dim, dim);

        // residual connection back into x
        for (int i = 0; i < dim; i++) {
            x[i] += s->xb2[i];
        }

        // ffn rmsnorm
        rmsnorm(s->xb, x, w->rms_ffn_weight + l*dim, dim);

        // Now for FFN in PyTorch we have: self.w2(F.silu(self.w1(x)) * self.w3(x))
        // first calculate self.w1(x) and self.w3(x)
        matmul(s->hb, s->xb, w->w1 + l*dim*hidden_dim, dim, hidden_dim);
        matmul(s->hb2, s->xb, w->w3 + l*dim*hidden_dim, dim, hidden_dim);

        // SwiGLU non-linearity
        for (int i = 0; i < hidden_dim; i++) {
            float val = s->hb[i];
            // silu(x)=x*σ(x), where σ(x) is the logistic sigmoid
            val *= (1.0f / (1.0f + expf(-val)));
            // elementwise multiply with w3(x)
            val *= s->hb2[i];
            s->hb[i] = val;
        }

        // final matmul to get the output of the ffn
        matmul(s->xb, s->hb, w->w2 + l*dim*hidden_dim, hidden_dim, dim);

        // residual connection
        for (int i = 0; i < dim; i++) {
            x[i] += s->xb[i];
        }
    }

    // final rmsnorm
    rmsnorm(x, x, w->rms_final_weight, dim);

    // classifier into logits
    matmul(s->logits, x, w->wcls, p->dim, p->vocab_size);
    return s->logits;
}

// ----------------------------------------------------------------------------
// generation loop

void generate(Transformer *transformer, Tokenizer *tokenizer, Sampler *sampler, char *prompt, int steps) {
    char *empty_prompt = "";
    if (prompt == NULL) { prompt = empty_prompt; }

    // encode the (string) prompt into tokens sequence
    int num_prompt_tokens = 0;
    int* prompt_tokens = (int*)malloc((strlen(prompt)+3) * sizeof(int)); // +3 for '\0', ?BOS, ?EOS
    encode(tokenizer, prompt, 1, 0, prompt_tokens, &num_prompt_tokens);
    if (num_prompt_tokens < 1) {
        printf( "something is wrong, expected at least 1 prompt token\r\n");
        exit(EXIT_FAILURE);
    }

    // start the main loop
    long start = 0;  // used to time our code, only initialized after first iteration
    int next;        // will store the next token in the sequence
    int token = prompt_tokens[0]; // kick off with the first token in the prompt
    int pos = 0;     // position in the sequence
    while (pos < steps) {

        // forward the transformer to get logits for the next token
        float* logits = forward(transformer, token, pos);

        // advance the state machine
        if (pos < num_prompt_tokens - 1) {
            // if we are still processing the input prompt, force the next prompt token
            next = prompt_tokens[pos + 1];
        } else {
            // otherwise sample the next token from the logits
            next = sample(sampler, logits);
        }
        pos++;

        // data-dependent terminating condition: the BOS (=1) token delimits sequences
        if (next == 1) { break; }

        // print the token as string, decode it with the Tokenizer object
        char* piece = decode(tokenizer, token, next);
        safe_printf(piece); // same as printf("%s", piece), but skips "unsafe" bytes
        
        token = next;

        // init the timer here because the first iteration can be slower
        if (start == 0) { start = time_in_ns(); }
    }
    printf("\r\n");

    // report achieved tok/s (pos-1 because the timer starts after first iteration)
    if (pos > 1) {
        long end = time_in_ns();
        printf( "Total tokens: %d ; Achieved tok/s: %f\r\n",(pos-1), (pos-1) / (double)(end-start)*1000000000);
    }

    free(prompt_tokens);
}

// =============================
//          Quantize
// =============================
void matmul_Q(float* xout, QuantizedTensor *x, QuantizedTensor *w, int n, int d) {
    // W (d,n) @ x (n,) -> xout (d,)
    // by far the most amount of time is spent inside this little function
    // inputs to this function are both quantized

    int i;

    for (i = 0; i < d; i++) {

        float val = 0.0f;
        int32_t ival = 0;
        int in = i * n;

        // do the matmul in groups of GS
        int j;
        for (j = 0; j <= n - GS; j += GS) {
            for (int k = 0; k < GS; k++) {
                ival += ((int32_t) x->q[j + k]) * ((int32_t) w->q[in + j + k]);
            }
            val += ((float) ival) * w->s[(in + j) / GS] * x->s[j / GS];
            ival = 0;
        }

        xout[i] = val;
    }
}

float* forward_Q(Transformer_Q* transformer, int token, int pos) {

    // a few convenience variables
    Config* p = &transformer->config;
    TransformerWeights_Q* w = &transformer->weights;
    RunState_Q* s = &transformer->state;
    float *x = s->x;
    int dim = p->dim;
    int kv_dim = (p->dim * p->n_kv_heads) / p->n_heads;
    int kv_mul = p->n_heads / p->n_kv_heads; // integer multiplier of the kv sharing in multiquery
    int hidden_dim =  p->hidden_dim;
    int head_size = dim / p->n_heads;

    // copy the token embedding into x
    memcpy(x, w->token_embedding_table + token*dim, dim * sizeof(float));

    // forward all the layers
    for(int l = 0; l < p->n_layers; l++) {

        // attention rmsnorm
        rmsnorm(s->xb, x, w->rms_att_weight + l*dim, dim);

        // qkv matmuls for this position
        quantize(&s->xq, s->xb, dim);
        matmul_Q(s->q, &s->xq, w->wq + l, dim, dim);
        matmul_Q(s->k, &s->xq, w->wk + l, dim, kv_dim);
        matmul_Q(s->v, &s->xq, w->wv + l, dim, kv_dim);

        // RoPE relative positional encoding: complex-valued rotate q and k in each head
        for (int i = 0; i < dim; i+=2) {
            int head_dim = i % head_size;
            float freq = 1.0f / powf(10000.0f, head_dim / (float)head_size);
            float val = pos * freq;
            float fcr = cosf(val);
            float fci = sinf(val);
            int rotn = i < kv_dim ? 2 : 1; // how many vectors? 2 = q & k, 1 = q only
            for (int v = 0; v < rotn; v++) {
                float* vec = v == 0 ? s->q : s->k; // the vector to rotate (query or key)
                float v0 = vec[i];
                float v1 = vec[i+1];
                vec[i]   = v0 * fcr - v1 * fci;
                vec[i+1] = v0 * fci + v1 * fcr;
            }
        }

        // save key,value at this time step (pos) to our kv cache
        int loff = l * p->seq_len * kv_dim; // kv cache layer offset for convenience
        float* key_cache_row = s->key_cache + loff + pos * kv_dim;
        float* value_cache_row = s->value_cache + loff + pos * kv_dim;
        memcpy(key_cache_row, s->k, kv_dim * sizeof(*key_cache_row));
        memcpy(value_cache_row, s->v, kv_dim * sizeof(*value_cache_row));

        // multihead attention. iterate over all heads
        int h;
        
        for (h = 0; h < p->n_heads; h++) {
            // get the query vector for this head
            float* q = s->q + h * head_size;
            // attention scores for this head
            float* att = s->att + h * p->seq_len;
            // iterate over all timesteps, including the current one
            for (int t = 0; t <= pos; t++) {
                // get the key vector for this head and at this timestep
                float* k = s->key_cache + loff + t * kv_dim + (h / kv_mul) * head_size;
                // calculate the attention score as the dot product of q and k
                float score = 0.0f;
                for (int i = 0; i < head_size; i++) {
                    score += q[i] * k[i];
                }
                score /= sqrtf(head_size);
                // save the score to the attention buffer
                att[t] = score;
            }

            // softmax the scores to get attention weights, from 0..pos inclusively
            softmax(att, pos + 1);

            // weighted sum of the values, store back into xb
            float* xb = s->xb + h * head_size;
            memset(xb, 0, head_size * sizeof(float));
            for (int t = 0; t <= pos; t++) {
                // get the value vector for this head and at this timestep
                float* v = s->value_cache + loff + t * kv_dim + (h / kv_mul) * head_size;
                // get the attention weight for this timestep
                float a = att[t];
                // accumulate the weighted value into xb
                for (int i = 0; i < head_size; i++) {
                    xb[i] += a * v[i];
                }
            }
        }

        // final matmul to get the output of the attention
        quantize(&s->xq, s->xb, dim);
        matmul_Q(s->xb2, &s->xq, w->wo + l, dim, dim);

        // residual connection back into x
        for (int i = 0; i < dim; i++) {
            x[i] += s->xb2[i];
        }

        // ffn rmsnorm
        rmsnorm(s->xb, x, w->rms_ffn_weight + l*dim, dim);

        // Now for FFN in PyTorch we have: self.w2(F.silu(self.w1(x)) * self.w3(x))
        // first calculate self.w1(x) and self.w3(x)
        quantize(&s->xq, s->xb, dim);
        matmul_Q(s->hb, &s->xq, w->w1 + l, dim, hidden_dim);
        matmul_Q(s->hb2, &s->xq, w->w3 + l, dim, hidden_dim);

        // SwiGLU non-linearity
        for (int i = 0; i < hidden_dim; i++) {
            float val = s->hb[i];
            // silu(x)=x*σ(x), where σ(x) is the logistic sigmoid
            val *= (1.0f / (1.0f + expf(-val)));
            // elementwise multiply with w3(x)
            val *= s->hb2[i];
            s->hb[i] = val;
        }

        // final matmul to get the output of the ffn
        quantize(&s->hq, s->hb, hidden_dim);
        matmul_Q(s->xb, &s->hq, w->w2 + l, hidden_dim, dim);

        // residual connection
        for (int i = 0; i < dim; i++) {
            x[i] += s->xb[i];
        }
    }

    // final rmsnorm
    rmsnorm(x, x, w->rms_final_weight, dim);

    // classifier into logits
    quantize(&s->xq, x, dim);
    matmul_Q(s->logits, &s->xq, w->wcls, dim, p->vocab_size);
    return s->logits;
}

void generate_Q(Transformer_Q *transformer, Tokenizer *tokenizer, Sampler *sampler, char *prompt, int steps) {
    char *empty_prompt = "";
    if (prompt == NULL) { prompt = empty_prompt; }

    // encode the (string) prompt into tokens sequence
    int num_prompt_tokens = 0;
    int* prompt_tokens = (int*)malloc((strlen(prompt)+3) * sizeof(int)); // +3 for '\0', ?BOS, ?EOS
    encode(tokenizer, prompt, 1, 0, prompt_tokens, &num_prompt_tokens);
    if (num_prompt_tokens < 1) {
        printf( "something is wrong, expected at least 1 prompt token\r\n");
        exit(EXIT_FAILURE);
    }

    // start the main loop
    long start = 0;  // used to time our code, only initialized after first iteration
    int next;        // will store the next token in the sequence
    int token = prompt_tokens[0]; // kick off with the first token in the prompt
    int pos = 0;     // position in the sequence
    while (pos < steps) {

        // forward the transformer to get logits for the next token
        float* logits = forward_Q(transformer, token, pos);

        // advance the state state machine
        if (pos < num_prompt_tokens - 1) {
            // if we are still processing the input prompt, force the next prompt token
            next = prompt_tokens[pos + 1];
        } else {
            // otherwise sample the next token from the logits
            next = sample(sampler, logits);
        }
        pos++;

        // data-dependent terminating condition: the BOS (=1) token delimits sequences
        if (next == 1) { break; }

        // print the token as string, decode it with the Tokenizer object
        char* piece = decode(tokenizer, token, next);
        safe_printf(piece); // same as printf("%s", piece), but skips "unsafe" bytes
        
        token = next;

        // init the timer here because the first iteration can be slower
        if (start == 0) { start = time_in_ns(); }
    }
    printf("\r\n");

    // report achieved tok/s (pos-1 because the timer starts after first iteration)
    if (pos > 1) {
        long end = time_in_ns();
        printf( "Total tokens: %d ; Achieved tok/s: %f\r\n",(pos-1), (pos-1) / (double)(end-start)*1000000000);
    }

    free(prompt_tokens);
}

// =============================
//          Quantize  RVV
// =============================

float rvv_vwmul_e8_m1(int8_t* x,  int8_t* w, int n) {
    // W (d,n) * x (n,)   -> xout (d,)
    // x^T(,n) * W^T(n,d) -> xout^T (,d)
    unsigned long int block_size_max=65535;
    unsigned long int block_size;
    int8_t* w_ = w;
    int8_t* x_ = x;
    int32_t sum;
    float   xout;

    // block_size is VLMAX
    asm volatile("vsetvli %0, %1, e32, m4, ta, ma" : "=r"(block_size) : "r"(block_size_max));
    asm volatile("vmv.v.i v4,  0");
    asm volatile("vmv.v.i v0,  0");

    // printf("block_size=%d\n", block_size);
    if (n < block_size)
    {
        asm volatile("vsetvli zero, %0, e8, m1, ta, ma" ::"r"(n));    
        // printf("p_=%d\n", p_);
        asm volatile("vle8.v v16, (%0);" ::"r"(w_));
        asm volatile("vle8.v v20, (%0);" ::"r"(x_));
        asm volatile("vsetvli zero, %0, e32, m4, ta, ma" ::"r"(n));       
        asm volatile("vsext.vf4  v8, v16");
        asm volatile("vsext.vf4 v12, v20");
        asm volatile("vmacc.vv v0, v8, v12");
    } else {
    
        for (unsigned long int m = 0; m < n; m += block_size) {

            const unsigned long int p_ = MIN(n - m, block_size);
            asm volatile("vsetvli zero, %0, e8, m1, ta, ma" ::"r"(p_));    
            // printf("p_=%d\n", p_);
            asm volatile("vle8.v v16, (%0);" ::"r"(w_));
            asm volatile("vle8.v v20, (%0);" ::"r"(x_));
            asm volatile("vsetvli zero, %0, e32, m4, ta, ma" ::"r"(p_));       
            asm volatile("vsext.vf4  v8, v16");
            asm volatile("vsext.vf4 v12, v20");
            asm volatile("vmacc.vv v0, v8, v12");
            w_ += block_size;
            x_ += block_size;
        }
    }
    asm volatile("vredsum.vs v4, v0, v4");  // vredsum.vs vd, vs2,vs1; vd[0]=sum(vs1[0], vs2[*])
    asm volatile("vmv.x.s %0, v4;":"=r"(sum));
    xout = (float) sum;

    return xout;
}


void matmul_Q_RVV(float* xout, QuantizedTensor *x, QuantizedTensor *w, int n, int d) {
    // W (d,n) @ x (n,) -> xout (d,)
    // by far the most amount of time is spent inside this little function
    // inputs to this function are both quantized

    int i;
    for (i = 0; i < d; i++) {

        float val = 0.0f;
        float fval = 0.0f;
        int in = i * n;

        // do the matmul in groups of GS
        int j;
        for (j = 0; j <= n - GS; j += GS) {
            fval = rvv_vwmul_e8_m1(&x->q[j], &w->q[in + j], GS);
            val +=  fval * w->s[(in + j) / GS] * x->s[j / GS];
            fval = 0;
        }
        xout[i] = val;
    }
}

float* forward_Q_RVV(Transformer_Q* transformer, int token, int pos) {

    // a few convenience variables
    Config* p = &transformer->config;
    TransformerWeights_Q* w = &transformer->weights;
    RunState_Q* s = &transformer->state;
    float *x = s->x;
    int dim = p->dim;
    int kv_dim = (p->dim * p->n_kv_heads) / p->n_heads;
    int kv_mul = p->n_heads / p->n_kv_heads; // integer multiplier of the kv sharing in multiquery
    int hidden_dim =  p->hidden_dim;
    int head_size = dim / p->n_heads;

    // copy the token embedding into x
    memcpy(x, w->token_embedding_table + token*dim, dim * sizeof(float));

    // forward all the layers
    for(int l = 0; l < p->n_layers; l++) {

        // attention rmsnorm
        rmsnorm(s->xb, x, w->rms_att_weight + l*dim, dim);

        // qkv matmuls for this position
        quantize(&s->xq, s->xb, dim);
        matmul_Q_RVV(s->q, &s->xq, w->wq + l, dim, dim);
        matmul_Q_RVV(s->k, &s->xq, w->wk + l, dim, kv_dim);
        matmul_Q_RVV(s->v, &s->xq, w->wv + l, dim, kv_dim);

        // RoPE relative positional encoding: complex-valued rotate q and k in each head
        for (int i = 0; i < dim; i+=2) {
            int head_dim = i % head_size;
            float freq = 1.0f / powf(10000.0f, head_dim / (float)head_size);
            float val = pos * freq;
            float fcr = cosf(val);
            float fci = sinf(val);
            int rotn = i < kv_dim ? 2 : 1; // how many vectors? 2 = q & k, 1 = q only
            for (int v = 0; v < rotn; v++) {
                float* vec = v == 0 ? s->q : s->k; // the vector to rotate (query or key)
                float v0 = vec[i];
                float v1 = vec[i+1];
                vec[i]   = v0 * fcr - v1 * fci;
                vec[i+1] = v0 * fci + v1 * fcr;
            }
        }

        // save key,value at this time step (pos) to our kv cache
        int loff = l * p->seq_len * kv_dim; // kv cache layer offset for convenience
        float* key_cache_row = s->key_cache + loff + pos * kv_dim;
        float* value_cache_row = s->value_cache + loff + pos * kv_dim;
        memcpy(key_cache_row, s->k, kv_dim * sizeof(*key_cache_row));
        memcpy(value_cache_row, s->v, kv_dim * sizeof(*value_cache_row));

        // multihead attention. iterate over all heads
        int h;
        
        for (h = 0; h < p->n_heads; h++) {
            // get the query vector for this head
            float* q = s->q + h * head_size;
            // attention scores for this head
            float* att = s->att + h * p->seq_len;
            // iterate over all timesteps, including the current one
            for (int t = 0; t <= pos; t++) {
                // get the key vector for this head and at this timestep
                float* k = s->key_cache + loff + t * kv_dim + (h / kv_mul) * head_size;
                // calculate the attention score as the dot product of q and k
                float score = 0.0f;
                for (int i = 0; i < head_size; i++) {
                    score += q[i] * k[i];
                }
                score /= sqrtf(head_size);
                // save the score to the attention buffer
                att[t] = score;
            }

            // softmax the scores to get attention weights, from 0..pos inclusively
            softmax(att, pos + 1);

            // weighted sum of the values, store back into xb
            float* xb = s->xb + h * head_size;
            memset(xb, 0, head_size * sizeof(float));
            for (int t = 0; t <= pos; t++) {
                // get the value vector for this head and at this timestep
                float* v = s->value_cache + loff + t * kv_dim + (h / kv_mul) * head_size;
                // get the attention weight for this timestep
                float a = att[t];
                // accumulate the weighted value into xb
                for (int i = 0; i < head_size; i++) {
                    xb[i] += a * v[i];
                }
            }
        }

        // final matmul to get the output of the attention
        quantize(&s->xq, s->xb, dim);
        matmul_Q_RVV(s->xb2, &s->xq, w->wo + l, dim, dim);

        // residual connection back into x
        for (int i = 0; i < dim; i++) {
            x[i] += s->xb2[i];
        }

        // ffn rmsnorm
        rmsnorm(s->xb, x, w->rms_ffn_weight + l*dim, dim);

        // Now for FFN in PyTorch we have: self.w2(F.silu(self.w1(x)) * self.w3(x))
        // first calculate self.w1(x) and self.w3(x)
        quantize(&s->xq, s->xb, dim);
        matmul_Q_RVV(s->hb, &s->xq, w->w1 + l, dim, hidden_dim);
        matmul_Q_RVV(s->hb2, &s->xq, w->w3 + l, dim, hidden_dim);

        // SwiGLU non-linearity
        for (int i = 0; i < hidden_dim; i++) {
            float val = s->hb[i];
            // silu(x)=x*σ(x), where σ(x) is the logistic sigmoid
            val *= (1.0f / (1.0f + expf(-val)));
            // elementwise multiply with w3(x)
            val *= s->hb2[i];
            s->hb[i] = val;
        }

        // final matmul to get the output of the ffn
        quantize(&s->hq, s->hb, hidden_dim);
        matmul_Q_RVV(s->xb, &s->hq, w->w2 + l, hidden_dim, dim);

        // residual connection
        for (int i = 0; i < dim; i++) {
            x[i] += s->xb[i];
        }
    }

    // final rmsnorm
    rmsnorm(x, x, w->rms_final_weight, dim);

    // classifier into logits
    quantize(&s->xq, x, dim);
    matmul_Q_RVV(s->logits, &s->xq, w->wcls, dim, p->vocab_size);
    return s->logits;
}


void generate_Q_RVV(Transformer_Q *transformer, Tokenizer *tokenizer, Sampler *sampler, char *prompt, int steps) {
    char *empty_prompt = "";
    if (prompt == NULL) { prompt = empty_prompt; }

    // encode the (string) prompt into tokens sequence
    int num_prompt_tokens = 0;
    int* prompt_tokens = (int*)malloc((strlen(prompt)+3) * sizeof(int)); // +3 for '\0', ?BOS, ?EOS
    encode(tokenizer, prompt, 1, 0, prompt_tokens, &num_prompt_tokens);
    if (num_prompt_tokens < 1) {
        printf( "something is wrong, expected at least 1 prompt token\r\n");
        exit(EXIT_FAILURE);
    }

    // start the main loop
    long start = 0;  // used to time our code, only initialized after first iteration
    int next;        // will store the next token in the sequence
    int token = prompt_tokens[0]; // kick off with the first token in the prompt
    int pos = 0;     // position in the sequence
    while (pos < steps) {

        // forward the transformer to get logits for the next token
        float* logits = forward_Q_RVV(transformer, token, pos);

        // advance the state state machine
        if (pos < num_prompt_tokens - 1) {
            // if we are still processing the input prompt, force the next prompt token
            next = prompt_tokens[pos + 1];
        } else {
            // otherwise sample the next token from the logits
            next = sample(sampler, logits);
        }
        pos++;

        // data-dependent terminating condition: the BOS (=1) token delimits sequences
        if (next == 1) { break; }

        // print the token as string, decode it with the Tokenizer object
        char* piece = decode(tokenizer, token, next);
        safe_printf(piece); // same as printf("%s", piece), but skips "unsafe" bytes
        
        token = next;

        // init the timer here because the first iteration can be slower
        if (start == 0) { start = time_in_ns(); }
    }
    printf("\r\n");

    // report achieved tok/s (pos-1 because the timer starts after first iteration)
    if (pos > 1) {
        long end = time_in_ns();
        printf( "Total tokens: %d ; Achieved tok/s: %f\r\n",(pos-1), (pos-1) / (double)(end-start)*1000000000);
    }

    free(prompt_tokens);
}

// =============================
//          Quantize  VIFMM
// =============================

float vifbw_e32_m4( float* x, int8_t* w, int size) {
  // W (d,n) * x (n,)   -> xout (d,)
  // x^T(,n) * W^T(n,d) -> xout^T (,d)
  unsigned long int block_size;
  int8_t* w_  = w;
  float* x_   = x;
  float  sum;
  unsigned long int block_size_max=65535;

  asm volatile("vsetvli %0, %1, e32, m4, ta, ma" : "=r"(block_size) : "r"(size));
  asm volatile("vmv.v.i v8,  0");
  asm volatile("vmv.v.i v0,  0");

  // printf("Available block_size=%d\n", block_size);

  if (size <= block_size)
  {
      asm volatile("vle32.v v16, (%0);" ::"r"(x_));
      asm volatile("vsetvli zero, %0, e8, m1, ta, ma" ::"r"(size));    
      asm volatile("vle8.v v24, (%0);" ::"r"(w_));
      asm volatile("vsetvli zero, %0, e32, m4, ta, ma" ::"r"(size));    
    #ifndef LLVM
      asm volatile(".word 0xbb882057");   // gcc  vifbw v0, v16, v24
    #else
    //   asm volatile(".word 0xbb882057");    // llvm vifbw.vv v0, v16, v24
      asm volatile("vifbw.vv v0, v16, v24");
    #endif

      
  } else {
  
      for (unsigned long int m = 0; m < size; m += block_size) {
        const unsigned long int p_ = MIN(size - m, block_size); 
        asm volatile("vle32.v v16, (%0);" ::"r"(x_));
        asm volatile("vsetvli zero, %0, e8, m1, ta, ma" ::"r"(p_));    
        asm volatile("vle8.v v24, (%0);" ::"r"(w_));
        w_ += block_size;
        x_ += block_size;
        asm volatile("vsetvli zero, %0, e32, m4, ta, ma" ::"r"(p_));    
      #ifndef LLVM
        asm volatile(".word 0xbb882057");   // gcc  vifbw v0, v16, v24
      #else
      //   asm volatile(".word 0xbb882057");    // llvm vifbw.vv v0, v16, v24
        asm volatile("vifbw.vv v0, v16, v24");
      #endif
      }
  }
  asm volatile("vfredsum.vs v8, v0, v8");  // vredsum.vs vd, vs2,vs1; vd[0]=sum(vs1[0], vs2[*])
  asm volatile("vfmv.f.s %0, v8;":"=f"(sum));
  return sum;
}

void matmul_Q_VIFMM(float* xout, float* x, QuantizedTensor *w, int n, int d) {
    // W (d,n) @ x (n,) -> xout (d,)
    // by far the most amount of time is spent inside this little function
    // inputs to this function are both quantized

    int i;
    for (i = 0; i < d; i++) {

        float val = 0.0f;
        float fval = 0;
        int in = i * n;

        // do the matmul in groups of GS
        int j;
        for (j = 0; j <= n - GS; j += GS) {
            fval = vifbw_e32_m4(&x[j], &w->q[in + j], GS);
            val +=  fval * w->s[(in + j) / GS];
        }

        xout[i] = val;
    }
}

float* forward_Q_VIFMM(Transformer_Q* transformer, int token, int pos) {

    // a few convenience variables
    Config* p = &transformer->config;
    TransformerWeights_Q* w = &transformer->weights;
    RunState_Q* s = &transformer->state;
    float *x = s->x;
    int dim = p->dim;
    int kv_dim = (p->dim * p->n_kv_heads) / p->n_heads;
    int kv_mul = p->n_heads / p->n_kv_heads; // integer multiplier of the kv sharing in multiquery
    int hidden_dim =  p->hidden_dim;
    int head_size = dim / p->n_heads;

    // copy the token embedding into x
    memcpy(x, w->token_embedding_table + token*dim, dim * sizeof(float));

    // forward all the layers
    for(int l = 0; l < p->n_layers; l++) {

        // attention rmsnorm
        rmsnorm(s->xb, x, w->rms_att_weight + l*dim, dim);

        // qkv matmuls for this position
        // gukai
        // quantize(&s->xq, s->xb, dim);
        // matmul(s->q, &s->xq, w->wq + l, dim, dim);
        // matmul(s->k, &s->xq, w->wk + l, dim, kv_dim);
        // matmul(s->v, &s->xq, w->wv + l, dim, kv_dim);
        matmul_Q_VIFMM(s->q, s->xb, w->wq + l, dim, dim);
        matmul_Q_VIFMM(s->k, s->xb, w->wk + l, dim, kv_dim);
        matmul_Q_VIFMM(s->v, s->xb, w->wv + l, dim, kv_dim);

        // RoPE relative positional encoding: complex-valued rotate q and k in each head
        for (int i = 0; i < dim; i+=2) {
            int head_dim = i % head_size;
            float freq = 1.0f / powf(10000.0f, head_dim / (float)head_size);
            float val = pos * freq;
            float fcr = cosf(val);
            float fci = sinf(val);
            int rotn = i < kv_dim ? 2 : 1; // how many vectors? 2 = q & k, 1 = q only
            for (int v = 0; v < rotn; v++) {
                float* vec = v == 0 ? s->q : s->k; // the vector to rotate (query or key)
                float v0 = vec[i];
                float v1 = vec[i+1];
                vec[i]   = v0 * fcr - v1 * fci;
                vec[i+1] = v0 * fci + v1 * fcr;
            }
        }

        // save key,value at this time step (pos) to our kv cache
        int loff = l * p->seq_len * kv_dim; // kv cache layer offset for convenience
        float* key_cache_row = s->key_cache + loff + pos * kv_dim;
        float* value_cache_row = s->value_cache + loff + pos * kv_dim;
        memcpy(key_cache_row, s->k, kv_dim * sizeof(*key_cache_row));
        memcpy(value_cache_row, s->v, kv_dim * sizeof(*value_cache_row));

        // multihead attention. iterate over all heads
        int h;
        
        for (h = 0; h < p->n_heads; h++) {
            // get the query vector for this head
            float* q = s->q + h * head_size;
            // attention scores for this head
            float* att = s->att + h * p->seq_len;
            // iterate over all timesteps, including the current one
            for (int t = 0; t <= pos; t++) {
                // get the key vector for this head and at this timestep
                float* k = s->key_cache + loff + t * kv_dim + (h / kv_mul) * head_size;
                // calculate the attention score as the dot product of q and k
                float score = 0.0f;
                for (int i = 0; i < head_size; i++) {
                    score += q[i] * k[i];
                }
                score /= sqrtf(head_size);
                // save the score to the attention buffer
                att[t] = score;
            }

            // softmax the scores to get attention weights, from 0..pos inclusively
            softmax(att, pos + 1);

            // weighted sum of the values, store back into xb
            float* xb = s->xb + h * head_size;
            memset(xb, 0, head_size * sizeof(float));
            for (int t = 0; t <= pos; t++) {
                // get the value vector for this head and at this timestep
                float* v = s->value_cache + loff + t * kv_dim + (h / kv_mul) * head_size;
                // get the attention weight for this timestep
                float a = att[t];
                // accumulate the weighted value into xb
                for (int i = 0; i < head_size; i++) {
                    xb[i] += a * v[i];
                }
            }
        }

        // final matmul to get the output of the attention
        // gukai
        // quantize(&s->xq, s->xb, dim);
        // matmul(s->xb2, &s->xq, w->wo + l, dim, dim);
        matmul_Q_VIFMM(s->xb2, s->xb, w->wo + l, dim, dim);

        // residual connection back into x
        for (int i = 0; i < dim; i++) {
            x[i] += s->xb2[i];
        }

        // ffn rmsnorm
        rmsnorm(s->xb, x, w->rms_ffn_weight + l*dim, dim);

        // Now for FFN in PyTorch we have: self.w2(F.silu(self.w1(x)) * self.w3(x))
        // first calculate self.w1(x) and self.w3(x)
        // gukai
        // quantize(&s->xq, s->xb, dim);
        // matmul(s->hb, &s->xq, w->w1 + l, dim, hidden_dim);
        // matmul(s->hb2, &s->xq, w->w3 + l, dim, hidden_dim);
        matmul_Q_VIFMM(s->hb, s->xb, w->w1 + l, dim, hidden_dim);
        matmul_Q_VIFMM(s->hb2, s->xb, w->w3 + l, dim, hidden_dim);

        // SwiGLU non-linearity
        for (int i = 0; i < hidden_dim; i++) {
            float val = s->hb[i];
            // silu(x)=x*σ(x), where σ(x) is the logistic sigmoid
            val *= (1.0f / (1.0f + expf(-val)));
            // elementwise multiply with w3(x)
            val *= s->hb2[i];
            s->hb[i] = val;
        }

        // final matmul to get the output of the ffn
        // gukai
        // quantize(&s->hq, s->hb, hidden_dim);
        // matmul(s->xb, &s->hq, w->w2 + l, hidden_dim, dim);
        matmul_Q_VIFMM(s->xb, s->hb, w->w2 + l, hidden_dim, dim);

        // residual connection
        for (int i = 0; i < dim; i++) {
            x[i] += s->xb[i];
        }
    }

    // final rmsnorm
    rmsnorm(x, x, w->rms_final_weight, dim);

    // classifier into logits
    // gukai
    // quantize(&s->xq, x, dim);
    // matmul_Q_RVV(s->logits, &s->xq, w->wcls, dim, p->vocab_size);
    matmul_Q_VIFMM(s->logits, x, w->wcls, dim, p->vocab_size);
    return s->logits;
}


void generate_Q_VIFMM(Transformer_Q *transformer, Tokenizer *tokenizer, Sampler *sampler, char *prompt, int steps) {
    char *empty_prompt = "";
    if (prompt == NULL) { prompt = empty_prompt; }

    // encode the (string) prompt into tokens sequence
    int num_prompt_tokens = 0;
    int* prompt_tokens = (int*)malloc((strlen(prompt)+3) * sizeof(int)); // +3 for '\0', ?BOS, ?EOS
    encode(tokenizer, prompt, 1, 0, prompt_tokens, &num_prompt_tokens);
    if (num_prompt_tokens < 1) {
        printf( "something is wrong, expected at least 1 prompt token\n");
        exit(EXIT_FAILURE);
    }

    // start the main loop
    long start = 0;  // used to time our code, only initialized after first iteration
    int next;        // will store the next token in the sequence
    int token = prompt_tokens[0]; // kick off with the first token in the prompt
    int pos = 0;     // position in the sequence
    while (pos < steps) {

        // forward the transformer to get logits for the next token
        float* logits = forward_Q_VIFMM(transformer, token, pos);

        // advance the state state machine
        if (pos < num_prompt_tokens - 1) {
            // if we are still processing the input prompt, force the next prompt token
            next = prompt_tokens[pos + 1];
        } else {
            // otherwise sample the next token from the logits
            next = sample(sampler, logits);
        }
        pos++;

        // data-dependent terminating condition: the BOS (=1) token delimits sequences
        if (next == 1) { break; }

        // print the token as string, decode it with the Tokenizer object
        char* piece = decode(tokenizer, token, next);
        safe_printf(piece); // same as printf("%s", piece), but skips "unsafe" bytes
        
        token = next;

        // init the timer here because the first iteration can be slower
        if (start == 0) { start = time_in_ns(); }
    }
    printf("\r\n");

    // report achieved tok/s (pos-1 because the timer starts after first iteration)
    if (pos > 1) {
        long end = time_in_ns();
        printf( "Total tokens: %d ; Achieved tok/s: %f\r\n",(pos-1), (pos-1) / (double)(end-start)*1000000000);
    }

    free(prompt_tokens);
}
