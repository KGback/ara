// Copyright 2020 ETH Zurich and University of Bologna.
//
// SPDX-License-Identifier: Apache-2.0
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Author: Matheus Cavalcante, ETH Zurich

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
#define VEC_SIZE_3     100
#define OLR_THD       2
#define MAX_QUANTIZE  127
#define GS 64

extern int8_t w[]         __attribute__((aligned(1 * NR_LANES), section(".data")));
extern float x[]          __attribute__((aligned(4 * NR_LANES), section(".data")));
extern float xinit[]      __attribute__((aligned(1 * NR_LANES), section(".data")));
extern int8_t xout_g[]    __attribute__((aligned(1 * NR_LANES), section(".data")));


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
    asm volatile("vle32.v v16, (%0);" ::"r"(x_f));
    asm volatile("vsetvli zero, %0, e8, m2, ta, ma" ::"r"(block_size));    
    asm volatile("vle8.v v24, (%0);" ::"r"(w));
    asm volatile("vsetvli zero, %0, e32, m8, ta, ma" ::"r"(block_size));    
    // asm volatile("vle32.v v16, (%0);" ::"r"(x_f));
    asm volatile("vifbw.vv v0, v16, v24");  // llvm
    // asm volatile("vifbw v0, v24, v16");   // gcc

    asm volatile("vsetvli zero, %0, e32, m8, ta, ma" ::"r"(block_size));    
    asm volatile("vse32.v v0, (%0);" ::"r"(xp));

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

void quantize_GS(int8_t *qx, float *sf, float* x, int n) {
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
      sf[group] = scale;

      // calculate and write the quantized values
      for (int i = 0; i < GS; i++) {
          float quant_value = x[group * GS + i] / scale; // scale
          int8_t quantized = (int8_t) round(quant_value); // round and clamp
          qx[group * GS + i] = quantized;
      }
  }
}

float vifbw_e32_m4( float* x, int8_t* w, int size) {
  // W (d,n) * x (n,)   -> xout (d,)
  // x^T(,n) * W^T(n,d) -> xout^T (,d)
  unsigned long int block_size;
  int8_t* w_  = w;
  float* x_   = x;
  float  sum;
  unsigned long int block_size_max=65535;

  asm volatile("vsetvli %0, %1, e32, m4, ta, ma" : "=r"(block_size) : "r"(block_size_max));
  asm volatile("vmv.v.i v8,  0");
  asm volatile("vmv.v.i v0,  0");

  // printf("Available block_size=%d\n", block_size);

  if (size < block_size)
  {
      asm volatile("vsetvli zero, %0, e32, m4, ta, ma" ::"r"(size));    
      asm volatile("vle32.v v16, (%0);" ::"r"(x_));
      asm volatile("vsetvli zero, %0, e8, m1, ta, ma" ::"r"(size));    
      asm volatile("vle8.v v24, (%0);" ::"r"(w_));
      asm volatile("vsetvli zero, %0, e32, m4, ta, ma" ::"r"(size));    
    #ifndef LLVM
      asm volatile(".word 0xbb882057");   // gcc  vifbw v0, v24, v16
    #else
    //   asm volatile(".word 0xbb0c2057");    // llvm vifbw.vv v0, v16, v24
      asm volatile("vifbw.vv v0, v16, v24");
    #endif

      
  } else {
  
      for (unsigned long int m = 0; m < size; m += block_size) {
        const unsigned long int p_ = MIN(size - m, block_size);
        asm volatile("vsetvli zero, %0, e32, m4, ta, ma" ::"r"(p_));    
        asm volatile("vle32.v v16, (%0);" ::"r"(x_));
        asm volatile("vsetvli zero, %0, e8, m1, ta, ma" ::"r"(p_));    
        asm volatile("vle8.v v24, (%0);" ::"r"(w_));
        w_ += block_size;
        x_ += block_size;
        asm volatile("vsetvli zero, %0, e32, m4, ta, ma" ::"r"(p_));    
      #ifndef LLVM
        asm volatile(".word 0xbb882057");   // gcc  vifbw v0, v24, v16
      #else
      //   asm volatile(".word 0xbb0c2057");    // llvm vifbw.vv v0, v16, v24
        asm volatile("vifbw.vv v0, v16, v24");
      #endif
      }
  }
  asm volatile("vfredsum.vs v8, v0, v8");  // vredsum.vs vd, vs2,vs1; vd[0]=sum(vs1[0], vs2[*])
  asm volatile("vfmv.f.s %0, v8;":"=f"(sum));
  return sum;
}

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

