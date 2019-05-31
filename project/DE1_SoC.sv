// EE 371 project
// Tianning Li, Mingcun Fan

// This module is the main module for the system. It will use the keyboard driver for the control
// signal. 
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, CLOCK_50, PS2_DAT, PS2_CLK,  
	VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS);
	
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	//output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;

	input CLOCK_50, PS2_DAT, PS2_CLK;
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_BLANK_N;
	output VGA_CLK;
	output VGA_HS;
	output VGA_SYNC_N;
	output VGA_VS;
	
	//assign HEX0 = '1;
	//assign HEX1 = '1;
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	assign HEX5 = '1;
	
	logic [10:0] x0, y0, x1, y1, x, y;
	logic pixel_color;
	
	VGA_framebuffer fb(
		.clk50(CLOCK_50)
		,.reset(1'b0)
		,.x
		,.y
		,.pixel_color
		,.pixel_write(1'b1)
		,.VGA_R
		,.VGA_G
		,.VGA_B
		,.VGA_CLK
		,.VGA_HS
		,.VGA_VS
		,.VGA_BLANK_n(VGA_BLANK_N)
		,.VGA_SYNC_n(VGA_SYNC_N)
		);
		
	logic drawPuzzle_done,clk, reset,color, valid, makeBreak;
	logic [3:0] empty_position,control;
	logic [4:0] counter;
	logic [2:0] shuffle_index;
	logic [7:0] outCode;	
	
	assign reset = SW[9];
	
	// keyboard pressing driver
	keyboard_press_driver press
		(.CLOCK_50
		,.valid
		,.makeBreak
		,.outCode
		,.PS2_DAT
		,.PS2_CLK
		,.reset
		);
	
	logic [7:0] up, down, left, right;
	logic [3:0] raw;
	
	assign up = 8'h75;
	assign down = 8'h72;
	assign left = 8'h6B;
	assign right = 8'h74;
	
	// get the raw singal, it is high when the given input key is pressing
	always_ff @(posedge CLOCK_50)
		begin 
			if (makeBreak == 1'b1 && outCode == up) raw[0] <= 1;
			else raw[0] <= 0;
			
			if (makeBreak == 1'b1 && outCode == down) raw[1] <= 1;
			else raw[1] <= 0;
			
			if (makeBreak == 1'b1 && outCode == left) raw[2] <= 1;
			else raw[2] <= 0;
			
			if (makeBreak == 1'b1 && outCode == right) raw[3] <= 1;
			else raw[3] <= 0;
		end
		
	assign clk = CLOCK_50;
	
	//control
	controlSignal pressUp		(clk, reset, raw[0], control[3]);
	controlSignal pressDown		(clk, reset, raw[1], control[2]);
	controlSignal pressLeft 	(clk, reset, raw[2], control[1]);
	controlSignal pressRight	(clk, reset, raw[3], control[0]);
	
	assign shuffle_index = SW[2:0];

	drawPuzzle init_puzzle(clk,reset,shuffle_index, control, x,y, drawPuzzle_done, empty_position,color,counter);
	
	// assign the VGA color
	always_comb begin
		if(color)
			pixel_color = 1'b1;
		else 
			pixel_color = 1'b0;
	end
	logic [3:0] tenDigit, oneDigit;
	assign tenDigit = counter/16;
	assign oneDigit = counter%16;
	
	// display the counter on the hes display.
	seg7 ten(tenDigit, HEX1);
	seg7 one(oneDigit, HEX0);
	
endmodule


	

