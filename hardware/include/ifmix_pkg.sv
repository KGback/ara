package ifmix_pkg;

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
localparam int unsigned SCALING_FACTOR_INT8     = 127/OLR_THD;
localparam int unsigned SCALING_FACTOR_INT16    = 32767/OLR_THD;

// compute outlier value with compensation
function automatic logic [31:0] fp32_to_int32_compensate(ara_pkg::fp32_t fp32);
    automatic logic [31:0] int32;

    // Wide sign
    int32[31] = fp32.s;

    int32[30:0] = fp32.s ? {~{7'b0,1'b1,fp32.m}} + 1 : {7'b0,1'b1,fp32.m};

    fp32_to_int32_compensate = int32;
endfunction

// common value with quantization
// 23 | 22 - 0|
//  1 . -----
function automatic logic [31:0] fp32_to_int8_quantize(ara_pkg::fp32_t fp32, logic [7:0] scaling_factor);
    automatic logic   [7:0]   diff_e_fp32;
    automatic logic   [23:0]  full_m_fp32;
    automatic logic   [31:0]  int_val_tmp;
    automatic logic   [7:0]   int_val;

    full_m_fp32 = {1'b1, fp32.m};
    
    if (fp32.e == 8'd0) begin
        int_val                = 8'h0;    
        fp32_to_int8_quantize  = 8'h0;
    end else begin
          int_val_tmp  = full_m_fp32 * scaling_factor;  //bitwidth: 32 = 24 + 8
          
          if (fp32.e > 8'd127) begin // left shift
               diff_e_fp32 = fp32.e - 8'd127;

               case (diff_e_fp32)
                    8'd0: int_val = int_val_tmp[22] ? {int_val_tmp[30:23]      } + 1'b1 : {int_val_tmp[30:23]      };  // only need integer part
                    8'd1: int_val = int_val_tmp[22] ? {int_val_tmp[29:23], 1'b0} + 1'b1 : {int_val_tmp[29:23], 1'b0};  // round to the nearest
                    8'd2: int_val = int_val_tmp[22] ? {int_val_tmp[28:23], 2'b0} + 1'b1 : {int_val_tmp[28:23], 2'b0};
                    8'd3: int_val = int_val_tmp[22] ? {int_val_tmp[27:23], 3'b0} + 1'b1 : {int_val_tmp[27:23], 3'b0};
                    8'd4: int_val = int_val_tmp[22] ? {int_val_tmp[26:23], 4'b0} + 1'b1 : {int_val_tmp[26:23], 4'b0};
                    8'd5: int_val = int_val_tmp[22] ? {int_val_tmp[25:23], 5'b0} + 1'b1 : {int_val_tmp[25:23], 5'b0};
                    8'd6: int_val = int_val_tmp[22] ? {int_val_tmp[24:23], 6'b0} + 1'b1 : {int_val_tmp[24:23], 6'b0};
                    8'd7: int_val = int_val_tmp[22] ? {int_val_tmp[23],    7'b0} + 1'b1 : {int_val_tmp[23],    7'b0};
                    default:  int_val = 8'd127;    // data with too big will be max of int8
               endcase

          end else begin      // right shift
               diff_e_fp32 = 8'd127 - fp32.e;

               case (diff_e_fp32)
                    8'd0: int_val = int_val_tmp[22]  ?         int_val_tmp[30:23] + 1'b1 :         int_val_tmp[30:23];  // only need integer part
                    8'd1: int_val = int_val_tmp[23]  ? {1'b0, int_val_tmp[30:24]} + 1'b1 : {1'b0, int_val_tmp[30:24]};
                    8'd2: int_val = int_val_tmp[24]  ? {2'b0, int_val_tmp[30:25]} + 1'b1 : {2'b0, int_val_tmp[30:25]};
                    8'd3: int_val = int_val_tmp[25]  ? {3'b0, int_val_tmp[30:26]} + 1'b1 : {3'b0, int_val_tmp[30:26]};
                    8'd4: int_val = int_val_tmp[26]  ? {4'b0, int_val_tmp[30:27]} + 1'b1 : {4'b0, int_val_tmp[30:27]};
                    8'd5: int_val = int_val_tmp[27]  ? {5'b0, int_val_tmp[30:28]} + 1'b1 : {5'b0, int_val_tmp[30:28]};
                    8'd6: int_val = int_val_tmp[28]  ? {6'b0, int_val_tmp[30:29]} + 1'b1 : {6'b0, int_val_tmp[30:29]};
                    8'd7: int_val = int_val_tmp[29]  ? {7'b0, int_val_tmp[30]   } + 1'b1 : {7'b0, int_val_tmp[30]   };
                    default:  int_val = '0;       // data with too small will be 0
               endcase
          end
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

     `ifdef TARGET_SIMULATION
          $display("[INFO: FP32_INT8_Q]: fp32: %h full_m_fp32: %h, int_val: %d, int8_q: %h %d",fp32, full_m_fp32, int_val, fp32_to_int8_quantize,$signed(fp32_to_int8_quantize)); 
     `endif
endfunction

