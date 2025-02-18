
`timescale 1ns/1ns

module mul_tb();

wire [7:0] product_o;
reg  [3:0] multplcnd_i;
reg  [3:0] multplr_i;
reg clk_i;
reg reset_i;
reg mul_enable_i;

top_module dut(.*);

initial begin
	clk_i= 0;
	forever #5 clk_i=~clk_i;
end

initial begin

	reset_i=1'b1;
	#40 reset_i=1'b0;
	#10 multplcnd_i=4'd7; multplr_i=4'd8;
	#10 mul_enable_i=1'b1;
	#10 mul_enable_i=1'b0;
	#200 multplcnd_i=4'd15; multplr_i=4'd15;
	#10 mul_enable_i=1'b1;
	#10 mul_enable_i=1'b0;
	#200 $stop;
end


endmodule
