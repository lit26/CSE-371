// EE 371 Lab 2 Task1
// Tianning Li

// This module is the onboard module for the whole system.
// It uses the timescale 1ps/1ps
// The inputs are the clock and switch and the output is the LEDs on the board
// This module use ram32x4 from the pre-built library 
`timescale 1 ps/1 ps
module DE1_SoC (LEDR, CLOCK_50, SW); 
	output logic [3:0]LEDR;
	input logic CLOCK_50;
	input logic [9:0] SW;
	
	//ram32x4.v comes from the pre-built library
	//ram32x4 (address,clock,data,wren,q)
	//read or write to the memory.
	//sw[4:0] is the address, SW[8:5] is the data and SW[9] is wren
	ram32x4 theRAM(SW[4:0], CLOCK_50, SW[8:5],SW[9], LEDR);
endmodule

// The testbench module for the whole system.
module DE1_SoC_testbench();
	logic [3:0] LEDR;
	logic clk;
	logic [9:0] SW;
	DE1_SoC dut (.LEDR, .CLOCK_50(clk), .SW);

	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin //sw = wren, datain, address
										
		SW <= 10'b1010000100; 	@(posedge clk); // write data to address 00100
										@(posedge clk);
		SW <= 10'b0000000100; 	@(posedge clk); // read data from address 00100
		SW <= 10'b1001000000; 	@(posedge clk); // write data to address 00000
										@(posedge clk);
		SW <= 10'b0000000000; 	@(posedge clk); // read data from address 00000
		$stop();
	end
endmodule
		
	