`define TRANS_QUANTIZE
// `define TRANS_COMPENSATE

module quantize_control import ara_pkg::*; import rvv_pkg::*;import ifmix_pkg::*; #(
    parameter  int           unsigned VLEN                = 0,
    parameter  int           unsigned TagDepth        = 8,
    parameter  int           unsigned DataBufDepth        = 2,
    localparam int           unsigned DataWidth      = $bits(elen_t),
    localparam type                   vlen_t         = logic[$clog2(VLEN+1)-1:0]
) (
    input  logic                              clk_i,
    input  logic                              rst_ni,
    input  logic                              flush_i,
    input  elen_t                             operand_a_i,
    input  logic                              operand_a_valid_i,
    input  elen_t                             operand_c_i,
    input  logic                              operand_c_valid_i,
    input  opqueue_conversion_e               conv_a_i,
    input  opqueue_conversion_e               conv_b_i,
    input  opqueue_conversion_e               conv_c_i,
    input  logic                              conv_dead_i,
    input  vlen_t                             elem_sum_a_i,
    input  vlen_t                             elem_sum_c_i,
    output [3:0] [1:0]                        transfer_type_o,
    output [3:0] [15:0]                       transfer_data_o,
    output logic                              transfer_full_valid_o,
    output logic                              transfer_all_quantize_en_o,
    output opqueue_conversion_e               conv_vifmm_o
);

elen_t          operand_a_fifo;
fp32_t [1:0]    operand_a_comp,operand_c_comp;

logic   [TagDepth-1 :0]            transfer_type_d,transfer_type_q;
logic   [TagDepth-1 :0] [7:0]      transfer_data_d,transfer_data_q;
logic  [$clog2(TagDepth)-1:0]    transfer_type_pointer_d,transfer_type_pointer_q;
logic                              conv_quantize_en;
logic                              opa_push,opa_pop;
vlen_t                             elem_count_a_d, elem_count_a_q;
vlen_t                             elem_count_c_d, elem_count_c_q;

