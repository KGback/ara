onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group CVA6 /ara_tb/dut/i_ara_soc/i_system/i_ariane/id_stage_i/decoder_i/gen_accel_decoder/i_accel_decoder/is_accel_o
add wave -noupdate -expand -group CVA6 /ara_tb/dut/i_ara_soc/i_system/i_ariane/id_stage_i/decoder_i/gen_accel_decoder/i_accel_decoder/instruction_o.op
add wave -noupdate -expand -group CVA6 /ara_tb/dut/i_ara_soc/i_system/i_ariane/ex_stage_i/pc_i
add wave -noupdate -expand -group CVA6 /ara_tb/dut/i_ara_soc/i_system/axi_req_o
add wave -noupdate -expand -group CVA6 /ara_tb/dut/i_ara_soc/i_system/axi_resp_i
add wave -noupdate -expand -group ARA /ara_tb/dut/i_ara_soc/i_system/i_ara/i_dispatcher/acc_req_i
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
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_lane_sequencer/pe_req_i}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_lane_sequencer/pe_req_valid_i}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_lane_sequencer/operand_request_valid_o}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_lane_sequencer/operand_request_o}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_lane_sequencer/vfu_operation_o}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/operand_request_valid_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/operand_request_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[4]/state_q}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/vinsn_result_written_q}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_operand_requester[0]/stall}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/operand_queue_ready_i}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/lane_operand_req_transposed}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/lane_operand_req}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/operand_payload[4]}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/operand_payload[3]}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/operand_payload[2]}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[7]/payload_hp_req}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[7]/payload_hp}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[6]/payload_hp_req}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[6]/payload_hp}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[5]/payload_hp_req}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[5]/payload_hp}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[4]/payload_hp_req}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[4]/payload_hp}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[3]/payload_hp_req}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[3]/payload_hp}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[2]/payload_hp_req}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[2]/payload_hp}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[1]/payload_hp_req}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[1]/payload_hp}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[0]/payload_hp_req}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER -group RR_ARBITER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/gen_vrf_arbiters[0]/payload_hp}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/vrf_addr_o}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/vrf_be_o}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/vrf_req_o}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/vrf_wen_o}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/vrf_wdata_o}
add wave -noupdate -expand -group LANE0 -expand -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_requester/vrf_tgt_opqueue_o}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vrf/addr_i}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vrf/operand_valid_o}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vrf/operand_o}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/operand_i}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/operand_valid_i}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/clk_i}
add wave -noupdate -expand -group LANE0 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vrf/req_i}
add wave -noupdate -expand -group LANE0 -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_outlier_judge/operand_eew_a}
add wave -noupdate -expand -group LANE0 -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_outlier_judge/operand_eew_b}
add wave -noupdate -expand -group LANE0 -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_outlier_judge/full_m_fp32}
add wave -noupdate -expand -group LANE0 -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_outlier_judge/olr_thd_diff_e_fp32}
add wave -noupdate -expand -group LANE0 -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_outlier_judge/op0_diff_e_fp32}
add wave -noupdate -expand -group LANE0 -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_outlier_judge/op1_diff_e_fp32}
add wave -noupdate -expand -group LANE0 -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_outlier_judge/olr_thd_dynamic_d}
add wave -noupdate -expand -group LANE0 -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_outlier_judge/olr_thd_dynamic_q}
add wave -noupdate -expand -group LANE0 -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_outlier_judge/max_int_fp32}
add wave -noupdate -expand -group LANE0 -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_outlier_judge/scaling_factor}
add wave -noupdate -expand -group LANE0 -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_outlier_judge/transfer_pack_o}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_queue_cmd_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_queue_cmd_valid_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/transfer_pack_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_valid_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_issued_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_ready_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/cmd}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/transfer_pack}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/ibuf_pop}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/cmd_pop}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/elem_count_d}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/elem_count_q}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_alu_a/select_d}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_alu_a/select_q}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/transfer_pack_o}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/ibuf_operand}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/conv_operand}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_valid_o}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_a -color Khaki {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_o}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_queue_cmd_valid_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_queue_cmd_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_ready_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_valid_i}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_valid_o}
add wave -noupdate -expand -group LANE0 -group operand_queue_mfpu_b -color Khaki {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_o}
add wave -noupdate -expand -group LANE0 -group VFUS -color Khaki -expand -subitemconfig {{/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/mfpu_operand_i[2]} {-color Khaki -height 17} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/mfpu_operand_i[1]} {-color Khaki -height 17} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/mfpu_operand_i[0]} {-color Khaki -height 17}} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/mfpu_operand_i}
add wave -noupdate -expand -group LANE0 -group VFUS -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/mfpu_operand_valid_i}
add wave -noupdate -expand -group LANE0 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vfu_operation_i}
add wave -noupdate -expand -group LANE0 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vfu_operation_valid_i}
add wave -noupdate -expand -group LANE0 -group VFUS -expand -group VMFPU -color Khaki {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/mfpu_operand_i}
add wave -noupdate -expand -group LANE0 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/mfpu_operand_valid_i}
add wave -noupdate -expand -group LANE0 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vinsn_issue_mul}
add wave -noupdate -expand -group LANE0 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vmul_in_ready}
add wave -noupdate -expand -group LANE0 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/operands_ready}
add wave -noupdate -expand -group LANE0 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/mfpu_state_q}
add wave -noupdate -expand -group LANE0 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/operand_a_i}
add wave -noupdate -expand -group LANE0 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/operand_b_i}
add wave -noupdate -expand -group LANE0 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/operand_c_i}
add wave -noupdate -expand -group LANE0 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vinsn_processing_q}
add wave -noupdate -expand -group LANE0 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vmul_result}
add wave -noupdate -expand -group LANE0 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/unit_out_result}
add wave -noupdate -expand -group LANE0 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/vifmm_transfer_pack_ff2}
add wave -noupdate -expand -group LANE0 -group VFUS -expand -group VMFPU -expand -subitemconfig {{/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/result_queue_d[0]} -expand} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/result_queue_d}
add wave -noupdate -expand -group LANE0 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/mfpu_result_req_o}
add wave -noupdate -expand -group LANE0 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/mfpu_result_addr_o}
add wave -noupdate -expand -group LANE0 -group VFUS -expand -group VMFPU -color Khaki {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/mfpu_result_wdata_o}
add wave -noupdate -expand -group LANE0 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_vfus/i_vmfpu/mfpu_operand_ready_o}
add wave -noupdate -group LANE1 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_lane_sequencer/pe_req_i}
add wave -noupdate -group LANE1 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_lane_sequencer/pe_req_valid_i}
add wave -noupdate -group LANE1 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_lane_sequencer/operand_request_valid_o}
add wave -noupdate -group LANE1 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_lane_sequencer/operand_request_o}
add wave -noupdate -group LANE1 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_lane_sequencer/vfu_operation_o}
add wave -noupdate -group LANE1 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_requester/operand_request_valid_i}
add wave -noupdate -group LANE1 -group OPERAND_REQUESTER -expand -subitemconfig {{/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_requester/operand_request_i[4]} -expand} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_requester/operand_request_i}
add wave -noupdate -group LANE1 -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_requester/gen_operand_requester[4]/state_q}
add wave -noupdate -group LANE1 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_requester/vinsn_result_written_q}
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
add wave -noupdate -group LANE1 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vrf/addr_i}
add wave -noupdate -group LANE1 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vrf/operand_valid_o}
add wave -noupdate -group LANE1 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vrf/operand_o}
add wave -noupdate -group LANE1 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/operand_i}
add wave -noupdate -group LANE1 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/operand_valid_i}
add wave -noupdate -group LANE1 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/clk_i}
add wave -noupdate -group LANE1 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vrf/req_i}
add wave -noupdate -group LANE1 -expand -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_outlier_judge/operand_eew_a}
add wave -noupdate -group LANE1 -expand -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_outlier_judge/operand_eew_b}
add wave -noupdate -group LANE1 -expand -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_outlier_judge/full_m_fp32}
add wave -noupdate -group LANE1 -expand -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_outlier_judge/op0_diff_e_fp32}
add wave -noupdate -group LANE1 -expand -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_outlier_judge/op1_diff_e_fp32}
add wave -noupdate -group LANE1 -expand -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_outlier_judge/olr_thd_dynamic_d}
add wave -noupdate -group LANE1 -expand -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_outlier_judge/olr_thd_dynamic_q}
add wave -noupdate -group LANE1 -expand -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_outlier_judge/max_int_fp32}
add wave -noupdate -group LANE1 -expand -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_outlier_judge/scaling_factor}
add wave -noupdate -group LANE1 -expand -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_outlier_judge/transfer_pack_o}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_queue_cmd_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_queue_cmd_valid_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/transfer_pack_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_valid_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_issued_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_ready_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/cmd}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/transfer_pack}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/ibuf_pop}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/cmd_pop}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/elem_count_d}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/elem_count_q}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_alu_a/select_d}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_alu_a/select_q}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/transfer_pack_o}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/ibuf_operand}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/conv_operand}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_valid_o}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_a -color Khaki {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_o}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_queue_cmd_valid_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_queue_cmd_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_ready_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_valid_i}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_valid_o}
add wave -noupdate -group LANE1 -group operand_queue_mfpu_b -color Khaki {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_o}
add wave -noupdate -group LANE1 -expand -group VFUS -color Khaki -expand -subitemconfig {{/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/mfpu_operand_i[2]} {-color Khaki -height 17} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/mfpu_operand_i[1]} {-color Khaki -height 17} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/mfpu_operand_i[0]} {-color Khaki -height 17}} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/mfpu_operand_i}
add wave -noupdate -group LANE1 -expand -group VFUS -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/mfpu_operand_valid_i}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/vfu_operation_i}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/vfu_operation_valid_i}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU -color Khaki {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/mfpu_operand_i}
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
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/vifmm_transfer_pack_ff2}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/result_queue_d}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/mfpu_result_req_o}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/mfpu_result_addr_o}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU -color Khaki {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/mfpu_result_wdata_o}
add wave -noupdate -group LANE1 -expand -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[1]/i_lane/i_vfus/i_vmfpu/mfpu_operand_ready_o}
add wave -noupdate -group LANE2 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_lane_sequencer/pe_req_i}
add wave -noupdate -group LANE2 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_lane_sequencer/pe_req_valid_i}
add wave -noupdate -group LANE2 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_lane_sequencer/operand_request_valid_o}
add wave -noupdate -group LANE2 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_lane_sequencer/operand_request_o}
add wave -noupdate -group LANE2 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_lane_sequencer/vfu_operation_o}
add wave -noupdate -group LANE2 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_requester/operand_request_valid_i}
add wave -noupdate -group LANE2 -group OPERAND_REQUESTER -expand -subitemconfig {{/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_requester/operand_request_i[4]} -expand} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_requester/operand_request_i}
add wave -noupdate -group LANE2 -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_requester/gen_operand_requester[4]/state_q}
add wave -noupdate -group LANE2 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_requester/vinsn_result_written_q}
add wave -noupdate -group LANE2 -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_requester/gen_operand_requester[0]/stall}
add wave -noupdate -group LANE2 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_requester/operand_queue_ready_i}
add wave -noupdate -group LANE2 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_requester/lane_operand_req_transposed}
add wave -noupdate -group LANE2 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_requester/lane_operand_req}
add wave -noupdate -group LANE2 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_requester/operand_payload[4]}
add wave -noupdate -group LANE2 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_requester/operand_payload[3]}
add wave -noupdate -group LANE2 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_requester/operand_payload[2]}
add wave -noupdate -group LANE2 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_requester/gen_vrf_arbiters[0]/payload_hp}
add wave -noupdate -group LANE2 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_requester/vrf_addr_o}
add wave -noupdate -group LANE2 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_requester/vrf_be_o}
add wave -noupdate -group LANE2 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_requester/vrf_req_o}
add wave -noupdate -group LANE2 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_requester/vrf_wen_o}
add wave -noupdate -group LANE2 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_requester/vrf_wdata_o}
add wave -noupdate -group LANE2 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_requester/vrf_tgt_opqueue_o}
add wave -noupdate -group LANE2 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vrf/addr_i}
add wave -noupdate -group LANE2 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vrf/operand_valid_o}
add wave -noupdate -group LANE2 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vrf/operand_o}
add wave -noupdate -group LANE2 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/operand_i}
add wave -noupdate -group LANE2 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/operand_valid_i}
add wave -noupdate -group LANE2 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/clk_i}
add wave -noupdate -group LANE2 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vrf/req_i}
add wave -noupdate -group LANE2 -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_outlier_judge/operand_eew_a}
add wave -noupdate -group LANE2 -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_outlier_judge/operand_eew_b}
add wave -noupdate -group LANE2 -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_outlier_judge/full_m_fp32}
add wave -noupdate -group LANE2 -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_outlier_judge/olr_thd_dynamic_d}
add wave -noupdate -group LANE2 -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_outlier_judge/olr_thd_dynamic_q}
add wave -noupdate -group LANE2 -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_outlier_judge/max_int_fp32}
add wave -noupdate -group LANE2 -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_outlier_judge/scaling_factor}
add wave -noupdate -group LANE2 -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_outlier_judge/transfer_pack_o}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_queue_cmd_i}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_queue_cmd_valid_i}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_i}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/transfer_pack_i}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_valid_i}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_issued_i}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_ready_i}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/cmd}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/transfer_pack}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/ibuf_pop}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/cmd_pop}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/elem_count_d}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/elem_count_q}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_alu_a/select_d}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_alu_a/select_q}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/transfer_pack_o}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/ibuf_operand}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/conv_operand}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_valid_o}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_a -color Khaki {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_o}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_queue_cmd_valid_i}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_queue_cmd_i}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_i}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_ready_i}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_valid_i}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_valid_o}
add wave -noupdate -group LANE2 -group operand_queue_mfpu_b -color Khaki {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_o}
add wave -noupdate -group LANE2 -group VFUS -color Khaki -expand -subitemconfig {{/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/mfpu_operand_i[2]} {-color Khaki -height 17} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/mfpu_operand_i[1]} {-color Khaki -height 17} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/mfpu_operand_i[0]} {-color Khaki -height 17}} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/mfpu_operand_i}
add wave -noupdate -group LANE2 -group VFUS -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/mfpu_operand_valid_i}
add wave -noupdate -group LANE2 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/i_vmfpu/vfu_operation_i}
add wave -noupdate -group LANE2 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/i_vmfpu/vfu_operation_valid_i}
add wave -noupdate -group LANE2 -group VFUS -expand -group VMFPU -color Khaki {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/i_vmfpu/mfpu_operand_i}
add wave -noupdate -group LANE2 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/i_vmfpu/mfpu_operand_valid_i}
add wave -noupdate -group LANE2 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/i_vmfpu/vinsn_issue_mul}
add wave -noupdate -group LANE2 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/i_vmfpu/vmul_in_ready}
add wave -noupdate -group LANE2 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/i_vmfpu/operands_ready}
add wave -noupdate -group LANE2 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/i_vmfpu/mfpu_state_q}
add wave -noupdate -group LANE2 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/operand_a_i}
add wave -noupdate -group LANE2 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/operand_b_i}
add wave -noupdate -group LANE2 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/operand_c_i}
add wave -noupdate -group LANE2 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/i_vmfpu/vinsn_processing_q}
add wave -noupdate -group LANE2 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/i_vmfpu/vmul_result}
add wave -noupdate -group LANE2 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/i_vmfpu/unit_out_result}
add wave -noupdate -group LANE2 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/i_vmfpu/vifmm_transfer_pack_ff2}
add wave -noupdate -group LANE2 -group VFUS -expand -group VMFPU -expand -subitemconfig {{/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/i_vmfpu/result_queue_d[0]} -expand} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/i_vmfpu/result_queue_d}
add wave -noupdate -group LANE2 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/i_vmfpu/mfpu_result_req_o}
add wave -noupdate -group LANE2 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/i_vmfpu/mfpu_result_addr_o}
add wave -noupdate -group LANE2 -group VFUS -expand -group VMFPU -color Khaki {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/i_vmfpu/mfpu_result_wdata_o}
add wave -noupdate -group LANE2 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[2]/i_lane/i_vfus/i_vmfpu/mfpu_operand_ready_o}
add wave -noupdate -group LANE3 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_lane_sequencer/pe_req_i}
add wave -noupdate -group LANE3 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_lane_sequencer/pe_req_valid_i}
add wave -noupdate -group LANE3 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_lane_sequencer/operand_request_valid_o}
add wave -noupdate -group LANE3 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_lane_sequencer/operand_request_o}
add wave -noupdate -group LANE3 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_lane_sequencer/vfu_operation_o}
add wave -noupdate -group LANE3 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_requester/operand_request_valid_i}
add wave -noupdate -group LANE3 -group OPERAND_REQUESTER -expand -subitemconfig {{/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_requester/operand_request_i[4]} -expand} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_requester/operand_request_i}
add wave -noupdate -group LANE3 -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_requester/gen_operand_requester[4]/state_q}
add wave -noupdate -group LANE3 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_requester/vinsn_result_written_q}
add wave -noupdate -group LANE3 -group OPERAND_REQUESTER {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_requester/gen_operand_requester[0]/stall}
add wave -noupdate -group LANE3 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_requester/operand_queue_ready_i}
add wave -noupdate -group LANE3 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_requester/lane_operand_req_transposed}
add wave -noupdate -group LANE3 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_requester/lane_operand_req}
add wave -noupdate -group LANE3 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_requester/operand_payload[4]}
add wave -noupdate -group LANE3 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_requester/operand_payload[3]}
add wave -noupdate -group LANE3 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_requester/operand_payload[2]}
add wave -noupdate -group LANE3 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_requester/gen_vrf_arbiters[0]/payload_hp}
add wave -noupdate -group LANE3 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_requester/vrf_addr_o}
add wave -noupdate -group LANE3 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_requester/vrf_be_o}
add wave -noupdate -group LANE3 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_requester/vrf_req_o}
add wave -noupdate -group LANE3 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_requester/vrf_wen_o}
add wave -noupdate -group LANE3 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_requester/vrf_wdata_o}
add wave -noupdate -group LANE3 -group OPERAND_REQUESTER -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_requester/vrf_tgt_opqueue_o}
add wave -noupdate -group LANE3 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vrf/addr_i}
add wave -noupdate -group LANE3 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vrf/operand_valid_o}
add wave -noupdate -group LANE3 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vrf/operand_o}
add wave -noupdate -group LANE3 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/operand_i}
add wave -noupdate -group LANE3 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/operand_valid_i}
add wave -noupdate -group LANE3 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/clk_i}
add wave -noupdate -group LANE3 {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vrf/req_i}
add wave -noupdate -group LANE3 -expand -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_outlier_judge/operand_eew_a}
add wave -noupdate -group LANE3 -expand -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_outlier_judge/operand_eew_b}
add wave -noupdate -group LANE3 -expand -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_outlier_judge/full_m_fp32}
add wave -noupdate -group LANE3 -expand -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_outlier_judge/op0_diff_e_fp32}
add wave -noupdate -group LANE3 -expand -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_outlier_judge/op1_diff_e_fp32}
add wave -noupdate -group LANE3 -expand -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_outlier_judge/olr_thd_diff_e_fp32}
add wave -noupdate -group LANE3 -expand -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[0]/i_lane/i_operand_queues/i_outlier_judge/operand_c}
add wave -noupdate -group LANE3 -expand -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_outlier_judge/olr_thd_dynamic_d}
add wave -noupdate -group LANE3 -expand -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_outlier_judge/olr_thd_dynamic_q}
add wave -noupdate -group LANE3 -expand -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_outlier_judge/max_int_fp32}
add wave -noupdate -group LANE3 -expand -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_outlier_judge/scaling_factor}
add wave -noupdate -group LANE3 -expand -group OLR_JUDGE {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_outlier_judge/transfer_pack_o}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_queue_cmd_i}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_queue_cmd_valid_i}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_i}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/transfer_pack_i}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_valid_i}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_issued_i}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_ready_i}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/cmd}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/transfer_pack}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/ibuf_pop}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/cmd_pop}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/elem_count_d}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/elem_count_q}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_alu_a/select_d}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_alu_a/select_q}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/transfer_pack_o}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/ibuf_operand}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/conv_operand}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_a {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_valid_o}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_a -color Khaki {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_mfpu_a/operand_o}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_queue_cmd_valid_i}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_queue_cmd_i}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_i}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_ready_i}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_valid_i}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_b {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_valid_o}
add wave -noupdate -group LANE3 -group operand_queue_mfpu_b -color Khaki {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_operand_queues/i_operand_queue_mfpu_b/operand_o}
add wave -noupdate -group LANE3 -group VFUS -color Khaki -expand -subitemconfig {{/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/mfpu_operand_i[2]} {-color Khaki -height 17} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/mfpu_operand_i[1]} {-color Khaki -height 17} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/mfpu_operand_i[0]} {-color Khaki -height 17}} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/mfpu_operand_i}
add wave -noupdate -group LANE3 -group VFUS -expand {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/mfpu_operand_valid_i}
add wave -noupdate -group LANE3 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/i_vmfpu/vfu_operation_i}
add wave -noupdate -group LANE3 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/i_vmfpu/vfu_operation_valid_i}
add wave -noupdate -group LANE3 -group VFUS -expand -group VMFPU -color Khaki {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/i_vmfpu/mfpu_operand_i}
add wave -noupdate -group LANE3 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/i_vmfpu/mfpu_operand_valid_i}
add wave -noupdate -group LANE3 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/i_vmfpu/vinsn_issue_mul}
add wave -noupdate -group LANE3 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/i_vmfpu/vmul_in_ready}
add wave -noupdate -group LANE3 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/i_vmfpu/operands_ready}
add wave -noupdate -group LANE3 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/i_vmfpu/mfpu_state_q}
add wave -noupdate -group LANE3 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/operand_a_i}
add wave -noupdate -group LANE3 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/operand_b_i}
add wave -noupdate -group LANE3 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/i_vmfpu/i_simd_mul_ew32/operand_c_i}
add wave -noupdate -group LANE3 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/i_vmfpu/vinsn_processing_q}
add wave -noupdate -group LANE3 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/i_vmfpu/vmul_result}
add wave -noupdate -group LANE3 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/i_vmfpu/unit_out_result}
add wave -noupdate -group LANE3 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/i_vmfpu/vifmm_transfer_pack_ff2}
add wave -noupdate -group LANE3 -group VFUS -expand -group VMFPU -expand -subitemconfig {{/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/i_vmfpu/result_queue_d[0]} -expand} {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/i_vmfpu/result_queue_d}
add wave -noupdate -group LANE3 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/i_vmfpu/mfpu_result_req_o}
add wave -noupdate -group LANE3 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/i_vmfpu/mfpu_result_addr_o}
add wave -noupdate -group LANE3 -group VFUS -expand -group VMFPU -color Khaki {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/i_vmfpu/mfpu_result_wdata_o}
add wave -noupdate -group LANE3 -group VFUS -expand -group VMFPU {/ara_tb/dut/i_ara_soc/i_system/i_ara/gen_lanes[3]/i_lane/i_vfus/i_vmfpu/mfpu_operand_ready_o}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3351500 ps} 0} {{Cursor 2} {3352491 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 389
configure wave -valuecolwidth 267
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
WaveRestoreZoom {3350675 ps} {3354214 ps}
