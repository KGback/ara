module PostU import ara_pkg::*; (
    input  logic                    clk_i,
    input  logic                    rst_ni,
    input  logic                    valid_i,
    input  elen_t [1:0]             result_i,
    input  logic [3:0] [1:0]              transfer_type_i, 
    input  logic [3:0] [15:0]       transfer_data_i,  
    input  logic                    transfer_all_quantize_en_i,
    input  ara_op_e                 op_i,
    output elen_t                   result_o
);

logic  [1:0] [7:0]   fp32_exponent;  // gukai@20250610
logic [1:0] pointer_d, pointer_q;
elen_t [1:0]             result_i_tmp;
logic  [1:0] [31:0]            result_o_tmp;

always_comb begin
  if (transfer_all_quantize_en_i) begin
      case (pointer_d)
        2'b00: begin
          fp32_exponent[0]    = transfer_data_i[0][7:0] - 'd6;
          fp32_exponent[1]    = transfer_data_i[0][15:8] - 'd6;
          result_i_tmp[0]     = { {48{result_i[0][15]}}, result_i[0][15:0]};
          result_i_tmp[1]     = { {48{result_i[0][31]}}, result_i[0][31:16]};
        end
        2'b01: begin
          fp32_exponent[0]    = transfer_data_i[1][7:0] - 'd6;
          fp32_exponent[1]    = transfer_data_i[1][15:8] - 'd6;
          result_i_tmp[0]     = { {48{result_i[0][47]}}, result_i[0][47:32]};
          result_i_tmp[1]     = { {48{result_i[0][63]}}, result_i[0][63:48]};
        end
        2'b10: begin
          fp32_exponent[0]    = transfer_data_i[2][7:0] - 'd6;
          fp32_exponent[1]    = transfer_data_i[2][15:8] - 'd6;
          result_i_tmp[0]     = { {48{result_i[1][15]}}, result_i[1][15:0]};
          result_i_tmp[1]     = { {48{result_i[1][31]}}, result_i[1][31:16]};
        end
        2'b11: begin
          fp32_exponent[0]    = transfer_data_i[3][7:0] - 'd6;
          fp32_exponent[1]    = transfer_data_i[3][15:8] - 'd6;
          result_i_tmp[0]     = { {48{result_i[1][47]}}, result_i[1][47:32]};
          result_i_tmp[1]     = { {48{result_i[1][63]}}, result_i[1][63:48]};
        end 
        default: ;
      endcase
  end else begin
    
      fp32_exponent[0]   = transfer_type_i[pointer_q][0] ? (transfer_data_i[pointer_q][7: 0] - 'd6) : (transfer_data_i[pointer_q][7: 0] - 'd30) ;
      fp32_exponent[1]   = transfer_type_i[pointer_q][1] ? (transfer_data_i[pointer_q][15: 8] - 'd6) : (transfer_data_i[pointer_q][15: 8] - 'd30) ;
      result_i_tmp[0]    = result_i[0];
      result_i_tmp[1]    = result_i[1];
    
  end
end
assign pointer_d = (valid_i) ? ( pointer_q + 1) : pointer_q;

always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      pointer_q <= 0;
    end else begin
      pointer_q <= pointer_d;
    end
end

int_fp32_convert i_int_fp32_convert_0 (
  .int64          ( result_i_tmp[0] ),
  .fp32_exponent  ( fp32_exponent[0]),        
  .int_to_fp32    ( result_o_tmp[0])
);

int_fp32_convert i_int_fp32_convert_1 (
  .int64          ( result_i_tmp[1] ),
  .fp32_exponent  ( fp32_exponent[1]),        
  .int_to_fp32    ( result_o_tmp[1])
);

assign result_o = (op_i == VIFMM) ? {result_o_tmp[1], result_o_tmp[0]} : result_i;

endmodule