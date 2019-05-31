// EE 371 project
// Tianning Li, Mingcun Fan

// This module will delay cycles for the pre-signal is ready.
module delay(clk,x_pre,y_pre,done_pre,x,y,done);
	input logic clk, done_pre;
	input logic [10:0]x_pre,y_pre;
	output logic [10:0]x,y;
	output logic done;
	logic [10:0]x_1,x_2,y_1,y_2;
	logic done_1,done_2;
	always_ff @(posedge clk) begin
		x_1<=x_pre;
		x_2<=x_1;
		x<=x_2;
		y_1<=y_pre;
		y_2<=y_1;
		y<=y_2;
		done_1<=done_pre;
		done_2<=done_1;
		done<=done_2;
	end
endmodule