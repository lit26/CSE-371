// EE 371 Lab 3
// Tianning Li

// This module will count the cycle and determine the move and clear signal
// It will take clk and reset as input. It will output move, clear and counter
// to the main module.
module counter(counter, move, clear, clk, reset);
	output logic [6:0] counter;
	output logic move, clear;
	input logic clk, reset;
	
	// when the counter is 127, set move to 1 otherwise
	// set move to 0
	always_comb begin
		if((counter%7'd127==0 && (counter !=7'b0)))
			move = 1;
		else 
			move = 0;
	end
	
	// when the counter is 63, set clear to 1 otherwise
	// set clear to 0
	always_comb begin
		if((counter%7'd63==0) && (counter !=7'b0))
			clear = 1;
		else 
			clear = 0;
	end
	
	// increment the counter per cycle set the 
	// counter to 0 when reset or the next counter is 128
	always_ff @(posedge clk) begin
		if(reset|(counter ==7'b1111111))
			counter <=7'b0000000;
      else if (counter<7'b1111111)
			counter <=counter+7'b0000001;
	 end
endmodule

// Testbench for the counter module
module counter_testbench();
	logic [6:0] counter;
	logic move, clear,clk, reset;
	
	counter count(.counter, .move, .clear, .clk, .reset);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	integer i;
	initial begin
		reset<=1;						@(posedge clk);
		reset<=0;						@(posedge clk);
		for (i = 0; i <1000;i++) 	@(posedge clk);
	$stop();
	end
endmodule