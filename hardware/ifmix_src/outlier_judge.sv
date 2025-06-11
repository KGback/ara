// `define TRANS_QUANTIZE
// `define TRANS_COMPENSATE
// `define TRANS_MIX

module outlier_judge import ara_pkg::*; import rvv_pkg::*;import ifmix_pkg::*; #(
    parameter  fp32_t                 outlier_thd_static
) (
    input  logic                              clk_i,
    input  logic                              rst_ni,
    input  logic                              flush_i,
    input  elen_t   [2:0]                     operand_i,
    input  logic    [2:0]                     operand_valid_i,
    input  vifmm_conversion_e                   conver_type_i,
    output elen_t   [2:0]                       operand_o,
    output transfer_pack_t     [1:0]            transfer_pack_o,       //  quantize/compensate
    output logic                                transfer_pack_valid_o                 
);

localparam signed FP32_E_BIAS          = 127;
localparam signed INT8_SIGNED_MAX      = 127;
localparam signed INT16_SIGNED_MAX     = 32767;
localparam signed INT32_SIGNED_MAX     = 2147483648;

fp32_t [1:0]    operand_a,operand_c;
logic   [31:0]  opa0_int32_quantize, opa1_int32_quantize, opc0_int32_quantize, opc1_int32_quantize;
// logic   [31:0]  opa0_int32_compensate, ;

always_comb begin  
    operand_a[1]                  = '0;
    operand_a[0]                  = '0;
    operand_c[1]                  = '0;
    operand_c[0]                  = '0;        

    unique case (conver_type_i)
        F16I8: begin
            
        end  
        F16I16: begin
            
        end
        F32I8: begin
            operand_a[1]    = operand_i[0][63:32];
            operand_a[0]    = operand_i[0][31:0];
            operand_c[1]    = operand_i[2][63:32];
            operand_c[0]    = operand_i[2][31:0];
        end
        default: ;
    endcase   
end

always_comb begin 
    operand_o[0] = operand_i[0];
    operand_o[1] = operand_i[1];
    operand_o[2] = operand_i[2];
    transfer_pack_o[0]  = '0;
    transfer_pack_o[1]  = '0;
    if (conver_type_i != NON_VIFMM) begin
        // operand[0].e is positive (operand[0].e is larger than FP32_E_BIAS),  and larger  than olr_thd_dynamic
        // so operand[0] is larger than outlier threshold
        // TODO: test compensate
      `ifdef TRANS_COMPENSATE
        transfer_pack_o[1].transfer_type       = 0;
        transfer_pack_o[0].transfer_type       = 0;
      `elsif TRANS_QUANTIZE  
        transfer_pack_o[1].transfer_type       = 1;
        transfer_pack_o[0].transfer_type       = 1;
      `else
        if ( operand_a[1].e[7] || (& operand_a[1].e[6:0] || operand_c[1].e[7] || (& operand_c[1].e[6:0] ) ) ) begin
            transfer_pack_o[1].transfer_type       = 0;
        end else begin
            transfer_pack_o[1].transfer_type       = 1;
        end                                                     

        if ( operand_a[0].e[7] || (& operand_a[0].e[6:0] ) || operand_c[0].e[7] || (& operand_c[0].e[6:0] ) ) begin
            transfer_pack_o[0].transfer_type       = 0;
        end else begin
            transfer_pack_o[0].transfer_type       = 1;
        end
      `endif

        transfer_pack_o[0].transfer_data       = (operand_valid_i[0] & operand_valid_i[2]) 
                                                     ? ($unsigned(operand_a[0].e) > $unsigned(operand_c[0].e) ? operand_a[0].e :    operand_c[0].e)
                                                     : '0;
        transfer_pack_o[1].transfer_data       = (operand_valid_i[0] & operand_valid_i[2]) 
                                                     ? ($unsigned(operand_a[1].e) > $unsigned(operand_c[1].e) ? operand_a[1].e :    operand_c[1].e) 
                                                     : '0;

        if (transfer_pack_o[1].transfer_type) begin
            operand_o[0][63:32] = opa1_int32_quantize;
            operand_o[2][63:32] = opc1_int32_quantize;
        end else begin
            operand_o[0][63:32] = fp32_to_int32_compensate(operand_i[0][63:32], transfer_pack_o[1].transfer_data);
            operand_o[2][63:32] = fp32_to_int32_compensate(operand_i[2][63:32], transfer_pack_o[1].transfer_data);
        end

        if (transfer_pack_o[0].transfer_type) begin
            operand_o[0][31:0] = opa0_int32_quantize;
            operand_o[2][31:0] = opc0_int32_quantize;
        end else begin
            operand_o[0][31:0] = fp32_to_int32_compensate(operand_i[0][31:0], transfer_pack_o[0].transfer_data);
            operand_o[2][31:0] = fp32_to_int32_compensate(operand_i[2][31:0], transfer_pack_o[0].transfer_data);
        end
    end

    
    
end

assign  transfer_pack_valid_o = 1;

fp32_int8_quantize i_opa0_fp32_int8_quantize(
    .fp32           ( operand_i[0][31:0] ),    
    .scaling_factor ( transfer_pack_o[0].transfer_data ),            
    .int8           ( opa0_int32_quantize )    
);

fp32_int8_quantize i_opc0_fp32_int8_quantize(
    .fp32           ( operand_i[2][31:0] ),    
    .scaling_factor ( transfer_pack_o[0].transfer_data ),            
    .int8           ( opc0_int32_quantize )    
);

fp32_int8_quantize i_opa1_fp32_int8_quantize(
    .fp32           ( operand_i[0][63:32] ),    
    .scaling_factor ( transfer_pack_o[1].transfer_data ),            
    .int8           ( opa1_int32_quantize )    
);

fp32_int8_quantize i_opc1_fp32_int8_quantize(
    .fp32           ( operand_i[2][63:32] ),    
    .scaling_factor ( transfer_pack_o[1].transfer_data ),            
    .int8           ( opc1_int32_quantize )    
);


endmodule




module fp32_int8_quantize (
    input   ara_pkg::fp32_t fp32,
    input   logic [7:0]     scaling_factor,
    output  logic [31:0]    int8
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
        int8 = 32'h0;
    end else begin
        if (fp32.s) begin
            int8 = {{25{1'b1}}, {(~int_val[6:0])+1'b1}}; 
        end else begin
            int8 = {25'h0,int_val[6:0]};
        end
    end

end
    //  `ifdef TARGET_SIMULATION
        //   $display("[INFO: FP32_INT8_Q]: fp32: %h full_m_fp32: %h real_mantissa: %h diff_scaling_factor: %d int_val: %d int8_q: %h %d",fp32, full_m_fp32,real_mantissa, diff_scaling_factor, int_val, fp32_to_int8_quantize,$signed(fp32_to_int8_quantize)); 
    //  `endif
    
endmodule