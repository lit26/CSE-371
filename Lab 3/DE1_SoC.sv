// EE 371 Lab 3
// Tianning Li

// This is the main module that combine all the modules together and output 
// on the computer screen.
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, CLOCK_50, 
	VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS);
	
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;

	input CLOCK_50;
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_BLANK_N;
	output VGA_CLK;
	output VGA_HS;
	output VGA_SYNC_N;
	output VGA_VS;
	
	assign HEX0 = '1;
	assign HEX1 = '1;
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	assign HEX5 = '1;
	assign LEDR = SW;
	
	logic [10:0] x, y,x0,y0;
	logic pixel_color;
	logic clk, reset, move, clear;
	logic [6:0] counter;
	
	assign clk  = CLOCK_50;
	// choose clock
	/*logic [31:0] clock;
	parameter whichClock = 18;
	clock_divider cdiv (CLOCK_50, clock);
	assign clk = clock[whichClock];*/
	
	VGA_framebuffer fb(.clk50(CLOCK_50), .reset(1'b0), .x, .y,
				.pixel_color, .pixel_write(1'b1),
				.VGA_R, .VGA_G, .VGA_B, .VGA_CLK, .VGA_HS, .VGA_VS,
				.VGA_BLANK_n(VGA_BLANK_N), .VGA_SYNC_n(VGA_SYNC_N));
	assign blackOut = SW[0];
	assign reset = SW[1];
	line_move lines(x,y,x0, y0, clk, reset,move,clear,blackOut);
	counter counters(counter, move, clear, clk, reset);
	
	
	always_ff @(posedge clk) begin
		if(move)
			pixel_color <= 1'b1;
		else if (clear|reset|blackOut)
			pixel_color <= 1'b0;
	end	
endmodule

// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz, [25] = 0.75Hz, ...  
/*module clock_divider (clock, divided_clocks);
	input logic clock;
	output logic [31:0] divided_clocks;
	
	initial begin
		divided_clocks <= 0;
	end
	
	always_ff @(posedge clock) begin
		divided_clocks <= divided_clocks + 1;
	end
endmodule*/

// Testbench for the DE1_SoC module
module DE1_SoC_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;

	logic clk;
	logic [7:0] VGA_R;
	logic [7:0] VGA_G;
	logic [7:0] VGA_B;
	logic VGA_BLANK_N;
	logic VGA_CLK;
	logic VGA_HS;
	logic VGA_SYNC_N;
	logic VGA_VS;
	DE1_SoC dut(.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW, .CLOCK_50(clk), 
	.VGA_R, .VGA_G, .VGA_B, .VGA_BLANK_N, .VGA_CLK, .VGA_HS, .VGA_SYNC_N, .VGA_VS);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	integer i;
	initial begin
		SW[1]<=1;						@(posedge clk);
		SW[1]<=0;						@(posedge clk);
		for (i = 0; i <500;i++) 	@(posedge clk);
		SW[0]<=1;						@(posedge clk);
		for (i = 0; i <100;i++) 	@(posedge clk);
		SW[0]<=0;						@(posedge clk);
		for (i = 0; i <500;i++) 	@(posedge clk);
		
	$stop();
	end
endmodule


