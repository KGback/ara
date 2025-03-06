module outlier_judge import ara_pkg::*; import rvv_pkg::*;import ifmix_pkg::*; #(
    parameter  fp32_t                 outlier_thd_static
) (
    input  logic                              clk_i,
    input  logic                              rst_ni,
    input  logic                              flush_i,
    input  elen_t                               operand_a_i,
    input  elen_t                               operand_c_i,
    input  logic                                operand_valid_i,
    input  rvv_pkg::vew_e                       operand_eew_a_i,
    input  rvv_pkg::vew_e                       operand_eew_b_i,
    input  logic                                operand_eew_a_valid_i,
    input  logic                                operand_eew_b_valid_i,
    output transfer_pack_t     [1:0]            transfer_pack_o,       //  quantize/compensate
    output logic                                transfer_pack_valid_o                 
);

localparam signed FP32_E_BIAS          = 127;
localparam signed INT8_SIGNED_MAX      = 127;
localparam signed INT16_SIGNED_MAX     = 32767;
localparam signed INT32_SIGNED_MAX     = 2147483648;

fp32_t [1:0]    operand_a,operand_c;
fp32_t          olr_thd_dynamic_d,olr_thd_dynamic_q;
logic   [23:0]  max_int_fp32;
logic   [7:0]   olr_thd_diff_e_fp32;
logic   [7:0]   op0_diff_e_fp32,op1_diff_e_fp32;
logic   [7:0]   op0_c_diff_e_fp32,op1_c_diff_e_fp32;
// logic   [15:0]  op0_comp_diff_e_fp32, op1_comp_diff_e_fp32, olr_thd_comp_diff_e_fp32;
// logic   [15:0]  op0_abs_comp_diff_e_fp32, op1_abs_comp_diff_e_fp32, olrthd_abs_comp_diff_e_fp32;
logic   [23:0]  full_m_fp32;

logic   [7:0] scaling_factor,scaling_factor_reg;
rvv_pkg::vew_e                       operand_eew_a;
rvv_pkg::vew_e                       operand_eew_b;

