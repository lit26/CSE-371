// EE 371 Lab 1
// Tianning Li

// This module will perform HEX display according to the counter
// inputs: counter
// outputs: HEX5-HEX0
module display (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, counter);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	input logic[4:0] counter;
	
	// It will choose the LED of the HEX display according to the counter
	always_comb begin
		case (counter)
			5'b00000: begin HEX0 = 7'b1000000; HEX1 = 7'b0101111; HEX2 = 7'b0001000; HEX3 = 7'b0000110; HEX4 = 7'b1000111;HEX5 = 7'b1000110; end// CLEAR
			5'b00001: begin HEX0 = 7'b1111001; HEX1 = 7'b1111111; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111;HEX5 = 7'b1111111; end// 1
			5'b00010: begin HEX0 = 7'b0100100; HEX1 = 7'b1111111; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111;HEX5 = 7'b1111111; end// 2
			5'b00011: begin HEX0 = 7'b0110000; HEX1 = 7'b1111111; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111;HEX5 = 7'b1111111; end// 3
			5'b00100: begin HEX0 = 7'b0011001; HEX1 = 7'b1111111; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111;HEX5 = 7'b1111111; end// 4
			5'b00101: begin HEX0 = 7'b0010010; HEX1 = 7'b1111111; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111;HEX5 = 7'b1111111; end// 5
			5'b00110: begin HEX0 = 7'b0000010; HEX1 = 7'b1111111; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111;HEX5 = 7'b1111111; end// 6
			5'b00111: begin HEX0 = 7'b1111000; HEX1 = 7'b1111111; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111;HEX5 = 7'b1111111; end// 7
			5'b01000: begin HEX0 = 7'b0000000; HEX1 = 7'b1111111; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111;HEX5 = 7'b1111111; end// 8
			5'b01001: begin HEX0 = 7'b0010000; HEX1 = 7'b1111111; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111;HEX5 = 7'b1111111; end// 9
			5'b01010: begin HEX0 = 7'b1000000; HEX1 = 7'b1111001; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111;HEX5 = 7'b1111111; end// 10
			5'b01011: begin HEX0 = 7'b1111001; HEX1 = 7'b1111001; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111;HEX5 = 7'b1111111; end// 11
			5'b01100: begin HEX0 = 7'b0100100; HEX1 = 7'b1111001; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111;HEX5 = 7'b1111111; end// 12
			5'b01101: begin HEX0 = 7'b0110000; HEX1 = 7'b1111001; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111;HEX5 = 7'b1111111; end// 13
			5'b01110: begin HEX0 = 7'b0011001; HEX1 = 7'b1111001; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111;HEX5 = 7'b1111111; end// 14
			5'b01111: begin HEX0 = 7'b0010010; HEX1 = 7'b1111001; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111;HEX5 = 7'b1111111; end// 15
			5'b10000: begin HEX0 = 7'b0000010; HEX1 = 7'b1111001; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111;HEX5 = 7'b1111111; end// 16
			5'b10001: begin HEX0 = 7'b1111000; HEX1 = 7'b1111001; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111;HEX5 = 7'b1111111; end// 17
			5'b10010: begin HEX0 = 7'b0000000; HEX1 = 7'b1111001; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111;HEX5 = 7'b1111111; end// 18
			5'b10011: begin HEX0 = 7'b0010000; HEX1 = 7'b1111001; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111;HEX5 = 7'b1111111; end// 19
			5'b10100: begin HEX0 = 7'b1000000; HEX1 = 7'b0100100; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111;HEX5 = 7'b1111111; end// 20
			5'b10101: begin HEX0 = 7'b1111001; HEX1 = 7'b0100100; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111;HEX5 = 7'b1111111; end// 21
			5'b10110: begin HEX0 = 7'b0100100; HEX1 = 7'b0100100; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111;HEX5 = 7'b1111111; end// 22
			5'b10111: begin HEX0 = 7'b0110000; HEX1 = 7'b0100100; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111;HEX5 = 7'b1111111; end// 23
			5'b11000: begin HEX0 = 7'b0011001; HEX1 = 7'b0100100; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111;HEX5 = 7'b1111111; end// 24
			5'b11001: begin HEX0 = 7'b1111111; HEX1 = 7'b1111111; HEX2 = 7'b1000111; HEX3 = 7'b1000111; HEX4 = 7'b1000001;HEX5 = 7'b0001110; end// FULL 
			default: begin HEX0 = 7'bX; HEX1 = 7'bx; HEX2 = 7'bx; HEX3 = 7'bx; HEX4 = 7'bx; HEX5 = 7'bx;end
		endcase
	end
endmodule

// Testbench for the display module
module display_testbench(); 
	logic  [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic  [4:0] counter;    
	
	display dut (.HEX0, .HEX1, .HEX2, .HEX3,. HEX4, .HEX5, .counter);    
	// Try all combinations of inputs.   
	integer i;   
	initial begin      
		for(i = 1; i <=25; i++) begin     
			counter[4:0] = i; #10;    
		end   
	end  
endmodule