int test2() {
  int8_t  wint8[VEC_SIZE_2] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
  //   float x_fp32[VEC_SIZE_]   = {   2.0,    0.1,  0.256, 0.35, 0.86,  0.7, 0.0026,  0.4, 
                              //  1.5,    0.9,    1.8, -0.1,  2.0, -2.0,    0.3,  0.0,
  float xfp32[VEC_SIZE_2] = {-0.017, -0.015, -0.016,   10,  150,  -10,   1,    2,
                                300, -250  ,      8,  100,  100,   0 , 0.5, 0.15};
  float xinit_fp32[VEC_SIZE_2];
  float res_fp32[VEC_SIZE_2];
  float gold_fp32[VEC_SIZE_2];

  float threshold = (float) OLR_THD/ (float) MAX_QUANTIZE;
  // printf(" %f \n", threshold);

  for (int i = 0; i < VEC_SIZE_2; i++)
  {
    xinit_fp32[i]  = 1.0;
    res_fp32[i]  = 0.0;
  }

  compute(wint8, xfp32, xinit_fp32, res_fp32, VEC_SIZE_2);
  
  printf("VIFMM RES:");
  for (int i = 0; i < VEC_SIZE_2; i++)
  {
    printf(" %f \t", res_fp32[i]);
  }
  printf("\n");


  printf("GOLD RES:");
  for (int i = 0; i < VEC_SIZE_2; i++)
  {
    gold_fp32[i] = (float)wint8[i] * xfp32[i] + xinit_fp32[i];
    printf(" %f \t", gold_fp32[i]);
  }
  printf("\n");

  for (int i = 0; i < VEC_SIZE_2; i++)
  {
    if (!similarity_check_32b(res_fp32[i], gold_fp32[i], threshold)) 
    {
        printf("==== ERROR! ====: i=%d   gold_fp32=%f   res_fp32=%f\n",i,gold_fp32[i],res_fp32[i]);
        return 0;
    }
  }
  
  return 1;
}

int test3(float* x_fp32, int8_t* w_int8) {
    // int8_t  w_int8[VEC_SIZE_3] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
    //   float x_fp32[VEC_SIZE_3]   = {   2.0,    0.1,  0.256, 0.35, 0.86,  0.7, 0.0026,  0.4, 
                                //  1.5,    0.9,    1.8, -0.1,  2.0, -2.0,    0.3,  0.0,
    // float x_fp32[VEC_SIZE_3] = {-0.017, -0.015, -0.016,   10,  150,  -10,      1,    2,                                 300,   -250,      8,  100,  100,   0 ,    0.5, 0.15};
    float res_fp32[VEC_SIZE_3];
    float gold_fp32[VEC_SIZE_3];

    // float threshold = (float) OLR_THD/ (float) MAX_QUANTIZE;
    float threshold = 1.0;
    // printf(" %f \n", threshold);

    compute(w_int8, x_fp32, xinit, res_fp32, VEC_SIZE_3);
    
    printf("VIFMM RES:");
    for (int i = 0; i < VEC_SIZE_3; i++)
    {
      printf(" %f \t", res_fp32[i]);
    }
    printf("\n");


    printf("GOLD RES:");
    for (int i = 0; i < VEC_SIZE_3; i++)
    {
      gold_fp32[i] = (float)w_int8[i] * x_fp32[i] + (float)xinit[i];
      printf(" %f \t", gold_fp32[i]);
    }
    printf("\n");

    // printf("Stack address: %p, %p, %p, %p\n", (void*)&res_fp32[0],(void*)&res_fp32[1], (void*)&res_fp32[2],(void*)&res_fp32[3]);
    // printf("Stack address: %p, %p, %p, %p\n", (void*)&gold_fp32[0],(void*)&gold_fp32[1], (void*)&gold_fp32[2],(void*)&gold_fp32[3]);

    for (int i = 0; i < VEC_SIZE_3; i++)
    {
      if (!similarity_check_32b(res_fp32[i], gold_fp32[i], threshold)) 
      {
          printf("==== ERROR! ====: i=%d, w_int8=%x  x_fp32=%f  gold_fp32=%f   res_fp32=%f\n",i,w_int8[i], x_fp32[i],gold_fp32[i],res_fp32[i]);
          return 0;
      }
    }
    
    return 1;
}

