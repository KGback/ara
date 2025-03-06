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

#ifndef SPIKE
#include "printf.h"
#else
#include "util.h"
#include <stdio.h>
#endif

#define MIN(a, b) ((a) < (b) ? (a) : (b))

#define ROW 3
#define COL 96

extern  int w[] __attribute__((aligned(32 * NR_LANES), section(".l2")));
extern  int x[] __attribute__((aligned(32 * NR_LANES), section(".l2")));
extern  int xout[] __attribute__((aligned(32 * NR_LANES), section(".l2")));
// Gold results
extern  int xout_g[] __attribute__((aligned(32 * NR_LANES), section(".l2")));

void gold_matmul( int* xout,  int* x,  int* w, int n, int d) {
    // W (d,n) @ x (n,) -> xout (d,)
    // by far the most amount of time is spent inside this little function
    int i;
    
    for (i = 0; i < d; i++) {
         int val = 0.0f;
        for (int j = 0; j < n; j++) {
            val += w[i * n + j] * x[j];
            // printf("j=%d, w=%x, x=%x, val=%d\n", j,w[i * n + j],x[j], val);
            // printf("j=%d, val=%d\n", j,val);
        }
        xout[i] = val;
    }
}

void matmul( int* xout,  int* x,  int* w, int n, int d) {
    // W (d,n) * x (n,)   -> xout (d,)
    // x^T(,n) * W^T(n,d) -> xout^T (,d)
    unsigned long int block_size;
    int* w_ = w;
    int* x_ = x;
    unsigned long int block_size_max=65535;

    asm volatile("vsetvli %0, %1, e32, m4, ta, ma" : "=r"(block_size) : "r"(block_size_max));
    
    printf("block_size=%d\n", block_size);

    for (unsigned long int i = 0; i < d; i++)
    {
        w_ = w + n * i;
        x_ = x;

        asm volatile("vmv.v.i v0,  0");
        asm volatile("vmv.v.i v4,  0");
        asm volatile("vmv.v.i v8,  0");

        for (unsigned long int m = 0; m < n; m += block_size) {
            
            const unsigned long int p_ = MIN(n - m, block_size);
            asm volatile("vsetvli zero, %0, e32, m4, ta, ma" ::"r"(p_));    
            // printf("p_=%d\n", p_);
            asm volatile("vle32.v v16, (%0);" ::"r"(w_));
            asm volatile("vle32.v v20, (%0);" ::"r"(x_));
            asm volatile("vmacc.vv v0, v16, v20");
            w_ += block_size;
            x_ += block_size;
        }
        asm volatile("vsetvli zero, %0, e32, m4, ta, ma" ::"r"(block_size));
        asm volatile("vredsum.vs v8, v0, v4");
        int sum;
        asm volatile("vmv.x.s %0, v8;":"=r"(sum));

        xout[i] = sum;

    }

}


int main() {
  printf("Ariane says Hello!\n");

  gold_matmul(xout_g, x, w, COL, ROW);
  matmul     (xout, x, w,   COL, ROW);

  printf("xout_g:");
  for (int i = 0; i < ROW; i++)
  {
    printf(" %d ", xout_g[i]);
    // if (xout_g[i] != xout[i])
    // {
      // printf("==== ERROR! ====: i=%d   xout_g=%d   xout=%d\n",i,xout_g[i],xout[i]);
      // break;
    // }
  }
  printf("\n");
  
  printf("xout:");
  for (int i = 0; i < ROW; i++)
  {
    printf(" %d ", xout[i]);
    // if (xout_g[i] != xout[i])
    // {
      // printf("==== ERROR! ====: i=%d   xout_g=%d   xout=%d\n",i,xout_g[i],xout[i]);
      // break;
    // }
  }
  printf("\n");


  return 0;
}
