// Author: Kevin Gu
// Test the ulp of vifmm in quantize-only, compensate-only and mix of quantize and compensate modes.
// x and xinit are between -1.9 and 2

#include <stdint.h>
#include <string.h>
#include <math.h>

#include "printf.h"

#include "util.h"


#define ROW           5
#define COL           188
#define VEC_SIZE_0     16
#define VEC_SIZE_1     16
#define VEC_SIZE_2     16
#define VEC_SIZE_3     500
#define OLR_THD       2
#define MAX_QUANTIZE  127

extern float w[]         __attribute__((aligned(1 * NR_LANES), section(".data")));
extern float x[]          __attribute__((aligned(4 * NR_LANES), section(".data")));
extern int8_t qw[]        __attribute__((aligned(1 * NR_LANES), section(".data")));
extern float xinit[]      __attribute__((aligned(1 * NR_LANES), section(".data")));
extern int8_t xout_g[]    __attribute__((aligned(1 * NR_LANES), section(".data")));


int32_t float_ulp_distance(float a, float b) {
    int32_t ia = *(int32_t*)&a;
    int32_t ib = *(int32_t*)&b;
    
    if ((ia < 0) != (ib < 0)) {  // 符号不同
        if (a == b) return 0;    // +0 == -0
        return ia >= 0 ? ia - INT32_MIN - ib : INT32_MAX - ia + ib;
    }
    return ia >= ib ? ia - ib : ib - ia;
}

void compute( int8_t* w,  float* x_f,float* xinit, float* xp, int size) {
  // W (d,n) * x (n,)   -> xout (d,)
  // x^T(,n) * W^T(n,d) -> xout^T (,d)
  unsigned long int block_size;
  unsigned long int block_size_max=65535;

  asm volatile("vsetvli %0, %1, e8, m2, ta, ma" : "=r"(block_size) : "r"(block_size_max));
  printf("Available block_size=%d\n", block_size);

  block_size = size;

  asm volatile("vsetvli zero, %0, e32, m8, ta, ma" ::"r"(block_size));    
  asm volatile("vle32.v v0, (%0);" ::"r"(xinit));
  asm volatile("vsetvli zero, %0, e8, m2, ta, ma" ::"r"(block_size));    
  asm volatile("vle8.v v24, (%0);" ::"r"(w));
  asm volatile("vsetvli zero, %0, e32, m8, ta, ma" ::"r"(block_size));    
  asm volatile("vle32.v v16, (%0);" ::"r"(x_f));
  asm volatile("vifbw.vv v0, v16, v24");  // llvm
  // asm volatile("vifbw v0, v24, v16");   // gcc

  asm volatile("vsetvli zero, %0, e32, m8, ta, ma" ::"r"(block_size));    
  asm volatile("vse32.v v0, (%0);" ::"r"(xp));

}

// fp * 1
int test0() {
  //   int8_t  w_int8[VEC_SIZE_0]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31};
  //   int8_t  x_int8[32]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31};
  //   float x_fp32[VEC_SIZE_0]={0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,17.0,18.0,19.0,20.0,21.0,22.0,23.0,24.0,25.0,26.0,27.0,28.0,29.0,30.0,31.0};
  int8_t  w_int8[VEC_SIZE_0] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
  //   float x_fp32[VEC_SIZE_0]   = {   2.0,    0.1,  0.256, 0.35, 0.86,  0.7, 0.0026,  0.4, 
                              //  1.5,    0.9,    1.8, -0.1,  2.0, -2.0,    0.3,  0.0,
  float x_fp32[VEC_SIZE_0] = {0.01046, 0.00956, -0.017,  -0.015,  -0.016,   0.013,   0 ,      0.5, 
                              0.15,    0.00416, 0.00256, 0.00156, 0.00056,  0.00016, 0.00006, 0.00001};
  float xinit_fp32[VEC_SIZE_0];
  float res_fp32[VEC_SIZE_0];
  float gold_fp32[VEC_SIZE_0];

  float threshold = (float) OLR_THD/ (float) MAX_QUANTIZE;


  for (int i = 0; i < VEC_SIZE_0; i++)
  {
    w_int8[i] = 1;
    xinit_fp32[i]  = 0.0;
    res_fp32[i]  = 0.0;
  }


  compute(w_int8, x_fp32, xinit_fp32, res_fp32, VEC_SIZE_0);
  
  printf("VIFMM RES:");
  for (int i = 0; i < VEC_SIZE_0; i++)
  {
    printf(" %f \t", res_fp32[i]);
  }
  printf("\n");


  printf("GOLD RES:");
  for (int i = 0; i < VEC_SIZE_0; i++)
  {
    gold_fp32[i] = (float)w_int8[i] * x_fp32[i] + xinit_fp32[i];
    printf(" %f \t", gold_fp32[i]);
  }
  printf("\n");

  for (int i = 0; i < VEC_SIZE_0; i++)
  {
    if (!similarity_check_32b(res_fp32[i], gold_fp32[i], threshold)) 
    {
        printf("==== ERROR! ====: i=%d   gold_fp32=%f   res_fp32=%f\n",i,gold_fp32[i],res_fp32[i]);
        return 0;
    }
  }
  
  return 1;
}

