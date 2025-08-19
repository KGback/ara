
module int8_fp32_convert import ara_pkg::*;(
     input logic [15:0] int16,
     input logic [7:0] fp32_exponent,
     output fp32_t int_to_fp32
);
    logic [14:0] int32_tmp;

    // Need to convert complement code to orginal code, because op_b could be negative though fp32_to_int32_compensate.m is original code
    assign int32_tmp[14:0]  = int16[15] ? { ~int16[14:0]} + 'b1 : int16[14:0];   
    assign int_to_fp32.s = int16[15];

     always_comb begin
       unique casez (int32_tmp[14:0])
          15'b1??????_????????: begin
               int_to_fp32.e = 'd14 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[13:0],9'b0};
          end
          15'b01?????_????????: begin
               int_to_fp32.e = 'd13 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[12:0],10'b0};
          end
          15'b001????_????????: begin
               int_to_fp32.e = 'd12 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[11:0],11'b0};
          end
          15'b0001???_????????: begin
               int_to_fp32.e = 'd11 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[10:0],12'b0};
          end
          15'b00001??_????????: begin
               int_to_fp32.e = 'd10 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[9:0],13'b0};
          end
          15'b000001?_????????: begin
               int_to_fp32.e = 'd9 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[8:0],14'b0};
          end
          15'b0000001_????????: begin
               int_to_fp32.e = 'd8 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[7:0],15'b0};
          end
          15'b0000000_1???????: begin
               int_to_fp32.e = 'd7 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[6:0],16'b0};
          end
          15'b0000000_01??????: begin
               int_to_fp32.e = 'd6 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[5:0],17'b0};
          end
          15'b0000000_001?????: begin
               int_to_fp32.e = 'd5 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[4:0],18'b0};
          end
          15'b0000000_0001????: begin
               int_to_fp32.e = 'd4 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[3:0],19'b0};
          end
          15'b0000000_00001???: begin
               int_to_fp32.e = 'd3 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[2:0],20'b0};
          end
          15'b0000000_000001??: begin
               int_to_fp32.e = 'd2 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[1:0],21'b0};
          end
          15'b0000000_0000001?: begin
               int_to_fp32.e = 'd1 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[0],22'b0};
          end
          15'b0000000_00000001: begin
               int_to_fp32.e = 'd0 + fp32_exponent;
               int_to_fp32.m = 23'b0;
          end
          default: begin
               int_to_fp32.e = '0;
               int_to_fp32.m = '0;
          end
       endcase
     end

     // `ifdef TARGET_SIMULATION
     //      $display("[TIME: %0t, INFO: INT32_FP32_COMP]: int16: %h, exp: %h int32_tmp: %h, int_to_fp32: %h",$time(),int16, fp32_exponent, int32_tmp, int_to_fp32);
     // `endif
endmodule
