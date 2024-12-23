// Copyright 2021 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
//
// Author: Matheus Cavalcante <matheusd@iis.ee.ethz.ch>
//         Basile Bougenot <bbougenot@student.ethz.ch>

#include "vector_macros.h"

void TEST_CASE1() {
  VSET(16, e8, m1);
  VLOAD_8(v3, 8, 0, 0, 0, 0, 0, 0, 0);
  asm volatile("vmsof.m v2, v3");
  VSET(2, e8, m1);
  VCMP_U8(1, v2, 8, 0);
}

void TEST_CASE2() {
  VSET(16, e8, m1);
  VLOAD_8(v3, 0, 0, 0, 1, 0, 0, 0, 0);
  VLOAD_8(v0, 3, 0, 0, 0, 0, 0, 0, 0);
  VCLEAR(v2);
  asm volatile("vmsof.m v2, v3, v0.t");
  VSET(2, e8, m1);
  VCMP_U8(2, v2, 0, 0);

  VSET(16, e8, m1);
  VLOAD_8(v3, 0x38, 0, 0, 0, 0, 0, 0, 0);
  VLOAD_8(v0, 0xf7, 0, 0, 0, 0, 0, 0, 0);
  VCLEAR(v2);
  asm volatile("vmsof.m v2, v3, v0.t");
  VSET(2, e8, m1);
  VCMP_U8(3, v2, 0x10, 0);
}

int main(void) {
  INIT_CHECK();
  enable_vec();
  enable_fp();
  TEST_CASE1();
  TEST_CASE2();
  EXIT_CHECK();
}
