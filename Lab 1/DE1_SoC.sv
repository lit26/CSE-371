// EE 371 Lab 1
// Tianning Li

// This module is the onboard module for the whole system.
// It is connecting counter, check and display module
// inputs: CLOCK_50, SW, KEY 
// outputs: HEX5-HEX0, GPIO_0
module DE1_SoC (CLOCK_50, KEY, SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, GPIO_0); 
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	inout logic[35:0] GPIO_0;
	input logic CLOCK_50;
	input logic [1:0] KEY;
	input logic [0:0] SW;
	logic[4:0] counter;
	logic enter, exit, a, b, clk, reset;
	
	// choose clock
	logic [31:0] clock;
	parameter whichClock = 15;
	clock_divider cdiv (CLOCK_50, clock);
	assign clk = clock[whichClock];
	
	// assign onboard key, switch  and GPIOs
	assign reset = SW[0];
	assign a = ~KEY[0];
	assign b = ~KEY[1];
	
	assign GPIO_0[0] = a;
	assign GPIO_0[1] = b;
	
	
	counter countern(.counter, .clk, .reset, .inc(enter), .dec(exit));
	check checkingStatus(enter, exit, clk, reset, a, b);
	display hexdisplay(HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, counter);
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

//ModelSim module for the whole system
/*module DE1_SoC (clk, KEY, SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,GPIO_0);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	input logic clk;
	input logic [1:0] KEY;
	input logic [0:0] SW;
	output logic[1:0] GPIO_0;
	logic[4:0] counter;
	logic enter, exit, a, b, reset;
	
	assign reset = SW[0];
	assign a = ~KEY[0];
	assign b = ~KEY[1];
	assign GPIO_0[0] = a;
	assign GPIO_0[1] = b;
	
	counter countern(.counter, .clk, .reset, .inc(enter), .dec(exit));
	check checkingStatus(enter, exit, clk, reset, a, b);
	display hexdisplay(HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, counter);
endmodule

module DE1_SoC_testbench(); 
	logic [1:0] GPIO_0;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [1:0] KEY;
	logic [0:0] SW;
	logic clk;
	
	DE1_SoC dut (.clk, .KEY, .SW, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .GPIO_0);

	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	integer i;
	initial begin
		SW[0] <= 1;  KEY[1:0]<=2'b11;	@(posedge clk);
		SW[0] <= 0;       				@(posedge clk);
		// entering
		KEY[0] <= 1; KEY[1] <= 1;   	@(posedge clk);
		KEY[0] <= 0;           			@(posedge clk);
						 KEY[1] <= 0;   	@(posedge clk);
		KEY[0] <= 1;           			@(posedge clk);
						 KEY[1] <= 1;   	@(posedge clk); 
		// exiting
						 KEY[1] <= 0;   	@(posedge clk);
		KEY[0] <= 0;           			@(posedge clk);
						 KEY[1] <= 1;   	@(posedge clk);
		KEY[0] <= 1;           			@(posedge clk); 
												@(posedge clk);
		// pedestrian passing
		KEY[0] <= 0;						@(posedge clk); 
												@(posedge clk);
		KEY[0] <= 1; KEY[1] <= 0;		@(posedge clk); 
												@(posedge clk);
		for(i = 0; i < 25; i++) begin
		// entering
			KEY[0] <= 1; KEY[1] <= 1;  @(posedge clk);
			KEY[0] <= 0;           		@(posedge clk);
							 KEY[1] <= 0;  @(posedge clk);
			KEY[0] <= 1;           		@(posedge clk);
							 KEY[1] <= 1;  @(posedge clk); 
		end
		
		$stop();
	end
endmodule*/