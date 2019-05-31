// EE 371 Lab 2 Task2
// Tianning Li

// This module is the onboard module for the whole system.
// It uses the timescale 1ps/1ps
// The inputs are the KEY and switch and the output is the HEX display
// on the board. This module use ram32x4 from the pre-built library and 
// 7 segment display module.
`timescale 1 ps/1 ps
module DE1_SoC (SW,KEY,HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	input logic [9:0] SW;
	input logic [0:0] KEY;
	logic [3:0] q;

	// Turn off the HEX3 and HEX1
	assign HEX3 = 7'b1111111;
	assign HEX1 = 7'b1111111;
	
	// ram32x4 (address,clock,data,wren,q)
	// read or write to the memory.
	ram32x4 theRAM(SW[8:4], KEY[0], SW[3:0],SW[9], q);
	
	// seg7 (bcd, leds);
	// display the digit value on different HEX display.
	seg7inHEX addDisplay(SW[8:4],HEX5,HEX4);
	seg7 hex2Display(SW[3:0], HEX2);
	seg7 hex0Display(q, HEX0);
endmodule

// The testbench module for the whole system.
module DE1_SoC_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] SW;
	logic [0:0] KEY;
	
	DE1_SoC dut (.SW,.KEY,.HEX5, .HEX4, .HEX3, .HEX2, .HEX1, .HEX0);
	
	// use KEY0 as positive edge.
	parameter CLOCK_PERIOD=100;
	initial begin
		KEY[0] <= 0;
		forever #(CLOCK_PERIOD/2) KEY[0] <= ~KEY[0];
	end
	
	initial begin //sw[9] = wren; sw[8:4] = address; sw[3:0] = data
		SW <= 10'b1010000100; 	@(posedge KEY[0]);// write to 01000
										@(posedge KEY[0]);
		SW <= 10'b0010000000; 	@(posedge KEY[0]);// read 01000
										@(posedge KEY[0]);
		SW <= 10'b1001000010; 	@(posedge KEY[0]);// write to 00100
										@(posedge KEY[0]);
		SW <= 10'b0001000000; 	@(posedge KEY[0]);// read 01000
										@(posedge KEY[0]);
		SW <= 10'b1010000111; 	@(posedge KEY[0]);// write to 01000
										@(posedge KEY[0]);
		SW <= 10'b0010000000; 	@(posedge KEY[0]);// read 01000
										@(posedge KEY[0]);	
		$stop();
	end
endmodule
		
	