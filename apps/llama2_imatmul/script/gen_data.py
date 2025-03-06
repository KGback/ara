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
# arg1, arg2, arg3: M, N, P

import random as rand
import numpy as np
import sys

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

if len(sys.argv) == 4:
  M = int(sys.argv[1])
  N = int(sys.argv[2])
  P = int(sys.argv[3])
else:
  print("Error. Give me three argument: M, N, P.")
  print("C = AB with A=[MxN], B=[NxP], C=[MxP]")
  sys.exit()

dtype = np.int32

UPPER_LIMIT = 10000
LOWER_LIMIT = -10000

# Matrices and results
# A = np.random.randint(LOWER_LIMIT, UPPER_LIMIT, size=(M, N)).astype(dtype)
# B = np.random.randint(LOWER_LIMIT, UPPER_LIMIT, size=(N, P)).astype(dtype)
w = np.arange(0, M*N, step=1).astype(dtype)
A = w.reshape(M,N)
x = np.arange(1024, 1024+N*P, step=1).astype(dtype)
B = x.reshape(N,P)
C = np.zeros([M, P], dtype=dtype)
# Golden result matrix
G = np.matmul(A, B).astype(dtype)

# Create the file
print(".section .data,\"aw\",@progbits")
emit("w", A, 'NR_LANES*4')
emit("x", B, 'NR_LANES*4')
emit("xout", C, 'NR_LANES*4')
emit("xout_g", G, 'NR_LANES*4')
