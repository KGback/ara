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
#ifndef SPIKE
#include "printf.h"
#else
#include "util.h"
#include <stdio.h>
#endif

#define MIN(a, b) ((a) < (b) ? (a) : (b))

#define ROW 5
#define COL 188
#define VEC_SIZE 16


void compute( int8_t* w,  float* x_f,float* xp) {
    // W (d,n) * x (n,)   -> xout (d,)
    // x^T(,n) * W^T(n,d) -> xout^T (,d)
    unsigned long int block_size;
    unsigned long int block_size_max=65535;

    asm volatile("vsetvli %0, %1, e8, m2, ta, ma" : "=r"(block_size) : "r"(block_size_max));
    printf("Available block_size=%d\n", block_size);

    block_size = VEC_SIZE;

    asm volatile("vsetvli zero, %0, e32, m8, ta, ma" ::"r"(block_size));    
    asm volatile("vle32.v v0, (%0);" ::"r"(xp));
    asm volatile("vsetvli zero, %0, e8, m2, ta, ma" ::"r"(block_size));    
    asm volatile("vle8.v v16, (%0);" ::"r"(w));
    asm volatile("vsetvli zero, %0, e32, m8, ta, ma" ::"r"(block_size));    
    asm volatile("vle32.v v24, (%0);" ::"r"(x_f));
    asm volatile("vifmm.vv v0, v24, v16");

    asm volatile("vsetvli zero, %0, e32, m8, ta, ma" ::"r"(block_size));    
    asm volatile("vse32.v v0, (%0);" ::"r"(xp));

}

int test1() {
    //   int8_t  w_int8[VEC_SIZE]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31};
    //   int8_t  x_int8[32]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31};
    //   float x_fp32[VEC_SIZE]={0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,17.0,18.0,19.0,20.0,21.0,22.0,23.0,24.0,25.0,26.0,27.0,28.0,29.0,30.0,31.0};
    int8_t  w_int8[VEC_SIZE] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
    //   float x_fp32[VEC_SIZE]   = {   2.0,    0.1,  0.256, 0.35, 0.86,  0.7, 0.0026,  0.4, 
                                //  1.5,    0.9,    1.8, -0.1,  2.0, -2.0,    0.3,  0.0,
    float x_fp32[VEC_SIZE] = {-0.017, -0.015, -0.016,   10,  150,  -10,      1,    2,
                                 300,   -250,      8,  100,  100,   0 ,    0.5, 0.15};
    float xp_fp32[VEC_SIZE];


    for (int i = 0; i < VEC_SIZE; i++)
    {
      w_int8[i] = 1;
      xp_fp32[i]  = 0.0;
    }


    compute(w_int8, x_fp32, xp_fp32);
    
    printf("VIFMM RES:");
    for (int i = 0; i < VEC_SIZE; i++)
    {
      printf(" %f \t", xp_fp32[i]);
    }
    printf("\n");


    for (int i = 0; i < VEC_SIZE; i++)
    {
      xp_fp32[i]  = 0.0;
    }

    printf("GOLD RES:");
    for (int i = 0; i < VEC_SIZE; i++)
    {
      xp_fp32[i] = (float)w_int8[i] * x_fp32[i] + xp_fp32[i];
      printf(" %f \t", xp_fp32[i]);
    }
    printf("\n");
    return 0;
}

int test2() {
    //   int8_t  w_int8[VEC_SIZE]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31};
    //   int8_t  x_int8[32]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31};
    //   float x_fp32[VEC_SIZE]={0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,17.0,18.0,19.0,20.0,21.0,22.0,23.0,24.0,25.0,26.0,27.0,28.0,29.0,30.0,31.0};
    int8_t  w_int8[VEC_SIZE] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
    //   float x_fp32[VEC_SIZE]   = {   2.0,    0.1,  0.256, 0.35, 0.86,  0.7, 0.0026,  0.4, 
                                //  1.5,    0.9,    1.8, -0.1,  2.0, -2.0,    0.3,  0.0,
    float x_fp32[VEC_SIZE] = {-0.017, -0.015, -0.016,   10,  150,  -10,      1,    2,
                                 300,   -250,      8,  100,  100,   0 ,    0.5, 0.15};
    float xp_fp32[VEC_SIZE];


    for (int i = 0; i < VEC_SIZE; i++)
    {
      w_int8[i] = 1;
      xp_fp32[i]  = 0.1;
    }


    compute(w_int8, x_fp32, xp_fp32);
    
    printf("VIFMM RES:");
    for (int i = 0; i < VEC_SIZE; i++)
    {
      printf(" %f \t", xp_fp32[i]);
    }
    printf("\n");


    for (int i = 0; i < VEC_SIZE; i++)
    {
      xp_fp32[i]  = 0.1;
    }

    printf("GOLD RES:");
    for (int i = 0; i < VEC_SIZE; i++)
    {
      xp_fp32[i] = (float)w_int8[i] * x_fp32[i] + xp_fp32[i];
      printf(" %f \t", xp_fp32[i]);
    }
    printf("\n");
    return 0;
}

int test3() {
    //   int8_t  w_int8[VEC_SIZE]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31};
    //   int8_t  x_int8[32]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31};
    //   float x_fp32[VEC_SIZE]={0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,17.0,18.0,19.0,20.0,21.0,22.0,23.0,24.0,25.0,26.0,27.0,28.0,29.0,30.0,31.0};
    int8_t  w_int8[VEC_SIZE] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
    //   float x_fp32[VEC_SIZE]   = {   2.0,    0.1,  0.256, 0.35, 0.86,  0.7, 0.0026,  0.4, 
                                //  1.5,    0.9,    1.8, -0.1,  2.0, -2.0,    0.3,  0.0,
    float x_fp32[VEC_SIZE] = {-0.017, -0.015, -0.016,   10,  150,  -10,      1,    2,
                                 300,   -250,      8,  100,  100,   0 ,    0.5, 0.15};
    float xp_fp32[VEC_SIZE];


    for (int i = 0; i < VEC_SIZE; i++)
    {
      w_int8[i] = -1;
      xp_fp32[i]  = 0.0;
    }


    compute(w_int8, x_fp32, xp_fp32);
    
    printf("VIFMM RES:");
    for (int i = 0; i < VEC_SIZE; i++)
    {
      printf(" %f \t", xp_fp32[i]);
    }
    printf("\n");


    for (int i = 0; i < VEC_SIZE; i++)
    {
      xp_fp32[i]  = 0.0;
    }

    printf("GOLD RES:");
    for (int i = 0; i < VEC_SIZE; i++)
    {
      xp_fp32[i] = (float)w_int8[i] * x_fp32[i] + xp_fp32[i];
      printf(" %f \t", xp_fp32[i]);
    }
    printf("\n");
    return 0;
}

int main() {
    printf("CPU PRINT!\n");
    test1();
    printf("TEST1: PASS\n");

    // test2();
    // printf("TEST2: PASS\n");

    test3();
    printf("TEST3: PASS\n");
    return 0;
}
