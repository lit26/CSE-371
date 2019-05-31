// EE 371 Lab 1
// Tianning Li

// Check whether a car is entering or exiting the parking lot, or a pedestrian is passing through
// enter: a block, ab block, b block
// exit: b block, abock
// pedestrian passing: a block or b block
// inputs: clk, reset, a, b
// outputs: enter, exit
module check(enter, exit, clk, reset, a, b);
	output logic enter, exit;
	input logic clk, reset, a, b;
	//N: none blocking, A:a blocking, B:b blocking, AB: a b blocking
	enum {N, A, AB, B} ps, ns;

	always_comb begin
		case (ps)
      N:  if (a)        ns = A;
          else if (b)   ns = B;
          else          ns = N;
		// A is blocking
		// check when B is blocking, next state AB is blocking
		// when A is not blocking, pedestrian passing, next state is no blocking
      A:  if (b)        ns = AB;
          else if (~a)  ns = N;
          else          ns = A;
		// B is blocking
		// check when A is blocking, next state AB is blocking
		// when B is not blocking, pedestrian passing, next state is no blocking
      B:  if (a)        ns = AB;
          else if (~b)  ns = N;
          else          ns = B;
		// AB is blocking
		// check when A is not blocking, the car is entering, next state B is blocking
		// check when B is not blocking, the car is exiting, next state A is blocking
		AB: if (~a)       ns = B;
          else if (~b)  ns = A;
          else          ns = AB;
		endcase
	end
	
	// when present is A blocking and next is both blocking, we can say the car is entering
	// when present is B blocking and next is both blocking, we can say the car is exiting
	assign enter = (ps == A) & (ns == AB);
	assign exit = (ps == B) & (ns == AB);
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= A;
		else
			ps <= ns;
	end
endmodule

module check_testbench ();
	logic enter, exit;
	logic clk, reset, a, b;

	check dut (.enter, .exit, .clk, .reset, .a, .b);

	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	initial begin
		reset <= 1;			@(posedge clk);
		reset <= 0;       @(posedge clk);
		// entering
		a <= 0; b <= 0;   @(posedge clk);
		a <= 1;           @(posedge clk);
              b <= 1;   @(posedge clk);
		a <= 0;           @(posedge clk);
              b <= 0;   @(posedge clk); 
		// exiting
              b <= 1;   @(posedge clk);
		a <= 1;           @(posedge clk);
              b <= 0;   @(posedge clk);
		a <= 0;           @(posedge clk); 
								@(posedge clk);
		// pedestrian passing
		a <= 1;				@(posedge clk); 
								@(posedge clk);
		a <= 0; b <= 1;	@(posedge clk); 
								@(posedge clk);
		$stop();
	end
endmodule