package ifmix_pkg;


localparam int unsigned NumVIFMM = 4;

typedef enum logic [$clog2(NumVIFMM+1)-1:0] {
     NON_VIFMM,
     F32I8,
     F32I16,
     F16I8,
     F16I16
} vifmm_conversion_e;

typedef struct packed {
    logic [31:0] int32;
    logic [7:0]  e;
} fp32_int32_t;


// TODO: logic   [2:0]    transfer_type;
// |       quantize        |      compensate       |
// | 111 | 101 | 011 | 001 | 110 | 100 | 010 | 000 |
// | I32 | I16 | I8  |  I4 | I64 | I32 | I16 |  I8 |
typedef struct packed {
    logic       transfer_type;      //1/0: quantize       or compensate
    logic [7:0] transfer_data;      // scaling factor or exponent
} transfer_pack_t;

// localparam int unsigned OLR_THD = 32'b0_10000100_10010000000000000000000;  // 50
localparam int unsigned OLR_THD = 32'h4000_0000;  // 2
// localparam int unsigned OLR_THD = 32'h3F00_0000;  // 0.5
localparam int unsigned SCALING_FACTOR_INT8     = 127/OLR_THD;
localparam int unsigned SCALING_FACTOR_INT16    = 32767/OLR_THD;

// compute outlier value with compensation
function automatic logic [31:0] fp32_to_int32_compensate(ara_pkg::fp32_t fp32, logic [7:0] exp_bigger);
     automatic logic [31:0] int32;
     automatic logic [30:0] real_mantissa;
     // Wide sign
     int32[31] = fp32.s;

     if (fp32.e <  exp_bigger) begin
          real_mantissa = {1'b1, fp32.m, 7'b0} >> (exp_bigger - fp32.e);
     end else begin
          real_mantissa = {1'b1, fp32.m, 7'b0};
     end

     int32[30:0] = fp32.s ? {~real_mantissa} + 1 : real_mantissa;

     fp32_to_int32_compensate = int32;

     // `ifdef TARGET_SIMULATION
     //      $display("[TIME: %0t, INFO: FP32_INT32_COMP]: fp32: %h, EB:%h RM: %h, fp32_to_int32_compensate: %h",$time(),fp32, exp_bigger, real_mantissa, fp32_to_int32_compensate);
     // `endif
endfunction

