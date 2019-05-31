// EE 371 Lab 4 Task 2
// Tianning Li

// This is the top module of the whole system. It will take clock, switches
// and keys as input and output HEX display and LEDR display.
`timescale 1 ps / 1 ps
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, CLOCK_50);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	input logic CLOCK_50;
	logic clk, reset, start, found, done;
	logic [7:0] A;
	logic [4:0] addr;
	
	// assign all unused HEX display to off
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	assign HEX5 = '1;
	
	// assign control signal
	assign start = SW[9];
	assign reset = ~KEY[0];
	assign LEDR[9] = found;
	
	// choose clock
	assign clk  = CLOCK_50;
	/*logic [31:0] clock;
	parameter whichClock = 14;
	clock_divider cdiv (CLOCK_50, clock);
	assign clk = clock[whichClock];*/
	
	// binary search algorithm
	assign A = SW[7:0];
	bi_search searchValue(A, clk, reset, start, addr, found, done);
	seg7inHEX hexDisplay(found, addr, HEX1, HEX0);
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
	
	DE1_SoC dut(.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW, .CLOCK_50(clk));
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	integer i;
	integer j;
	initial begin
	for(j=0;j<32;j++) begin
		KEY[0]<=0;								@(posedge clk);
													@(posedge clk);
													@(posedge clk);
		KEY[0]<=1; SW<=j;				@(posedge clk);
		SW[9]<=1;								@(posedge clk);
		for (i = 0; i <20;i++) 				@(posedge clk);	
	end
	$stop();
	end
endmodule
	