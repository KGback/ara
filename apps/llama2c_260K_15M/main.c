
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <string.h>
#include "runtime.h"
#include "util.h"
#include "printf.h"
#include "memory.h"
#include "main.h"
#include "stories_common.h"
#include "stories_model.h"

float temperature = 1.0f;   // 0.0 = greedy deterministic. 1.0 = original. don't set higher
float topp = 0.9f;          // top-p in nucleus sampling. 1.0 = off. 0.9 works well, but slower
char *prompt = "One day, Lily met a Shoggoth";        // prompt string

int run_ST260K(char *input_text, int steps, unsigned long long rng_seed) {
    memory_init();
    // build the Transformer via the model .bin file
    Transformer transformer;
    build_transformer_ST260K(&transformer);

    // build the Tokenizer via the tokenizer .bin file
    Tokenizer tokenizer;
    build_tokenizer(&tokenizer, transformer.config.vocab_size);

    // build the Sampler
    Sampler sampler;
    build_sampler(&sampler, transformer.config.vocab_size, temperature, topp, rng_seed);

    // run!
    generate(&transformer, &tokenizer, &sampler, input_text, steps);
    // memory and file handles cleanup
    // free_sampler(&sampler);
    // free_tokenizer(&tokenizer);
    // free_transformer(&transformer);
    return 0;
}


int runq_ST260K(char *input_text, int steps, unsigned long long rng_seed) {
    memory_init();
    // build the Transformer via the model .bin file
    Transformer_Q transformer;
    build_transformer_ST260KQ(&transformer);

    // build the Tokenizer via the tokenizer .bin file
    Tokenizer tokenizer;
    build_tokenizer(&tokenizer, transformer.config.vocab_size);

    // build the Sampler
    Sampler sampler;
    build_sampler(&sampler, transformer.config.vocab_size, temperature, topp, rng_seed);

    // run!
    generate_Q(&transformer, &tokenizer, &sampler, input_text, steps);
    // memory and file handles cleanup
    // free_sampler(&sampler);
    // free_tokenizer(&tokenizer);
    // free_transformer_Q(&transformer);
    return 0;
}


int runq_rvv_ST260K(char *input_text, int steps, unsigned long long rng_seed) {
    memory_init();
    // build the Transformer via the model .bin file
    Transformer_Q transformer;
    build_transformer_ST260KQ(&transformer);

    // build the Tokenizer via the tokenizer .bin file
    Tokenizer tokenizer;
    build_tokenizer(&tokenizer, transformer.config.vocab_size);

    // build the Sampler
    Sampler sampler;
    build_sampler(&sampler, transformer.config.vocab_size, temperature, topp, rng_seed);

    // run!
    generate_Q_RVV(&transformer, &tokenizer, &sampler, input_text, steps);

    // memory and file handles cleanup
    // free_sampler(&sampler);
    // free_tokenizer(&tokenizer);
    // free_transformer_Q(&transformer);
    return 0;
}

int runq_vifmm_ST260K(char *input_text, int steps, unsigned long long rng_seed) {
    memory_init();
    // build the Transformer via the model .bin file
    Transformer_Q transformer;
    build_transformer_ST260KQ(&transformer);

    // build the Tokenizer via the tokenizer .bin file
    Tokenizer tokenizer;
    build_tokenizer(&tokenizer, transformer.config.vocab_size);

    // build the Sampler
    Sampler sampler;
    build_sampler(&sampler, transformer.config.vocab_size, temperature, topp, rng_seed);

    // run!
    generate_Q_VIFMM(&transformer, &tokenizer, &sampler, input_text, steps);

    // memory and file handles cleanup
    // free_sampler(&sampler);
    // free_tokenizer(&tokenizer);
    // free_transformer_Q(&transformer);
    return 0;
}

int run_ST15M(char *input_text, int steps, unsigned long long rng_seed) {
    memory_init();
    // build the Transformer via the model .bin file
    Transformer transformer;
    build_transformer_ST15M(&transformer);

    // build the Tokenizer via the tokenizer .bin file
    Tokenizer tokenizer;
    build_tokenizer(&tokenizer, transformer.config.vocab_size);

    // build the Sampler
    Sampler sampler;
    build_sampler(&sampler, transformer.config.vocab_size, temperature, topp, rng_seed);

    // run!
    generate(&transformer, &tokenizer, &sampler, input_text, steps);
    // memory and file handles cleanup
    // free_sampler(&sampler);
    // free_tokenizer(&tokenizer);
    // free_transformer(&transformer);
    return 0;
}


int runq_ST15M(char *input_text, int steps, unsigned long long rng_seed) {
    memory_init();
    // build the Transformer via the model .bin file
    Transformer_Q transformer;
    build_transformer_ST15MQ(&transformer);

    // build the Tokenizer via the tokenizer .bin file
    Tokenizer tokenizer;
    build_tokenizer(&tokenizer, transformer.config.vocab_size);

    // build the Sampler
    Sampler sampler;
    build_sampler(&sampler, transformer.config.vocab_size, temperature, topp, rng_seed);

    // run!
    generate_Q(&transformer, &tokenizer, &sampler, input_text, steps);
    // memory and file handles cleanup
    // free_sampler(&sampler);
    // free_tokenizer(&tokenizer);
    // free_transformer_Q(&transformer);
    return 0;
}


