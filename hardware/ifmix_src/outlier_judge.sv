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
        // if ( operand_a[1].e[7] || (& operand_a[1].e[6:0] || operand_c[1].e[7] || (& operand_c[1].e[6:0] ) ) ) begin
        //     transfer_pack_o[1].transfer_type       = 0;
        // end else begin
        //     transfer_pack_o[1].transfer_type       = 1;
        // end                                                     

        // if ( operand_a[0].e[7] || (& operand_a[0].e[6:0] ) || operand_c[0].e[7] || (& operand_c[0].e[6:0] ) ) begin
        //     transfer_pack_o[0].transfer_type       = 0;
        // end else begin
        //     transfer_pack_o[0].transfer_type       = 1;
        // end
        for (int l = 0; l < 2; l++) begin
            // if ( operand_a[l].e[7] || (| operand_a[l].e[6:1] || operand_c[l].e[7] || (| operand_c[l].e[6:1] ) ) ) begin   // 8
            // if ( operand_a[l].e[7] || (| operand_a[l].e[6:0] || operand_c[l].e[7] || (| operand_c[l].e[6:0] ) ) ) begin   // 4
            // if ( operand_a[l].e[7] || operand_c[l].e[7] ) begin   // 2
            // if ( operand_a[l].e[7] || (& operand_a[l].e[6:0] || operand_c[l].e[7] || (& operand_c[l].e[6:0] ) ) ) begin   // 1
            if ( operand_a[l].e[7] || (& operand_a[l].e[6:1] ) || operand_c[l].e[7] || (& operand_c[l].e[6:1] ) ) begin   // 0.5
            // if ( operand_a[l].e[7] || (& operand_a[l].e[6:2] ) || operand_c[l].e[7] || (& operand_c[l].e[6:2] ) ) begin   // 0.25
            // if ( operand_a[l].e[7] || (& operand_a[l].e[6:3] ) || operand_c[l].e[7] || (& operand_c[l].e[6:3] ) ) begin   // 0.125
                transfer_pack_o[l].transfer_type       = 0;
            end else begin
                transfer_pack_o[l].transfer_type       = 1;
            end                                         
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



endmodule




