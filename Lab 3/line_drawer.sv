// EE 371 Lab 3
// Tianning Li

// This module use Bresenham’s line algorithm to determine the points to draw
// It will take clk, reset and starting point and ending point as input. It will
// output the x ,y coordinate of the point to draw.
module line_drawer (
	input logic clk, reset,
   input logic [10:0]	x0, y0, x1, y1, //the end points of the line
   output logic [10:0]	x, y //outputs corresponding to the pair (x, y)
   );

   logic signed [10:0] error;

   logic is_steep;
   logic [10:0] abs_y, abs_x;
   dif absolutey(abs_y, y1, y0);
   dif absolutex(abs_x, x1, x0);
   assign is_steep = (abs_y > abs_x);

   logic [10:0] x0_mid, y0_mid, x1_mid, y1_mid;
	// if it is steep swap x, y coordinates.
	always_comb begin
		if(is_steep) begin
			// swap x0,y0
			y0_mid = x0;
			x0_mid = y0;
			// swap x1, y1
			x1_mid = y1;
			y1_mid = x1;
		end else begin
			// not swap
			x0_mid = x0;
			x1_mid = x1;
			y0_mid = y0;
			y1_mid = y1;
		end
	end

   logic [10:0] x0_new, y0_new, x1_new, y1_new;
	// make x0 smaller than x1
	always_comb begin
		if(x0_mid > x1_mid) begin
			// swap x0, x1
			x0_new = x1_mid;
			x1_new = x0_mid;
			// swap y0, y1
			y0_new = y1_mid;
			y1_new = y0_mid;
		end else begin
			// not swap
			x0_new = x0_mid;
			x1_new = x1_mid;
			y0_new = y0_mid;
			y1_new = y1_mid;
		end
	end

 	logic signed [10:0] dx, dy;
	assign dx = x1_new-x0_new;
	dif absoluteY(dy, y1_new, y0_new);

  	logic signed [10:0] y_step;
	// get y_step
	always_comb begin
		if (y0_new< y1_new)
			y_step = 1;
		else 
			y_step = -1;
	end

	logic signed [10:0] x_p, y_p;
	logic pre_reset;
	
	// main part of line-drawing algorithm
	always_ff @(posedge clk) begin
		// when reset, set x,y,error to 0
		if(reset) begin
			x <= 11'b0;
			y <= 11'b0;
			error <= 11'b0;
			pre_reset = 1;
		end else begin
			// draw the first point
			if (pre_reset == 1) begin
				x_p <= x0_new;
				y_p <= y0_new;
				error <= -(dx) / 2;
				pre_reset <= 0;
			// draw the remaining point
			end else if (x_p <= x1_new) begin
	         if (is_steep) begin
					x <= y_p;
	            y <= x_p;
	         end else begin
	            x <= x_p;
	            y <= y_p;
	         end
	         if ((error + dy) >= 1) begin
	            y_p <= y_p + y_step;
	            error <= error + dy - dx;
	         end else begin
	            y_p <= y_p;
	            error <= error + dy;
	         end
	         x_p <= x_p + 1;
			end
		end
	end
endmodule

// This module will output the difference between a and b
module dif(out, a,b);
	output logic [10:0] out;
	input logic [10:0] a,b;

	always_comb begin
		if (a > b)
			out = a-b;
		else
			out = b-a;
	end
endmodule

// The testbench for the line_drawer module
module line_drawer_testbench ();
   logic clk, reset;
   logic [10:0]	x0, y0, x1, y1;
   logic [10:0]	x, y;

   line_drawer dut (.clk, .reset, .x0, .y0, .x1, .y1, .x, .y);

   parameter CLOCK_PERIOD = 100;
   initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

   integer i;
   initial begin
		reset <= 1;																	   	@(posedge clk);
		reset <= 0; x0 <= 11'd3; y0 <= 11'd2; x1 <= 11'd7; y1 <= 11'd2;  	@(posedge clk); // draw horizontal line
		for (i = 0; i < 6; i++)													   	@(posedge clk);
		reset <= 1;  																		@(posedge clk);
		reset <= 0; x0 <= 11'd3; y0 <= 11'd2; x1 <= 11'd3; y1 <= 11'd6;  	@(posedge clk); // draw vertical line
		for (i = 0; i < 6; i++)													   	@(posedge clk);
		reset <= 1;  																		@(posedge clk);
		reset <= 0; x0 <= 11'd1; y0 <= 11'd1; x1 <= 11'd5; y1 <= 11'd5;	@(posedge clk); // draw diagonal line
		for (i = 0; i < 6; i++)													   	@(posedge clk);
		reset <= 1; 																		@(posedge clk);
		reset <= 0; x0 <= 11'd1; y0 <= 11'd1; x1 <= 11'd12; y1 <= 11'd5;	@(posedge clk); // draw spec line 
		for (i = 0; i < 15; i++)													   @(posedge clk);
		
		$stop();
	end
endmodule