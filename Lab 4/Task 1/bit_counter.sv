// EE 371 Lab 4 Task 1
// Tianning Li

// This is the bit_counter module. It will take the value A, clk, reset as input and 
// output the result and done. This module use a controller and datapath module.
module bit_counter(clk, reset, start, A, result, done);
	input logic [7:0] A;
	input logic clk, reset, start;
	output logic [3:0] result;
	output logic done;
	
	logic [7:0] A_cur;
	logic clr_result, init_A, rshift, incre_result;
	
	// controller module and datapath module
	controller c(clk, reset, start, A_cur, clr_result, init_A, rshift, incre_result, done);
	datapath d(clk,clr_result, init_A, rshift, incre_result, A, A_cur, result);
endmodule

// This is the controller module. It will take clk, reset, start, current A value as input 
// and output control signal clr_result, init_A, rshift, incre_result and done for the 
// datapath module
module controller(clk, reset, start, A_cur, clr_result, init_A, rshift, incre_result, done);
	input logic clk, reset, start;
	input logic [7:0] A_cur;
	output logic clr_result, init_A, rshift, incre_result, done;
	
	enum {s1, s2, s3} ps,ns;
	
	// For positive clk edge, update the current
	// to the next state unless reset is on, go to
	// state one.
	always_ff @(posedge clk) begin
		if(reset)
			ps<=s1;
		else
			ps<=ns;
	end
	
	// Set next state according to the input
	// or the current A value
	always_comb begin
		case (ps)
			s1: if(start) 		ns = s2;
				 else 	  		ns = s1;
			s2: if(A_cur ==0) ns = s3;
				 else 			ns = s2;
			s3: if(start)		ns = s3;
				 else 			ns = s1;
		endcase
	end
	
	// Assign the output according to the current state,
	// next state and the current A value.
	assign clr_result = (ps == s1);
	assign init_A = (ps == s1) & (ns == s1) & (~start);
	assign rshift = (ps == s2);
	assign incre_result = (ps == s2) & (ns == s2) & (A_cur[0] == 1);
	assign done = (ps == s3);
	
endmodule

// This is the datapath module. It will take clk, control signal clr_result, init_A, 
// rshift, incre_result and A as input and output current A and result of counting.
module datapath(clk,clr_result, init_A, rshift, incre_result, A, A_cur, result);
	input logic clk;
	input logic clr_result, init_A, rshift, incre_result;
	input logic [7:0] A;
	output logic [7:0] A_cur;
	output logic [3:0] result;
	
	always_ff @(posedge clk) begin
      if (clr_result)
			result <= 4'b0;
		if (init_A)
			A_cur <= A;
		if(rshift)
			A_cur <= (A_cur >> 1);
		if(incre_result)
			result <= result+ 4'b1;
	end
endmodule

// Testbench for the bit_counter module
module bit_counter_testbench();
	logic [7:0] A;
	logic clk, reset, start;
	logic [3:0] result;
	logic done;
	
	bit_counter dut(.clk, .reset, .start, .A, .result, .done);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	integer i;
	initial begin
		reset<=1;										@(posedge clk);
		reset<=0; start<=0; A <=8'b10101010;	@(posedge clk);
		start<=1;										@(posedge clk);
		for (i = 0; i <10;i++) 						@(posedge clk);
		reset<=1;										@(posedge clk);
		reset<=0;start<=0; A <=8'b10110010;		@(posedge clk);
		start<=1;										@(posedge clk);
		for (i = 0; i <10;i++) 						@(posedge clk);
	$stop();
	end
endmodule
	