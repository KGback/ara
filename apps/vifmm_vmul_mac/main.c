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
#define VEC_SIZE_3     500
#define OLR_THD       2
#define MAX_QUANTIZE  127

extern int8_t w[]         __attribute__((aligned(1 * NR_LANES), section(".data")));
extern float x[]          __attribute__((aligned(4 * NR_LANES), section(".data")));
extern int8_t qx[]        __attribute__((aligned(1 * NR_LANES), section(".data")));
extern float xinit[]      __attribute__((aligned(1 * NR_LANES), section(".data")));
extern int8_t xout_g[]    __attribute__((aligned(1 * NR_LANES), section(".data")));

int GS = 64;

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
      asm volatile("vsetvli zero, %0, e8, m1, ta, ma" ::"r"(size));    
      asm volatile("vle8.v v24, (%0);" ::"r"(w_));
      asm volatile("vsetvli zero, %0, e32, m4, ta, ma" ::"r"(size));    
      asm volatile("vle32.v v16, (%0);" ::"r"(x_));
    #ifndef LLVM
      asm volatile(".word 0xbb882057");   // gcc  vifbw v0, v24, v16
    #else
    //   asm volatile(".word 0xbb0c2057");    // llvm vifbw.vv v0, v16, v24
      asm volatile("vifbw.vv v0, v16, v24");
    #endif

      
  } else {
  
      for (unsigned long int m = 0; m < size; m += block_size) {
        const unsigned long int p_ = MIN(size - m, block_size);
        asm volatile("vsetvli zero, %0, e8, m1, ta, ma" ::"r"(p_));    
        asm volatile("vle8.v v24, (%0);" ::"r"(w_));
        asm volatile("vsetvli zero, %0, e32, m4, ta, ma" ::"r"(p_));    
        asm volatile("vle32.v v16, (%0);" ::"r"(x_));
      #ifndef LLVM
        asm volatile(".word 0xbb882057");   // gcc  vifbw v0, v24, v16
      #else
      //   asm volatile(".word 0xbb0c2057");    // llvm vifbw.vv v0, v16, v24
        asm volatile("vifbw.vv v0, v16, v24");
      #endif
        w_ += block_size;
        x_ += block_size;
      }
  }
  asm volatile("vfredsum.vs v8, v0, v8");  // vredsum.vs vd, vs2,vs1; vd[0]=sum(vs1[0], vs2[*])
  asm volatile("vfmv.f.s %0, v8;":"=f"(sum));
  return sum;
}

void matmul(float* xout, float* x, int8_t *w, int n, int d) {
  // W (d,n) @ x (n,) -> xout (d,)
  // by far the most amount of time is spent inside this little function
  // inputs to this function are both quantized

  int i;
  printf("GOLD RES:");
  for (i = 0; i < d; i++) {

      float val = 0.0f;
      float ival = 0.0f;
      int in = i * n;

      // do the matmul in groups of GS
      int j;
      
      for (j = 0; j <= n - GS; j += GS) {
          for (int k = 0; k < GS; k++) {
              ival +=  x[j + k] * ((float) w[in + j + k]);
          }
          printf("%f ", ival);
          val +=  ival * 0.0078 ;
          printf("%f ", val);
          ival = 0;
      }
      xout[i] = val;
  }
  printf("\r\n");
}

void matmul_vifmm(float* xout, float* x, int8_t *w, int n, int d) {
  // W (d,n) @ x (n,) -> xout (d,)
  // by far the most amount of time is spent inside this little function
  // inputs to this function are both quantized

  int i;
  printf("VIFMM RES:");
  for (i = 0; i < d; i++) {

      float val = 0.0f;
      float fval = 0;
      int in = i * n;

      // do the matmul in groups of GS
      int j;
      
      for (j = 0; j <= n - GS; j += GS) {
          fval = vifbw_e32_m4(&x[j], &w[in + j], GS);
          printf("%f ", fval);
          val +=  fval * 0.0078;
          printf("%f ", val);
          fval = 0;
      }
      xout[i] = val;
      
  }
  printf("\r\n");
}



int main() {
    printf("CPU PRINT!\n");
    float res_fp32[VEC_SIZE_3];
    float gold_fp32[VEC_SIZE_3];

    matmul_vifmm(res_fp32, x, w, GS, 64);
    matmul(     gold_fp32, x, w, GS, 64);

    for (int i = 0; i < VEC_SIZE_3; i++)
    {
      if (!similarity_check_32b(res_fp32[i], gold_fp32[i], 1.0)) 
      {
          printf("==== ERROR! ====: i=%d,   gold_fp32=%f   res_fp32=%f\n",i,gold_fp32[i],res_fp32[i]);
          return 0;
      }
    }
    
    return 0;
}
