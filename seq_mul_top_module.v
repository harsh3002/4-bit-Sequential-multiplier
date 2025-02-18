
`timescale 1ns/1ns

module top_module(
output [7:0] product_o,
input  [3:0] multplcnd_i,
input  [3:0] multplr_i,
input clk_i,
input reset_i,
input mul_enable_i);

wire mul_lsb;
wire shift_ena_ctrl;
wire load_reg_ctrl;
wire mux_ctrl;
wire add_ctrl;
wire [1:0] step_count_ctrl;

mul_controller control_inst(
.clk_i(clk_i),
.reset_i(reset_i),
.shift_ena_o(shift_ena_ctrl),
.load_reg_o(load_reg_ctrl),
.mux_ctrl_o(mux_ctrl),
.add_o(add_ctrl),
.mul_enable(mul_enable_i),
.step_count_i(step_count_ctrl),
.mul_lsb_i(mul_lsb));

mul_datapath datapath_inst(
.acc_o(product_o),
.step_count(step_count_ctrl),
.multplr_lsb(mul_lsb),
.multplcnd_i(multplcnd_i),
.multplr_i(multplr_i),
.shift_ena_i(shift_ena_ctrl),
.load_reg_i(load_reg_ctrl),
.mux_ctrl_i(mux_ctrl),
.add_i(add_ctrl),
.clk_i(clk_i));

endmodule
