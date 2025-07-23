module fp32_int8_quantize import ara_pkg::*;(
    input   fp32_t fp32,
    input   logic [7:0]     scaling_factor,
    output  logic [7:0]    int8
);

logic   [7:0]   diff_scaling_factor;
logic   [23:0]  full_m_fp32;
logic   [6:0]   int_val; // signed, only 7 bits are used

assign    full_m_fp32 = {1'b1, fp32.m};
    
always_comb begin
    if (fp32.e == 8'd0) begin
        int_val                = 7'h0;    
    end else begin          
        diff_scaling_factor = scaling_factor - fp32.e;

        case (diff_scaling_factor)
            8'd0:  int_val = |full_m_fp32[23:17]    
                                ? full_m_fp32[23:17] 
                                : (full_m_fp32[16] ? 7'b1 : 7'b0); 
            8'd1:  int_val = |full_m_fp32[23:18]
                                ? {1'b0, full_m_fp32[23:18]} 
                                : (full_m_fp32[17] ? 7'b1 : 7'b0);
            8'd2:  int_val = |full_m_fp32[23:19]
                                ? {2'b0, full_m_fp32[23:19]}
                                : (full_m_fp32[18] ? 7'b1 : 7'b0);
            8'd3:  int_val = |full_m_fp32[23:20]
                                ? {3'b0, full_m_fp32[23:20]}
                                : (full_m_fp32[19] ? 7'b1 : 7'b0);
            8'd4:  int_val = |full_m_fp32[23:21]
                                ? {4'b0, full_m_fp32[23:21]}
                                : (full_m_fp32[20] ? 7'b1 : 7'b0);
            8'd5:  int_val = |full_m_fp32[23:22]
                                ? {5'b0, full_m_fp32[23:22]}
                                : (full_m_fp32[21] ? 7'b1 : 7'b0);
            8'd6:  int_val = |full_m_fp32[23]
                                ? {6'b0, full_m_fp32[23]}
                                : (full_m_fp32[22] ? 7'b1 : 7'b0);
            8'd7:  int_val = (full_m_fp32[23] ? 7'b1 : 7'b0);
            default: int_val = 7'h0; // data with too small will be 0
        endcase
     end

    if (int_val == 8'd0) begin
        int8 = 8'h0;
    end else begin
        if (fp32.s) begin
            int8 = {{1{1'b1}}, {(~int_val[6:0])+1'b1}}; 
        end else begin
            int8 = {1'h0,int_val[6:0]};
        end
    end

end
    //  `ifdef TARGET_SIMULATION
        //   $display("[INFO: FP32_INT8_Q]: fp32: %h full_m_fp32: %h real_mantissa: %h diff_scaling_factor: %d int_val: %d int8_q: %h %d",fp32, full_m_fp32,real_mantissa, diff_scaling_factor, int_val, fp32_to_int8_quantize,$signed(fp32_to_int8_quantize)); 
    //  `endif
    
endmodule