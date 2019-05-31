// EE 371 project
// Tianning Li, Mingcun Fan

// This module will draw one square with the numbers base on the index and value.
// output x, y and whether the drawing is done.
module drawSquare(clk, reset, index,start, clear,value,x,y,draw_done);
	input logic clk, reset,start, clear;
	input logic [3:0] index,value;
	output logic [10:0]x,y;
	output logic draw_done;
	
	parameter width = 11'd100, margin_width = 11'd3,
				 init_x = 11'd100, init_y = 11'd30;
	
	logic [3:0]row, col;
	
	assign row = index/4;
	assign col = index%4;
	
	// assign the starting point for the drawing square.
	logic [10:0]start_x, start_y;
	assign start_x = init_x+col*(width+margin_width);
	assign start_y = init_y+row*(width+margin_width);
	
	logic [10:0]x0,y0,x1,y1,x_pre,y_pre, x_lines, y_lines, x_numbers, y_numbers;
	logic done,linereset,linereset_n, linereset_l,done_pre, done_lines, done_numbers;
	
	line_drawer lines (.clk, .reset(linereset_l),
				.x0, .y0, .x1, .y1, .x(x_pre), .y(y_pre),.done(done_pre));
	drawNumber numbers(.clk,.reset, .start(linereset_n), .start_x, 
				.start_y, .value, .x(x_numbers), .y(y_numbers), .number_done(done_numbers));
	delay delay3Cycle(clk,x_pre,y_pre,done_pre,x_lines,y_lines,done_lines);

	// mux choose line or number
	logic line_drawing;
	always_comb begin
		if(line_drawing) begin
			x = x_lines;
			y = y_lines;
			done = done_lines;
			linereset_l = linereset;
			linereset_n = 0;
		end else begin
			x = x_numbers;
			y = y_numbers;
			done = done_numbers;
			linereset_l = 0;
			linereset_n = linereset;
		end
	end
	
	enum {s0,s1,s2,s3,s4,s5,s6}ps, ns;
	
	// states for drawing squares and the numbers.
	always_comb begin
		ns=s0;x0=0;y0=0;x1=0;y1=0;line_drawing = 1;
		case(ps)
			s0: if (start) begin 
					ns=s1;x0=0;y0=0;x1=0;y1=0;
				 end else begin 
					ns=s0;x0=0;y0=0;x1=0;y1=0;
				 end					
			s1: if (done) begin 
					ns = s2;x0=start_x;y0=start_y;x1=start_x+width;y1 = start_y;
				 end else begin 
					ns = s1;x0=start_x;y0=start_y;x1=start_x+width;y1 = start_y;
				 end								 
			s2: if (done) begin 
					ns = s3;x0=start_x;y0=start_y;x1=start_x;y1 = start_y+width;
				 end else begin 
					ns = s2;x0=start_x;y0=start_y;x1=start_x;y1 = start_y+width;
				 end
				 
			s3: if (done) begin ns = s4;x0=start_x+width;y0=start_y;x1=start_x+width;y1 = start_y+width;end
				 else begin ns = s3;x0=start_x+width;y0=start_y;x1=start_x+width;y1 = start_y+width;end
				 
			s4: if (done) begin 
					ns = s5;x0=start_x+width;y0=start_y;x1=start_x+width;y1 = start_y+width;
				end else begin 
					ns = s4;x0=start_x;y0=start_y+width;x1=start_x+width;y1 = start_y+width;					
				end					
				 
			s5: if(done) begin ns = s0;line_drawing = 0;end 
				else begin ns = s5;line_drawing = 0;end 
			
		endcase		
	end
	
	// signals for when the drawing is started
	always_ff @(posedge clk) begin
		if(reset)
			ps <=s0;
      else 
			ps<=ns;
			if(start|(done &&(ps !=s0)))
				linereset<=1;
			else
				linereset<=0;
	end
	
	assign draw_done = (ps ==s5)&&(ns ==s0) ;
endmodule

// Testing module for drawSquare module.
module drawSquare_testbench();
    logic clk, reset,start;
    logic [3:0] index,value;
    logic [10:0]	x, y;
	logic draw_done;

    drawSquare dut (.clk, .reset, .index, .start,.value,.x,.y,.draw_done);

    parameter CLOCK_PERIOD = 100;
    initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

    integer i;
    initial begin
		reset <= 1;						@(posedge clk);
		reset <= 0; index <= 4'd0;start <= 1;value =4'd8;	@(posedge clk);
		start <= 0;@(posedge clk);
		for (i=0;i<1000;i++)			@(posedge clk);
		
		
		$stop();
	end
endmodule
			
					
	                 
	