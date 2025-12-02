onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group CVA6 -subitemconfig {{/ara_tb/dut/i_ara_soc/i_system/i_ariane/issue_stage_i/decoded_instr_i[0]} -expand} /ara_tb/dut/i_ara_soc/i_system/i_ariane/issue_stage_i/decoded_instr_i
add wave -noupdate -expand -group CVA6 {/ara_tb/dut/i_ara_soc/i_system/i_ariane/issue_stage_i/decoded_instr_i[0].pc}
add wave -noupdate -expand -group CVA6 /ara_tb/dut/i_ara_soc/i_system/i_ariane/issue_stage_i/issue_instr_o
add wave -noupdate -expand -group CVA6 -expand -subitemconfig {{/ara_tb/dut/i_ara_soc/i_system/i_ariane/fu_data_id_ex[0]} -expand} /ara_tb/dut/i_ara_soc/i_system/i_ariane/fu_data_id_ex
add wave -noupdate -expand -group CVA6 /ara_tb/dut/i_ara_soc/i_system/i_ariane/gen_accelerator/i_acc_dispatcher/acc_insn_queue_o
add wave -noupdate -expand -group CVA6 -color Magenta /ara_tb/dut/i_ara_soc/i_system/i_ariane/ex_stage_i/pc_i
add wave -noupdate -expand -group CVA6 /ara_tb/dut/i_ara_soc/i_system/i_ariane/ex_stage_i/fpu_gen/fpu_i/fpu_valid_i
add wave -noupdate -expand -group CVA6 /ara_tb/dut/i_ara_soc/i_system/i_ariane/ex_stage_i/fpu_gen/fpu_i/fu_data_i
add wave -noupdate -expand -group CVA6 /ara_tb/dut/i_ara_soc/i_system/i_ariane/ex_stage_i/fpu_gen/fpu_i/fpu_valid_o
add wave -noupdate -expand -group CVA6 /ara_tb/dut/i_ara_soc/i_system/i_ariane/ex_stage_i/fpu_gen/fpu_i/result_o
add wave -noupdate -expand -group CVA6 /ara_tb/dut/i_ara_soc/i_system/i_ariane/ex_stage_i/fpu_gen/fpu_i/fpu_exception_o
add wave -noupdate -expand -group CVA6 /ara_tb/dut/i_ara_soc/i_system/i_ariane/issue_stage_i/i_scoreboard/mem_n
add wave -noupdate -expand -group CVA6 /ara_tb/dut/i_ara_soc/i_system/i_ariane/issue_stage_i/i_scoreboard/wt_valid_i
add wave -noupdate -expand -group CVA6 /ara_tb/dut/i_ara_soc/i_system/i_ariane/issue_stage_i/i_scoreboard/wbdata_i
add wave -noupdate -expand -group CVA6 /ara_tb/dut/i_ara_soc/i_system/axi_req_o
add wave -noupdate -expand -group CVA6 /ara_tb/dut/i_ara_soc/i_system/axi_resp_i
add wave -noupdate -expand -group CVA6 /ara_tb/dut/i_ara_soc/uart_paddr_o
add wave -noupdate -expand -group CVA6 /ara_tb/dut/i_ara_soc/uart_penable_o
add wave -noupdate -expand -group CVA6 -radix ascii -childformat {{{/ara_tb/dut/i_ara_soc/uart_pwdata_o[31]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[30]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[29]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[28]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[27]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[26]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[25]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[24]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[23]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[22]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[21]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[20]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[19]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[18]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[17]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[16]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[15]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[14]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[13]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[12]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[11]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[10]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[9]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[8]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[7]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[6]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[5]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[4]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[3]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[2]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[1]} -radix ascii} {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[0]} -radix ascii}} -subitemconfig {{/ara_tb/dut/i_ara_soc/uart_pwdata_o[31]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[30]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[29]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[28]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[27]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[26]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[25]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[24]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[23]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[22]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[21]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[20]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[19]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[18]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[17]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[16]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[15]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[14]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[13]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[12]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[11]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[10]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[9]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[8]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[7]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[6]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[5]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[4]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[3]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[2]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[1]} {-height 17 -radix ascii} {/ara_tb/dut/i_ara_soc/uart_pwdata_o[0]} {-height 17 -radix ascii}} /ara_tb/dut/i_ara_soc/uart_pwdata_o
add wave -noupdate /ara_tb/dut/i_ara_soc/l2_addr
add wave -noupdate /ara_tb/dut/i_ara_soc/l2_wdata
add wave -noupdate /ara_tb/dut/i_ara_soc/l2_rdata
add wave -noupdate /ara_tb/dut/i_ara_soc/i_dram/addr_i
add wave -noupdate /ara_tb/dut/i_ara_soc/i_dram/rdata_o
add wave -noupdate -expand -group ARA -expand /ara_tb/dut/i_ara_soc/i_system/i_ara/i_dispatcher/acc_req_i
add wave -noupdate -expand -group ARA /ara_tb/dut/i_ara_soc/i_system/i_ara/i_dispatcher/reshuffle_req_q
add wave -noupdate -expand -group ARA /ara_tb/dut/i_ara_soc/i_system/i_ara/i_dispatcher/reshuffle_req_d
add wave -noupdate -expand -group ARA {/ara_tb/dut/i_ara_soc/i_system/i_ara/i_dispatcher/eew_d[16]}
add wave -noupdate -expand -group ARA {/ara_tb/dut/i_ara_soc/i_system/i_ara/i_dispatcher/eew_d[24]}
add wave -noupdate -expand -group ARA {/ara_tb/dut/i_ara_soc/i_system/i_ara/i_dispatcher/eew_q[0]}
add wave -noupdate -expand -group ARA {/ara_tb/dut/i_ara_soc/i_system/i_ara/i_dispatcher/eew_q[16]}
add wave -noupdate -expand -group ARA {/ara_tb/dut/i_ara_soc/i_system/i_ara/i_dispatcher/eew_q[24]}
add wave -noupdate -expand -group ARA /ara_tb/dut/i_ara_soc/i_system/i_ara/i_dispatcher/in_lane_op
add wave -noupdate -expand -group ARA /ara_tb/dut/i_ara_soc/i_system/i_ara/i_dispatcher/state_d
add wave -noupdate -expand -group ARA /ara_tb/dut/i_ara_soc/i_system/i_ara/i_dispatcher/state_q
add wave -noupdate -expand -group ARA /ara_tb/dut/i_ara_soc/i_system/i_ara/i_dispatcher/ara_req_valid
add wave -noupdate -expand -group ARA /ara_tb/dut/i_ara_soc/i_system/i_ara/i_dispatcher/ara_req
add wave -noupdate -expand -group ARA /ara_tb/dut/i_ara_soc/i_system/i_ara/i_dispatcher/ara_req_valid_o
add wave -noupdate -expand -group ARA /ara_tb/dut/i_ara_soc/i_system/i_ara/i_dispatcher/ara_req_o
add wave -noupdate -expand -group ARA /ara_tb/dut/i_ara_soc/i_system/i_ara/i_sequencer/ara_req_valid_i
add wave -noupdate -expand -group ARA /ara_tb/dut/i_ara_soc/i_system/i_ara/i_sequencer/ara_req_i
add wave -noupdate -expand -group ARA /ara_tb/dut/i_ara_soc/i_system/i_ara/i_sequencer/state_q
add wave -noupdate -expand -group ARA /ara_tb/dut/i_ara_soc/i_system/i_ara/i_sequencer/pe_req_valid_o
add wave -noupdate -expand -group ARA /ara_tb/dut/i_ara_soc/i_system/i_ara/i_sequencer/pe_req_o
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_lane_sequencer/pe_req}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_lane_sequencer/operand_request}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_lane_sequencer/operand_request_d}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_lane_sequencer/operand_request_valid_d}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_lane_sequencer/operand_request_o}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_lane_sequencer/operand_request_valid_o}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/mfpu_vinsn_done}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/mfpu_vinsn_done_o}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_lane_sequencer/pe_req_i}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_lane_sequencer/pe_req_valid_i}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_lane_sequencer/operand_request_valid_o}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_lane_sequencer/operand_request_o}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_lane_sequencer/vfu_operation_o}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_lane_sequencer/operand_request}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/ldu_result_wdata_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/operand_queue_ready_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/clk_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/operand_request_valid_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/operand_request_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/operand_request_ready_o}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/alu_result_id_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/ldu_result_id}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/mfpu_result_id_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/ext_operand_req}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/sldu_result_gnt}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/masku_result_gnt}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/ldu_result_gnt}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/mfpu_result_gnt_o}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/alu_result_wdata_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/alu_result_req_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/alu_result_gnt_o}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/vinsn_result_written_d}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/vinsn_result_written_q}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/vrf_vifmm_en}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group MFPU_A {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[2]/state_d}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group MFPU_A {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[2]/state_q}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group MFPU_A {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[2]/operand_requester_gnt}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group MFPU_A {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[2]/requester_metadata_d}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group MFPU_A {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[2]/requester_metadata_q}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group MFPU_A {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[2]/stall}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group MFPU_A {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[2]/requester_metadata_q.hazard}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group MFPU_A {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[2]/requester_metadata_q.waw_hazard_counter}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group MFPU_B {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[3]/state_d}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group MFPU_B {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[3]/state_q}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group MFPU_B {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[3]/operand_requester_gnt}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group MFPU_B {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[3]/requester_metadata_d}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group MFPU_B {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[3]/requester_metadata_q}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group MFPU_B {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[3]/stall}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group MFPU_C {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[4]/state_d}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group MFPU_C {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[4]/state_q}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group MFPU_C {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[4]/operand_requester_gnt}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group MFPU_C {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[4]/requester_metadata_d}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group MFPU_C -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[4]/requester_metadata_q}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group MFPU_C {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[4]/stall}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group STALL {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[0]/stall}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group STALL {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[1]/stall}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group STALL {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[5]/stall}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group STALL {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[6]/stall}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group STALL {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[7]/stall}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group STALL {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[8]/stall}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/mfpu_result_req_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/mfpu_result_wdata_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/mfpu_result_addr_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/ldu_result_req_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/operand_gnt}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/operand_payload[10]}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/lane_operand_req_transposed}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/lane_operand_req}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/ext_operand_req}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/operand_payload[4]}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/operand_payload[3]}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/operand_payload[2]}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[7]/payload_hp_req}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[7]/payload_hp}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[6]/payload_hp_req}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[6]/payload_hp}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[5]/i_hp_vrf_arbiter/req_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[5]/payload_hp_req}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[5]/payload_hp}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[4]/i_hp_vrf_arbiter/req_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[4]/payload_hp_req}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[4]/payload_hp}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER -expand -group HP_RR3 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[3]/i_hp_vrf_arbiter/req_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER -expand -group HP_RR3 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[3]/payload_hp_req}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER -expand -group HP_RR3 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[3]/i_hp_vrf_arbiter/gnt_o}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER -expand -group HP_RR3 -color Salmon {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[3]/i_hp_vrf_arbiter/gen_arbiter/rr_q}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER -expand -group HP_RR3 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[3]/payload_hp}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[2]/payload_hp_req}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[2]/payload_hp}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[1]/payload_hp_req}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[1]/payload_hp}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[0]/payload_hp_req}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[0]/payload_hp}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[0]/payload_hp_req}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[0]/i_hp_vrf_arbiter/req_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[0]/i_hp_vrf_arbiter/gnt_o}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[0]/i_hp_vrf_arbiter/req_o}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[0]/i_hp_vrf_arbiter/gnt_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[0]/i_lp_vrf_arbiter/req_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[0]/i_lp_vrf_arbiter/gnt_o}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[0]/i_lp_vrf_arbiter/req_o}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[0]/i_lp_vrf_arbiter/gnt_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[0]/i_vrf_arbiter/req_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[0]/i_vrf_arbiter/gnt_o}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[0]/i_vrf_arbiter/req_o}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[0]/i_vrf_arbiter/gnt_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[0]/i_hp_vrf_arbiter/req_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/vrf_addr_o}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/vrf_be_o}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/vrf_req_o}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/vrf_wen_o}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/vrf_wdata_o}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/vrf_tgt_opqueue_o}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/operand_queue_cmd_valid_o}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/operand_queue_cmd_o}
add wave -noupdate -expand -group LANE0 -expand -group VRF -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vrf/addr_i}
add wave -noupdate -expand -group LANE0 -expand -group VRF -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vrf/tgt_opqueue_i}
add wave -noupdate -expand -group LANE0 -expand -group VRF -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vrf/req_i}
add wave -noupdate -expand -group LANE0 -expand -group VRF -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vrf/wen_i}
add wave -noupdate -expand -group LANE0 -expand -group VRF {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vrf/wdata_i}
add wave -noupdate -expand -group LANE0 -expand -group VRF {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vrf/rdata_valid_q}
add wave -noupdate -expand -group LANE0 -expand -group VRF {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vrf/rdata}
add wave -noupdate -expand -group LANE0 -expand -group VRF {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vrf/vrf_wdata}
add wave -noupdate -expand -group LANE0 -expand -group VRF -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vrf/tgt_opqueue_q}
add wave -noupdate -expand -group LANE0 -expand -group VRF {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vrf/operand_valid_o}
add wave -noupdate -expand -group LANE0 -expand -group VRF {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vrf/operand_o}
add wave -noupdate -expand -group LANE0 -expand -group VRF {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vrf/vifmm_en_i}
add wave -noupdate -expand -group LANE0 -expand -group VRF {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vrf/vifmm_en_q}
add wave -noupdate -expand -group LANE0 -expand -group VRF {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vrf/gen_banks[1]/data_sram/req_i}
add wave -noupdate -expand -group LANE0 -expand -group VRF {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vrf/gen_banks[1]/data_sram/rdata_o}
add wave -noupdate -expand -group LANE0 -expand -group VRF {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vrf/operand_a_vifmm_o}
add wave -noupdate -expand -group LANE0 -expand -group VRF {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vrf/operand_c_vifmm_o}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/operand_valid_i}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/operand_i}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/clk_i}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/operand_queue_cmd_i}
add wave -noupdate -expand -group LANE0 -expand -group Quantize_Control {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/conv_dead_i}
add wave -noupdate -expand -group LANE0 -expand -group Quantize_Control {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/operand_a_valid_i}
add wave -noupdate -expand -group LANE0 -expand -group Quantize_Control {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/operand_a_i}
add wave -noupdate -expand -group LANE0 -expand -group Quantize_Control {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/operand_a_vifmm_i}
add wave -noupdate -expand -group LANE0 -expand -group Quantize_Control {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/operand_c_valid_i}
add wave -noupdate -expand -group LANE0 -expand -group Quantize_Control {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/operand_c_vifmm_i}
add wave -noupdate -expand -group LANE0 -expand -group Quantize_Control {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/elem_count_c_q}
add wave -noupdate -expand -group LANE0 -expand -group Quantize_Control {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/elem_count_c_d}
add wave -noupdate -expand -group LANE0 -expand -group Quantize_Control {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/elem_sum_a_i}
add wave -noupdate -expand -group LANE0 -expand -group Quantize_Control {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/elem_sum_c_i}
add wave -noupdate -expand -group LANE0 -expand -group Quantize_Control {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/elem_count_a_d}
add wave -noupdate -expand -group LANE0 -expand -group Quantize_Control {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/i_input_buffer_c/status_cnt_n}
add wave -noupdate -expand -group LANE0 -expand -group Quantize_Control {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/i_input_buffer_c/status_cnt_q}
add wave -noupdate -expand -group LANE0 -expand -group Quantize_Control {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/opa_push}
add wave -noupdate -expand -group LANE0 -expand -group Quantize_Control {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/opa_pop}
add wave -noupdate -expand -group LANE0 -expand -group Quantize_Control {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/operand_a_comp}
add wave -noupdate -expand -group LANE0 -expand -group Quantize_Control {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/operand_c_comp}
add wave -noupdate -expand -group LANE0 -expand -group Quantize_Control {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/transfer_data_d}
add wave -noupdate -expand -group LANE0 -expand -group Quantize_Control {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/trans_push}
add wave -noupdate -expand -group LANE0 -expand -group Quantize_Control {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/transfer_data_o}
add wave -noupdate -expand -group LANE0 -expand -group Quantize_Control {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/trans_pop}
add wave -noupdate -expand -group LANE0 -expand -group Quantize_Control {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/transfer_type_d}
add wave -noupdate -expand -group LANE0 -expand -group Quantize_Control {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/transfer_type_q}
add wave -noupdate -expand -group LANE0 -expand -group Quantize_Control {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/transfer_type_o}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/conv_vifmm_o}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/transfer_all_quantize_en_fifo}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/transfer_all_quantize_en}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_quantize_control/transfer_all_quantize_en_o}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_queue_cmd_valid_i}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_queue_cmd_i}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_valid_i}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_i}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_issued_i}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_ready_i}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/transfer_all_quantize_en_i}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/cmd_pop}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a -group CMD_FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/i_cmd_buffer/read_pointer_q}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a -group CMD_FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/i_cmd_buffer/read_pointer_n}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a -group CMD_FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/i_cmd_buffer/data_o}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a -group CMD_FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/i_cmd_buffer/empty_o}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a -group CMD_FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/i_cmd_buffer/mem_q}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/cmd}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_push_valid_d}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_push_valid_q}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_push_valid}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_vifmm_en_q}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_pop_valid_d}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_pop_valid_q}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/ibuf_empty_pop}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/ibuf_pop}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a -expand -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/i_input_buffer/push_i}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a -expand -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/i_input_buffer/status_cnt_q}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a -expand -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/i_input_buffer_1/push_i}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a -expand -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/i_input_buffer_1/status_cnt_q}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a -expand -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/i_input_buffer_2/push_i}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a -expand -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/i_input_buffer_2/status_cnt_q}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a -expand -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/i_input_buffer_3/push_i}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a -expand -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/i_input_buffer/pop_i}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a -expand -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/i_input_buffer_1/pop_i}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a -expand -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/i_input_buffer_2/pop_i}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a -expand -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/i_input_buffer_3/pop_i}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a -expand -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/i_input_buffer_3/status_cnt_q}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/ibuf_operand_valid}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/elem_count_d}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/elem_count_q}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_pop_valid_d}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_vifmm_pop_valid_d}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_vifmm_pop_valid_q}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_pop_valid}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/ibuf_operand_pop}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/ibuf_operand}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/conv_operand}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/conv_vifmm_o}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_valid_o}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a -color Khaki {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_o}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_vifmm_en_i}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/ibuf_usage_d}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/ibuf_usage_q}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_queue_ready_o}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_queue_cmd_valid_i}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_queue_cmd_i}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_valid_i}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_i}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_ready_i}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_issued_i}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/cmd}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/clk_i}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/elem_count_d}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/elem_count_q}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/elem_count_x8_o}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/cmd_pop}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/i_input_buffer/pop_i}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/i_input_buffer/data_o}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/ibuf_operand}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/bytenum_per_op_d}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/bytenum_per_op_q}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/conv_operand}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/transfer_all_quantize_en_i}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_valid_o}
add wave -noupdate -expand -group LANE0 -expand -group operand_queue_mfpu_b -color Khaki {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_o}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/operand_queue_cmd_valid_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/operand_queue_cmd_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/operand_ready_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/operand_issued_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/operand_valid_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/operand_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/operand_vifmm_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/operand_push_valid_d}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/operand_push_valid_q}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/operand_push_valid}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/i_input_buffer/read_pointer_n}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/i_input_buffer/write_pointer_n}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/i_input_buffer/push_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/i_input_buffer/data_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/i_input_buffer/pop_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/i_input_buffer/data_o}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/i_input_buffer/status_cnt_q}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/i_input_buffer_1/push_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/i_input_buffer_1/data_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/i_input_buffer_1/pop_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/i_input_buffer_1/data_o}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/i_input_buffer_1/status_cnt_q}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/i_input_buffer_2/status_cnt_q}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/i_input_buffer_3/push_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/i_input_buffer_3/pop_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c -group FIFO {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/i_input_buffer_3/status_cnt_q}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/ibuf_pop}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/clk_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/elem_count_d}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/elem_count_q}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/operand_pop_valid_d}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/ibuf_operand_pop}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/ibuf_operand}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/cmd}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/cmd_pop}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/conv_operand}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/conv_vifmm_o}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/operand_vifmm_en_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/ibuf_usage_d}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/ibuf_usage_q}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/operand_valid_o}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_c -color Khaki {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/operand_o}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/operand_queue_ready_o}
add wave -noupdate -expand -group LANE0 -expand -group PreU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_PreU/operand_valid_i}
add wave -noupdate -expand -group LANE0 -expand -group PreU -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_PreU/operand_a_i}
add wave -noupdate -expand -group LANE0 -expand -group PreU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_PreU/operand_c_i}
add wave -noupdate -expand -group LANE0 -expand -group PreU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_PreU/transfer_data_i}
add wave -noupdate -expand -group LANE0 -expand -group PreU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_PreU/transfer_all_quantize_en_i}
add wave -noupdate -expand -group LANE0 -expand -group PreU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_PreU/pointer_d}
add wave -noupdate -expand -group LANE0 -expand -group PreU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_PreU/pointer_q}
add wave -noupdate -expand -group LANE0 -expand -group PreU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_PreU/i_opa0_fp32_int32_compensate/exp_bigger}
add wave -noupdate -expand -group LANE0 -expand -group PreU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_PreU/i_opa1_fp32_int32_compensate/exp_bigger}
add wave -noupdate -expand -group LANE0 -expand -group PreU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_PreU/opa_int8}
add wave -noupdate -expand -group LANE0 -expand -group PreU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_PreU/operand_a_o}
add wave -noupdate -expand -group LANE0 -expand -group PreU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_PreU/operand_c_o}
add wave -noupdate -expand -group LANE0 -expand -group VFUS {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/vfu_operation_valid_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/vfu_operation_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -color Khaki -expand -subitemconfig {{/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/mfpu_operand_i[2]} {-color Khaki -height 17} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/mfpu_operand_i[1]} {-color Khaki -height 17} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/mfpu_operand_i[0]} {-color Khaki -height 17}} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/mfpu_operand_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/mfpu_operand_valid_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/transfer_all_quantize_en_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/transfer_data_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/transfer_data_ff1}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/transfer_data_ff2}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vfu_operation_valid_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vfu_operation_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/mfpu_operand_valid_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -color Khaki -expand -subitemconfig {{/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/mfpu_operand_i[2]} {-color Khaki -height 17} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/mfpu_operand_i[1]} {-color Khaki -height 17} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/mfpu_operand_i[0]} {-color Khaki -height 17}} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/mfpu_operand_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vmul_simd_op_a_q}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/operands_valid}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vmul_in_valid}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vmul_out_ready}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vmul_simd_out_ready}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group OPQ2VMFPU_IN_READY -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vmul_simd_in_ready}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group OPQ2VMFPU_IN_READY {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vmul_in_ready}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group OPQ2VMFPU_IN_READY {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/operands_ready}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group OPQ2VMFPU_IN_READY {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/mfpu_operand_ready_o}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/clk_i_gated}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_DATA_IN {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vmul_simd_in_valid}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_DATA_IN {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vmul_simd_in_valid_q}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_DATA_IN {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vmul_simd_op_a_q}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_DATA_IN {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vmul_simd_op_a_q_gated}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_DATA_IN {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vmul_simd_op_b_q}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_DATA_IN {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vmul_simd_op_b_q_gated}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_DATA_IN {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vmul_simd_op_c_q}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_DATA_IN {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vmul_simd_op_c_q_gated}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/gate_ff_en}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/gate_ff_clr}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/mfpu_state_q}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -color Gold {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vinsn_queue_d}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -color Gold {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vinsn_queue_q}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group ISSUE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vinsn_issue_q_valid}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group ISSUE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vinsn_issue_mul}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group ISSUE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/issue_cnt_d}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group ISSUE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/issue_cnt_q}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group ISSUE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/issue_sew_d}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group ISSUE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/issue_sew_q}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group ISSUE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/state_vifmm_issue_d}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group ISSUE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/state_vifmm_issue_q}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group ISSUE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vinsn_issue_d}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group ISSUE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vinsn_issue_q}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group PROCESSING {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/to_process_cnt_q}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group PROCESSING {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/to_process_cnt_d}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group PROCESSING {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/processing_sew_d}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group PROCESSING {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/processing_sew_q}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group PROCESSING {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/state_vifmm_processing_d}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group PROCESSING {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/state_vifmm_processing_q}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group PROCESSING {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vinsn_processing_d_valid}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group PROCESSING {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vinsn_processing_d}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group PROCESSING {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vinsn_processing_q}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group Latency {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/latency_problem_d}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group Latency {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/latency_problem_q}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group Latency {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vinsn_issue_lat_d}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group Latency {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vinsn_processing_lat_d}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group Latency {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/latency_stall}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vmul_out_ready}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vmul_simd_out_ready}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_8 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew8/ready_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_8 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew8/ready_o}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_8 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew8/valid_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_8 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew8/transfer_data_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_8 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew8/operand_a_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_8 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew8/operand_b_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_8 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew8/operand_c_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_8 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew8/valid_o}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_8 -group POSTU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew8/i_PostU/result_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_8 -group POSTU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew8/i_PostU/transfer_data_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_8 -group POSTU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew8/i_PostU/result_o}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_8 -group POSTU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew8/i_PostU/result1_o}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_8 -group POSTU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew8/i_PostU/result2_o}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_8 -group POSTU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew8/i_PostU/result3_o}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/transfer_data_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/transfer_data_ff1}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/transfer_data_ff2}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_32 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/ready_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_32 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/ready_o}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_32 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/valid_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_32 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/operand_a_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_32 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/operand_b_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_32 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/operand_c_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_32 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/transfer_data_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_32 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/opa}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_32 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/opb}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_32 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/opc}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_32 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/result_tmp}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_32 -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/result_vifmm_o}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_32 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/result_o}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_32 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/valid_o}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_32 -group PostU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/i_PostU/result_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_32 -group PostU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/i_PostU/valid_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_32 -group PostU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/i_PostU/transfer_data_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_32 -group PostU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/i_PostU/COMPENSATE/pointer_d}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_32 -group PostU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/i_PostU/COMPENSATE/pointer_q}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_32 -group PostU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/i_PostU/result_o}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_32 -group PostU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/i_PostU/result1_o}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_32 -group PostU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/i_PostU/result2_o}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_32 -group PostU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/i_PostU/result3_o}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/mfpu_state_q}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group FPNEW {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/fpu_gen/i_fpnew_bulk/in_valid_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group FPNEW -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/fpu_gen/i_fpnew_bulk/operands_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group FPNEW {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/fpu_gen/i_fpnew_bulk/op_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group FPNEW {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/fpu_gen/i_fpnew_bulk/out_valid_o}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group FPNEW {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/fpu_gen/i_fpnew_bulk/result_o}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group FPNEW {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vfpu_processed_result}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_16 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew16/valid_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_16 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew16/operand_a_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_16 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew16/operand_b_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -group SIMD_MUL_16 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew16/operand_c_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vmul_simd_out_valid}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vmul_result}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vmul_out_valid}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/unit_out_valid}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/result_queue_read_pnt_d}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/result_queue_read_pnt_q}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/result_queue_write_pnt_d}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/result_queue_write_pnt_q}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/result_queue_d}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/result_queue_q}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/result_queue_valid_q}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/mfpu_result_req_o}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/mfpu_result_addr_o}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/mfpu_result_wdata_vifmm_o}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -color Khaki {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/mfpu_result_wdata_o}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/mfpu_operand_ready_o}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/mfpu_result_gnt_i}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/result_queue_cnt_d}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/result_queue_cnt_q}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/result_queue_full}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group COMMIT {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vinsn_commit}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group COMMIT {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vinsn_commit_valid}
add wave -noupdate -expand -group LANE0 -expand -group VFUS -expand -group VMFPU -expand -group COMMIT {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/commit_cnt_d}
add wave -noupdate -group LANE1 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_lane_sequencer/pe_req_i}
add wave -noupdate -group LANE1 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_lane_sequencer/pe_req_valid_i}
add wave -noupdate -group LANE1 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_lane_sequencer/operand_request_valid_o}
add wave -noupdate -group LANE1 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_lane_sequencer/operand_request_o}
add wave -noupdate -group LANE1 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_lane_sequencer/vfu_operation_o}
add wave -noupdate -group LANE1 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_requester/operand_request_valid_i}
add wave -noupdate -group LANE1 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_requester/operand_request_i}
add wave -noupdate -group LANE1 -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_requester/gen_operand_requester[4]/state_q}
add wave -noupdate -group LANE1 -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_requester/vinsn_result_written_q}
add wave -noupdate -group LANE1 -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_requester/gen_operand_requester[0]/stall}
add wave -noupdate -group LANE1 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_requester/operand_queue_ready_i}
add wave -noupdate -group LANE1 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_requester/lane_operand_req_transposed}
add wave -noupdate -group LANE1 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_requester/lane_operand_req}
add wave -noupdate -group LANE1 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_requester/operand_payload[4]}
add wave -noupdate -group LANE1 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_requester/operand_payload[3]}
add wave -noupdate -group LANE1 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_requester/operand_payload[2]}
add wave -noupdate -group LANE1 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_requester/gen_vrf_arbiters[0]/payload_hp}
add wave -noupdate -group LANE1 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_requester/vrf_addr_o}
add wave -noupdate -group LANE1 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_requester/vrf_be_o}
add wave -noupdate -group LANE1 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_requester/vrf_req_o}
add wave -noupdate -group LANE1 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_requester/vrf_wen_o}
add wave -noupdate -group LANE1 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_requester/vrf_wdata_o}
add wave -noupdate -group LANE1 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_requester/vrf_tgt_opqueue_o}
add wave -noupdate -group LANE1 -group VRF -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vrf/addr_i}
add wave -noupdate -group LANE1 -group VRF -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vrf/req_i}
add wave -noupdate -group LANE1 -group VRF -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vrf/wen_i}
add wave -noupdate -group LANE1 -group VRF {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vrf/wdata_i}
add wave -noupdate -group LANE1 -group VRF {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vrf/rdata}
add wave -noupdate -group LANE1 -group VRF {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vrf/operand_valid_o}
add wave -noupdate -group LANE1 -group VRF {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vrf/operand_o}
add wave -noupdate -group LANE1 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/operand_i}
add wave -noupdate -group LANE1 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/operand_valid_i}
add wave -noupdate -group LANE1 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/clk_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_queue_cmd_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_queue_cmd_valid_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_valid_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_issued_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_ready_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/cmd}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/ibuf_pop}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/cmd_pop}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/elem_count_d}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/elem_count_q}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_alu_a/select_d}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_alu_a/select_q}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/ibuf_operand}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/conv_operand}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_valid_o}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a -color Khaki {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_o}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_queue_cmd_valid_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_queue_cmd_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_ready_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_issued_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_valid_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/cmd}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/elem_count_d}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/clk_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/elem_count_q}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/cmd_pop}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/ibuf_operand}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/bytenum_per_op_d}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/bytenum_per_op_q}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/conv_operand}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_valid_o}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_b -color Khaki {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_o}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/operand_queue_cmd_valid_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/operand_queue_cmd_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/operand_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/operand_ready_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/operand_issued_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/operand_valid_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/cmd}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/elem_count_d}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/clk_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/elem_count_q}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/cmd_pop}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/ibuf_operand}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/conv_operand}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_c {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/operand_valid_o}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_c -color Khaki {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_c/operand_o}
add wave -noupdate -group LANE1 -expand -group VFUS -color Khaki -expand -subitemconfig {{/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/mfpu_operand_i[2]} {-color Khaki -height 17} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/mfpu_operand_i[1]} {-color Khaki -height 17} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/mfpu_operand_i[0]} {-color Khaki -height 17}} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/mfpu_operand_i}
add wave -noupdate -group LANE1 -expand -group VFUS -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/mfpu_operand_valid_i}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/vfu_operation_i}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/vfu_operation_valid_i}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU -color Khaki -expand -subitemconfig {{/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/mfpu_operand_i[2]} {-color Khaki -height 17} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/mfpu_operand_i[1]} {-color Khaki -height 17} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/mfpu_operand_i[0]} {-color Khaki -height 17}} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/mfpu_operand_i}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/mfpu_operand_valid_i}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/vinsn_issue_mul}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/vmul_in_ready}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/operands_ready}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/mfpu_state_q}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/operand_a_i}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/operand_b_i}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/operand_c_i}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/vinsn_processing_q}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/vmul_result}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/unit_out_result}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/result_queue_d}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/mfpu_result_req_o}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/mfpu_result_addr_o}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU -color Khaki {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/mfpu_result_wdata_o}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/mfpu_operand_ready_o}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_32 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/valid_i}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_32 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/operand_a_i}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_32 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/operand_b_i}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_32 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/operand_c_i}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_32 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/opa}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_32 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/opb}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_32 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/opc}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_32 -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/mul_res}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_32 -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/result_tmp}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_32 -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/result_vifmm_o}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_32 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/result_o}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_32 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/transfer_data_i}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_32 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/i_PostU/COMPENSATE/fp32_exponent}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU -expand -group SIMD_MUL_32 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/valid_o}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 4} {2430500 ps} 0} {{Cursor 7} {2456500 ps} 0} {{Cursor 8} {2505500 ps} 0} {{Cursor 9} {7265500 ps} 0} {{Cursor 10} {2184318 ps} 0} {{Cursor 6} {2115500 ps} 0} {{Cursor 7} {2147500 ps} 0}
quietly wave cursor active 5
configure wave -namecolwidth 427
configure wave -valuecolwidth 186
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {2171227 ps} {2236326 ps}
