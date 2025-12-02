#ifndef _MAIN_H
#define _MAIN_H

#include <ctype.h>



extern int32_t MAX_TOKEN_LEN;                   __attribute__((aligned(4), section(".data")));;
extern char    VOCAB_START[]      __attribute__((aligned(8), section(".data")));  ;

extern int32_t ST15M_DIM;                 __attribute__((aligned(4), section(".data")));;
extern int32_t ST15M_HIDDEN_DIM;                  __attribute__((aligned(4), section(".data")));;
extern int32_t ST15M_N_LAYERS;                    __attribute__((aligned(4), section(".data")));;
extern int32_t ST15M_N_HEADS;                 __attribute__((aligned(4), section(".data")));;
extern int32_t ST15M_N_KV_HEADS;                  __attribute__((aligned(4), section(".data")));;
extern int32_t ST15M_VOCAB_SIZE;                  __attribute__((aligned(4), section(".data")));;
extern int32_t ST15M_MAX_SEQ_LEN;                 __attribute__((aligned(4), section(".data")));;
extern int32_t ST15M_SHARED_CLASSIFIER;                   __attribute__((aligned(4), section(".data")));;
extern float   ST15M_weight_tok_embeddings[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_weight_attention_norm[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_weight_wq[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_weight_wk[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_weight_wv[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_weight_wo[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_weight_ffn_norm[]      __attribute__((aligned(8), section(".data")));  ;
extern float   ST15M_weight_1[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_weight_2[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_weight_3[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_weight_final_norm[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_weight_output[]      __attribute__((aligned(8), section(".data")));;

extern int32_t ST15M_Q_DIM;                 __attribute__((aligned(4), section(".data")));;
extern int32_t ST15M_Q_HIDDEN_DIM;                  __attribute__((aligned(4), section(".data")));;
extern int32_t ST15M_Q_N_LAYERS;                    __attribute__((aligned(4), section(".data")));;
extern int32_t ST15M_Q_N_HEADS;                 __attribute__((aligned(4), section(".data")));;
extern int32_t ST15M_Q_N_KV_HEADS;                  __attribute__((aligned(4), section(".data")));;
extern int32_t ST15M_Q_VOCAB_SIZE;                  __attribute__((aligned(4), section(".data")));;
extern int32_t ST15M_Q_MAX_SEQ_LEN;                 __attribute__((aligned(4), section(".data")));;
extern int32_t ST15M_Q_SHARED_CLASSIFIER;                   __attribute__((aligned(4), section(".data")));;
extern int32_t ST15M_Q_GROUP_SIZE;                   __attribute__((aligned(4), section(".data")));;
extern float   ST15M_Q_weight_tok_embeddings_q[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_Q_weight_tok_embeddings_s[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_Q_weight_attention_norm[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_Q_weight_wq_q[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_Q_weight_wq_s[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_Q_weight_wk_q[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_Q_weight_wk_s[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_Q_weight_wv_q[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_Q_weight_wv_s[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_Q_weight_wo_q[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_Q_weight_wo_s[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_Q_weight_ffn_norm[]      __attribute__((aligned(8), section(".data")));  ;
extern float   ST15M_Q_weight_w1_q[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_Q_weight_w1_s[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_Q_weight_w2_q[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_Q_weight_w2_s[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_Q_weight_w3_q[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_Q_weight_w3_s[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_Q_weight_final_norm[]      __attribute__((aligned(8), section(".data")));;
extern float   ST15M_Q_weight_output[]      __attribute__((aligned(8), section(".data")));;

extern int32_t ST260K_DIM;                 __attribute__((aligned(4), section(".data")));;
extern int32_t ST260K_HIDDEN_DIM;                  __attribute__((aligned(4), section(".data")));;
extern int32_t ST260K_N_LAYERS;                    __attribute__((aligned(4), section(".data")));;
extern int32_t ST260K_N_HEADS;                 __attribute__((aligned(4), section(".data")));;
extern int32_t ST260K_N_KV_HEADS;                  __attribute__((aligned(4), section(".data")));;
extern int32_t ST260K_VOCAB_SIZE;                  __attribute__((aligned(4), section(".data")));;
extern int32_t ST260K_MAX_SEQ_LEN;                 __attribute__((aligned(4), section(".data")));;
extern int32_t ST260K_SHARED_CLASSIFIER;                   __attribute__((aligned(4), section(".data")));;
extern float   ST260K_weight_tok_embeddings[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_weight_attention_norm[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_weight_wq[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_weight_wk[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_weight_wv[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_weight_wo[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_weight_ffn_norm[]      __attribute__((aligned(8), section(".data")));  ;
extern float   ST260K_weight_1[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_weight_2[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_weight_3[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_weight_final_norm[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_weight_output[]      __attribute__((aligned(8), section(".data")));;

extern int32_t ST260K_Q_DIM;                 __attribute__((aligned(4), section(".data")));;
extern int32_t ST260K_Q_HIDDEN_DIM;                  __attribute__((aligned(4), section(".data")));;
extern int32_t ST260K_Q_N_LAYERS;                    __attribute__((aligned(4), section(".data")));;
extern int32_t ST260K_Q_N_HEADS;                 __attribute__((aligned(4), section(".data")));;
extern int32_t ST260K_Q_N_KV_HEADS;                  __attribute__((aligned(4), section(".data")));;
extern int32_t ST260K_Q_VOCAB_SIZE;                  __attribute__((aligned(4), section(".data")));;
extern int32_t ST260K_Q_MAX_SEQ_LEN;                 __attribute__((aligned(4), section(".data")));;
extern int32_t ST260K_Q_SHARED_CLASSIFIER;                   __attribute__((aligned(4), section(".data")));;
extern int32_t ST260K_Q_GROUP_SIZE;                   __attribute__((aligned(4), section(".data")));;
extern float   ST260K_Q_weight_tok_embeddings_q[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_Q_weight_tok_embeddings_s[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_Q_weight_attention_norm[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_Q_weight_wq_q[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_Q_weight_wq_s[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_Q_weight_wk_q[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_Q_weight_wk_s[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_Q_weight_wv_q[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_Q_weight_wv_s[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_Q_weight_wo_q[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_Q_weight_wo_s[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_Q_weight_ffn_norm[]      __attribute__((aligned(8), section(".data")));  ;
extern float   ST260K_Q_weight_w1_q[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_Q_weight_w1_s[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_Q_weight_w2_q[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_Q_weight_w2_s[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_Q_weight_w3_q[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_Q_weight_w3_s[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_Q_weight_final_norm[]      __attribute__((aligned(8), section(".data")));;
extern float   ST260K_Q_weight_output[]      __attribute__((aligned(8), section(".data")));;



#endif