int test4(float* x_fp32, int8_t* w_int8) {
  // int8_t  w_int8[VEC_SIZE_3] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
  //   float x_fp32[VEC_SIZE_3]   = {   2.0,    0.1,  0.256, 0.35, 0.86,  0.7, 0.0026,  0.4, 
                              //  1.5,    0.9,    1.8, -0.1,  2.0, -2.0,    0.3,  0.0,
  // float x_fp32[VEC_SIZE_3] = {-0.017, -0.015, -0.016,   10,  150,  -10,      1,    2,                                 300,   -250,      8,  100,  100,   0 ,    0.5, 0.15};
  float res_rvv;
  float res_vifmm;
  float gold_fp32;
  int8_t qx[VEC_SIZE_3];
  int16_t res_qx_tmp;
  float res_qx_fp32=0.0;
  float res_fp32[VEC_SIZE_3];
  float res_sum_fp32=0.0;
  float scale;

  // float threshold = (float) OLR_THD/ (float) MAX_QUANTIZE;
  float threshold = 1.0;
  // printf(" %f \n", threshold);
  for (int i = 0; i < VEC_SIZE_3; i++)
  {
    res_fp32[i] = (float)w_int8[i] * x[i];
    res_sum_fp32 += res_fp32[i];
    // printf(" %f \t", res_fp32[i]);
  }

  printf("\nFP32: %.10f \n", res_sum_fp32);

  res_vifmm = vifbw_e32_m4(x, w_int8, VEC_SIZE_3);
  printf("VIFMM: %.10f \n", res_vifmm);

  scale = quantize(qx, x, VEC_SIZE_3);
  res_rvv = rvv_vwmul_e8_m1(qx, w_int8, VEC_SIZE_3);
  printf("VMACC: %.10f \n", res_rvv * scale);

  for (int i = 0; i < VEC_SIZE_3; i++)
    {
      res_qx_tmp = (int16_t)w_int8[i] * (int16_t)qx[i];
      res_qx_fp32 += (float)res_qx_tmp;
    }
  printf("INT8: %.10f \n", res_qx_fp32 * scale);
    
  return 1;
}

void matmul(float* xout, float* x, float* w, int n, int d) {
  // W (d,n) @ x (n,) -> xout (d,)
  // by far the most amount of time is spent inside this little function
  int i;

  for (i = 0; i < d; i++) {
      float val = 0.0f;
      for (int j = 0; j < n; j++) {
          val   += w[i * n + j] * x[j];
      }
      xout[i] = val;
  }
}

void matmul_Q_VIFMM(float* xout, float* x, int8_t *w, int n, int d) {
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
          fval = vifbw_e32_m4(&x[j], &w[in + j], GS);
          val +=  fval;
      }

      xout[i] = val;
  }
}

void matmul_Q_RVV(float* xout, int8_t *x, int8_t *w, float *sf, int n, int d) {
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
          fval = rvv_vwmul_e8_m1(&x[j], &w[in + j], GS);
          val +=  fval * sf[j / GS];
          fval = 0;
      }
      xout[i] = val;
  }
}

