module fp32_int32_compensate import ara_pkg::*; ( 
    input  fp32_t   fp32, 
    input  logic [7:0]       exp_bigger,
    output logic [31:0]     fp32_to_int32_compensate
    );
    logic [31:0] int32;
    logic [30:0] real_mantissa;
     // Wide sign
    assign int32[31] = fp32.s;

    always_comb begin 
        if (fp32.e <  exp_bigger) begin
              real_mantissa = {1'b1, fp32.m, 7'b0} >> (exp_bigger - fp32.e);
         end else begin
              real_mantissa = {1'b1, fp32.m, 7'b0};
         end

         int32[30:0] = fp32.s ? {~real_mantissa} + 1 : real_mantissa;
    end
     

    assign fp32_to_int32_compensate = int32;

     // `ifdef TARGET_SIMULATION
     //      $display("[TIME: %0t, INFO: FP32_INT32_COMP]: fp32: %h, EB:%h RM: %h, fp32_to_int32_compensate: %h",$time(),fp32, exp_bigger, real_mantissa, fp32_to_int32_compensate);
     // `endif
endmodule