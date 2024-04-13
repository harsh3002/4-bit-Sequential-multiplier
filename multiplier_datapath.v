
`timescale 1ns/1ns

module mul_datapath(
output  [7:0] acc_o,
output  multplr_lsb,
output  reg [1:0] step_count,
input [3:0] multplcnd_i,
input [3:0] multplr_i,
input shift_ena_i,
input load_reg_i,
input mux_ctrl_i,
input add_i,
input clk_i);

reg [4:0] acc;
reg [3:0] mul_A;
reg [3:0] mul_B;
reg [3:0] mux_out;

always@(posedge clk_i) begin

	if(load_reg_i) begin
		acc<=5'b0;
		mul_A<=multplcnd_i;
		mul_B<=multplr_i;	
		step_count<=2'b11;	
	end
	else if(shift_ena_i)begin
		 {acc,mul_B}<={acc,mul_B}>>1;
		step_count=step_count-1'b1;
	end
	else if(add_i) begin
		mux_out= mux_ctrl_i? mul_A:4'b0;
		acc= mux_out + acc;
		
	end
	

end
assign multplr_lsb = mul_B[0];
assign acc_o = {acc[3:0],mul_B};
endmodule 