int runq_rvv_ST15M(char *input_text, int steps, unsigned long long rng_seed) {
    memory_init();
    // build the Transformer via the model .bin file
    Transformer_Q transformer;
    build_transformer_ST15MQ(&transformer);
    // build the Tokenizer via the tokenizer .bin file
    Tokenizer tokenizer;
    build_tokenizer(&tokenizer, transformer.config.vocab_size);

    // build the Sampler
    Sampler sampler;
    build_sampler(&sampler, transformer.config.vocab_size, temperature, topp, rng_seed);

    // run!
    generate_Q_RVV(&transformer, &tokenizer, &sampler, input_text, steps);

    // memory and file handles cleanup
    // free_sampler(&sampler);
    // free_tokenizer(&tokenizer);
    // free_transformer_Q(&transformer);
    return 0;
}

int runq_vifmm_ST15M(char *input_text, int steps, unsigned long long rng_seed) {
    memory_init();
    // build the Transformer via the model .bin file
    Transformer_Q transformer;
    build_transformer_ST15MQ(&transformer);
    // build the Tokenizer via the tokenizer .bin file
    Tokenizer tokenizer;
    build_tokenizer(&tokenizer, transformer.config.vocab_size);

    // build the Sampler
    Sampler sampler;
    build_sampler(&sampler, transformer.config.vocab_size, temperature, topp, rng_seed);

    // run!
    generate_Q_VIFMM(&transformer, &tokenizer, &sampler, input_text, steps);

    // memory and file handles cleanup
    // free_sampler(&sampler);
    // free_tokenizer(&tokenizer);
    // free_transformer_Q(&transformer);
    return 0;
}


int main() {

    printf("Hello!\r\n");

    // parameter validation/overrides
    unsigned long long rng_seed = 0;
    if (temperature < 0.0) temperature = 0.0;
    if (topp < 0.0 || 1.0 < topp) topp = 0.9;

    int i   = 0;
    printf("===============================\r\n");
    printf("[TEST FOR THE CHANGE OF TOKENS]\r\n");
    printf("===============================\r\n");
    for (int tokens = 64; tokens <= 256; tokens += 8)
    {
        // int tokens = 5;
        printf("TEST%d,   Number of TOKEN: %d\r\n",i++, tokens);
        printf("stories260K, no_quantize, rv64gc\r\n");
        run_ST260K(NULL, tokens,0);
        printf("stories260K, quantize, rv64gc\r\n");
        runq_ST260K(NULL, tokens,0);
        printf("stories260K, quantize, rv64gcv\r\n");
        runq_rvv_ST260K(NULL, tokens,0);
        printf("stories260K, quantize, rv64gcv_vifmm\r\n");
        runq_vifmm_ST260K(NULL, tokens,0);
        printf("stories15M, no_quantize, rv64gc\r\n");
        run_ST15M(NULL, tokens,0);
        printf("stories15M, quantize, rv64gc\r\n");
        runq_ST15M(NULL, tokens,0);
        printf("stories15M, quantize, rv64gcv\r\n");
        runq_rvv_ST15M(NULL, tokens,0);
        printf("stories15M, quantize, rv64gcv_vifmm\r\n");
        runq_vifmm_ST15M(NULL, tokens,0);
    }

    int j   = 0;
    printf("=================================\r\n");
    printf("[TEST FOR THE CHANGE OF RNG_SEED]\r\n");
    printf("=================================\r\n");
    while(1)
    {
        rng_seed = (unsigned long long)get_cycle_count();
        printf("TEST%d,    Number of RND_SEED: %lld\r\n",j++, rng_seed);
        // printf("stories260K, no_quantize, rv64gc\r\n");
        // run_ST260K       (256,rng_seed);
        // printf("stories260K, quantize, rv64gc\r\n");
        // runq_ST260K      (256,rng_seed);
        // printf("stories260K, quantize, rv64gcv\r\n");
        // runq_rvv_ST260K  (256,rng_seed);
        // printf("stories260K, quantize, rv64gcv_vifmm\r\n");
        // runq_vifmm_ST260K(256,rng_seed);
        printf("stories15M, no_quantize, rv64gc\r\n");
        run_ST15M        (prompt, 256,rng_seed);
        printf("stories15M, quantize, rv64gc\r\n");
        runq_ST15M       (prompt, 256,rng_seed);
        printf("stories15M, quantize, rv64gcv\r\n");
        runq_rvv_ST15M   (prompt, 256,rng_seed);
        printf("stories15M, quantize, rv64gcv_vifmm\r\n");
        runq_vifmm_ST15M (prompt, 256,rng_seed);
    }

    

    return 0;
}