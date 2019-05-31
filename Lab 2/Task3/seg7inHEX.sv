// EE 371 Lab 2 Task4
// Tianning Li

// This module will display the hex value and return the two 7 bit
// value for HEX display. The inputs are the hex value and the
// output value are the two 7 bit value.
module seg7inHEX (bcd, led1,led0);
	input logic [4:0] bcd;
	output logic [6:0] led1,led0;

	always_comb begin
		case (bcd)
			// Light:          6543210
			5'd0: begin led1 = 7'b1000000;led0 = 7'b1000000; end// 0
			5'd1: begin led1 = 7'b1000000;led0 = 7'b1111001; end// 1
			5'd2: begin led1 = 7'b1000000;led0 = 7'b0100100; end// 2
			5'd3: begin led1 = 7'b1000000;led0 = 7'b0110000; end// 3
			5'd4: begin led1 = 7'b1000000;led0 = 7'b0011001; end// 4
			5'd5: begin led1 = 7'b1000000;led0 = 7'b0010010; end// 5
			5'd6: begin led1 = 7'b1000000;led0 = 7'b0000010; end// 6
			5'd7: begin led1 = 7'b1000000;led0 = 7'b1111000; end// 7
			5'd8: begin led1 = 7'b1000000;led0 = 7'b0000000; end// 8
			5'd9: begin led1 = 7'b1000000;led0 = 7'b0010000; end// 9
			5'd10: begin led1 = 7'b1000000;led0 = 7'b0001000; end// A
			5'd11: begin led1 = 7'b1000000;led0 = 7'b0000011; end// B
			5'd12: begin led1 = 7'b1000000;led0 = 7'b1000110; end// C
			5'd13: begin led1 = 7'b1000000;led0 = 7'b0100001; end// D
			5'd14: begin led1 = 7'b1000000;led0 = 7'b0000110; end// E
			5'd15: begin led1 = 7'b1000000;led0 = 7'b0001110; end// F
			5'd16: begin led1 = 7'b1111001;led0 = 7'b1000000; end// 10
			5'd17: begin led1 = 7'b1111001;led0 = 7'b1111001; end// 11
			5'd18: begin led1 = 7'b1111001;led0 = 7'b0100100; end// 12
			5'd19: begin led1 = 7'b1111001;led0 = 7'b0110000; end// 13
			5'd20: begin led1 = 7'b1111001;led0 = 7'b0011001; end// 14
			5'd21: begin led1 = 7'b1111001;led0 = 7'b0010010; end// 15
			5'd22: begin led1 = 7'b1111001;led0 = 7'b0000010; end// 16
			5'd23: begin led1 = 7'b1111001;led0 = 7'b1111000; end// 17
			5'd24: begin led1 = 7'b1111001;led0 = 7'b0000000; end// 18
			5'd25: begin led1 = 7'b1111001;led0 = 7'b0010000; end// 19
			5'd26: begin led1 = 7'b1111001;led0 = 7'b0001000; end// 1A
			5'd27: begin led1 = 7'b1111001;led0 = 7'b0000011; end// 1B
			5'd28: begin led1 = 7'b1111001;led0 = 7'b1000110; end// 1C
			5'd29: begin led1 = 7'b1111001;led0 = 7'b0100001; end// 1D
			5'd30: begin led1 = 7'b1111001;led0 = 7'b0000110; end// 1E
			5'd31: begin led1 = 7'b1111001;led0 = 7'b0001110; end// 1F
			default: begin led1 = 7'bX;led0 = 7'bx;end
		endcase
	end
endmodule

// Testbench for the display module
module seg7inHEX_testbench(); 
	logic [4:0] bcd;
	logic [6:0] led1,led0;
	
	seg7inHEX dut(.bcd, .led1,.led0);
	// Try all combinations of inputs.   
	integer i;   
	initial begin      
		for(i = 0; i <32; i++) begin     
			bcd[4:0] = i; #10;    
		end   
	end  
endmodule