void matmul_Q(float* xout, int8_t *x, int8_t *w, float *sf, int n, int d) {
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
              ival += ((int32_t) x[j + k]) * ((int32_t) w[in + j + k]);
          }
          val += ((float) ival) * sf[j / GS];
          ival = 0;
      }

      xout[i] = val;
  }
}

int test5(float* x_fp32, int8_t* w_int8) {
  // int8_t  w_int8[VEC_SIZE_3] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
  //   float x_fp32[VEC_SIZE_3]   = {   2.0,    0.1,  0.256, 0.35, 0.86,  0.7, 0.0026,  0.4, 
                              //  1.5,    0.9,    1.8, -0.1,  2.0, -2.0,    0.3,  0.0,
  // float x_fp32[VEC_SIZE_3] = {-0.017, -0.015, -0.016,   10,  150,  -10,      1,    2,                                 300,   -250,      8,  100,  100,   0 ,    0.5, 0.15};
  float res_rvv[VEC_SIZE_3];
  float res_vifmm[VEC_SIZE_3];
  float res_fp32[VEC_SIZE_3];
  float res_int8[VEC_SIZE_3];
  float w_fp32[VEC_SIZE_3*GS];
  int8_t qx[VEC_SIZE_3*GS];
  float scale[VEC_SIZE_3];

  float threshold = 1.0;
  
  matmul_Q_VIFMM(res_vifmm, x_fp32, w_int8, GS, VEC_SIZE_3);
  printf("VIFMM RES:");
  for (int i = 0; i < VEC_SIZE_3; i++)
  {
    printf(" %f \t", res_vifmm[i]);
  }
  printf("\n");

  for (int i = 0; i < VEC_SIZE_3*GS; i++)
    {
      w_fp32[i] = (float) w_int8[i];
    }
  matmul(res_fp32, x_fp32, w_fp32, GS, VEC_SIZE_3);
  
  printf("FP32 RES:");
  for (int i = 0; i < VEC_SIZE_3; i++)
  {
    printf(" %f \t", res_fp32[i]);
  }
  printf("\n");

  for (int i = 0; i < VEC_SIZE_3; i++)
  {
    if (!similarity_check_32b(res_fp32[i], res_vifmm[i], threshold)) 
    {
        printf("==== ERROR! ====: i=%d, w_int8=%x  x_fp32=%f  gold_fp32=%f   res_fp32=%f\n",i,w_int8[i], x_fp32[i],res_vifmm[i],res_fp32[i]);
        return 0;
    }
  }
  

  // quantize_GS(qx, scale, x_fp32, VEC_SIZE_3*GS);

  // matmul_Q_RVV(res_rvv, qx, w_int8, scale, GS, VEC_SIZE_3);
  // printf("RVV RES:");
  // for (int i = 0; i < VEC_SIZE_3; i++)
  // {
  //   printf(" %f \t", res_rvv[i]);
  // }
  // printf("\n");
  // printFloatBinary(res_rvv * scale);

  // matmul_Q(res_int8, qx, w_int8, scale, GS, VEC_SIZE_3);  
  // printf("INT8 RES:");
  // for (int i = 0; i < VEC_SIZE_3; i++)
  // {
  //   printf(" %f \t", res_int8[i]);
  // }
  // printf("\n");
  // printFloatBinary(res_qx_fp32 * scale);
    
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
    

    // if (test2())
    // {
    //   printf("TEST2: PASS\n");
    // } else {
    //   printf("TEST2: FAILED\n");
    // }

    // if (test3(x, w))
    // {
    //   printf("TEST3: PASS\n");
    // } else {
    //   printf("TEST3: FAILED\n");
    // }

    // if (test4(x, w))
    // {
    //   printf("TEST4: PASS\n");
    // } else {
    //   printf("TEST4: FAILED\n");
    // }

    if (test5(x, w))
    {
      printf("TEST5: PASS\n");
    } else {
      printf("TEST5: FAILED\n");
    }
    return 0;
}