// common value with quantization
// 23 | 22 - 0|
//  1 . -----
function automatic logic [31:0] fp32_to_int8_quantize(ara_pkg::fp32_t fp32, logic [7:0] scaling_factor);
    automatic logic   [7:0]   diff_e_fp32, diff_scaling_factor;
    automatic logic   [23:0]  full_m_fp32,real_mantissa;
    automatic logic   [31:0]  int_val_tmp;
    automatic logic   [7:0]   int_val;

    full_m_fp32 = {1'b1, fp32.m};
    
    if (fp32.e == 8'd0) begin
        int_val                = 8'h0;    
        fp32_to_int8_quantize  = 8'h0;
    end else begin          

          diff_e_fp32         = 8'd127 - fp32.e;

          unique case (diff_e_fp32)
               8'd23:  real_mantissa =  { 23'b0, full_m_fp32[23]};
               8'd22:  real_mantissa =  { 22'b0, full_m_fp32[23:22]};
               8'd21:  real_mantissa =  { 21'b0, full_m_fp32[23:21]};
               8'd20:  real_mantissa =  { 20'b0, full_m_fp32[23:20]}; 
               8'd19:  real_mantissa =  { 19'b0, full_m_fp32[23:19]};
               8'd18:  real_mantissa =  { 18'b0, full_m_fp32[23:18]};
               8'd17:  real_mantissa =  { 17'b0, full_m_fp32[23:17]};
               8'd16:  real_mantissa =  { 16'b0, full_m_fp32[23:16]};
               8'd15:  real_mantissa =  { 15'b0, full_m_fp32[23:15]};
               8'd14:  real_mantissa =  { 14'b0, full_m_fp32[23:14]};
               8'd13:  real_mantissa =  { 13'b0, full_m_fp32[23:13]};
               8'd12:  real_mantissa =  { 12'b0, full_m_fp32[23:12]};
               8'd11:  real_mantissa =  { 11'b0, full_m_fp32[23:11]};
               8'd10:  real_mantissa =  { 10'b0, full_m_fp32[23:10]};
               8'd9:   real_mantissa =  { 9'b0,  full_m_fp32[23:9]};
               8'd8:   real_mantissa =  { 8'b0,  full_m_fp32[23:8]};
               8'd7:   real_mantissa =  { 7'b0,  full_m_fp32[23:7]};
               8'd6:   real_mantissa =  { 6'b0,  full_m_fp32[23:6]};
               8'd5:   real_mantissa =  { 5'b0,  full_m_fp32[23:5]};
               8'd4:   real_mantissa =  { 4'b0,  full_m_fp32[23:4]};
               8'd3:   real_mantissa =  { 3'b0,  full_m_fp32[23:3]};
               8'd2:   real_mantissa =  { 2'b0,  full_m_fp32[23:2]};
               8'd1:   real_mantissa =  { 1'b0,  full_m_fp32[23:1]};
               8'd0:   real_mantissa =  {        full_m_fp32[23:0]};
               default: real_mantissa =  '0;
          endcase

          diff_scaling_factor = scaling_factor - fp32.e;

          case (diff_scaling_factor)
               8'd0:  int_val = |real_mantissa[23:16]
                                   ? real_mantissa[23:16] 
                                   : (real_mantissa[15] ? 8'b1 : 8'b0);                    
               8'd1:  int_val = |real_mantissa[22:15]
                                   ? real_mantissa[22:15]
                                   : (real_mantissa[14] ? 8'b1 : 8'b0);
               8'd2:  int_val = |real_mantissa[21:14]
                                   ? real_mantissa[21:14]
                                   : (real_mantissa[13] ? 8'b1 : 8'b0);
               8'd3:  int_val = |real_mantissa[20:13]
                                   ? real_mantissa[20:13]
                                   : (real_mantissa[12] ? 8'b1 : 8'b0);
               8'd4:  int_val = |real_mantissa[19:12]
                                   ? real_mantissa[19:12]
                                   : (real_mantissa[11] ? 8'b1 : 8'b0);
               8'd5:  int_val = |real_mantissa[18:11]
                                   ? real_mantissa[18:11]
                                   : (real_mantissa[10] ? 8'b1 : 8'b0);
               8'd6:  int_val = |real_mantissa[17:10]
                                   ? real_mantissa[17:10]
                                   : (real_mantissa[9]  ? 8'b1 : 8'b0);
               8'd7:  int_val = |real_mantissa[16:9]
                                   ? real_mantissa[16:9]
                                   : (real_mantissa[8]  ? 8'b1 : 8'b0);
               8'd8:  int_val = |real_mantissa[15:8]
                                   ? real_mantissa[15:8]
                                   : (real_mantissa[7]  ? 8'b1 : 8'b0);
               8'd9:  int_val = |real_mantissa[14:7]
                                   ? real_mantissa[14:7]
                                   : (real_mantissa[6]  ? 8'b1 : 8'b0);
               8'd10: int_val = |real_mantissa[13:6]
                                   ? real_mantissa[13:6]
                                   : (real_mantissa[5]  ? 8'b1 : 8'b0);
               8'd11: int_val = |real_mantissa[12:5]
                                   ? real_mantissa[12:5]
                                   : (real_mantissa[4]  ? 8'b1 : 8'b0);
               8'd12: int_val = |real_mantissa[11:4]
                                   ? real_mantissa[11:4]
                                   : (real_mantissa[3]  ? 8'b1 : 8'b0);
               8'd13: int_val = |real_mantissa[10:3]
                                   ? real_mantissa[10:3]
                                   : (real_mantissa[2]  ? 8'b1 : 8'b0);
               8'd14: int_val = |real_mantissa[9:2]
                                   ? real_mantissa[9:2]
                                   : (real_mantissa[1]  ? 8'b1 : 8'b0);
               8'd15: int_val = |real_mantissa[8:1]
                                   ? real_mantissa[8:1]
                                   : (real_mantissa[0]  ? 8'b1 : 8'b0);
               8'd16: int_val = real_mantissa[7:0]; 
               8'd17: int_val = {1'b0, real_mantissa[6:0]};
               8'd18: int_val = {2'b0, real_mantissa[5:0]};
               8'd19: int_val = {3'b0, real_mantissa[4:0]};
               8'd20: int_val = {4'b0, real_mantissa[3:0]};
               8'd21: int_val = {5'b0, real_mantissa[2:0]};
               8'd22: int_val = {6'b0, real_mantissa[1:0]};
               8'd23: int_val = {7'b0, real_mantissa[0]};
               default:  int_val = 8'h0; // data with too small will be 0
          endcase
     end

     if (int_val == 8'd0) begin
          fp32_to_int8_quantize = 32'h0;
     end else begin
          if (fp32.s) begin
               fp32_to_int8_quantize = {{25{1'b1}}, {(~int_val[6:0])+1'b1}};
          end else begin
               fp32_to_int8_quantize = {24'h0,int_val[7:0]};
          end
     end

     // `ifdef TARGET_SIMULATION
     //      $display("[INFO: FP32_INT8_Q]: fp32: %h full_m_fp32: %h real_mantissa: %h diff_scaling_factor: %d int_val: %d int8_q: %h %d",fp32, full_m_fp32,real_mantissa, diff_scaling_factor, int_val, fp32_to_int8_quantize,$signed(fp32_to_int8_quantize)); 
     // `endif
endfunction

function automatic ara_pkg::fp32_t int32_to_fp32_compensate(logic [63:0] int32,logic [7:0] fp32_exponent);
    automatic logic [62:0] int32_tmp;

    // Need to convert complement code to orginal code, because op_b could be negative though fp32_to_int32_compensate.m is original code
    int32_tmp[62:0]  = int32[63] ? { ~int32[62:0]} + 'b1 : int32[62:0];   
    int32_to_fp32_compensate.s = int32[63];

     unique casex (int32_tmp[62:0])
          63'b1??????_????????_????????_????????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd62 + fp32_exponent- 'd30;   // 30=23+7 real_mantissa
               int32_to_fp32_compensate.m = int32_tmp[61:39];
          end
          63'b01?????_????????_????????_????????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd61 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[60:38];
          end
          63'b001????_????????_????????_????????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd60 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[59:37];
          end
          63'b0001???_????????_????????_????????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd59 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[58:36];
          end
          63'b00001??_????????_????????_????????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd58 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[57:35];
          end
          63'b000001?_????????_????????_????????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd57 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[56:34];
          end
          63'b0000001_????????_????????_????????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd56 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[55:33];
          end
          63'b0000000_1???????_????????_????????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd55 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[54:32];
          end
          63'b0000000_01??????_????????_????????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd54 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[53:31];
          end
          63'b0000000_001?????_????????_????????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd53 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[52:30];
          end
          63'b0000000_0001????_????????_????????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd52 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[51:29];
          end
          63'b0000000_00001???_????????_????????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd51 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[50:28];
          end
          63'b0000000_000001??_????????_????????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd50 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[49:27];
          end
          63'b0000000_0000001?_????????_????????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd49 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[48:26];
          end
          63'b0000000_00000001_????????_????????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd48 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[47:25];
          end
          63'b0000000_00000000_1???????_????????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd47 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[46:24];
          end
          63'b0000000_00000000_01??????_????????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd46 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[45:23];
          end
          63'b0000000_00000000_001?????_????????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd45 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[44:22];
          end
          63'b0000000_00000000_0001????_????????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd44 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[43:21];
          end
          63'b0000000_00000000_00001???_????????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd43 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[42:20];
          end
          63'b0000000_00000000_000001??_????????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd42 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[41:19];
          end
          63'b0000000_00000000_0000001?_????????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd41 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[40:18];
          end
          63'b0000000_00000000_00000001_????????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd40 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[39:17];
          end
          63'b0000000_00000000_00000000_1???????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd39 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[38:16];
          end
          63'b0000000_00000000_00000000_01??????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd38 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[37:15];
          end
          63'b0000000_00000000_00000000_001?????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd37 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[36:14];
          end
          63'b0000000_00000000_00000000_0001????_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd36 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[35:13];
          end
          63'b0000000_00000000_00000000_00001???_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd35 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[34:12];
          end
          63'b0000000_00000000_00000000_000001??_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd34 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[33:11];
          end
          63'b0000000_00000000_00000000_0000001?_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd33 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[32:10];
          end
          63'b0000000_00000000_00000000_00000001_????????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd32 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[31:9];
          end
          63'b0000000_00000000_00000000_00000000_1???????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd31 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[30:8];
          end
          63'b0000000_00000000_00000000_00000000_01??????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd30 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[29:7];
          end
          63'b0000000_00000000_00000000_00000000_001?????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd29 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[28:6];
          end
          63'b0000000_00000000_00000000_00000000_0001????_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd28 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[27:5];
          end
          63'b0000000_00000000_00000000_00000000_00001???_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd27 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[26:4];
          end
          63'b0000000_00000000_00000000_00000000_000001??_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd26 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[25:3];
          end
          63'b0000000_00000000_00000000_00000000_0000001?_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd25 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[24:2];
          end
          63'b0000000_00000000_00000000_00000000_00000001_????????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd24 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[23:1];
          end
          63'b0000000_00000000_00000000_00000000_00000000_1???????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd23 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = int32_tmp[22:0];
          end
          63'b0000000_00000000_00000000_00000000_00000000_01??????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd22 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = {int32_tmp[21:0],1'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_001?????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd21 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = {int32_tmp[20:0],2'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_0001????_????????_????????: begin
               int32_to_fp32_compensate.e = 'd20 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = {int32_tmp[19:0],3'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00001???_????????_????????: begin
               int32_to_fp32_compensate.e = 'd19 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = {int32_tmp[18:0],4'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_000001??_????????_????????: begin
               int32_to_fp32_compensate.e = 'd18 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = {int32_tmp[17:0],5'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_0000001?_????????_????????: begin
               int32_to_fp32_compensate.e = 'd17 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = {int32_tmp[16:0],6'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000001_????????_????????: begin
               int32_to_fp32_compensate.e = 'd16 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = {int32_tmp[15:0],7'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_1???????_????????: begin
               int32_to_fp32_compensate.e = 'd15 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = {int32_tmp[14:0],8'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_01??????_????????: begin
               int32_to_fp32_compensate.e = 'd14 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = {int32_tmp[13:0],9'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_001?????_????????: begin
               int32_to_fp32_compensate.e = 'd13 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = {int32_tmp[12:0],10'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_0001????_????????: begin
               int32_to_fp32_compensate.e = 'd12 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = {int32_tmp[11:0],11'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00001???_????????: begin
               int32_to_fp32_compensate.e = 'd11 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = {int32_tmp[10:0],12'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_000001??_????????: begin
               int32_to_fp32_compensate.e = 'd10 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = {int32_tmp[9:0],13'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_0000001?_????????: begin
               int32_to_fp32_compensate.e = 'd9 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = {int32_tmp[8:0],14'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000001_????????: begin
               int32_to_fp32_compensate.e = 'd8 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = {int32_tmp[7:0],15'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000000_1???????: begin
               int32_to_fp32_compensate.e = 'd7 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = {int32_tmp[6:0],16'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000000_01??????: begin
               int32_to_fp32_compensate.e = 'd6 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = {int32_tmp[5:0],17'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000000_001?????: begin
               int32_to_fp32_compensate.e = 'd5 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = {int32_tmp[4:0],18'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000000_0001????: begin
               int32_to_fp32_compensate.e = 'd4 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = {int32_tmp[3:0],19'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000000_00001???: begin
               int32_to_fp32_compensate.e = 'd3 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = {int32_tmp[2:0],20'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000000_000001??: begin
               int32_to_fp32_compensate.e = 'd2 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = {int32_tmp[1:0],21'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000000_0000001?: begin
               int32_to_fp32_compensate.e = 'd1 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = {int32_tmp[0],22'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000000_00000001: begin
               int32_to_fp32_compensate.e = 'd0 + fp32_exponent- 'd30;
               int32_to_fp32_compensate.m = 23'b0;
          end
          default: begin
               int32_to_fp32_compensate.e = '0;
               int32_to_fp32_compensate.m = '0;
          end
     endcase

     // `ifdef TARGET_SIMULATION
     //      $display("[TIME: %0t, INFO: INT32_FP32_COMP]: int32: %h, exp: %h int32_tmp: %h, int32_to_fp32_compensate: %h",$time(),int32, fp32_exponent, int32_tmp, int32_to_fp32_compensate);
     // `endif
endfunction

function automatic ara_pkg::fp32_t int8_to_fp32_dequantize(logic [63:0] int32,logic [7:0] fp32_exponent);
    automatic logic [62:0] int32_tmp;

    // Need to convert complement code to orginal code, because op_b could be negative though fp32_to_int32_compensate.m is original code
    int32_tmp[62:0]  = int32[63] ? { ~int32[62:0]} + 'b1 : int32[62:0];   
    int8_to_fp32_dequantize.s = int32[63];

     unique casex (int32_tmp[62:0])
          63'b0000000_00000000_00000000_00000000_00000000_00000000_1???????_????????: begin
               int8_to_fp32_dequantize.e = 'd15 + fp32_exponent- 'd6;  // int8, only 7 bits of mantissa is needed, so mantissa left shift 6 bits to the final operand, so we need to minus 6
               int8_to_fp32_dequantize.m = {int32_tmp[14:0],8'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_01??????_????????: begin
               int8_to_fp32_dequantize.e = 'd14 + fp32_exponent- 'd6;
               int8_to_fp32_dequantize.m = {int32_tmp[13:0],9'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_001?????_????????: begin
               int8_to_fp32_dequantize.e = 'd13 + fp32_exponent- 'd6;
               int8_to_fp32_dequantize.m = {int32_tmp[12:0],10'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_0001????_????????: begin
               int8_to_fp32_dequantize.e = 'd12 + fp32_exponent- 'd6;
               int8_to_fp32_dequantize.m = {int32_tmp[11:0],11'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00001???_????????: begin
               int8_to_fp32_dequantize.e = 'd11 + fp32_exponent- 'd6;
               int8_to_fp32_dequantize.m = {int32_tmp[10:0],12'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_000001??_????????: begin
               int8_to_fp32_dequantize.e = 'd10 + fp32_exponent- 'd6;
               int8_to_fp32_dequantize.m = {int32_tmp[9:0],13'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_0000001?_????????: begin
               int8_to_fp32_dequantize.e = 'd9 + fp32_exponent- 'd6;
               int8_to_fp32_dequantize.m = {int32_tmp[8:0],14'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000001_????????: begin
               int8_to_fp32_dequantize.e = 'd8 + fp32_exponent- 'd6;
               int8_to_fp32_dequantize.m = {int32_tmp[7:0],15'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000000_1???????: begin
               int8_to_fp32_dequantize.e = 'd7 + fp32_exponent- 'd6;
               int8_to_fp32_dequantize.m = {int32_tmp[6:0],16'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000000_01??????: begin
               int8_to_fp32_dequantize.e = 'd6 + fp32_exponent- 'd6;
               int8_to_fp32_dequantize.m = {int32_tmp[5:0],17'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000000_001?????: begin
               int8_to_fp32_dequantize.e = 'd5 + fp32_exponent- 'd6;
               int8_to_fp32_dequantize.m = {int32_tmp[4:0],18'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000000_0001????: begin
               int8_to_fp32_dequantize.e = 'd4 + fp32_exponent- 'd6;
               int8_to_fp32_dequantize.m = {int32_tmp[3:0],19'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000000_00001???: begin
               int8_to_fp32_dequantize.e = 'd3 + fp32_exponent- 'd6;
               int8_to_fp32_dequantize.m = {int32_tmp[2:0],20'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000000_000001??: begin
               int8_to_fp32_dequantize.e = 'd2 + fp32_exponent- 'd6;
               int8_to_fp32_dequantize.m = {int32_tmp[1:0],21'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000000_0000001?: begin
               int8_to_fp32_dequantize.e = 'd1 + fp32_exponent- 'd6;
               int8_to_fp32_dequantize.m = {int32_tmp[0],22'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000000_00000001: begin
               int8_to_fp32_dequantize.e = 'd0 + fp32_exponent- 'd6;
               int8_to_fp32_dequantize.m = 23'b0; // no fraction part
          end
          default: begin
               int8_to_fp32_dequantize.e = '0;
               int8_to_fp32_dequantize.m = '0;
          end
     endcase

     // `ifdef TARGET_SIMULATION
     //      $display("[TIME: %0t, INFO: INT32_FP32_COMP]: int32: %h, exp: %h int32_tmp: %h, int8_to_fp32_dequantize: %h",$time(),int32, fp32_exponent, int32_tmp, int8_to_fp32_dequantize);
     // `endif
endfunction

function automatic ara_pkg::fp32_t int_to_fp32(logic [63:0] int32,logic [7:0] fp32_exponent);
    automatic logic [62:0] int32_tmp;

    // Need to convert complement code to orginal code, because op_b could be negative though fp32_to_int32_compensate.m is original code
    int32_tmp[62:0]  = int32[63] ? { ~int32[62:0]} + 'b1 : int32[62:0];   
    int_to_fp32.s = int32[63];

     unique casex (int32_tmp[62:0])
          63'b1??????_????????_????????_????????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd62 + fp32_exponent;   // 30=23+7 real_mantissa
               int_to_fp32.m = int32_tmp[61:39];
          end
          63'b01?????_????????_????????_????????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd61 + fp32_exponent;
               int_to_fp32.m = int32_tmp[60:38];
          end
          63'b001????_????????_????????_????????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd60 + fp32_exponent;
               int_to_fp32.m = int32_tmp[59:37];
          end
          63'b0001???_????????_????????_????????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd59 + fp32_exponent;
               int_to_fp32.m = int32_tmp[58:36];
          end
          63'b00001??_????????_????????_????????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd58 + fp32_exponent;
               int_to_fp32.m = int32_tmp[57:35];
          end
          63'b000001?_????????_????????_????????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd57 + fp32_exponent;
               int_to_fp32.m = int32_tmp[56:34];
          end
          63'b0000001_????????_????????_????????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd56 + fp32_exponent;
               int_to_fp32.m = int32_tmp[55:33];
          end
          63'b0000000_1???????_????????_????????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd55 + fp32_exponent;
               int_to_fp32.m = int32_tmp[54:32];
          end
          63'b0000000_01??????_????????_????????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd54 + fp32_exponent;
               int_to_fp32.m = int32_tmp[53:31];
          end
          63'b0000000_001?????_????????_????????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd53 + fp32_exponent;
               int_to_fp32.m = int32_tmp[52:30];
          end
          63'b0000000_0001????_????????_????????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd52 + fp32_exponent;
               int_to_fp32.m = int32_tmp[51:29];
          end
          63'b0000000_00001???_????????_????????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd51 + fp32_exponent;
               int_to_fp32.m = int32_tmp[50:28];
          end
          63'b0000000_000001??_????????_????????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd50 + fp32_exponent;
               int_to_fp32.m = int32_tmp[49:27];
          end
          63'b0000000_0000001?_????????_????????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd49 + fp32_exponent;
               int_to_fp32.m = int32_tmp[48:26];
          end
          63'b0000000_00000001_????????_????????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd48 + fp32_exponent;
               int_to_fp32.m = int32_tmp[47:25];
          end
          63'b0000000_00000000_1???????_????????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd47 + fp32_exponent;
               int_to_fp32.m = int32_tmp[46:24];
          end
          63'b0000000_00000000_01??????_????????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd46 + fp32_exponent;
               int_to_fp32.m = int32_tmp[45:23];
          end
          63'b0000000_00000000_001?????_????????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd45 + fp32_exponent;
               int_to_fp32.m = int32_tmp[44:22];
          end
          63'b0000000_00000000_0001????_????????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd44 + fp32_exponent;
               int_to_fp32.m = int32_tmp[43:21];
          end
          63'b0000000_00000000_00001???_????????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd43 + fp32_exponent;
               int_to_fp32.m = int32_tmp[42:20];
          end
          63'b0000000_00000000_000001??_????????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd42 + fp32_exponent;
               int_to_fp32.m = int32_tmp[41:19];
          end
          63'b0000000_00000000_0000001?_????????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd41 + fp32_exponent;
               int_to_fp32.m = int32_tmp[40:18];
          end
          63'b0000000_00000000_00000001_????????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd40 + fp32_exponent;
               int_to_fp32.m = int32_tmp[39:17];
          end
          63'b0000000_00000000_00000000_1???????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd39 + fp32_exponent;
               int_to_fp32.m = int32_tmp[38:16];
          end
          63'b0000000_00000000_00000000_01??????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd38 + fp32_exponent;
               int_to_fp32.m = int32_tmp[37:15];
          end
          63'b0000000_00000000_00000000_001?????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd37 + fp32_exponent;
               int_to_fp32.m = int32_tmp[36:14];
          end
          63'b0000000_00000000_00000000_0001????_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd36 + fp32_exponent;
               int_to_fp32.m = int32_tmp[35:13];
          end
          63'b0000000_00000000_00000000_00001???_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd35 + fp32_exponent;
               int_to_fp32.m = int32_tmp[34:12];
          end
          63'b0000000_00000000_00000000_000001??_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd34 + fp32_exponent;
               int_to_fp32.m = int32_tmp[33:11];
          end
          63'b0000000_00000000_00000000_0000001?_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd33 + fp32_exponent;
               int_to_fp32.m = int32_tmp[32:10];
          end
          63'b0000000_00000000_00000000_00000001_????????_????????_????????_????????: begin
               int_to_fp32.e = 'd32 + fp32_exponent;
               int_to_fp32.m = int32_tmp[31:9];
          end
          63'b0000000_00000000_00000000_00000000_1???????_????????_????????_????????: begin
               int_to_fp32.e = 'd31 + fp32_exponent;
               int_to_fp32.m = int32_tmp[30:8];
          end
          63'b0000000_00000000_00000000_00000000_01??????_????????_????????_????????: begin
               int_to_fp32.e = 'd30 + fp32_exponent;
               int_to_fp32.m = int32_tmp[29:7];
          end
          63'b0000000_00000000_00000000_00000000_001?????_????????_????????_????????: begin
               int_to_fp32.e = 'd29 + fp32_exponent;
               int_to_fp32.m = int32_tmp[28:6];
          end
          63'b0000000_00000000_00000000_00000000_0001????_????????_????????_????????: begin
               int_to_fp32.e = 'd28 + fp32_exponent;
               int_to_fp32.m = int32_tmp[27:5];
          end
          63'b0000000_00000000_00000000_00000000_00001???_????????_????????_????????: begin
               int_to_fp32.e = 'd27 + fp32_exponent;
               int_to_fp32.m = int32_tmp[26:4];
          end
          63'b0000000_00000000_00000000_00000000_000001??_????????_????????_????????: begin
               int_to_fp32.e = 'd26 + fp32_exponent;
               int_to_fp32.m = int32_tmp[25:3];
          end
          63'b0000000_00000000_00000000_00000000_0000001?_????????_????????_????????: begin
               int_to_fp32.e = 'd25 + fp32_exponent;
               int_to_fp32.m = int32_tmp[24:2];
          end
          63'b0000000_00000000_00000000_00000000_00000001_????????_????????_????????: begin
               int_to_fp32.e = 'd24 + fp32_exponent;
               int_to_fp32.m = int32_tmp[23:1];
          end
          63'b0000000_00000000_00000000_00000000_00000000_1???????_????????_????????: begin
               int_to_fp32.e = 'd23 + fp32_exponent;
               int_to_fp32.m = int32_tmp[22:0];
          end
          63'b0000000_00000000_00000000_00000000_00000000_01??????_????????_????????: begin
               int_to_fp32.e = 'd22 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[21:0],1'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_001?????_????????_????????: begin
               int_to_fp32.e = 'd21 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[20:0],2'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_0001????_????????_????????: begin
               int_to_fp32.e = 'd20 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[19:0],3'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00001???_????????_????????: begin
               int_to_fp32.e = 'd19 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[18:0],4'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_000001??_????????_????????: begin
               int_to_fp32.e = 'd18 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[17:0],5'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_0000001?_????????_????????: begin
               int_to_fp32.e = 'd17 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[16:0],6'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000001_????????_????????: begin
               int_to_fp32.e = 'd16 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[15:0],7'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_1???????_????????: begin
               int_to_fp32.e = 'd15 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[14:0],8'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_01??????_????????: begin
               int_to_fp32.e = 'd14 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[13:0],9'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_001?????_????????: begin
               int_to_fp32.e = 'd13 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[12:0],10'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_0001????_????????: begin
               int_to_fp32.e = 'd12 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[11:0],11'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00001???_????????: begin
               int_to_fp32.e = 'd11 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[10:0],12'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_000001??_????????: begin
               int_to_fp32.e = 'd10 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[9:0],13'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_0000001?_????????: begin
               int_to_fp32.e = 'd9 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[8:0],14'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000001_????????: begin
               int_to_fp32.e = 'd8 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[7:0],15'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000000_1???????: begin
               int_to_fp32.e = 'd7 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[6:0],16'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000000_01??????: begin
               int_to_fp32.e = 'd6 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[5:0],17'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000000_001?????: begin
               int_to_fp32.e = 'd5 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[4:0],18'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000000_0001????: begin
               int_to_fp32.e = 'd4 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[3:0],19'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000000_00001???: begin
               int_to_fp32.e = 'd3 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[2:0],20'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000000_000001??: begin
               int_to_fp32.e = 'd2 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[1:0],21'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000000_0000001?: begin
               int_to_fp32.e = 'd1 + fp32_exponent;
               int_to_fp32.m = {int32_tmp[0],22'b0};
          end
          63'b0000000_00000000_00000000_00000000_00000000_00000000_00000000_00000001: begin
               int_to_fp32.e = 'd0 + fp32_exponent;
               int_to_fp32.m = 23'b0;
          end
          default: begin
               int_to_fp32.e = '0;
               int_to_fp32.m = '0;
          end
     endcase

     // `ifdef TARGET_SIMULATION
     //      $display("[TIME: %0t, INFO: INT32_FP32_COMP]: int32: %h, exp: %h int32_tmp: %h, int_to_fp32: %h",$time(),int32, fp32_exponent, int32_tmp, int_to_fp32);
     // `endif
endfunction


endpackage: ifmix_pkg