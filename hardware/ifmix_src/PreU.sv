module PreU import ara_pkg::*; (
    input   logic               clk_i,
    input   logic               rst_ni,
    input   logic  [2:0]        operand_valid_i,   
    input   elen_t [3:0]        operand_a_i,
    input   elen_t [3:0]        operand_c_i,
    input   [3:0] [1:0]         transfer_type_i,
    input   [3:0] [15:0]        transfer_data_i,
    input   opqueue_conversion_e               conv_i,
    input   logic               transfer_all_quantize_en_i,
    output  elen_t              operand_a_o,
    output  elen_t              operand_c_o
);

logic [1:0] pointer_d, pointer_q;
always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      pointer_q <= 0;
    end else begin
      pointer_q <= pointer_d;
    end
end

    logic   [3:0][15:0]   opa_int8;
    logic   [1:0][31:0]  opa_int32;

    // Convert operand_a_i to int8 with quantization based on transfer_type_i
    fp32_int8_quantize i_opa00_fp32_int8_quantize(
        .fp32           ( operand_a_i[0][31:0] ),    
        .scaling_factor ( transfer_data_i[0][7:0] ),            
        .int8           ( opa_int8[0][7:0] )    
    );

    fp32_int8_quantize i_opa01_fp32_int8_quantize(
        .fp32           ( operand_a_i[0][63:32] ),    
        .scaling_factor ( transfer_data_i[0][15:8] ),            
        .int8           ( opa_int8[0][15:8] )    
    );
    fp32_int8_quantize i_opa10_fp32_int8_quantize(
        .fp32           ( operand_a_i[1][31:0] ),    
        .scaling_factor ( transfer_data_i[1][7:0] ),            
        .int8           ( opa_int8[1][7:0] )    
    );
    fp32_int8_quantize i_opa11_fp32_int8_quantize(
        .fp32           ( operand_a_i[1][63:32] ),    
        .scaling_factor ( transfer_data_i[1][15:8] ),            
        .int8           ( opa_int8[1][15:8] )    
    );
    fp32_int8_quantize i_opa20_fp32_int8_quantize(
        .fp32           ( operand_a_i[2][31:0] ),    
        .scaling_factor ( transfer_data_i[2][7:0] ),            
        .int8           ( opa_int8[2][7:0] )
    );
    fp32_int8_quantize i_opa21_fp32_int8_quantize(
        .fp32           ( operand_a_i[2][63:32] ),    
        .scaling_factor ( transfer_data_i[2][15:8] ),            
        .int8           ( opa_int8[2][15:8] )
    );
    fp32_int8_quantize i_opa30_fp32_int8_quantize(
        .fp32           ( operand_a_i[3][31:0] ),    
        .scaling_factor ( transfer_data_i[3][7:0] ),            
        .int8           ( opa_int8[3][7:0] )
    );
    fp32_int8_quantize i_opa31_fp32_int8_quantize(
        .fp32           ( operand_a_i[3][63:32] ),    
        .scaling_factor ( transfer_data_i[3][15:8] ),            
        .int8           ( opa_int8[3][15:8] )
    );

    // Convert operand_a_i to int32 with compensation based on transfer_data_i

    fp32_int32_compensate i_opa0_fp32_int32_compensate(
        .fp32           ( operand_a_i[0][31:0] ),    
        .exp_bigger     ( transfer_data_i[pointer_q][7:0] ),            
        .fp32_to_int32_compensate ( opa_int32[0] )    
    );
    fp32_int32_compensate i_opa1_fp32_int32_compensate(
        .fp32           ( operand_a_i[0][63:32] ),    
        .exp_bigger     ( transfer_data_i[pointer_q][15:8] ),            
        .fp32_to_int32_compensate ( opa_int32[1] )    
    );

    logic   [3:0][15:0]  opc_int8;
    logic   [1:0][31:0]  opc_int32;
    // Convert operand_c_i to int8 with quantization based on transfer_type_i
    fp32_int8_quantize i_opc00_fp32_int8_quantize(
        .fp32           ( operand_c_i[0][31:0] ),    
        .scaling_factor ( transfer_data_i[0][7:0] ),            
        .int8           ( opc_int8[0][7:0] )    
    );
    fp32_int8_quantize i_opc01_fp32_int8_quantize(
        .fp32           ( operand_c_i[0][63:32] ),    
        .scaling_factor ( transfer_data_i[0][15:8] ),            
        .int8           ( opc_int8[0][15:8] )    
    );
    fp32_int8_quantize i_opc10_fp32_int8_quantize(
        .fp32           ( operand_c_i[1][31:0] ),    
        .scaling_factor ( transfer_data_i[1][7:0] ),            
        .int8           ( opc_int8[1][7:0] )    
    );
    fp32_int8_quantize i_opc11_fp32_int8_quantize(
        .fp32           ( operand_c_i[1][63:32] ),    
        .scaling_factor ( transfer_data_i[1][15:8] ),            
        .int8           ( opc_int8[1][15:8] )    
    );
    fp32_int8_quantize i_opc20_fp32_int8_quantize(
        .fp32           ( operand_c_i[2][31:0] ),    
        .scaling_factor ( transfer_data_i[2][7:0] ),            
        .int8           ( opc_int8[2][7:0] )
    );
    fp32_int8_quantize i_opc21_fp32_int8_quantize(
        .fp32           ( operand_c_i[2][63:32] ),    
        .scaling_factor ( transfer_data_i[2][15:8] ),            
        .int8           ( opc_int8[2][15:8] )
    );
    fp32_int8_quantize i_opc30_fp32_int8_quantize(
        .fp32           ( operand_c_i[3][31:0] ),    
        .scaling_factor ( transfer_data_i[3][7:0] ),            
        .int8           ( opc_int8[3][7:0] )
    );
    fp32_int8_quantize i_opc31_fp32_int8_quantize(
        .fp32           ( operand_c_i[3][63:32] ),    
        .scaling_factor ( transfer_data_i[3][15:8] ),            
        .int8           ( opc_int8[3][15:8] )
    );
    // Convert operand_c_i to int32 with compensation based on transfer_data_i
    fp32_int32_compensate i_opc0_fp32_int32_compensate(
        .fp32           ( operand_c_i[0][31:0] ),    
        .exp_bigger     ( transfer_data_i[pointer_q][7:0] ),            
        .fp32_to_int32_compensate ( opc_int32[0] )    
    );
    fp32_int32_compensate i_opc1_fp32_int32_compensate(
        .fp32           ( operand_c_i[0][63:32] ),    
        .exp_bigger     ( transfer_data_i[pointer_q][15:8] ),            
        .fp32_to_int32_compensate ( opc_int32[1] )    
    );

    always_comb begin 
        operand_a_o = operand_a_i[0];
        operand_c_o = operand_c_i[0];
        pointer_d = pointer_q;
        if (&operand_valid_i) begin
            if (conv_i == OpQueueConversionF32I8) begin
                pointer_d = pointer_q + 1;

                if (transfer_all_quantize_en_i) begin
                    // All transfer types are 1, so we can use int8 quantization
                    operand_a_o = {opa_int8[3], opa_int8[2], opa_int8[1], opa_int8[0]};
                    operand_c_o = {opc_int8[3], opc_int8[2], opc_int8[1], opc_int8[0]};
                end else begin
                    if (transfer_type_i[pointer_q][0]) begin   // quantize
                        operand_a_o[31:0] = {{24{opa_int8[pointer_q][7]}},opa_int8[pointer_q][7:0]};
                        operand_c_o[31:0] = {{24{opc_int8[pointer_q][7]}},opc_int8[pointer_q][7:0]};
                    end else begin                             // compensate
                        operand_a_o[31:0] = opa_int32[0];
                        operand_c_o[31:0] = opc_int32[0];
                    end
                    if (transfer_type_i[pointer_q][1]) begin   // quantize
                        operand_a_o[63:32] = {{24{opa_int8[pointer_q][15]}},opa_int8[pointer_q][15:8]};
                        operand_c_o[63:32] = {{24{opc_int8[pointer_q][15]}},opc_int8[pointer_q][15:8]};
                    end else begin                              // compensate
                        operand_a_o[63:32] = opa_int32[1];
                        operand_c_o[63:32] = opc_int32[1];
                    end
                end 
            end
        end 
    end

endmodule