assign          full_m_fp32 = {1'b1, olr_thd_dynamic_d.m};

always_comb begin  // update olr_thd
    operand_a[1]                  = '0;
    operand_a[0]                  = '0;
    operand_c[1]                  = '0;
    operand_c[0]                  = '0;
    olr_thd_dynamic_d           = olr_thd_dynamic_q;
    max_int_fp32                = '0;
    olr_thd_diff_e_fp32         = '0;
    op0_diff_e_fp32             = '0;  
    // op0_comp_diff_e_fp32        = '0;          
    // op0_abs_comp_diff_e_fp32    = '0;              
    op1_diff_e_fp32             = '0;  
    // op1_comp_diff_e_fp32        = '0;          
    // op1_abs_comp_diff_e_fp32    = '0;      
    op0_c_diff_e_fp32             = '0;
    op1_c_diff_e_fp32             = '0;
    olr_thd_diff_e_fp32         = '0;
    // olr_thd_comp_diff_e_fp32    = '0;        
    // olrthd_abs_comp_diff_e_fp32 = '0; 
                      

    unique case (operand_eew_a)
        EW8: begin
            
        end  
        EW16: begin
            
        end
        EW32: begin
            operand_a[1]    = operand_a_i[63:32];
            operand_a[0]    = operand_a_i[31:0];
            operand_c[1]    = operand_c_i[63:32];
            operand_c[0]    = operand_c_i[31:0];
            
            op0_diff_e_fp32             = operand_a[0].e - FP32_E_BIAS;   // maybe less than 0
            // op0_comp_diff_e_fp32        = {{8{op0_diff_e_fp32[7]}}, op0_diff_e_fp32};  // complement for 16 bits
            // op0_abs_comp_diff_e_fp32    = op0_comp_diff_e_fp32[15] ?  ~op0_comp_diff_e_fp32 + 1: op0_comp_diff_e_fp32;

            op1_diff_e_fp32             = operand_a[1].e - FP32_E_BIAS;
            // op1_comp_diff_e_fp32        = {{8{op1_diff_e_fp32[7]}}, op1_diff_e_fp32};
            // op1_abs_comp_diff_e_fp32    = op1_comp_diff_e_fp32[15] ?  ~op1_comp_diff_e_fp32 + 1: op1_comp_diff_e_fp32;
            op0_c_diff_e_fp32           = operand_c[0].e - FP32_E_BIAS;
            op1_c_diff_e_fp32           = operand_c[1].e - FP32_E_BIAS;

            // mostly, olr_thd_dynamic > 1, so olr_thd_dynamic_q.e > 127
            olr_thd_diff_e_fp32         = olr_thd_dynamic_q.e - FP32_E_BIAS;        
            // olr_thd_comp_diff_e_fp32    = {{8{olr_thd_diff_e_fp32[7]}}, olr_thd_diff_e_fp32}; 
            // olrthd_abs_comp_diff_e_fp32 = olr_thd_comp_diff_e_fp32[15] ?  ~olr_thd_comp_diff_e_fp32 + 1: olr_thd_comp_diff_e_fp32;

            // operand_a[0].e is positive (operand_a[0].e is larger than FP32_E_BIAS) and 2^7=128 larger than olr_thd_dynamic      
            // if ((olrthd_abs_comp_diff_e_fp32 + 7) < op0_abs_comp_diff_e_fp32 ) begin  
            if (operand_a[0].e[7] && ((olr_thd_diff_e_fp32 + 7) < op0_diff_e_fp32)) begin 
                olr_thd_dynamic_d = operand_a[0];
            end

            // if ((olrthd_abs_comp_diff_e_fp32 + 7) < op1_abs_comp_diff_e_fp32 ) begin
            if (operand_a[1].e[7] && ((olr_thd_diff_e_fp32 + 7) < op1_diff_e_fp32)) begin        
                olr_thd_dynamic_d = operand_a[1];
            end

            unique case (olr_thd_diff_e_fp32)
                8'd0:  max_int_fp32 =  { 23'b0, full_m_fp32[23]};
                8'd1:  max_int_fp32 =  { 22'b0, full_m_fp32[23:22]};
                8'd2:  max_int_fp32 =  { 21'b0, full_m_fp32[23:21]};
                8'd3:  max_int_fp32 =  { 20'b0, full_m_fp32[23:20]}; 
                8'd4:  max_int_fp32 =  { 19'b0, full_m_fp32[23:19]};
                8'd5:  max_int_fp32 =  { 18'b0, full_m_fp32[23:18]};
                8'd6:  max_int_fp32 =  { 17'b0, full_m_fp32[23:17]};
                8'd7:  max_int_fp32 =  { 16'b0, full_m_fp32[23:16]};
                8'd8:  max_int_fp32 =  { 15'b0, full_m_fp32[23:15]};
                8'd9:  max_int_fp32 =  { 14'b0, full_m_fp32[23:14]};
                8'd10:  max_int_fp32 =  { 13'b0, full_m_fp32[23:13]};
                8'd11:  max_int_fp32 =  { 12'b0, full_m_fp32[23:12]};
                8'd12:  max_int_fp32 =  { 11'b0, full_m_fp32[23:11]};
                8'd13:  max_int_fp32 =  { 10'b0, full_m_fp32[23:10]};
                8'd14:   max_int_fp32 =  { 9'b0,  full_m_fp32[23:9]};
                8'd15:   max_int_fp32 =  { 8'b0,  full_m_fp32[23:8]};
                8'd16:   max_int_fp32 =  { 7'b0,  full_m_fp32[23:7]};
                8'd17:   max_int_fp32 =  { 6'b0,  full_m_fp32[23:6]};
                8'd18:   max_int_fp32 =  { 5'b0,  full_m_fp32[23:5]};
                8'd19:   max_int_fp32 =  { 4'b0,  full_m_fp32[23:4]};
                8'd20:   max_int_fp32 =  { 3'b0,  full_m_fp32[23:3]};
                8'd21:   max_int_fp32 =  { 2'b0,  full_m_fp32[23:2]};
                8'd22:   max_int_fp32 =  { 1'b0,  full_m_fp32[23:1]};
                8'd23:   max_int_fp32 =  {        full_m_fp32[23:0]};
                default: max_int_fp32 =  '0;
            endcase
        end
        default: ;
    endcase   