// fp * 1,2,3, ...
int test1() {
  int8_t  wint8[VEC_SIZE_1] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
  //   float x_fp32[VEC_SIZE_]   = {   2.0,    0.1,  0.256, 0.35, 0.86,  0.7, 0.0026,  0.4, 
                              //  1.5,    0.9,    1.8, -0.1,  2.0, -2.0,    0.3,  0.0,
  float xfp32[VEC_SIZE_1] = {-0.017, -0.015, -0.016,   10,  150,  -10,   1,    2,
                                300, -250  ,      8,  100,  100,   0 , 0.5, 0.15};
  float xinit_fp32[VEC_SIZE_1];
  float res_fp32[VEC_SIZE_1];
  float gold_fp32[VEC_SIZE_1];

  float threshold = (float) OLR_THD/ (float) MAX_QUANTIZE;
  // printf(" %f \n", threshold);

  for (int i = 0; i < VEC_SIZE_1; i++)
  {
    xinit_fp32[i]  = 0.0;
    res_fp32[i]  = 0.0;
  }

  compute(wint8, xfp32, xinit_fp32, res_fp32, VEC_SIZE_1);
  
  printf("VIFMM RES:");
  for (int i = 0; i < VEC_SIZE_1; i++)
  {
    printf(" %f \t", res_fp32[i]);
  }
  printf("\n");


  printf("GOLD RES:");
  for (int i = 0; i < VEC_SIZE_1; i++)
  {
    gold_fp32[i] = (float)wint8[i] * xfp32[i] + xinit_fp32[i];
    printf(" %f \t", gold_fp32[i]);
  }
  printf("\n");

  for (int i = 0; i < VEC_SIZE_1; i++)
  {
    if (!similarity_check_32b(res_fp32[i], gold_fp32[i], threshold)) 
    {
        printf("==== ERROR! ====: i=%d   gold_fp32=%f   res_fp32=%f\n",i,gold_fp32[i],res_fp32[i]);
        return 0;
    }
  }
  
  return 1;
}



float quantize(int8_t *qx, float* x, int n) {
  int num_groups = 1;
  float Q_MAX = 127.0f;
  float scale = 0.0f;

  // find the max absolute value in the current group
  float wmax = 0.0;
  for (int i = 0; i < VEC_SIZE_3; i++) {
      float val = fabs(x[i]);
      if (val > wmax) {
          wmax = val;
      }
  }

  // calculate and write the scaling factor
  scale = wmax / Q_MAX;

  // calculate and write the quantized values
  for (int i = 0; i < VEC_SIZE_3; i++) {
      float quant_value = x[i] / scale; // scale
      int8_t quantized = (int8_t) round(quant_value); // round and clamp
      qx[i] = quantized;
  }
  
  return scale;
}

int test3(float* x_fp32, int8_t* w_int8) {
    // int8_t  w_int8[VEC_SIZE_3] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
    //   float x_fp32[VEC_SIZE_3]   = {   2.0,    0.1,  0.256, 0.35, 0.86,  0.7, 0.0026,  0.4, 
                                //  1.5,    0.9,    1.8, -0.1,  2.0, -2.0,    0.3,  0.0,
    // float x_fp32[VEC_SIZE_3] = {-0.017, -0.015, -0.016,   10,  150,  -10,      1,    2,                                 300,   -250,      8,  100,  100,   0 ,    0.5, 0.15};
    float res_vifmm[VEC_SIZE_3];
    float gold_fp32[VEC_SIZE_3];
    int8_t qx[VEC_SIZE_3];
    int16_t res_qx_tmp;
    float res_qx_fp32[VEC_SIZE_3];
    float scale;

    // float threshold = (float) OLR_THD/ (float) MAX_QUANTIZE;
    float threshold = 1.0;
    // printf(" %f \n", threshold);

    printf("GOLD RES:");
    for (int i = 0; i < VEC_SIZE_3; i++)
    {
      gold_fp32[i] = (float)w_int8[i] * x_fp32[i] + (float)xinit[i] ;
      // printf(" %.10f \t", gold_fp32[i]);
    }
    printf("\n");

    compute(w_int8, x_fp32, xinit, res_vifmm, VEC_SIZE_3);
    printf("VIFMM RES:");
    for (int i = 0; i < VEC_SIZE_3; i++)
    {
      // printf(" %.10f \t", res_vifmm[i]);
    }
    printf("\n");
    printf("VIFMM ULP:");
    for (int i = 0; i < VEC_SIZE_3; i++)
    {
      printf(" %d \t", float_ulp_distance(res_vifmm[i], gold_fp32[i]));
    }
    printf("\n");


    scale = quantize(qx, x, VEC_SIZE_3);
    printf("X FP32 TO INT8 RES:");
    for (int i = 0; i < VEC_SIZE_3; i++)
    {
      res_qx_tmp = (int16_t)w_int8[i] * (int16_t)qx[i];
      res_qx_fp32[i] = (float)res_qx_tmp * scale + (float)xinit[i];
      // printf(" %.10f \t", res_qx_fp32[i]);
    }
    printf("\n");
    printf("X FP32 TO INT8 ULP:");
    for (int i = 0; i < VEC_SIZE_3; i++)
    {
      printf(" %d \t", float_ulp_distance(res_qx_fp32[i], gold_fp32[i]));
    }
    printf("\n");
    
    return 1;
}



int main() {
    printf("CPU PRINT!\n");
    
    if (test0())
    {
      printf("TEST0: PASS\n");
    } else {
      printf("TEST0: FAILED\n");
    }

    if (test1())
    {
      printf("TEST1: PASS\n");
    } else {
      printf("TEST1: FAILED\n");
    }
    

    // test2();
    // 

    if (test3(x, qw))
    {
      printf("TEST3: PASS\n");
    } else {
      printf("TEST3: FAILED\n");
    }
    
    return 0;
}
