module PostU import ara_pkg::*; import rvv_pkg::*; #(
  parameter  vew_e           ElementWidth = EW64
) (
    input  logic                    clk_i,
    input  logic                    rst_ni,
    input  logic                    valid_i,
    input  elen_t [1:0]             result_i,
    input  logic[2:0]           transfer_len_i, 
    input  logic [3:0] [15:0]       transfer_data_i,  
    input  logic                    transfer_all_quantize_en_i,
    input  ara_op_e                 op_i,
    output logic                    valid_o,
    output elen_t                   result_o,
    output elen_t                   result1_o,
    output elen_t                   result2_o,
    output elen_t                   result3_o
);

if (ElementWidth == EW32) begin  : COMPENSATE

  logic  [1:0] [7:0]   fp32_exponent;  // gukai@20250610
  logic  [1:0]         pointer_d, pointer_q;
  logic  [63:0]            result_o_tmp;
  logic  [3:0] [63:0]            result_q, result_d;

  assign  fp32_exponent[0]   = transfer_data_i[pointer_q][7: 0] - 'd30 ;
  assign  fp32_exponent[1]   =  transfer_data_i[pointer_q][15: 8] - 'd30 ;
  assign  pointer_d = (valid_i) ? ( pointer_q + 1) : pointer_q;

  always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        pointer_q <= 0;
        result_q <= '0;
      end else begin
        pointer_q <= pointer_d;
        result_q <= result_d;
      end
  end

  int_fp32_convert i_int_fp32_convert_0 (
    .int64          ( result_i[0] ),
    .fp32_exponent  ( fp32_exponent[0]),        
    .int_to_fp32    ( result_o_tmp[31:0])
  );

  int_fp32_convert i_int_fp32_convert_1 (
    .int64          ( result_i[1] ),
    .fp32_exponent  ( fp32_exponent[1]),        
    .int_to_fp32    ( result_o_tmp[63:32])
  );

  always_comb begin  
    if (op_i == VIFMM) begin
      result_d[0] = (valid_i & (pointer_q == 2'b00)) ? result_o_tmp : result_q[0];
      result_d[1] = (valid_i & (pointer_q == 2'b01)) ? result_o_tmp : result_q[1];
      result_d[2] = (valid_i & (pointer_q == 2'b10)) ? result_o_tmp : result_q[2];
      result_d[3] = (valid_i & (pointer_q == 2'b11)) ? result_o_tmp : result_q[3];

      result_o = result_d[0];
      result1_o = result_d[1];
      result2_o = result_d[2];
      result3_o = result_d[3];

      valid_o = (valid_i & (  pointer_d == transfer_len_i[2:1] // transfer_len < 4
                            | pointer_q == 2'b11));   // transfer_len >= 4
    end else begin
      result_d = '0;
      result_o =  result_i;
      result1_o =  '0;
      result2_o =  '0;
      result3_o =  '0;
      valid_o = valid_i;
    end
  end
  
end : COMPENSATE else if (ElementWidth == EW8) begin : QUANTIZE
  elen_t            result_o_AQ_tmp0;

  int8_fp32_convert i_int8_fp32_convert_0 (
    .int16          ( result_i[0][15:0] ),
    .fp32_exponent  ( transfer_data_i[0][7:0] - 8'd6),
    .int_to_fp32    ( result_o_AQ_tmp0[31:0])
  );
  int8_fp32_convert i_int8_fp32_convert_1 (
    .int16          ( result_i[0][31:16] ),
    .fp32_exponent  ( transfer_data_i[0][15:8] - 8'd6),
    .int_to_fp32    ( result_o_AQ_tmp0[63:32])
  );
  int8_fp32_convert i_int8_fp32_convert_2 (
    .int16          ( result_i[0][47:32] ),
    .fp32_exponent  ( transfer_data_i[1][7:0] - 8'd6),
    .int_to_fp32    ( result1_o[31:0])
  );
  int8_fp32_convert i_int8_fp32_convert_3 (
    .int16          ( result_i[0][63:48] ),
    .fp32_exponent  ( transfer_data_i[1][15:8] - 8'd6),
    .int_to_fp32    ( result1_o[63:32])
  );
  int8_fp32_convert i_int8_fp32_convert_4 (
    .int16          ( result_i[1][15:0] ),
    .fp32_exponent  ( transfer_data_i[2][7:0] - 8'd6),
    .int_to_fp32    ( result2_o[31:0])
  );
  int8_fp32_convert i_int8_fp32_convert_5 (
    .int16          ( result_i[1][31:16] ),
    .fp32_exponent  ( transfer_data_i[2][15:8] - 8'd6),
    .int_to_fp32    ( result2_o[63:32])
  );
  int8_fp32_convert i_int8_fp32_convert_6 (
    .int16          ( result_i[1][47:32] ),
    .fp32_exponent  ( transfer_data_i[3][7:0] - 8'd6),
    .int_to_fp32    ( result3_o[31:0])
  );
  int8_fp32_convert i_int8_fp32_convert_7 (
    .int16          ( result_i[1][63:48] ),
    .fp32_exponent  ( transfer_data_i[3][15:8] - 8'd6),        
    .int_to_fp32    ( result3_o[63:32])
  );

  assign result_o = (op_i == VIFMM) ? result_o_AQ_tmp0 : result_i;
  assign valid_o = valid_i;
end: QUANTIZE


endmodule