assign conv_quantize_en = (conv_a_i == OpQueueConversionF32I8) & (conv_b_i == OpQueueConversionF32I8) & (conv_c_i == OpQueueConversionF32I8);
assign conv_vifmm_o     = conv_quantize_en ? OpQueueConversionF32I8 : OpQueueConversionNone;

  fifo_v3 #(
    .DEPTH     (DataBufDepth),
    .DATA_WIDTH(DataWidth   )
  ) i_input_buffer_c (
    .clk_i     (clk_i          ),
    .rst_ni    (rst_ni         ),
    .testmode_i(1'b0           ),
    .flush_i   (flush_i        ),
    .data_i    (operand_a_i      ),
    .push_i    (opa_push ),
    .full_o    (/* Unused */   ),
    .data_o    (operand_a_fifo   ),
    .pop_i     (opa_pop         ),
    .empty_o   (/* Unused */   ),
    .usage_o   (/* Unused */   )
  );

always_comb begin: obuf_control
    transfer_type_pointer_d  = transfer_type_pointer_q;

    if (conv_dead_i) begin
        elem_count_a_d = '0;
        elem_count_c_d = '0;
        opa_pop        = 1'b0; // Do not pop if the command is dead
        opa_push       = 1'b0; // Do not push if the command is dead
    end else begin
        if (operand_c_valid_i) begin
          // Finished execution
          if (elem_count_c_q >= elem_sum_c_i) begin 
            elem_count_c_d     = elem_count_c_q;
            opa_pop            = 1'b0; // Do not pop if the command is dead
          end else begin
            // If the command is not dead, we can push the operand
                unique case (conv_vifmm_o)
                  OpQueueConversionF32I8: begin
                      elem_count_c_d            = elem_count_c_q + 2;
                      opa_pop                   = 1'b1; // Pop the operand if opa is valid
                      transfer_type_pointer_d   = transfer_type_pointer_q + 2'b10;
                  end
                  default: begin
                        opa_pop            = 1'b0;
                        elem_count_c_d = elem_count_c_q;
                  end
                endcase
          end
        end else begin
            opa_pop            = 1'b0;
            elem_count_c_d     = elem_count_c_q;
        end

        if (operand_a_valid_i) begin
            // Finished execution
            if (elem_count_a_q >= elem_sum_a_i) begin
              elem_count_a_d     = elem_count_a_q;
              opa_push           = 1'b0; // Do not push if the command is dead
            end else begin
                // Count the used elements
                unique case (conv_vifmm_o)
                  OpQueueConversionF32I8: begin
                      elem_count_a_d = elem_count_a_q + 2;
                      opa_push           = 1'b1; // Push the operand if the command is not dead
                  end
                  default: begin
                    opa_push           = 1'b0;
                    elem_count_a_d = elem_count_a_q;
                  end
                endcase
            end
        end else begin
            opa_push           = 1'b0;
            elem_count_a_d     = elem_count_a_q;
        end
    end
  end : obuf_control

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      elem_count_a_q     <= '0;
      elem_count_c_q     <= '0;
    end else begin
      elem_count_a_q     <= elem_count_a_d;
      elem_count_c_q     <= elem_count_c_d;
    end
  end


always_comb begin       

    case (conv_vifmm_o)
        OpQueueConversionF32I8: begin
            operand_a_comp[1]    = operand_a_fifo[63:32];
            operand_a_comp[0]    = operand_a_fifo[31:0];
            operand_c_comp[1]    = operand_c_i[63:32];
            operand_c_comp[0]    = operand_c_i[31:0];
        end
        default: begin
            operand_a_comp[1]                  = '0;
            operand_a_comp[0]                  = '0;
            operand_c_comp[1]                  = '0;
            operand_c_comp[0]                  = '0;   
        end
    endcase   
end

always_comb begin 
    transfer_type_d          = transfer_type_q;
    transfer_data_d          = transfer_data_q;
    
    if (conv_vifmm_o == OpQueueConversionF32I8) begin
        // operand[0].e is positive (operand[0].e is larger than FP32_E_BIAS),  and larger  than olr_thd_dynamic
        // so operand[0] is larger than outlier threshold
        // TODO: test compensate
        
          `ifdef TRANS_COMPENSATE
            for (int t = 0; t < TagDepth; t++) begin
                transfer_type_d[t] = 0;
            end
          `elsif TRANS_QUANTIZE  
            for (int t = 0; t < TagDepth; t++) begin
                transfer_type_d[t] = 1;
            end
          `else 
            for (int l = 0; l < 2; l++) begin
                // if ( operand_a_comp[l].e[7] || (| operand_a_comp[l].e[6:1] || operand_c_comp[l].e[7] || (| operand_c_comp[l].e[6:1] ) ) ) begin   // 8
                // if ( operand_a_comp[l].e[7] || (| operand_a_comp[l].e[6:0] || operand_c_comp[l].e[7] || (| operand_c_comp[l].e[6:0] ) ) ) begin   // 4
                // if ( operand_a_comp[l].e[7] || operand_c_comp[l].e[7] ) begin   // 2
                if ( operand_a_comp[l].e[7] || (& operand_a_comp[l].e[6:0] || operand_c_comp[l].e[7] || (& operand_c_comp[l].e[6:0] ) ) ) begin   // 1
                // if ( operand_a_comp[l].e[7] || (& operand_a_comp[l].e[6:1] ) || operand_a_comp[l].e[7] || (& operand_c_comp[l].e[6:1] ) ) begin   // 0.5
                // if ( operand_a_comp[l].e[7] || (& operand_a_comp[l].e[6:2] ) || operand_c_comp[l].e[7] || (& operand_c_comp[l].e[6:2] ) ) begin   // 0.125
                // if ( operand_a_comp[l].e[7] || (& operand_a_comp[l].e[6:3] ) || operand_c_comp[l].e[7] || (& operand_c_comp[l].e[6:3] ) ) begin   // 0.0078740
                    transfer_type_d[transfer_type_pointer_q+l]       = 0;
                end else begin
                    transfer_type_d[transfer_type_pointer_q+l]       = 1;
                end                                       
            end
          `endif
          transfer_data_d[transfer_type_pointer_q]  = ($unsigned(operand_a_comp[0].e) > $unsigned(operand_c_comp[0].e) ? operand_a_comp[0].e :    operand_c_comp[0].e);
          transfer_data_d[transfer_type_pointer_q+1]  = ($unsigned(operand_a_comp[1].e) > $unsigned(operand_c_comp[1].e) ? operand_a_comp[1].e :    operand_c_comp[1].e);
                                                         
    end
     
end
 


 //   0 | 0
 //     | 1
 //   1 | 2
 //     | 3
 //   2 | 4
 //     | 5
 //   3 | 6
 //     | 7
generate
    for (genvar i = 0; i < TagDepth; i=i+2) begin
        assign transfer_data_o[i/2] = {transfer_data_d[i+1],transfer_data_d[i]};   // 0,0,0; 1,2,1; 2,4,2; 3,6,3
        assign transfer_type_o[i/2] = {transfer_type_d[i+1],transfer_type_d[i]};
    end
endgenerate

// enable full signal each four data,  the power of 4
assign transfer_full_valid_o = (transfer_type_pointer_d[1:0] == 2'b00 && transfer_type_pointer_d[$clog2(TagDepth)-1:2] );
`ifdef EN_ALL_QUANT
    assign transfer_all_quantize_en_o = transfer_full_valid_o && (&transfer_type_d);
`else
    assign transfer_all_quantize_en_o = 1'b0;
`endif

always_ff @(posedge clk_i or negedge rst_ni) begin
    if(~rst_ni) begin
        transfer_type_pointer_q <= '0;
        transfer_type_q         <= '0;
        transfer_data_q         <= '0;

    end else begin
        transfer_type_pointer_q <= transfer_type_pointer_d;
        transfer_type_q         <= transfer_type_d;
        transfer_data_q         <= transfer_data_d;
    end
end

endmodule