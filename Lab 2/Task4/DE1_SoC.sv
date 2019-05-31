// EE 371 Lab 2 Task4
// Tianning Li

// This module is the onboard module for the whole system.
// It uses the timescale 1ps/1ps. The inputs are the clock and switch 
// and the output is the HEX on the board
// This module use two ports ram32x4 from the pre-built library 
`timescale 1 ps/1 ps
module DE1_SoC(CLOCK_50,SW,KEY,HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	input logic CLOCK_50;
	input logic [9:0] SW;
	input logic [0:0] KEY;

	logic [3:0]  data;
	logic [4:0]  rdaddress;
	logic [4:0]  wraddress;
	logic wren, reset, clk;
	logic [3:0]  q;
	
	// assign the values for the memory system from the switches
	assign data = SW[3:0];
	assign wraddress = SW[8:4];
	assign wren = SW[9];
	assign reset = ~KEY[0];
	
	// choose clock
	logic [31:0] clock;
	parameter whichClock = 24;
	clock_divider cdiv (CLOCK_50, clock);
	assign clk = clock[whichClock];
	
	ram32x4 theRam(clk, data, rdaddress, wraddress,wren,q);
	
	always_ff @(posedge clk) begin
		if(reset)
			rdaddress <=5'b0; // if reset read address go back to 0
		else if (rdaddress<5'b11111) begin
			rdaddress =rdaddress +5'b1; // not reset read address increment by 1 per second
		end
	end
	
	// seg7inHEX (bcd, led1,led0);
	// Display the digit value or the hex value on the hex display.
	seg7inHEX waddDisplay(wraddress,HEX5,HEX4);
	seg7inHEX raddDisplay(rdaddress,HEX3,HEX2);
	seg7 hex1Display(data, HEX1);
	seg7 hex0Display(q, HEX0);
	
endmodule

// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz, [25] = 0.75Hz, ...  
module clock_divider (clock, divided_clocks);
	input logic clock;
	output logic [31:0] divided_clocks;
	
	initial begin
		divided_clocks <= 0;
	end
	
	always_ff @(posedge clock) begin
		divided_clocks <= divided_clocks + 1;
	end
endmodule

// This module is for running the modelism
/*module DE1_SoC(clk,SW,KEY,HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	input logic clk;
	input logic [9:0] SW;
	input logic [0:0] KEY;

	logic [3:0]  data;
	logic [4:0]  rdaddress;
	logic [4:0]  wraddress;
	logic wren, reset;
	logic [3:0]  q;
	
	assign data = SW[3:0];
	assign wraddress = SW[8:4];
	assign wren = SW[9];
	assign reset = ~KEY[0];
	
	ram32x4 theRam(clk, data, rdaddress, wraddress,wren,q);
	
	always_ff @(posedge clk) begin
		if(reset)
			rdaddress <=5'b0;
		else if (rdaddress<5'b11111) begin
			rdaddress =rdaddress +5'b1;
		end
	end
	
	//seg7inHEX (bcd, led1,led0);
	seg7inHEX waddDisplay(wraddress,HEX5,HEX4);
	seg7inHEX raddDisplay(rdaddress,HEX3,HEX2);
	seg7 hex1Display(data, HEX1);
	seg7 hex0Display(q, HEX0);
	
endmodule

module DE1_SoC_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic clk;
	logic [9:0] SW;
	logic [0:0] KEY;
	
	DE1_SoC dut (.clk,.SW,.KEY,.HEX5, .HEX4, .HEX3, .HEX2, .HEX1, .HEX0);

	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	integer i;
	initial begin 
		KEY[0]<= 0;					@(posedge clk); //reset the system
		KEY[0]<= 1;					@(posedge clk);
		for (i=0;i<32;i++) begin
										@(posedge clk);	// see the data output from the memory.								
		end
		SW[9:0]<=10'b1111111111;@(posedge clk); // write data to address 11111
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);	
		SW[9:0]<=10'b0111110000;@(posedge clk); // read data from address 11111
										@(posedge clk);	
		
		$stop();
	end
endmodule*/