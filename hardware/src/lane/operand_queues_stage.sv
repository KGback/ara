// Copyright 2021 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
//
// Author: Matheus Cavalcante <matheusd@iis.ee.ethz.ch>
// Description:
// This stage holds the operand queues, holding elements for the VRFs.

module operand_queues_stage import ara_pkg::*; import rvv_pkg::*; import cf_math_pkg::idx_width; import ifmix_pkg::*; #(
    parameter int     unsigned NrLanes          = 0,
    parameter int     unsigned VLEN             = 0,
    // Support for floating-point data types
    parameter fpu_support_e FPUSupport          = FPUSupportHalfSingleDouble,
    parameter type          operand_queue_cmd_t = logic
  ) (
    input  logic                                     clk_i,
    input  logic                                     rst_ni,
    input  logic            [idx_width(NrLanes)-1:0] lane_id_i,
    // Interface with the Vector Register File
    input  elen_t              [NrOperandQueues-1:0] operand_i,
    input  logic               [NrOperandQueues-1:0] operand_valid_i,
    // Input with the Operand Requester
    input  logic               [NrOperandQueues-1:0] operand_issued_i,
    output logic               [NrOperandQueues-1:0] operand_queue_ready_o,
    input  operand_queue_cmd_t [NrOperandQueues-1:0] operand_queue_cmd_i,
    input  logic               [NrOperandQueues-1:0] operand_queue_cmd_valid_i,
    // Support for store exception flush
    input  logic                                     lsu_ex_flush_i,
    output logic                                     lsu_ex_flush_o,
    // Interface with the Lane Sequencer
    output logic                                     mask_b_cmd_pop_o,
    // Interface with the Lane
    output logic                                     sldu_addrgen_cmd_pop_o,
    // Interface with the VFUs
    // ALU
    output elen_t              [1:0]                 alu_operand_o,
    output logic               [1:0]                 alu_operand_valid_o,
    input  logic               [1:0]                 alu_operand_ready_i,
    // Multiplier/FPU
    output elen_t              [2:0]                 mfpu_operand_o,
    output logic               [2:0]                 mfpu_operand_valid_o,
    input  logic               [2:0]                 mfpu_operand_ready_i,
    // Store unit
    output elen_t                                    stu_operand_o,
    output logic                                     stu_operand_valid_o,
    input  logic                                     stu_operand_ready_i,
    // Slide Unit/Address Generation unit
    output elen_t                                    sldu_addrgen_operand_o,
    output target_fu_e                               sldu_addrgen_operand_target_fu_o,
    output logic                                     sldu_addrgen_operand_valid_o,
    input  logic                                     sldu_addrgen_operand_ready_i,
    // Mask unit
    output elen_t              [1:0]                 mask_operand_o,
    output logic               [1:0]                 mask_operand_valid_o,
    input  logic               [1:0]                 mask_operand_ready_i,

    output logic [3:0] [1:0]                          transfer_type_o,
    output logic [3:0] [15:0]                         transfer_data_o,
    output logic                                    transfer_all_quantize_en_o
  );

  `include "common_cells/registers.svh"

  // STU flush support
  `FF(lsu_ex_flush_o, lsu_ex_flush_i, 1'b0, clk_i, rst_ni);

  ///////////
  //  ALU  //
  ///////////

  operand_queue #(
    .CmdBufDepth        (ValuInsnQueueDepth   ),
    .DataBufDepth       (5                    ),
    .FPUSupport         (FPUSupportNone       ),
    .NrLanes            (NrLanes              ),
    .VLEN               (VLEN                 ),
    .SupportIntExt2     (1'b1                 ),
    .SupportIntExt4     (1'b1                 ),
    .SupportIntExt8     (1'b1                 ),
    .SupportReduct      (1'b1                 ),
    .SupportNtrVal      (1'b0                 ),
    .operand_queue_cmd_t(operand_queue_cmd_t  )
  ) i_operand_queue_alu_a (
    .clk_i                    (clk_i                          ),
    .rst_ni                   (rst_ni                         ),
    .flush_i                  (1'b0                           ),
    .lane_id_i                (lane_id_i                      ),
    .operand_queue_cmd_i      (operand_queue_cmd_i[AluA]      ),
    .operand_queue_cmd_valid_i(operand_queue_cmd_valid_i[AluA]),
    .cmd_pop_o                (/* Unused */                   ),
    .operand_i                (operand_i[AluA]                ),
    .operand_valid_i          (operand_valid_i[AluA]          ),
    .operand_issued_i         (operand_issued_i[AluA]         ),
    .operand_queue_ready_o    (operand_queue_ready_o[AluA]    ),
    .operand_o                (alu_operand_o[0]               ),
    .operand_target_fu_o      (/* Unused */                   ),
    .operand_valid_o          (alu_operand_valid_o[0]         ),
    .operand_ready_i          (alu_operand_ready_i[0]         )
  );

  operand_queue #(
    .CmdBufDepth        (ValuInsnQueueDepth   ),
    .DataBufDepth       (5                    ),
    .FPUSupport         (FPUSupportNone       ),
    .NrLanes            (NrLanes              ),
    .VLEN               (VLEN                 ),
    .SupportIntExt2     (1'b1                 ),
    .SupportIntExt4     (1'b1                 ),
    .SupportIntExt8     (1'b1                 ),
    .SupportReduct      (1'b1                 ),
    .SupportNtrVal      (1'b1                 ),
    .operand_queue_cmd_t(operand_queue_cmd_t  )
  ) i_operand_queue_alu_b (
    .clk_i                    (clk_i                          ),
    .rst_ni                   (rst_ni                         ),
    .flush_i                  (1'b0                           ),
    .lane_id_i                (lane_id_i                      ),
    .operand_queue_cmd_i      (operand_queue_cmd_i[AluB]      ),
    .operand_queue_cmd_valid_i(operand_queue_cmd_valid_i[AluB]),
    .cmd_pop_o                (/* Unused */                   ),
    .operand_i                (operand_i[AluB]                ),
    .operand_valid_i          (operand_valid_i[AluB]          ),
    .operand_issued_i         (operand_issued_i[AluB]         ),
    .operand_queue_ready_o    (operand_queue_ready_o[AluB]    ),
    .operand_o                (alu_operand_o[1]               ),
    .operand_target_fu_o      (/* Unused */                   ),
    .operand_valid_o          (alu_operand_valid_o[1]         ),
    .operand_ready_i          (alu_operand_ready_i[1]         )
  );

  //////////////////////
  //  Multiplier/FPU  //
  //////////////////////

  // gukai@20250625: CONTROL module for choosing  quantization or compensation
  logic [3:0] [1:0]                          transfer_type;
  logic [3:0] [15:0]                         transfer_data;
  logic                                    transfer_full_valid;
  elen_t [3:0]                            mfpu_operand_a, mfpu_operand_c;
  logic                                    transfer_all_quantize_en;
  logic                                    cmd_dead;
  logic[$clog2(VLEN+1)-1:0]                elem_sum_a, elem_sum_c;
  opqueue_conversion_e                     conv_vifmm_Pre, conv_vifmm_a, conv_vifmm_b, conv_vifmm_c;

  assign transfer_type_o        = transfer_type;
  assign transfer_data_o        = transfer_data;
  assign transfer_all_quantize_en_o        = transfer_all_quantize_en;

  quantize_control #(
    .VLEN               (VLEN                 ),
    .DataBufDepth     ( 16)  
  ) i_quantize_control (
    .clk_i                ( clk_i )  ,
    .rst_ni               ( rst_ni )  ,
    .flush_i              ( flush_i )    ,
    .operand_a_i          ( operand_i[MulFPUA] )        ,
    .operand_a_valid_i    ( operand_valid_i[MulFPUA] ),
    .operand_c_i          ( operand_i[MulFPUC] )        ,
    .operand_c_valid_i    ( operand_valid_i[MulFPUC] ),
    .conv_a_i             ( conv_vifmm_a ),
    .conv_b_i             ( conv_vifmm_b ),
    .conv_c_i             ( conv_vifmm_c ),
    .conv_dead_i          ( cmd_dead ),
    .elem_sum_a_i         ( elem_sum_a ), 
    .elem_sum_c_i         ( elem_sum_c ), 
    .transfer_type_o      ( transfer_type ),
    .transfer_data_o      ( transfer_data ),
    .transfer_full_valid_o( transfer_full_valid ),
    .transfer_all_quantize_en_o( transfer_all_quantize_en ),
    .conv_vifmm_o         ( conv_vifmm_Pre )
  );

  PreU i_PreU (
    .clk_i                ( clk_i )  ,
    .rst_ni               ( rst_ni )  ,
    .operand_valid_i      ( mfpu_operand_valid_o ),
    .operand_a_i          ( mfpu_operand_a ),
    .operand_c_i          ( mfpu_operand_c ),
    .transfer_type_i      ( transfer_type       ),
    .transfer_data_i      ( transfer_data       ),
    .conv_i               ( conv_vifmm_Pre )  ,
    .transfer_all_quantize_en_i ( transfer_all_quantize_en ),
    .operand_a_o          ( mfpu_operand_o[0]   ),
    .operand_c_o          ( mfpu_operand_o[2]   )
  );

  operand_queue_mfpu_a #(
    .CmdBufDepth        (MfpuInsnQueueDepth   ),
    .DataBufDepth       (16                    ),
    .FPUSupport         (FPUSupport           ),
    .AccessCmdPop       (1'b1 ),
    .NrLanes            (NrLanes              ),
    .VLEN               (VLEN                 ),
    .SupportIntExt2     (1'b1                 ),
    .SupportReduct      (1'b1                 ),
    .SupportNtrVal      (1'b0                 ),
    .operand_queue_cmd_t(operand_queue_cmd_t)
  ) i_operand_queue_mfpu_a (
    .clk_i                    (clk_i                             ),
    .rst_ni                   (rst_ni                            ),
    .flush_i                  (1'b0                              ),
    .lane_id_i                (lane_id_i                         ),
    .operand_queue_cmd_i      (operand_queue_cmd_i[MulFPUA]      ),
    .operand_queue_cmd_valid_i(operand_queue_cmd_valid_i[MulFPUA]),
    .cmd_pop_o                (cmd_dead                         ),  // gukai@20250704
    .operand_i                (operand_i[MulFPUA]                ),
    .operand_valid_i          (operand_valid_i[MulFPUA]          ),
    .operand_issued_i         (operand_issued_i[MulFPUA]         ),
    .operand_queue_ready_o    (operand_queue_ready_o[MulFPUA]    ),
    .operand_o                (mfpu_operand_a                 ),  // gukai@20250625: mfpu_operand_a is used to hold the operand_a for PreU, which is repleased by mfpu_operand_o[0]
    .operand_target_fu_o      (/* Unused */                      ),
    .operand_valid_o          (mfpu_operand_valid_o[0]           ),
    .operand_ready_i          (mfpu_operand_ready_i[0]           ),
    .transfer_all_quantize_en_i          ( transfer_all_quantize_en ),
    .conv_vifmm_o             (conv_vifmm_a                  ),
    .elem_sum_a_o           (elem_sum_a                     )
  );

  operand_queue_mfpu_b #(
    .CmdBufDepth        (MfpuInsnQueueDepth   ),
    .DataBufDepth       (16                    ),
    .FPUSupport         (FPUSupport           ),
    .NrLanes            (NrLanes              ),
    .VLEN               (VLEN                 ),
    .SupportIntExt2     (1'b1                 ),
    .SupportReduct      (1'b1                 ),
    .SupportNtrVal      (1'b1                 ),
    .operand_queue_cmd_t(operand_queue_cmd_t  )
  ) i_operand_queue_mfpu_b (
    .clk_i                    (clk_i                             ),
    .rst_ni                   (rst_ni                            ),
    .flush_i                  (1'b0                              ),
    .lane_id_i                (lane_id_i                         ),
    .operand_queue_cmd_i      (operand_queue_cmd_i[MulFPUB]      ),
    .operand_queue_cmd_valid_i(operand_queue_cmd_valid_i[MulFPUB]),
    .cmd_pop_o                (/* Unused */                      ),
    .operand_i                (operand_i[MulFPUB]                ),
    .operand_valid_i          (operand_valid_i[MulFPUB]          ),
    .operand_issued_i         (operand_issued_i[MulFPUB]         ), 
    .operand_queue_ready_o    (operand_queue_ready_o[MulFPUB]    ),
    .operand_o                (mfpu_operand_o[1]                 ),
    .operand_target_fu_o      (/* Unused */                      ),
    .operand_valid_o          (mfpu_operand_valid_o[1]           ),
    .operand_ready_i          (mfpu_operand_ready_i[1]           ),
    .transfer_all_quantize_en_i          ( transfer_all_quantize_en ),
    .conv_vifmm_o             (conv_vifmm_b                  )
  );

  operand_queue_mfpu_c #(
    .CmdBufDepth        (MfpuInsnQueueDepth   ),
    .DataBufDepth       (16                    ),
    .FPUSupport         (FPUSupport           ),
    .NrLanes            (NrLanes              ),
    .VLEN               (VLEN                 ),
    .SupportIntExt2     (1'b1                 ),
    .SupportReduct      (1'b1                 ),
    .SupportNtrVal      (1'b1                 ),
    .operand_queue_cmd_t(operand_queue_cmd_t  )
  ) i_operand_queue_mfpu_c (
    .clk_i                    (clk_i                             ),
    .rst_ni                   (rst_ni                            ),
    .flush_i                  (1'b0                              ),
    .lane_id_i                (lane_id_i                         ),
    .operand_queue_cmd_i      (operand_queue_cmd_i[MulFPUC]      ),
    .operand_queue_cmd_valid_i(operand_queue_cmd_valid_i[MulFPUC]),
    .cmd_pop_o                (/* Unused */                      ),
    .operand_i                (operand_i[MulFPUC]                ),
    .operand_valid_i          (operand_valid_i[MulFPUC]          ),
    .operand_issued_i         (operand_issued_i[MulFPUC]         ),
    .operand_queue_ready_o    (operand_queue_ready_o[MulFPUC]    ),
    .operand_o                (mfpu_operand_c                 ),  //gukai@20250625: mfpu_operand_c is used to hold the operand_c for PreU, which is repleased by mfpu_operand_o[2]
    .operand_target_fu_o      (/* Unused */                      ),
    .operand_valid_o          (mfpu_operand_valid_o[2]           ),
    .operand_ready_i          (mfpu_operand_ready_i[2]           ),
    .transfer_all_quantize_en_i          ( transfer_all_quantize_en ),
    .conv_vifmm_o             (conv_vifmm_c                  ),
    .elem_sum_c_o           (elem_sum_c                     )
  );

  ///////////////////////
  //  Load/Store Unit  //
  ///////////////////////

  operand_queue #(
    .CmdBufDepth        (VstuInsnQueueDepth + MaskuInsnQueueDepth),
    .DataBufDepth       (2                                       ),
    .FPUSupport         (FPUSupportNone                          ),
    .NrLanes            (NrLanes                                 ),
    .VLEN               (VLEN                                    ),
    .operand_queue_cmd_t(operand_queue_cmd_t                     )
  ) i_operand_queue_st_mask_a (
    .clk_i                    (clk_i                         ),
    .rst_ni                   (rst_ni                        ),
    .flush_i                  (lsu_ex_flush_o                ),
    .lane_id_i                (lane_id_i                     ),
    .operand_queue_cmd_i      (operand_queue_cmd_i[StA]      ),
    .operand_queue_cmd_valid_i(operand_queue_cmd_valid_i[StA]),
    .cmd_pop_o                (/* Unused */                  ),
    .operand_i                (operand_i[StA]                ),
    .operand_valid_i          (operand_valid_i[StA]          ),
    .operand_issued_i         (operand_issued_i[StA]         ),
    .operand_queue_ready_o    (operand_queue_ready_o[StA]    ),
    .operand_o                (stu_operand_o                 ),
    .operand_target_fu_o      (/* Unused */                  ),
    .operand_valid_o          (stu_operand_valid_o           ),
    .operand_ready_i          (stu_operand_ready_i           )
  );

  /****************
   *  Slide Unit  *
   ****************/

  operand_queue #(
    .CmdBufDepth        (VlduInsnQueueDepth   ),
    .DataBufDepth       (2                    ),
    .AccessCmdPop       (1'b1                 ),
    .FPUSupport         (FPUSupportNone       ),
    .NrLanes            (NrLanes              ),
    .VLEN               (VLEN                 ),
    .operand_queue_cmd_t(operand_queue_cmd_t  )
  ) i_operand_queue_slide_addrgen_a (
    .clk_i                    (clk_i                                   ),
    .rst_ni                   (rst_ni                                  ),
    .flush_i                  (lsu_ex_flush_o                          ),
    .lane_id_i                (lane_id_i                               ),
    .operand_queue_cmd_i      (operand_queue_cmd_i[SlideAddrGenA]      ),
    .operand_queue_cmd_valid_i(operand_queue_cmd_valid_i[SlideAddrGenA]),
    .cmd_pop_o                (sldu_addrgen_cmd_pop_o                  ),
    .operand_i                (operand_i[SlideAddrGenA]                ),
    .operand_valid_i          (operand_valid_i[SlideAddrGenA]          ),
    .operand_issued_i         (operand_issued_i[SlideAddrGenA]         ),
    .operand_queue_ready_o    (operand_queue_ready_o[SlideAddrGenA]    ),
    .operand_o                (sldu_addrgen_operand_o                  ),
    .operand_target_fu_o      (sldu_addrgen_operand_target_fu_o        ),
    .operand_valid_o          (sldu_addrgen_operand_valid_o            ),
    .operand_ready_i          (sldu_addrgen_operand_ready_i            )
  );

  /////////////////
  //  Mask Unit  //
  /////////////////

  operand_queue #(
    .CmdBufDepth        (MaskuInsnQueueDepth + VrgatherOpQueueBufDepth ),
    .DataBufDepth       (MaskuInsnQueueDepth + VrgatherOpQueueBufDepth ),
    .AccessCmdPop       (1'b1                                          ),
    .FPUSupport         (FPUSupportNone                                ),
    .SupportIntExt2     (1'b1                                          ),
    .SupportIntExt4     (1'b1                                          ),
    .SupportIntExt8     (1'b1                                          ),
    .NrLanes            (NrLanes                                       ),
    .VLEN               (VLEN                                          ),
    .operand_queue_cmd_t(operand_queue_cmd_t                           )
  ) i_operand_queue_mask_b (
    .clk_i                    (clk_i                           ),
    .rst_ni                   (rst_ni                          ),
    .flush_i                  (1'b0                            ),
    .lane_id_i                (lane_id_i                       ),
    .operand_queue_cmd_i      (operand_queue_cmd_i[MaskB]      ),
    .operand_queue_cmd_valid_i(operand_queue_cmd_valid_i[MaskB]),
    .cmd_pop_o                (mask_b_cmd_pop_o                ),
    .operand_i                (operand_i[MaskB]                ),
    .operand_valid_i          (operand_valid_i[MaskB]          ),
    .operand_issued_i         (operand_issued_i[MaskB]         ),
    .operand_queue_ready_o    (operand_queue_ready_o[MaskB]    ),
    .operand_o                (mask_operand_o[1]               ),
    .operand_target_fu_o      (/* Unused */                    ),
    .operand_valid_o          (mask_operand_valid_o[1]         ),
    .operand_ready_i          (mask_operand_ready_i[1]         )
  );

  operand_queue #(
    .CmdBufDepth        (MaskuInsnQueueDepth  ),
    .DataBufDepth       (1                    ),
    .FPUSupport         (FPUSupportNone       ),
    .NrLanes            (NrLanes              ),
    .VLEN               (VLEN                 ),
    .operand_queue_cmd_t(operand_queue_cmd_t  )
  ) i_operand_queue_mask_m (
    .clk_i                    (clk_i                           ),
    .rst_ni                   (rst_ni                          ),
    .flush_i                  (lsu_ex_flush_o                  ),
    .lane_id_i                (lane_id_i                       ),
    .operand_queue_cmd_i      (operand_queue_cmd_i[MaskM]      ),
    .operand_queue_cmd_valid_i(operand_queue_cmd_valid_i[MaskM]),
    .cmd_pop_o                (/* Unused */                    ),
    .operand_i                (operand_i[MaskM]                ),
    .operand_valid_i          (operand_valid_i[MaskM]          ),
    .operand_issued_i         (operand_issued_i[MaskM]         ),
    .operand_queue_ready_o    (operand_queue_ready_o[MaskM]    ),
    .operand_o                (mask_operand_o[0]               ),
    .operand_target_fu_o      (/* Unused */                    ),
    .operand_valid_o          (mask_operand_valid_o[0]         ),
    .operand_ready_i          (mask_operand_ready_i[0]         )
  );

  // Checks
  if (VrgatherOpQueueBufDepth % 2 != 0) $fatal(1, "Parameter VrgatherOpQueueBufDepth must be power of 2.");

endmodule : operand_queues_stage
