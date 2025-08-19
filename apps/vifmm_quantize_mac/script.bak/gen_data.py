#!/usr/bin/env python3
# Copyright 2022 ETH Zurich and University of Bologna.
#
# SPDX-License-Identifier: Apache-2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Author: Matteo Perotti

# C = AB with A=[MxN], B=[NxP], C=[MxP]
# arg1, arg2, arg3: d, n, P

import random as rand
import numpy as np
import sys
from scipy.stats import truncnorm

def emit(name, array, alignment='8'):
  print(".global %s" % name)
  print(".balign " + alignment)
  print("%s:" % name)
  bs = array.tobytes()
  for i in range(0, len(bs), 4):
    s = ""
    for n in range(4):
      s += "%02x" % bs[i+3-n]
    print("    .word 0x%s" % s)

############
## SCRIPT ##
############

# if len(sys.argv) == 4:
#   d = int(sys.argv[1])
#   n = int(sys.argv[2])
#   P = int(sys.argv[3])
# else:
#   print("Error. Give me three argument: d, n, P.")
#   print("C = AB with A=[MxN], B=[NxP], C=[MxP]")
#   sys.exit()
d = 188
n = 5 
VEC_SIZE = 288*5000
P = 1 

dtypew = np.int8
dtypex = np.float32

# Matrices and results
# A = np.random.rand(d, n).astype(dtypew)
A = np.random.randint(low=-128,high=127,size=VEC_SIZE,dtype=np.int8)
# A = np.random.normal(loc=0.0, scale=1.0, size=(d, n))
# max_f = A.max()
# scale = max_f / 127
# qA = A / scale
# w = qA.astype(dtypew)

# 设置截断范围
x_max = 0.999999999999
x_min = -0.999999999999
x_loc   = 0  # 原始均值
x_scale = 1  # 标准差
truncated_norm = truncnorm(x_min, x_max, x_loc, x_scale)
B = truncated_norm.rvs(VEC_SIZE)
B = B.astype(np.float32)
D = truncated_norm.rvs(VEC_SIZE)
D = D.astype(np.float32)
# B = np.random.rand(n, P).astype(dtypex)
# B = np.random.normal(loc = 0, scale=0.005, size=500)

# Golden result matrix
G = np.matmul(A, B).astype(dtypex)

# Create the file
print(".section .data,\"aw\",@progbits")
# emit("d", np.array(d, dtype=np.uint64))
# emit("n", np.array(n, dtype=np.uint64))
# emit("P", np.array(P, dtype=np.uint64))
emit("w", A, 'NR_LANES*1')
emit("x", B, 'NR_LANES*4')
emit("xinit", D, 'NR_LANES*4')
emit("xout_g", G, 'NR_LANES*1')
