// EE 371 Lab 1
// Tianning Li

// This module will update the counter according to the input
// Input inc will increment the counter and dec will decrement
// the counter.
// inputs: clk, reset, inc, dec
// outputs: counter
module counter (counter, clk, reset, inc, dec);
	output logic [4:0] counter;
	input logic clk, reset, inc, dec;
	
	// increment or decrement the counter
	always_ff @(posedge clk) begin
		if(reset)
			counter <=5'b00000;
      else if(inc) begin
			if(counter < 5'b11001)
				counter <=counter+5'b00001;	
		end
		else if(dec) begin
			if(counter > 5'b00000)
				counter <= counter-5'b00001;
		end
	 end 				
endmodule

// test module for counter
module counter_testbench();
	logic [4:0] counter;
	logic clk, reset, inc, dec;
	
	counter dut(.counter, .clk, .reset, .inc, .dec);
	
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	integer i;
	initial begin 
      reset <= 1;				@(posedge clk);
		reset <= 0;       	@(posedge clk);
		dec <= 1;				@(posedge clk); //testing dec when counter = 0
		dec <= 0; inc <= 1;	@(posedge clk);
		for(i = 0; i < 25; i++) begin
									@(posedge clk); //testing inc from 0-25
		end
									@(posedge clk); //testing inc when counter = 25
		dec <= 1; inc <= 0;	@(posedge clk); //testing dec at 25
									@(posedge clk);
		$stop; // End the simulation.
	end
endmodule 