function automatic ara_pkg::fp32_t int32_to_fp32_compensate(logic [31:0] int32,logic [7:0] fp32_exponent);
    automatic logic [30:0] int32_tmp;

    // Need to convert complement code to orginal code, because op_b could be negative though fp32_to_int32_compensate.m is original code
    int32_tmp[30:0]  = int32[31] ? { ~int32[30:0]} + 'b1 : int32[30:0];   
    int32_to_fp32_compensate.s = int32[31];

    unique casex ({int32[31],int32_tmp[30:0]})
        32'b11??????_????????_????????_????????: begin
             int32_to_fp32_compensate.e = 'd30 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = int32_tmp[29:7];
        end
        32'b101?????_????????_????????_????????: begin
             int32_to_fp32_compensate.e = 'd29 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = int32_tmp[28:6];
        end
        32'b1001????_????????_????????_????????: begin
             int32_to_fp32_compensate.e = 'd28 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = int32_tmp[27:5];
        end
        32'b10001???_????????_????????_????????: begin
             int32_to_fp32_compensate.e = 'd27 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = int32_tmp[26:4];
        end
        32'b100001??_????????_????????_????????: begin
             int32_to_fp32_compensate.e = 'd26 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = int32_tmp[25:3];;
        end
        32'b1000001?_????????_????????_????????: begin
             int32_to_fp32_compensate.e = 'd25 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = int32_tmp[24:2];;
        end
        32'b10000001_????????_????????_????????: begin
             int32_to_fp32_compensate.e = 'd24 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = int32_tmp[23:1];;
        end
        32'b10000000_1???????_????????_????????: begin
             int32_to_fp32_compensate.e = 'd23 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = int32_tmp[22:0];;
        end
        32'b10000000_01??????_????????_????????: begin
             int32_to_fp32_compensate.e = 'd22 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {1'b0,int32_tmp[21:0]};
        end
        32'b10000000_001?????_????????_????????: begin
             int32_to_fp32_compensate.e = 'd21 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {2'b0,int32_tmp[20:0]};
        end
        32'b10000000_0001????_????????_????????: begin
             int32_to_fp32_compensate.e = 'd20 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {3'b0,int32_tmp[19:0]};
        end
        32'b10000000_00001???_????????_????????: begin
             int32_to_fp32_compensate.e = 'd19 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {4'b0,int32_tmp[18:0]};
        end
        32'b10000000_000001??_????????_????????: begin
             int32_to_fp32_compensate.e = 'd18 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {5'b0,int32_tmp[17:0]};
        end
        32'b10000000_0000001?_????????_????????: begin
             int32_to_fp32_compensate.e = 'd17 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {6'b0,int32_tmp[16:0]};
        end
        32'b10000000_00000001_????????_????????: begin
             int32_to_fp32_compensate.e = 'd16 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {7'b0,int32_tmp[15:0]};
        end
        32'b10000000_00000000_1???????_????????: begin
             int32_to_fp32_compensate.e = 'd15 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {8'b0,int32_tmp[14:0]};
        end
        32'b10000000_00000000_01??????_????????: begin
            int32_to_fp32_compensate.e = 'd14 + fp32_exponent- 'd23;
            int32_to_fp32_compensate.m = {9'b0,int32_tmp[13:0]};
        end
        32'b10000000_00000000_001?????_????????: begin
            int32_to_fp32_compensate.e = 'd13 + fp32_exponent- 'd23;
            int32_to_fp32_compensate.m = {10'b0,int32_tmp[12:0]};
        end
        32'b10000000_00000000_0001????_????????: begin
            int32_to_fp32_compensate.e = 'd12 + fp32_exponent- 'd23;
            int32_to_fp32_compensate.m = {11'b0,int32_tmp[11:0]};
        end
        32'b10000000_00000000_00001???_????????: begin
            int32_to_fp32_compensate.e = 'd11 + fp32_exponent- 'd23;
            int32_to_fp32_compensate.m = {12'b0,int32_tmp[10:0]};
        end
        32'b10000000_00000000_000001??_????????: begin
            int32_to_fp32_compensate.e = 'd10 + fp32_exponent- 'd23;
            int32_to_fp32_compensate.m = {13'b0,int32_tmp[9:0]};
        end
        32'b10000000_00000000_0000001?_????????: begin
            int32_to_fp32_compensate.e = 'd9 + fp32_exponent- 'd23;
            int32_to_fp32_compensate.m = {14'b0,int32_tmp[8:0]};
        end
        32'b10000000_00000000_00000001_????????: begin
            int32_to_fp32_compensate.e = 'd8 + fp32_exponent- 'd23;
            int32_to_fp32_compensate.m = {15'b0,int32_tmp[7:0]};
        end
        32'b10000000_00000000_00000000_1???????: begin
            int32_to_fp32_compensate.e = 'd7 + fp32_exponent- 'd23;
            int32_to_fp32_compensate.m = {16'b0,int32_tmp[6:0]};
        end
        32'b10000000_00000000_00000000_01??????: begin
            int32_to_fp32_compensate.e = 'd6 + fp32_exponent- 'd23;
            int32_to_fp32_compensate.m = {17'b0,int32_tmp[5:0]};
        end
        32'b10000000_00000000_00000000_001?????: begin
            int32_to_fp32_compensate.e = 'd5 + fp32_exponent- 'd23;
            int32_to_fp32_compensate.m = {18'b0,int32_tmp[4:0]};
        end
        32'b10000000_00000000_00000000_0001????: begin
            int32_to_fp32_compensate.e = 'd4 + fp32_exponent- 'd23;
            int32_to_fp32_compensate.m = {19'b0,int32_tmp[3:0]};
        end
        32'b10000000_00000000_00000000_00001???: begin
            int32_to_fp32_compensate.e = 'd3 + fp32_exponent- 'd23;
            int32_to_fp32_compensate.m = {20'b0,int32_tmp[2:0]};
        end
        32'b10000000_00000000_00000000_000001??: begin
            int32_to_fp32_compensate.e = 'd2 + fp32_exponent- 'd23;
            int32_to_fp32_compensate.m = {21'b0,int32_tmp[1:0]};
        end
        32'b10000000_00000000_00000000_0000001?: begin
            int32_to_fp32_compensate.e = 'd1 + fp32_exponent- 'd23;
            int32_to_fp32_compensate.m = {22'b0,int32_tmp[0]};
        end
        32'b10000000_00000000_00000000_00000001: begin
             int32_to_fp32_compensate.e = fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {23'b0};
        end
        32'b01??????_????????_????????_????????: begin
             int32_to_fp32_compensate.e = 'd30 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = int32_tmp[29:7];
        end
        32'b001?????_????????_????????_????????: begin
             int32_to_fp32_compensate.e = 'd29 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = int32_tmp[28:6];
        end
        32'b0001????_????????_????????_????????: begin
             int32_to_fp32_compensate.e = 'd28 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = int32_tmp[27:5];
        end
        32'b00001???_????????_????????_????????: begin
             int32_to_fp32_compensate.e = 'd27 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = int32_tmp[26:4];
        end
        32'b000001??_????????_????????_????????: begin
             int32_to_fp32_compensate.e = 'd26 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = int32_tmp[25:3];;
        end
        32'b0000001?_????????_????????_????????: begin
             int32_to_fp32_compensate.e = 'd25 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = int32_tmp[24:2];;
        end
        32'b00000001_????????_????????_????????: begin
             int32_to_fp32_compensate.e = 'd24 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = int32_tmp[23:1];;
        end
        32'b00000000_1???????_????????_????????: begin
             int32_to_fp32_compensate.e = 'd23 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = int32_tmp[22:0];;
        end
        32'b00000000_01??????_????????_????????: begin
             int32_to_fp32_compensate.e = 'd22 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {1'b0,int32_tmp[21:0]};
        end
        32'b00000000_001?????_????????_????????: begin
             int32_to_fp32_compensate.e = 'd21 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {2'b0,int32_tmp[20:0]};
        end
        32'b00000000_0001????_????????_????????: begin
             int32_to_fp32_compensate.e = 'd20 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {3'b0,int32_tmp[19:0]};
        end
        32'b00000000_00001???_????????_????????: begin
             int32_to_fp32_compensate.e = 'd19 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {4'b0,int32_tmp[18:0]};
        end
        32'b00000000_000001??_????????_????????: begin
             int32_to_fp32_compensate.e = 'd18 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {5'b0,int32_tmp[17:0]};
        end
        32'b00000000_0000001?_????????_????????: begin
             int32_to_fp32_compensate.e = 'd17 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {6'b0,int32_tmp[16:0]};
        end
        32'b00000000_00000001_????????_????????: begin
             int32_to_fp32_compensate.e = 'd16 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {7'b0,int32_tmp[15:0]};
        end
        32'b00000000_00000000_1???????_????????: begin
             int32_to_fp32_compensate.e = 'd15 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {8'b0,int32_tmp[14:0]};
        end
        32'b00000000_00000000_01??????_????????: begin
             int32_to_fp32_compensate.e = 'd14 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {9'b0,int32_tmp[13:0]};
        end
        32'b00000000_00000000_001?????_????????: begin
             int32_to_fp32_compensate.e = 'd13 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {10'b0,int32_tmp[12:0]};
        end
        32'b00000000_00000000_0001????_????????: begin
             int32_to_fp32_compensate.e = 'd12 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {11'b0,int32_tmp[11:0]};
        end
        32'b00000000_00000000_00001???_????????: begin
             int32_to_fp32_compensate.e = 'd11 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {12'b0,int32_tmp[10:0]};
        end
        32'b00000000_00000000_000001??_????????: begin
             int32_to_fp32_compensate.e = 'd10 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {13'b0,int32_tmp[9:0]};
        end
        32'b00000000_00000000_0000001?_????????: begin
             int32_to_fp32_compensate.e = 'd9 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {14'b0,int32_tmp[8:0]};
        end
        32'b00000000_00000000_00000001_????????: begin
             int32_to_fp32_compensate.e = 'd8 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {15'b0,int32_tmp[7:0]};
        end
        32'b00000000_00000000_00000000_1???????: begin
             int32_to_fp32_compensate.e = 'd7 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {16'b0,int32_tmp[6:0]};
        end
        32'b00000000_00000000_00000000_01??????: begin
             int32_to_fp32_compensate.e = 'd6 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {17'b0,int32_tmp[5:0]};
        end
        32'b00000000_00000000_00000000_001?????: begin
             int32_to_fp32_compensate.e = 'd5 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {18'b0,int32_tmp[4:0]};
        end
        32'b00000000_00000000_00000000_0001????: begin
             int32_to_fp32_compensate.e = 'd4 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {19'b0,int32_tmp[3:0]};
        end
        32'b00000000_00000000_00000000_00001???: begin
             int32_to_fp32_compensate.e = 'd3 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {20'b0,int32_tmp[2:0]};
        end
        32'b00000000_00000000_00000000_000001??: begin
             int32_to_fp32_compensate.e = 'd2 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {21'b0,int32_tmp[1:0]};
        end
        32'b00000000_00000000_00000000_0000001?: begin
             int32_to_fp32_compensate.e = 'd1 + fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {22'b0,int32_tmp[0]};
        end
        32'b00000000_00000000_00000000_00000001: begin
             int32_to_fp32_compensate.e = fp32_exponent- 'd23;
             int32_to_fp32_compensate.m = {23'b0};
        end
        default: begin
          int32_to_fp32_compensate.e = '0;
          int32_to_fp32_compensate.m = '0;
        end
    endcase
     `ifdef TARGET_SIMULATION
          $display("[INFO: INT32_FP32_COMP]: int32: %h, int32_tmp: %h, int32_to_fp32_compensate: %h",int32, int32_tmp, int32_to_fp32_compensate);
     `endif
endfunction

function automatic ara_pkg::fp32_t int8_to_fp32_dequantize(logic [31:0] int32,logic [7:0] scaling_factor);
    automatic logic [47:0] int32_deq;
    automatic logic [30:0] int32_tmp;
    automatic logic [23:0] full_m_scaling_factor_recpi;
    automatic ara_pkg::fp32_t scaling_factor_recpi;

     // compute by look up table
    case (scaling_factor) 
          8'd1: scaling_factor_recpi =       32'h3f800000;
          8'd2: scaling_factor_recpi =       32'h3f000000;
          8'd3: scaling_factor_recpi =       32'h3eaaaaab;
          8'd4: scaling_factor_recpi =       32'h3e800000;
          8'd5: scaling_factor_recpi =       32'h3e4ccccd;
          8'd6: scaling_factor_recpi =       32'h3e2aaaab;
          8'd7: scaling_factor_recpi =       32'h3e124925;
          8'd8: scaling_factor_recpi =       32'h3e000000;
          8'd9: scaling_factor_recpi =       32'h3de38e39;
          8'd10: scaling_factor_recpi =      32'h3dcccccd;
          8'd11: scaling_factor_recpi =      32'h3dba2e8c;
          8'd12: scaling_factor_recpi =      32'h3daaaaab;
          8'd13: scaling_factor_recpi =      32'h3d9d89d9;
          8'd14: scaling_factor_recpi =      32'h3d924925;
          8'd15: scaling_factor_recpi =      32'h3d888889;
          8'd16: scaling_factor_recpi =      32'h3d800000;
          8'd17: scaling_factor_recpi =      32'h3d70f0f1;
          8'd18: scaling_factor_recpi =      32'h3d638e39;
          8'd19: scaling_factor_recpi =      32'h3d579436;
          8'd20: scaling_factor_recpi =      32'h3d4ccccd;
          8'd21: scaling_factor_recpi =      32'h3d430c31;
          8'd22: scaling_factor_recpi =      32'h3d3a2e8c;
          8'd23: scaling_factor_recpi =      32'h3d321643;
          8'd24: scaling_factor_recpi =      32'h3d2aaaab;
          8'd25: scaling_factor_recpi =      32'h3d23d70a;
          8'd26: scaling_factor_recpi =      32'h3d1d89d9;
          8'd27: scaling_factor_recpi =      32'h3d17b426;
          8'd28: scaling_factor_recpi =      32'h3d124925;
          8'd29: scaling_factor_recpi =      32'h3d0d3dcb;
          8'd30: scaling_factor_recpi =      32'h3d088889;
          8'd31: scaling_factor_recpi =      32'h3d042108;
          8'd32: scaling_factor_recpi =      32'h3d000000;
          8'd33: scaling_factor_recpi =      32'h3cf83e10;
          8'd34: scaling_factor_recpi =      32'h3cf0f0f1;
          8'd35: scaling_factor_recpi =      32'h3cea0ea1;
          8'd36: scaling_factor_recpi =      32'h3ce38e39;
          8'd37: scaling_factor_recpi =      32'h3cdd67c9;
          8'd38: scaling_factor_recpi =      32'h3cd79436;
          8'd39: scaling_factor_recpi =      32'h3cd20d21;
          8'd40: scaling_factor_recpi =      32'h3ccccccd;
          8'd41: scaling_factor_recpi =      32'h3cc7ce0c;
          8'd42: scaling_factor_recpi =      32'h3cc30c31;
          8'd43: scaling_factor_recpi =      32'h3cbe82fa;
          8'd44: scaling_factor_recpi =      32'h3cba2e8c;
          8'd45: scaling_factor_recpi =      32'h3cb60b61;
          8'd46: scaling_factor_recpi =      32'h3cb21643;
          8'd47: scaling_factor_recpi =      32'h3cae4c41;
          8'd48: scaling_factor_recpi =      32'h3caaaaab;
          8'd49: scaling_factor_recpi =      32'h3ca72f05;
          8'd50: scaling_factor_recpi =      32'h3ca3d70a;
          8'd51: scaling_factor_recpi =      32'h3ca0a0a1;
          8'd52: scaling_factor_recpi =      32'h3c9d89d9;
          8'd53: scaling_factor_recpi =      32'h3c9a90e8;
          8'd54: scaling_factor_recpi =      32'h3c97b426;
          8'd55: scaling_factor_recpi =      32'h3c94f209;
          8'd56: scaling_factor_recpi =      32'h3c924925;
          8'd57: scaling_factor_recpi =      32'h3c8fb824;
          8'd58: scaling_factor_recpi =      32'h3c8d3dcb;
          8'd59: scaling_factor_recpi =      32'h3c8ad8f3;
          8'd60: scaling_factor_recpi =      32'h3c888889;
          8'd61: scaling_factor_recpi =      32'h3c864b8a;
          8'd62: scaling_factor_recpi =      32'h3c842108;
          8'd63: scaling_factor_recpi =      32'h3c820821;
          8'd64: scaling_factor_recpi =      32'h3c800000;
          8'd65: scaling_factor_recpi =      32'h3c7c0fc1;
          8'd66: scaling_factor_recpi =      32'h3c783e10;
          8'd67: scaling_factor_recpi =      32'h3c74898d;
          8'd68: scaling_factor_recpi =      32'h3c70f0f1;
          8'd69: scaling_factor_recpi =      32'h3c6d7304;
          8'd70: scaling_factor_recpi =      32'h3c6a0ea1;
          8'd71: scaling_factor_recpi =      32'h3c66c2b4;
          8'd72: scaling_factor_recpi =      32'h3c638e39;
          8'd73: scaling_factor_recpi =      32'h3c607038;
          8'd74: scaling_factor_recpi =      32'h3c5d67c9;
          8'd75: scaling_factor_recpi =      32'h3c5a740e;
          8'd76: scaling_factor_recpi =      32'h3c579436;
          8'd77: scaling_factor_recpi =      32'h3c54c77b;
          8'd78: scaling_factor_recpi =      32'h3c520d21;
          8'd79: scaling_factor_recpi =      32'h3c4f6475;
          8'd80: scaling_factor_recpi =      32'h3c4ccccd;
          8'd81: scaling_factor_recpi =      32'h3c4a4588;
          8'd82: scaling_factor_recpi =      32'h3c47ce0c;
          8'd83: scaling_factor_recpi =      32'h3c4565c8;
          8'd84: scaling_factor_recpi =      32'h3c430c31;
          8'd85: scaling_factor_recpi =      32'h3c40c0c1;
          8'd86: scaling_factor_recpi =      32'h3c3e82fa;
          8'd87: scaling_factor_recpi =      32'h3c3c5264;
          8'd88: scaling_factor_recpi =      32'h3c3a2e8c;
          8'd89: scaling_factor_recpi =      32'h3c381703;
          8'd90: scaling_factor_recpi =      32'h3c360b61;
          8'd91: scaling_factor_recpi =      32'h3c340b41;
          8'd92: scaling_factor_recpi =      32'h3c321643;
          8'd93: scaling_factor_recpi =      32'h3c302c0b;
          8'd94: scaling_factor_recpi =      32'h3c2e4c41;
          8'd95: scaling_factor_recpi =      32'h3c2c7692;
          8'd96: scaling_factor_recpi =      32'h3c2aaaab;
          8'd97: scaling_factor_recpi =      32'h3c28e83f;
          8'd98: scaling_factor_recpi =      32'h3c272f05;
          8'd99: scaling_factor_recpi =      32'h3c257eb5;
          8'd100: scaling_factor_recpi =     32'h3c23d70a;
          8'd101: scaling_factor_recpi =     32'h3c2237c3;
          8'd102: scaling_factor_recpi =     32'h3c20a0a1;
          8'd103: scaling_factor_recpi =     32'h3c1f1166;
          8'd104: scaling_factor_recpi =     32'h3c1d89d9;
          8'd105: scaling_factor_recpi =     32'h3c1c09c1;
          8'd106: scaling_factor_recpi =     32'h3c1a90e8;
          8'd107: scaling_factor_recpi =     32'h3c191f1a;
          8'd108: scaling_factor_recpi =     32'h3c17b426;
          8'd109: scaling_factor_recpi =     32'h3c164fda;
          8'd110: scaling_factor_recpi =     32'h3c14f209;
          8'd111: scaling_factor_recpi =     32'h3c139a86;
          8'd112: scaling_factor_recpi =     32'h3c124925;
          8'd113: scaling_factor_recpi =     32'h3c10fdbc;
          8'd114: scaling_factor_recpi =     32'h3c0fb824;
          8'd115: scaling_factor_recpi =     32'h3c0e7835;
          8'd116: scaling_factor_recpi =     32'h3c0d3dcb;
          8'd117: scaling_factor_recpi =     32'h3c0c08c1;
          8'd118: scaling_factor_recpi =     32'h3c0ad8f3;
          8'd119: scaling_factor_recpi =     32'h3c09ae41;
          8'd120: scaling_factor_recpi =     32'h3c088889;
          8'd121: scaling_factor_recpi =     32'h3c0767ab;
          8'd122: scaling_factor_recpi =     32'h3c064b8a;
          8'd123: scaling_factor_recpi =     32'h3c053408;
          8'd124: scaling_factor_recpi =     32'h3c042108;
          8'd125: scaling_factor_recpi =     32'h3c03126f;
          8'd126: scaling_factor_recpi =     32'h3c020821;
          8'd127: scaling_factor_recpi =     32'h3c010204 ;
          default: scaling_factor_recpi =     32'h0;
    endcase

     // use original code when negative number
    int32_tmp[30:0]  = int32[31] ? { ~int32[30:0]} + 'b1 : int32[30:0];   

     //  TODO: Is No-dequantize OK? because if int32_tmp < scaling_factor, int32_deq will be zero
     // 20250304: replace  multiple + divide when using the reciprocal
    full_m_scaling_factor_recpi = {1'b1, scaling_factor_recpi.m};
    int32_deq[47:0]  = int32_tmp[30:0] * full_m_scaling_factor_recpi; 

     int8_to_fp32_dequantize.s = int32[31];

     unique casex ({int32[31], int32_deq[47:0]})
        49'b1_1???????_????????_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd47 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[46:24];
        end
        49'b1_01??????_????????_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd46 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[45:23];
        end
        49'b1_001?????_????????_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd45 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[44:22];
        end
        49'b1_0001????_????????_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd44 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[43:21];
        end
        49'b1_00001???_????????_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd43 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[42:20];
        end
        49'b1_000001??_????????_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd42 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[41:19];
        end        
        49'b1_0000001?_????????_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd41 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[40:18];
        end        
        49'b1_00000001_????????_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd40 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[39:17];
        end
        49'b1_00000000_1???????_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd39 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[38:16];
        end
        49'b1_00000000_01??????_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd38 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[37:15];
        end
        49'b1_00000000_001?????_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd37 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[36:14];
        end
        49'b1_00000000_0001????_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd36 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[35:13];
        end        
        49'b1_00000000_00001???_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd35 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[34:12];
        end
        49'b1_00000000_000001??_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd34 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[33:11];
        end
        49'b1_00000000_0000001?_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd33 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[32:10];
        end
        49'b1_00000000_00000001_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd32 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[31:9];
        end
        49'b1_00000000_00000000_1???????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd31 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[30:8];
        end
        49'b1_00000000_00000000_01??????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd30 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[29:7];
        end
        49'b1_00000000_00000000_001?????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd29 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[28:6];
        end
        49'b1_00000000_00000000_0001????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd28 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[27:5];
        end
        49'b1_00000000_00000000_00001???_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd27 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[26:4];
        end
        49'b1_00000000_00000000_000001??_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd26 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[25:3];;
        end
        49'b1_00000000_00000000_0000001?_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd25 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[24:2];;
        end
        49'b1_00000000_00000000_00000001_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd24 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[23:1];;
        end
        49'b1_00000000_00000000_00000000_1???????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd23 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[22:0];;
        end
        49'b1_00000000_00000000_00000000_01??????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd22 - 'd23;
             int8_to_fp32_dequantize.m = {1'b0,int32_deq[21:0]};
        end
        49'b1_00000000_00000000_00000000_001?????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd21 - 'd23;
             int8_to_fp32_dequantize.m = {2'b0,int32_deq[20:0]};
        end
        49'b1_00000000_00000000_00000000_0001????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd20 - 'd23;
             int8_to_fp32_dequantize.m = {3'b0,int32_deq[19:0]};
        end
        49'b1_00000000_00000000_00000000_00001???_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd19 - 'd23;
             int8_to_fp32_dequantize.m = {4'b0,int32_deq[18:0]};
        end
        49'b1_00000000_00000000_00000000_000001??_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd18 - 'd23;
             int8_to_fp32_dequantize.m = {5'b0,int32_deq[17:0]};
        end
        49'b1_00000000_00000000_00000000_0000001?_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd17 - 'd23;
             int8_to_fp32_dequantize.m = {6'b0,int32_deq[16:0]};
        end
        49'b1_00000000_00000000_00000000_00000001_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd16 - 'd23;
             int8_to_fp32_dequantize.m = {7'b0,int32_deq[15:0]};
        end
        49'b1_00000000_00000000_00000000_00000000_1???????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd15 - 'd23;
             int8_to_fp32_dequantize.m = {8'b0,int32_deq[14:0]};
        end
        49'b1_00000000_00000000_00000000_00000000_01??????_????????: begin
            int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd14 - 'd23;
            int8_to_fp32_dequantize.m = {9'b0,int32_deq[13:0]};
        end
        49'b1_00000000_00000000_00000000_00000000_001?????_????????: begin
            int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd13 - 'd23;
            int8_to_fp32_dequantize.m = {10'b0,int32_deq[12:0]};
        end
        49'b1_00000000_00000000_00000000_00000000_0001????_????????: begin
            int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd12 - 'd23;
            int8_to_fp32_dequantize.m = {11'b0,int32_deq[11:0]};
        end
        49'b1_00000000_00000000_00000000_00000000_00001???_????????: begin
            int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd11 - 'd23;
            int8_to_fp32_dequantize.m = {12'b0,int32_deq[10:0]};
        end
        49'b1_00000000_00000000_00000000_00000000_000001??_????????: begin
            int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd10 - 'd23;
            int8_to_fp32_dequantize.m = {13'b0,int32_deq[9:0]};
        end
        49'b1_00000000_00000000_00000000_00000000_0000001?_????????: begin
            int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd9 - 'd23;
            int8_to_fp32_dequantize.m = {14'b0,int32_deq[8:0]};
        end
        49'b1_00000000_00000000_00000000_00000000_00000001_????????: begin
            int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd8 - 'd23;
            int8_to_fp32_dequantize.m = {15'b0,int32_deq[7:0]};
        end
        49'b1_00000000_00000000_00000000_00000000_00000000_1???????: begin
            int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd7 - 'd23;
            int8_to_fp32_dequantize.m = {16'b0,int32_deq[6:0]};
        end
        49'b1_00000000_00000000_00000000_00000000_00000000_01??????: begin
            int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd6 - 'd23;
            int8_to_fp32_dequantize.m = {17'b0,int32_deq[5:0]};
        end
        49'b1_00000000_00000000_00000000_00000000_00000000_001?????: begin
            int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd5 - 'd23;
            int8_to_fp32_dequantize.m = {18'b0,int32_deq[4:0]};
        end
        49'b1_00000000_00000000_00000000_00000000_00000000_0001????: begin
            int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd4 - 'd23;
            int8_to_fp32_dequantize.m = {19'b0,int32_deq[3:0]};
        end
        49'b1_00000000_00000000_00000000_00000000_00000000_00001???: begin
            int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd3 - 'd23;
            int8_to_fp32_dequantize.m = {20'b0,int32_deq[2:0]};
        end
        49'b1_00000000_00000000_00000000_00000000_00000000_000001??: begin
            int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd2 - 'd23;
            int8_to_fp32_dequantize.m = {21'b0,int32_deq[1:0]};
        end
        49'b1_00000000_00000000_00000000_00000000_00000000_0000001?: begin
            int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd1 - 'd23;
            int8_to_fp32_dequantize.m = {22'b0,int32_deq[0]};
        end
        49'b1_00000000_00000000_00000000_00000000_00000000_00000001: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e  - 'd23;
             int8_to_fp32_dequantize.m = {23'b0};
        end
        49'b0_1???????_????????_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd47 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[46:24];
        end
        49'b0_01??????_????????_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd46 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[45:23];
        end
        49'b0_001?????_????????_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd45 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[44:22];
        end
        49'b0_0001????_????????_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd44 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[43:21];
        end
        49'b0_00001???_????????_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd43 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[42:20];
        end
        49'b0_000001??_????????_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd42 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[41:19];
        end        
        49'b0_0000001?_????????_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd41 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[40:18];
        end        
        49'b0_00000001_????????_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd40 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[39:17];
        end
        49'b0_00000000_1???????_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd39 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[38:16];
        end
        49'b0_00000000_01??????_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd38 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[37:15];
        end
        49'b0_00000000_001?????_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd37 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[36:14];
        end
        49'b0_00000000_0001????_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd36 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[35:13];
        end        
        49'b0_00000000_00001???_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd35 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[34:12];
        end
        49'b0_00000000_000001??_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd34 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[33:11];
        end
        49'b0_00000000_0000001?_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd33 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[32:10];
        end
        49'b0_00000000_00000001_????????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd32 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[31:9];
        end
        49'b0_00000000_00000000_1???????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd31 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[30:8];
        end
        49'b0_00000000_00000000_01??????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd30 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[29:7];
        end
        49'b0_00000000_00000000_001?????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd29 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[28:6];
        end
        49'b0_00000000_00000000_0001????_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd28 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[27:5];
        end
        49'b0_00000000_00000000_00001???_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd27 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[26:4];
        end
        49'b0_00000000_00000000_000001??_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd26 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[25:3];;
        end
        49'b0_00000000_00000000_0000001?_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd25 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[24:2];;
        end
        49'b0_00000000_00000000_00000001_????????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd24 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[23:1];;
        end
        49'b0_00000000_00000000_00000000_1???????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd23 - 'd23;
             int8_to_fp32_dequantize.m = int32_deq[22:0];;
        end
        49'b0_00000000_00000000_00000000_01??????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd22 - 'd23;
             int8_to_fp32_dequantize.m = {1'b0,int32_deq[21:0]};
        end
        49'b0_00000000_00000000_00000000_001?????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd21 - 'd23;
             int8_to_fp32_dequantize.m = {2'b0,int32_deq[20:0]};
        end
        49'b0_00000000_00000000_00000000_0001????_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd20 - 'd23;
             int8_to_fp32_dequantize.m = {3'b0,int32_deq[19:0]};
        end
        49'b0_00000000_00000000_00000000_00001???_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd19 - 'd23;
             int8_to_fp32_dequantize.m = {4'b0,int32_deq[18:0]};
        end
        49'b0_00000000_00000000_00000000_000001??_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd18 - 'd23;
             int8_to_fp32_dequantize.m = {5'b0,int32_deq[17:0]};
        end
        49'b0_00000000_00000000_00000000_0000001?_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd17 - 'd23;
             int8_to_fp32_dequantize.m = {6'b0,int32_deq[16:0]};
        end
        49'b0_00000000_00000000_00000000_00000001_????????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd16 - 'd23;
             int8_to_fp32_dequantize.m = {7'b0,int32_deq[15:0]};
        end
        49'b0_00000000_00000000_00000000_00000000_1???????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd15 - 'd23;
             int8_to_fp32_dequantize.m = {8'b0,int32_deq[14:0]};
        end
        49'b0_00000000_00000000_00000000_00000000_01??????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd14 - 'd23;
             int8_to_fp32_dequantize.m = {9'b0,int32_deq[13:0]};
        end
        49'b0_00000000_00000000_00000000_00000000_001?????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd13 - 'd23;
             int8_to_fp32_dequantize.m = {10'b0,int32_deq[12:0]};
        end
        49'b0_00000000_00000000_00000000_00000000_0001????_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd12 - 'd23;
             int8_to_fp32_dequantize.m = {11'b0,int32_deq[11:0]};
        end
        49'b0_00000000_00000000_00000000_00000000_00001???_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd11 - 'd23;
             int8_to_fp32_dequantize.m = {12'b0,int32_deq[10:0]};
        end
        49'b0_00000000_00000000_00000000_00000000_000001??_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd10 - 'd23;
             int8_to_fp32_dequantize.m = {13'b0,int32_deq[9:0]};
        end
        49'b0_00000000_00000000_00000000_00000000_0000001?_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd9 - 'd23;
             int8_to_fp32_dequantize.m = {14'b0,int32_deq[8:0]};
        end
        49'b0_00000000_00000000_00000000_00000000_00000001_????????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd8 - 'd23;
             int8_to_fp32_dequantize.m = {15'b0,int32_deq[7:0]};
        end
        49'b0_00000000_00000000_00000000_00000000_00000000_1???????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd7 - 'd23;
             int8_to_fp32_dequantize.m = {16'b0,int32_deq[6:0]};
        end
        49'b0_00000000_00000000_00000000_00000000_00000000_01??????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd6 - 'd23;
             int8_to_fp32_dequantize.m = {17'b0,int32_deq[5:0]};
        end
        49'b0_00000000_00000000_00000000_00000000_00000000_001?????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd5 - 'd23;
             int8_to_fp32_dequantize.m = {18'b0,int32_deq[4:0]};
        end
        49'b0_00000000_00000000_00000000_00000000_00000000_0001????: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd4 - 'd23;
             int8_to_fp32_dequantize.m = {19'b0,int32_deq[3:0]};
        end
        49'b0_00000000_00000000_00000000_00000000_00000000_00001???: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd3 - 'd23;
             int8_to_fp32_dequantize.m = {20'b0,int32_deq[2:0]};
        end
        49'b0_00000000_00000000_00000000_00000000_00000000_000001??: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd2 - 'd23;
             int8_to_fp32_dequantize.m = {21'b0,int32_deq[1:0]};
        end
        49'b0_00000000_00000000_00000000_00000000_00000000_0000001?: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e + 'd1 - 'd23;
             int8_to_fp32_dequantize.m = {22'b0,int32_deq[0]};
        end
        49'b0_00000000_00000000_00000000_00000000_00000000_00000001: begin
             int8_to_fp32_dequantize.e = scaling_factor_recpi.e - 'd23;
             int8_to_fp32_dequantize.m = {23'b0};
        end
        default: begin
          int8_to_fp32_dequantize.e = '0;
          int8_to_fp32_dequantize.m = '0;
        end

    endcase

     `ifdef TARGET_SIMULATION
          $display("[INFO: FP32_INT8_DQ]: int32: %h, int32_deq: %h, int8_to_fp32_dequantize: %h",int32, int32_deq, int8_to_fp32_dequantize); 
          $display("scaling_factor_recpi: %h, full_m_scaling_factor_recpi: %h",scaling_factor_recpi, full_m_scaling_factor_recpi); 
     `endif

endfunction

endpackage: ifmix_pkg