// EE 371 Lab 3
// Tianning Li

// This module controls the line move using finite state machine. It will take clk, 
// reset, move, clear, blackOut and starting point and ending point as input. 
// It will output the x ,y, coordinate of the point to draw and the starting point.
module line_move(x,y, x0, y0, clk, reset,move,clear,blackOut);
	output logic [10:0] x,y, x0, y0;
	logic [10:0] x1, y1;
	input logic clk, reset,move,clear,blackOut;
	logic linereset;

	// draw the line using the algorithm
	line_drawer lines (.clk, .reset(linereset),
				.x0, .y0, .x1, .y1, .x, .y);
	enum {NA, A1, B1, C1, D1, E1, F1, G1, H1, I1, J1, K1, L1, M1, N1, O1} ps, ns;
	
	// update the line according to the case, it will draw different according to the inputs.
	always_comb begin
		case(ps)
			NA: if (move) begin ns = A1; x0 = 11'd000; y0 = 11'd000; x1 = 11'd000; y1 = 11'd000;
				 end else begin ns = NA; x0 = 11'd000; y0 = 11'd000; x1 = 11'd000; y1 = 11'd000; end
			A1: if (move) begin ns = B1; x0 = 11'd100; y0 = 11'd010; x1 = 11'd100; y1 = 11'd100;
				 end else begin ns = A1; x0 = 11'd100; y0 = 11'd010; x1 = 11'd100; y1 = 11'd100; end
			B1: if (move) begin ns = C1; x0 = 11'd110; y0 = 11'd010; x1 = 11'd100; y1 = 11'd100;
				 end else begin ns = B1; x0 = 11'd110; y0 = 11'd010; x1 = 11'd100; y1 = 11'd100; end
			C1: if (move) begin ns = D1; x0 = 11'd120; y0 = 11'd020; x1 = 11'd100; y1 = 11'd100;
				 end else begin ns = C1; x0 = 11'd120; y0 = 11'd020; x1 = 11'd100; y1 = 11'd100; end
			D1: if (move) begin ns = E1; x0 = 11'd130; y0 = 11'd020; x1 = 11'd100; y1 = 11'd100;
				 end else begin ns = D1; x0 = 11'd130; y0 = 11'd020; x1 = 11'd100; y1 = 11'd100; end
			E1: if (move) begin ns = F1; x0 = 11'd140; y0 = 11'd020; x1 = 11'd100; y1 = 11'd100;
				 end else begin ns = E1; x0 = 11'd140; y0 = 11'd020; x1 = 11'd100; y1 = 11'd100; end
			F1: if (move) begin ns = G1; x0 = 11'd150; y0 = 11'd030; x1 = 11'd100; y1 = 11'd100;
				 end else begin ns = F1; x0 = 11'd150; y0 = 11'd030; x1 = 11'd100; y1 = 11'd100; end
			G1: if (move) begin ns = H1; x0 = 11'd160; y0 = 11'd030; x1 = 11'd100; y1 = 11'd100;
				 end else begin ns = G1; x0 = 11'd160; y0 = 11'd030; x1 = 11'd100; y1 = 11'd100; end
			H1: if (move) begin ns = I1; x0 = 11'd160; y0 = 11'd040; x1 = 11'd100; y1 = 11'd100;
				 end else begin ns = H1; x0 = 11'd160; y0 = 11'd040; x1 = 11'd100; y1 = 11'd100; end
			I1: if (move) begin ns = J1; x0 = 11'd170; y0 = 11'd040; x1 = 11'd100; y1 = 11'd100;
				 end else begin ns = I1; x0 = 11'd170; y0 = 11'd040; x1 = 11'd100; y1 = 11'd100; end
			J1: if (move) begin ns = K1; x0 = 11'd170; y0 = 11'd050; x1 = 11'd100; y1 = 11'd100;
				 end else begin ns = J1; x0 = 11'd170; y0 = 11'd050; x1 = 11'd100; y1 = 11'd100; end
			K1: if (move) begin ns = L1; x0 = 11'd180; y0 = 11'd060; x1 = 11'd100; y1 = 11'd100;
				 end else begin ns = K1; x0 = 11'd180; y0 = 11'd060; x1 = 11'd100; y1 = 11'd100; end
			L1: if (move) begin ns = M1; x0 = 11'd180; y0 = 11'd070; x1 = 11'd100; y1 = 11'd100;
				 end else begin ns = L1; x0 = 11'd180; y0 = 11'd070; x1 = 11'd100; y1 = 11'd100; end
			M1: if (move) begin ns = N1; x0 = 11'd180; y0 = 11'd080; x1 = 11'd100; y1 = 11'd100;
				 end else begin ns = M1; x0 = 11'd180; y0 = 11'd080; x1 = 11'd100; y1 = 11'd100; end
			N1: if (move) begin ns = O1; x0 = 11'd190; y0 = 11'd090; x1 = 11'd100; y1 = 11'd100;
				 end else begin ns = N1; x0 = 11'd190; y0 = 11'd090; x1 = 11'd100; y1 = 11'd100; end
			O1: if (move) begin ns = A1; x0 = 11'd190; y0 = 11'd100; x1 = 11'd100; y1 = 11'd100;
				 end else begin ns = O1; x0 = 11'd190; y0 = 11'd100; x1 = 11'd100; y1 = 11'd100; end
		endcase
	end
	
	// update the current state
	// if move or clear is true, set linereset to 1
	always_ff @(posedge clk) begin
	   if(reset) 
			ps<=ps;
		// clear the screen by drawing black on every pixel
		// on the same line. 
		else if (blackOut) begin 
			ps<=ps;
			if(move|clear)
				linereset<=1;
			else
				linereset<=0;
		// update the current state to the next state. 
		end else begin
			ps<=ns;
			if(move|clear)
				linereset<=1;
			else
				linereset<=0;
		end
	end
endmodule

// Testbench for the line_move module
module line_move_testbench();
	logic [10:0] x,y,x0,y0;
	logic clk, reset;
	logic move,clear,blackOut;
	
	line_move dut (.x, .y, .x0, .y0, .clk, .reset,.move,.clear,.blackOut);

	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	integer i;
	integer j;
	initial begin
		reset<=1;						@(posedge clk);
		for (j = 0; j <15;j++) 		@(posedge clk);  
		reset<=0;						@(posedge clk);
		for (i = 0; i <18;i++) begin					// draw a loop of all the lines.
			move<=1;						@(posedge clk);
			move<=0;						@(posedge clk);
			for (j = 0; j <30;j++) 	@(posedge clk);    // draw and clear the whole line.
			clear<=1;					@(posedge clk);
			clear <=0;					@(posedge clk);
			for (j = 0; j <12;j++) 	@(posedge clk);
		end
		$stop();
	end
endmodule