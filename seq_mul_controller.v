
`timescale 1ns/1ns

module mul_controller(
output shift_ena_o,
output load_reg_o,
output mux_ctrl_o,
output add_o,
input clk_i,
input reset_i,
input [1:0] step_count_i,
input mul_enable,
input mul_lsb_i);

parameter [1:0] IDLE=2'd0,  MUL=2'd2, SHIFT=2'd3;

reg [1:0] state,next_state;

always@(posedge clk_i) begin
	if(reset_i) state<=IDLE;
	else state<=next_state;
end 

always@(*) begin
	
	case(state) 
		IDLE  :  next_state= mul_enable? MUL: IDLE;
		MUL   :  begin  next_state = SHIFT;  end
		SHIFT :   next_state= (step_count_i==0) ? IDLE: MUL;
		default : next_state= IDLE;
	endcase

end

assign shift_ena_o = (state==SHIFT);
assign load_reg_o  = (state==IDLE) & mul_enable;
assign mux_ctrl_o  = (state==MUL) & mul_lsb_i;
assign add_o       = (state==MUL);

endmodule
