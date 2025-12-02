#ifndef _STORIES_COMMON_H
#define _STORIES_COMMON_H
#include <stdlib.h>
#include <ctype.h>
#include <stdint.h>


typedef struct {
    char *str;
    int id;
} TokenIndex;

typedef struct {
    char** vocab;
    float* vocab_scores;
    TokenIndex *sorted_vocab;
    int vocab_size;
    unsigned int max_token_length;
    unsigned char byte_pieces[512]; // stores all single-byte strings
} Tokenizer;

typedef struct {
    int dim; // transformer dimension
    int hidden_dim; // for ffn layers
    int n_layers; // number of layers
    int n_heads; // number of query heads
    int n_kv_heads; // number of key/value heads (can be < query heads because of multiquery)
    int vocab_size; // vocabulary size, usually 256 (byte-level)
    int seq_len; // max sequence length
} Config;


typedef struct {
    float prob;
    int index;
} ProbIndex; // struct used when sorting probabilities during top-p sampling

typedef struct {
    int vocab_size;
    ProbIndex* probindex; // buffer used in top-p sampling
    float temperature;
    float topp;
    unsigned long long rng_state;
} Sampler;

void build_tokenizer(Tokenizer* t, int vocab_size);
void build_sampler(Sampler* sampler, int vocab_size, float temperature, float topp, unsigned long long rng_seed);
void free_tokenizer(Tokenizer* t);
void free_sampler(Sampler* sampler);

void softmax(float* x, int size);
void rmsnorm(float* o, float* x, float* weight, int size);
char* decode(Tokenizer* t, int prev_token, int token);
void encode(Tokenizer* t, char *text, int8_t bos, int8_t eos, int *tokens, int *n_tokens);
void safe_printf(char *piece);
int sample(Sampler* sampler, float* logits);
long time_in_ns();


#endif