end


// compute scaling_factor
// one instruction, one cmd, then one scaling factor

always_comb begin : gen_scaling_factor
    
      unique case (operand_eew_b)
        EW8: begin
            scaling_factor   = INT8_SIGNED_MAX / max_int_fp32;
        end  
        EW16: begin
            scaling_factor   = INT16_SIGNED_MAX / max_int_fp32;
        end
        EW32: begin
            scaling_factor   = INT32_SIGNED_MAX / max_int_fp32;
        end
        default: scaling_factor = '0;
      endcase          
end

always_ff @(posedge clk_i or negedge rst_ni)  begin: keep_scaling_factor
    if (!rst_ni) begin
        scaling_factor_reg  <= '0;
        operand_eew_a       <= EW8;
        operand_eew_b       <= EW8;
        olr_thd_dynamic_q   <= outlier_thd_static;
    end else begin
        scaling_factor_reg  <= scaling_factor;
        operand_eew_a       <= operand_eew_a_valid_i ? operand_eew_a_i : operand_eew_a;
        operand_eew_b       <= operand_eew_b_valid_i ? operand_eew_b_i : operand_eew_b;
        olr_thd_dynamic_q   <= olr_thd_dynamic_d;
    end    
end

always_comb begin 
    transfer_pack_o[1].transfer_type = '0;
    transfer_pack_o[0].transfer_type = '0;
    transfer_pack_o[1].transfer_data = '0;
    transfer_pack_o[0].transfer_data = '0;

    // op0_diff_e_fp32 is positive (operand_a[0].e is larger than FP32_E_BIAS),  and larger than olr_thd_dynamic
    // so operand_a[0] is larger than outlier threshold
    if (( operand_a[1].e[7] && olr_thd_diff_e_fp32  < op1_diff_e_fp32 ) || (operand_c[1].e[7] && olr_thd_diff_e_fp32 < op1_c_diff_e_fp32)) begin
        transfer_pack_o[1].transfer_type       = 0;

        if (op1_diff_e_fp32 > op1_c_diff_e_fp32) begin                   // match exponents for larger exponent
            transfer_pack_o[1].transfer_data       = operand_a[1].e;     // the exponend of operand_a
        end else begin
            transfer_pack_o[1].transfer_data       = operand_c[1].e;    // the exponend of operand_c
        end
    end else begin
        transfer_pack_o[1].transfer_type       = 1;
        transfer_pack_o[1].transfer_data       = scaling_factor;
    end

    if (( operand_a[0].e[7] && olr_thd_diff_e_fp32  < op0_diff_e_fp32 ) || (operand_c[0].e[7] && olr_thd_diff_e_fp32 < op0_c_diff_e_fp32)) begin
        transfer_pack_o[0].transfer_type       = 0;

        if (op0_diff_e_fp32 > op0_c_diff_e_fp32) begin
            transfer_pack_o[0].transfer_data       = operand_a[0].e;
        end else begin
            transfer_pack_o[0].transfer_data       = operand_c[0].e;    // the exponend of operand_c
        end
    end else begin
        transfer_pack_o[0].transfer_type       = 1;
        transfer_pack_o[0].transfer_data       = scaling_factor;
    end
end

assign  transfer_pack_valid_o = 1;


endmodule