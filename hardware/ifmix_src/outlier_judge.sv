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

fp32_t [1:0]    operand_a,operand_b,operand_c;
fp32_t          olr_thd_dynamic_d,olr_thd_dynamic_q;
logic   [23:0]  max_int_fp32;
logic   [7:0]   olr_thd_diff_e_fp32;
logic   [7:0]   opa0_diff_e_fp32,opa1_diff_e_fp32;
logic   [7:0]   opc0_diff_e_fp32,opc1_diff_e_fp32;
// logic   [15:0]  op0_comp_diff_e_fp32, op1_comp_diff_e_fp32, olr_thd_comp_diff_e_fp32;
// logic   [15:0]  op0_abs_comp_diff_e_fp32, op1_abs_comp_diff_e_fp32, olrthd_abs_comp_diff_e_fp32;
logic   [23:0]  full_m_fp32;

logic   [7:0] scaling_factor,scaling_factor_reg;

// assign          full_m_fp32 = {1'b1, olr_thd_dynamic_d.m};
assign          full_m_fp32 = {1'b1, outlier_thd_static.m};

always_comb begin  // update olr_thd
    operand_a[1]                  = '0;
    operand_a[0]                  = '0;
    operand_b[1]                  = '0;
    operand_b[0]                  = '0;
    operand_c[1]                  = '0;
    operand_c[0]                  = '0;
    olr_thd_dynamic_d           = olr_thd_dynamic_q;
    max_int_fp32                = {        full_m_fp32[23:0]};
    olr_thd_diff_e_fp32         = '0;
    opa0_diff_e_fp32             = '0;  
    opc0_diff_e_fp32             = '0;  
    // op0_comp_diff_e_fp32        = '0;          
    // op0_abs_comp_diff_e_fp32    = '0;              
    opa1_diff_e_fp32             = '0;  
    opc1_diff_e_fp32             = '0;  
    // op1_comp_diff_e_fp32        = '0;          
    // op1_abs_comp_diff_e_fp32    = '0;      
    olr_thd_diff_e_fp32         = '0;
    // olr_thd_comp_diff_e_fp32    = '0;        
    // olrthd_abs_comp_diff_e_fp32 = '0;        
    scaling_factor              = '0;              

    unique case (conver_type_i)
        F16I8: begin
            
        end  
        F16I16: begin
            
        end
        F32I8: begin
            operand_a[1]    = operand_i[0][63:32];
            operand_a[0]    = operand_i[0][31:0];
            operand_b[1]    = operand_i[1][63:32];
            operand_b[0]    = operand_i[1][31:0];
            operand_c[1]    = operand_i[2][63:32];
            operand_c[0]    = operand_i[2][31:0];
            
            opa0_diff_e_fp32             = operand_a[0].e - FP32_E_BIAS;   // maybe less than 0
            opc0_diff_e_fp32             = operand_c[0].e - FP32_E_BIAS;
            // op0_comp_diff_e_fp32        = {{8{op0_diff_e_fp32[7]}}, op0_diff_e_fp32};  // complement for 16 bits
            // op0_abs_comp_diff_e_fp32    = op0_comp_diff_e_fp32[15] ?  ~op0_comp_diff_e_fp32 + 1: op0_comp_diff_e_fp32;

            opa1_diff_e_fp32             = operand_a[1].e - FP32_E_BIAS;
            opc1_diff_e_fp32             = operand_c[1].e - FP32_E_BIAS;
            // op1_comp_diff_e_fp32        = {{8{op1_diff_e_fp32[7]}}, op1_diff_e_fp32};
            // op1_abs_comp_diff_e_fp32    = op1_comp_diff_e_fp32[15] ?  ~op1_comp_diff_e_fp32 + 1: op1_comp_diff_e_fp32;

            // mostly, olr_thd_dynamic > 1, so olr_thd_dynamic_d.e > 127
            // olr_thd_diff_e_fp32         = olr_thd_dynamic_d.e - FP32_E_BIAS;   
            olr_thd_diff_e_fp32         = outlier_thd_static.e - FP32_E_BIAS;   // use static outlier threshold

            // olr_thd_comp_diff_e_fp32    = {{8{olr_thd_diff_e_fp32[7]}}, olr_thd_diff_e_fp32}; 
            // olrthd_abs_comp_diff_e_fp32 = olr_thd_comp_diff_e_fp32[15] ?  ~olr_thd_comp_diff_e_fp32 + 1: olr_thd_comp_diff_e_fp32;

            // operand[0].e is positive (operand[0].e is larger than FP32_E_BIAS) and 2^7=128 larger than olr_thd_dynamic      
            // if ((olrthd_abs_comp_diff_e_fp32 + 7) < op0_abs_comp_diff_e_fp32 ) begin  
            if (operand_a[0].e[7] && ((olr_thd_diff_e_fp32 + 7) < opa0_diff_e_fp32)) begin 
                olr_thd_dynamic_d = operand_a[0];
            end

            // if ((olrthd_abs_comp_diff_e_fp32 + 7) < op1_abs_comp_diff_e_fp32 ) begin
            if (operand_a[1].e[7] && ((olr_thd_diff_e_fp32 + 7) < opa1_diff_e_fp32)) begin        
                olr_thd_dynamic_d = operand_a[1];
            end
            if (operand_c[0].e[7] && ((olr_thd_diff_e_fp32 + 7) < opc0_diff_e_fp32)) begin        
                olr_thd_dynamic_d = operand_c[0];
            end
            if (operand_c[1].e[7] && ((olr_thd_diff_e_fp32 + 7) < opc1_diff_e_fp32)) begin        
                olr_thd_dynamic_d = operand_c[1];
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
                default: max_int_fp32 =  {        full_m_fp32[23:0]};
            endcase

            // compute scaling_factor
            // one instruction, one cmd, then one scaling factor
            // scaling_factor   = INT8_SIGNED_MAX / max_int_fp32;
            unique case (max_int_fp32)
                24'b1:   scaling_factor = INT8_SIGNED_MAX;
                24'b10:  scaling_factor = INT8_SIGNED_MAX/2;
                24'b11:  scaling_factor = INT8_SIGNED_MAX/3;
                24'b100:  scaling_factor = INT8_SIGNED_MAX/4;
                24'b101:  scaling_factor = INT8_SIGNED_MAX/5;
                24'b110:  scaling_factor = INT8_SIGNED_MAX/6;
                24'b111:  scaling_factor = INT8_SIGNED_MAX/7;
                24'b1000: scaling_factor = INT8_SIGNED_MAX/8;
                24'b1001: scaling_factor = INT8_SIGNED_MAX/9;
                24'b1010: scaling_factor = INT8_SIGNED_MAX/10;
                24'b1011: scaling_factor = INT8_SIGNED_MAX/11;
                24'b1100: scaling_factor = INT8_SIGNED_MAX/12;
                24'b1101: scaling_factor = INT8_SIGNED_MAX/13;
                24'b1110: scaling_factor = INT8_SIGNED_MAX/14;
                24'b1111: scaling_factor = INT8_SIGNED_MAX/15;
                24'b10000: scaling_factor = INT8_SIGNED_MAX/16;
                24'b10001: scaling_factor = INT8_SIGNED_MAX/17;
                24'b10010: scaling_factor = INT8_SIGNED_MAX/18;
                24'b10011: scaling_factor = INT8_SIGNED_MAX/19;
                24'b10100: scaling_factor = INT8_SIGNED_MAX/20;
                24'b10101: scaling_factor = INT8_SIGNED_MAX/21;
                24'b10110: scaling_factor = INT8_SIGNED_MAX/22;
                24'b10111: scaling_factor = INT8_SIGNED_MAX/23;
                24'b11000: scaling_factor = INT8_SIGNED_MAX/24;
                24'b11001: scaling_factor = INT8_SIGNED_MAX/25;
                24'b11010: scaling_factor = INT8_SIGNED_MAX/26;
                24'b11011: scaling_factor = INT8_SIGNED_MAX/27;
                24'b11100: scaling_factor = INT8_SIGNED_MAX/28;
                24'b11101: scaling_factor = INT8_SIGNED_MAX/29;
                24'b11110: scaling_factor = INT8_SIGNED_MAX/30;
                24'b11111: scaling_factor = INT8_SIGNED_MAX/31;
                24'b100000: scaling_factor = INT8_SIGNED_MAX/32;
                24'b100001: scaling_factor = INT8_SIGNED_MAX/33;
                24'b100010: scaling_factor = INT8_SIGNED_MAX/34;
                24'b100011: scaling_factor = INT8_SIGNED_MAX/35;
                24'b100100: scaling_factor = INT8_SIGNED_MAX/36;
                24'b100101: scaling_factor = INT8_SIGNED_MAX/37;
                24'b100110: scaling_factor = INT8_SIGNED_MAX/38;
                24'b100111: scaling_factor = INT8_SIGNED_MAX/39;
                24'b101000: scaling_factor = INT8_SIGNED_MAX/40;
                24'b101001: scaling_factor = INT8_SIGNED_MAX/41;
                24'b101010: scaling_factor = INT8_SIGNED_MAX/42;
                24'b101011: scaling_factor = INT8_SIGNED_MAX/43;
                24'b101100: scaling_factor = INT8_SIGNED_MAX/44;
                24'b101101: scaling_factor = INT8_SIGNED_MAX/45;
                24'b101110: scaling_factor = INT8_SIGNED_MAX/46;
                24'b101111: scaling_factor = INT8_SIGNED_MAX/47;
                24'b110000: scaling_factor = INT8_SIGNED_MAX/48;
                24'b110001: scaling_factor = INT8_SIGNED_MAX/49;
                24'b110010: scaling_factor = INT8_SIGNED_MAX/50;
                24'b110011: scaling_factor = INT8_SIGNED_MAX/51;
                24'b110100: scaling_factor = INT8_SIGNED_MAX/52;
                24'b110101: scaling_factor = INT8_SIGNED_MAX/53;
                24'b110110: scaling_factor = INT8_SIGNED_MAX/54;
                24'b110111: scaling_factor = INT8_SIGNED_MAX/55;
                24'b111000: scaling_factor = INT8_SIGNED_MAX/56;
                24'b111001: scaling_factor = INT8_SIGNED_MAX/57;
                24'b111010: scaling_factor = INT8_SIGNED_MAX/58;
                24'b111011: scaling_factor = INT8_SIGNED_MAX/59;
                24'b111100: scaling_factor = INT8_SIGNED_MAX/60;
                24'b111101: scaling_factor = INT8_SIGNED_MAX/61;
                24'b111110: scaling_factor = INT8_SIGNED_MAX/62;
                24'b111111: scaling_factor = INT8_SIGNED_MAX/63;
                24'b1000000: scaling_factor = INT8_SIGNED_MAX/64;
                24'b1000001: scaling_factor = INT8_SIGNED_MAX/65;
                24'b1000010: scaling_factor = INT8_SIGNED_MAX/66;
                24'b1000011: scaling_factor = INT8_SIGNED_MAX/67;
                24'b1000100: scaling_factor = INT8_SIGNED_MAX/68;
                24'b1000101: scaling_factor = INT8_SIGNED_MAX/69;
                24'b1000110: scaling_factor = INT8_SIGNED_MAX/70;
                24'b1000111: scaling_factor = INT8_SIGNED_MAX/71;
                24'b1001000: scaling_factor = INT8_SIGNED_MAX/72;
                24'b1001001: scaling_factor = INT8_SIGNED_MAX/73;
                24'b1001010: scaling_factor = INT8_SIGNED_MAX/74;
                24'b1001011: scaling_factor = INT8_SIGNED_MAX/75;
                24'b1001100: scaling_factor = INT8_SIGNED_MAX/76;
                24'b1001101: scaling_factor = INT8_SIGNED_MAX/77;
                24'b1001110: scaling_factor = INT8_SIGNED_MAX/78;
                24'b1001111: scaling_factor = INT8_SIGNED_MAX/79;
                24'b1010000: scaling_factor = INT8_SIGNED_MAX/80;
                24'b1010001: scaling_factor = INT8_SIGNED_MAX/81;
                24'b1010010: scaling_factor = INT8_SIGNED_MAX/82;
                24'b1010011: scaling_factor = INT8_SIGNED_MAX/83;
                24'b1010100: scaling_factor = INT8_SIGNED_MAX/84;
                24'b1010101: scaling_factor = INT8_SIGNED_MAX/85;
                24'b1010110: scaling_factor = INT8_SIGNED_MAX/86;
                24'b1010111: scaling_factor = INT8_SIGNED_MAX/87;
                24'b1011000: scaling_factor = INT8_SIGNED_MAX/88;
                24'b1011001: scaling_factor = INT8_SIGNED_MAX/89;
                24'b1011010: scaling_factor = INT8_SIGNED_MAX/90;
                24'b1011011: scaling_factor = INT8_SIGNED_MAX/91;
                24'b1011100: scaling_factor = INT8_SIGNED_MAX/92;
                24'b1011101: scaling_factor = INT8_SIGNED_MAX/93;
                24'b1011110: scaling_factor = INT8_SIGNED_MAX/94;
                24'b1011111: scaling_factor = INT8_SIGNED_MAX/95;
                24'b1100000: scaling_factor = INT8_SIGNED_MAX/96;
                24'b1100001: scaling_factor = INT8_SIGNED_MAX/97;
                24'b1100010: scaling_factor = INT8_SIGNED_MAX/98;
                24'b1100011: scaling_factor = INT8_SIGNED_MAX/99;
                24'b1100100: scaling_factor = INT8_SIGNED_MAX/100;
                24'b1100101: scaling_factor = INT8_SIGNED_MAX/101;
                24'b1100110: scaling_factor = INT8_SIGNED_MAX/102;
                24'b1100111: scaling_factor = INT8_SIGNED_MAX/103;
                24'b1101000: scaling_factor = INT8_SIGNED_MAX/104;
                24'b1101001: scaling_factor = INT8_SIGNED_MAX/105;
                24'b1101010: scaling_factor = INT8_SIGNED_MAX/106;
                24'b1101011: scaling_factor = INT8_SIGNED_MAX/107;
                24'b1101100: scaling_factor = INT8_SIGNED_MAX/108;
                24'b1101101: scaling_factor = INT8_SIGNED_MAX/109;
                24'b1101110: scaling_factor = INT8_SIGNED_MAX/110;
                24'b1101111: scaling_factor = INT8_SIGNED_MAX/111;
                24'b1110000: scaling_factor = INT8_SIGNED_MAX/112;
                24'b1110001: scaling_factor = INT8_SIGNED_MAX/113;
                24'b1110010: scaling_factor = INT8_SIGNED_MAX/114;
                24'b1110011: scaling_factor = INT8_SIGNED_MAX/115;
                24'b1110100: scaling_factor = INT8_SIGNED_MAX/116;
                24'b1110101: scaling_factor = INT8_SIGNED_MAX/117;
                24'b1110110: scaling_factor = INT8_SIGNED_MAX/118;
                24'b1110111: scaling_factor = INT8_SIGNED_MAX/119;
                24'b1111000: scaling_factor = INT8_SIGNED_MAX/120;
                24'b1111001: scaling_factor = INT8_SIGNED_MAX/121;
                24'b1111010: scaling_factor = INT8_SIGNED_MAX/122;
                24'b1111011: scaling_factor = INT8_SIGNED_MAX/123;
                24'b1111100: scaling_factor = INT8_SIGNED_MAX/124;
                24'b1111101: scaling_factor = INT8_SIGNED_MAX/125;
                24'b1111110: scaling_factor = INT8_SIGNED_MAX/126;
                24'b1111111: scaling_factor = INT8_SIGNED_MAX/127;
                24'b10000000: scaling_factor = INT8_SIGNED_MAX/128;
                default: scaling_factor = INT8_SIGNED_MAX;
            endcase
        end
        default: ;
    endcase   
end




always_ff @(posedge clk_i or negedge rst_ni)  begin: keep_scaling_factor
    if (!rst_ni) begin
        scaling_factor_reg  <= '0;
        
        olr_thd_dynamic_q   <= outlier_thd_static;
    end else begin
        scaling_factor_reg  <= scaling_factor;
        
        olr_thd_dynamic_q   <= olr_thd_dynamic_d;
    end    
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
        // if ( operand[1].e[7] && olr_thd_diff_e_fp32  < op1_diff_e_fp32 ) begin
            transfer_pack_o[1].transfer_type       = 0;
            // transfer_pack_o[1].transfer_data       = operand_a[1].e;
            transfer_pack_o[1].transfer_data       = (operand_valid_i[0] & operand_valid_i[2]) 
                                                     ? ($unsigned(operand_a[1].e) > $unsigned   (operand_c[1].e) ? operand_a[1].e :    operand_c[1].e) 
                                                     : '0;
        // end else begin
            // transfer_pack_o[1].transfer_type       = 1;
            // transfer_pack_o[1].transfer_data       = scaling_factor;
        // end

        // if ( operand[0].e[7] && olr_thd_diff_e_fp32  < op0_diff_e_fp32 ) begin
            transfer_pack_o[0].transfer_type       = 0;
            // transfer_pack_o[0].transfer_data       = operand_a[0].e;
            transfer_pack_o[0].transfer_data       = (operand_valid_i[0] & operand_valid_i[2]) 
                                                     ? ($unsigned(operand_a[0].e) > $unsigned   (operand_c[0].e) ? operand_a[0].e :    operand_c[0].e)
                                                     : '0;
        // end else begin
            // transfer_pack_o[0].transfer_type       = 1;
            // transfer_pack_o[0].transfer_data       = scaling_factor;
        // end

        if (transfer_pack_o[1].transfer_type) begin
            operand_o[0][63:32] = fp32_to_int8_quantize(operand_i[0][63:32], transfer_pack_o    [1].transfer_data);
            operand_o[2][63:32] = fp32_to_int8_quantize(operand_i[2][63:32], transfer_pack_o    [1].transfer_data);
        end else begin
            operand_o[0][63:32] = fp32_to_int32_compensate(operand_i[0][63:32], transfer_pack_o [1].transfer_data);
            operand_o[2][63:32] = fp32_to_int32_compensate(operand_i[2][63:32], transfer_pack_o [1].transfer_data);
        end

        if (transfer_pack_o[0].transfer_type) begin
            operand_o[0][31:0] = fp32_to_int8_quantize(operand_i[0][31:0], transfer_pack_o[0].  transfer_data);
            operand_o[2][31:0] = fp32_to_int8_quantize(operand_i[2][31:0], transfer_pack_o[0].  transfer_data);
        end else begin
            operand_o[0][31:0] = fp32_to_int32_compensate(operand_i[0][31:0], transfer_pack_o   [0].transfer_data);
            operand_o[2][31:0] = fp32_to_int32_compensate(operand_i[2][31:0], transfer_pack_o   [0].transfer_data);
        end
    end

    
    
end

assign  transfer_pack_valid_o = 1;


endmodule