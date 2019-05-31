// EE 371 Lab 4 Task 2
// Tianning Li

// This is the bi_search module. It will take the target, clk, reset, start as input
// and output the address of the value and signal found and done. This module use a
// controller module and datapath module.
`timescale 1 ps/1 ps
module bi_search(target, clk, reset, start, addr, found, done);
	input logic [7:0] target;
	input logic clk, reset, start;
	output logic [4:0] addr;
	output logic found, done;
	logic [4:0]low, high, mid;
	logic [7:0] cur_data;
	logic init, setAddr, setLow, setHigh;
	
	ram32x8 RAM (mid, clk,0,0,cur_data);	
	controller c(clk,reset, start, low, high, target, cur_data,init, setAddr, setLow, setHigh, found, done);
	datapath d(clk,init, setAddr, setLow, setHigh, low, high, mid, addr);
endmodule

// This is the controller module. It will take clk, reset, start, low, high, target and current value as input 
// and output control signal init, setAddr, setLow, setHigh for the datapath module and output signal found 
// and done/  
module controller(clk,reset, start, low, high, target, cur_data,init, setAddr, setLow, setHigh, found, done);
	input logic clk, reset, start;
	input logic [4:0] low, high;
	input logic [7:0] target, cur_data;
	output logic init, setAddr, setLow, setHigh;
	output logic found, done;
	
	enum {s_idle,s1, s2, s3, s_wait} ps,ns;
	
	// For positive clk edge, update the current
	// to the next state unless reset is on, go to
	// state idle.
	always_ff @(posedge clk) begin
		if(reset)
			ps<=s_idle;
		else
			ps<=ns;
	end
	
	// Set next state according to the input
	// or the current value and position.
	always_comb begin
		case (ps)
			// idle state if start, start the algorithm
			// else stay in idle state.
			s_idle: if(start) 			ns = s2;  
					  else 	  				ns = s_idle;
			s1: if(cur_data == target) ns = s3;
				 else 						ns = s2;
			// if the low position is higher than the high
			// position. stop the algorith, else stay in algorithm.
			s2: if(low > high)  		ns = s3;
				 else 						ns = s_wait;
			// wait for the data load from ram
			s_wait: ns = s1;
			// done state.
			s3: if(start)					ns = s3;
				 else 						ns = s_idle;
		endcase
	end
	
	// Assign the output according to the current state,
	// next state and input signal.
	assign init = (ps == s_idle);
	assign setAddr = (ps ==s2);
	assign setLow = (ps == s2) & (cur_data < target);
	assign setHigh = (ps == s2) & (cur_data > target);
	assign found = (ps == s3) & (cur_data == target);
	assign done = (ps ==s3);
endmodule

// This is the datapath module. It will take clk,init, setAddr, setLow, setHigh as input 
// and output current low, high and middle and address.
module datapath(clk,init, setAddr, setLow, setHigh, low, high, mid, addr);
	input logic clk;
	input logic init, setAddr, setLow, setHigh; 
	output logic [4:0] low, high, mid, addr;
	
	assign mid = low+ (high-low)/2;
	always_ff @(posedge clk) begin
		if(init) begin
			low <= 5'd0;
			high <= 5'd31;
			addr <= 5'd0;
		end
		if(setAddr)
			addr<= mid;
		if(setLow)
			low <= mid+1;
		if(setHigh)
			high <= mid-1;
	end
endmodule

// Testbench for the binary search module
module bi_search_testbench();
	logic [7:0] target;
	logic clk, reset, start;
	logic [4:0] addr;
	logic found, done;
	
	bi_search dut(.target, .clk, .reset, .start, .addr, .found, .done);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	integer i;
	integer j;
	initial begin
	// Test finding all the values in ram
	for (j=0;j<32; j++) begin
		reset<=1;										@(posedge clk);
															@(posedge clk);
															@(posedge clk);
		reset<=0; start<=1; target<= j;			@(posedge clk);
		for (i=0;i<20;i++) 							@(posedge clk);
	end
	$stop();
	end
endmodule