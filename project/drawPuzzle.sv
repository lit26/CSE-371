// EE 371 project
// Tianning Li, Mingcun Fan

// This module will draw the whole puzzle. It will clear the VGA when reset.
// It will assign the value into the ram and draw the whole puzzle. When move
// available, it will change the value in the ram, clear the old square and 
// draw the new square. It will output x, y and what color vga need to draw.
`timescale 1 ps / 1 ps
module drawPuzzle(clk,reset,shuffle_index, control, x,y, drawPuzzle_done, empty_position,color,counter);
	input logic clk, reset;
	input logic [3:0] control;
	input logic [2:0] shuffle_index;
	output logic [10:0] x,y;
	output logic drawPuzzle_done;
	output logic [3:0] empty_position;
	output logic color;
	output logic [4:0]counter;
	
	logic [3:0] index;
	logic start,done;
	logic [3:0]q,data;
	logic wren,start_pre;
	logic [4:0]address;
	logic [3:0] shuffle_data,moving_data, moving_data1,changingData;
	logic overwrite,clear;
	logic [4:0]shuffle_counter;
	
	//state: reset, write data to memory, draw Puzzle, move Puzzle
	enum {r, w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15,wa, d0, 
			d1, d2, d3, d4, d5, d6,d7,d8, d9, d10, d11, d12, d13, d14, d15,idle,c1,
			c2,c3,m1,m2,m3}ps, ns;
			
	//mux choose data
	always_comb begin
		if (ps ==m1 || ps ==m2)
			data = changingData;
		else if(!overwrite)
			data = shuffle_data;
		else
			data = moving_data;
	end
	
	logic [3:0] empty_po;
	shuffle getshuffleData(shuffle_index,address,shuffle_data, empty_po);
	
	logic [10:0] x_d, y_d, x_r, y_r;
	value_Position readWrite(address, clk, data, wren, q);
	drawSquare fifteenSq(clk, reset, index, start,clear,data, x_d, y_d, done);
	logic legal, clear_done,clear_all;
	logic [3:0] switchPosition,movingPosition, original_position;
	move checkMove(control, empty_position,switchPosition,legal);

	// mux for choose whether it is reset or drawing 
	always_comb begin
		if(clear_all) begin
			x = x_r;
			y = y_r;
		end else begin
			x = x_d;
			y = y_d;
		end
	end
	
	always_ff @(posedge clk) begin
		if(reset) begin
			clear_done<=0;
			x_r<=100;
			y_r<=30;
		end else if (x_r<510)begin 
			x_r<=x_r+1;
		end else if (x_r==510 && y_r<=440) begin
			y_r<=y_r+1;
			x_r<=100;
		end else
			clear_done<=1;;
	end 
	
	// states for reseting, clearing, drawing or moving. 
	always_comb begin
		// Defaults:
		ns=idle; 
		wren=0; 
		address=5'd0;
		index=4'd0; 
		overwrite=1;				
		start_pre=0;
		clear = 0;
		moving_data=q; 
		movingPosition=switchPosition; 
		clear_all = 0;
		case(ps)
			//clear
			r:if(clear_done) begin ns = w0;clear = 1;clear_all=1;end
				else begin ns = r;clear = 1;clear_all=1;end 
				
			// write to ram
			w0:begin ns=w1; wren=1;address=5'd0; overwrite = 0;end
			w1:begin ns=w2; wren=1; address=5'd1; overwrite = 0;end
			w2:begin ns=w3; wren=1; address=5'd2; overwrite = 0;end
			w3:begin ns=w4; wren=1; address=5'd3; overwrite = 0;end
			w4:begin ns=w5; wren=1; address=5'd4; overwrite = 0;end
			w5:begin ns=w6; wren=1; address=5'd5; overwrite = 0;end
			w6:begin ns=w7; wren=1; address=5'd6; overwrite = 0;end
			w7:begin ns=w8; wren=1; address=5'd7; overwrite = 0;end
			w8:begin ns=w9; wren=1; address=5'd8; overwrite = 0;end
			w9:begin ns=w10; wren=1; address=5'd9; overwrite = 0;end
			w10:begin ns=w11; wren=1; address=5'd10; overwrite = 0;end
			w11:begin ns=w12; wren=1; address=5'd11; overwrite = 0;end
			w12:begin ns=w13; wren=1; address=5'd12; overwrite = 0;end
			w13:begin ns=w14; wren=1; address=5'd13; overwrite = 0;end
			w14:begin ns=w15; wren=1; address=5'd14; overwrite = 0;end
			w15:begin ns=wa; wren=1; address=5'd15; overwrite = 0;end
			wa:begin ns=d0;wren=0;address=5'd0;start_pre=1; overwrite = 0;end
			
			// draw square
			d0:if(done) begin ns=d1; address=5'd0;index=4'd0; start_pre=1; overwrite = 0;end
			   else begin ns=d0; address=5'd0;index=4'd0; start_pre=0; overwrite = 0;end
			d1:if(done) begin ns=d2; address=5'd1;index=4'd1; start_pre=1; overwrite = 0;end
			   else begin ns=d1; address=5'd1;index=4'd1; start_pre=0; overwrite = 0;end
			d2:if(done) begin ns=d3; address=5'd2;index=4'd2; start_pre=1; overwrite = 0;end
			   else begin ns=d2; address=5'd2;index=4'd2; start_pre=0; overwrite = 0;end
			d3:if(done) begin ns=d4; address=5'd3;index=4'd3; start_pre=1; overwrite = 0;end
			   else begin ns=d3; address=5'd3;index=4'd3; start_pre=0; overwrite = 0;end
			d4:if(done) begin ns=d5; address=5'd4;index=4'd4; start_pre=1; overwrite = 0;end
			   else begin ns=d4; address=5'd4;index=4'd4; start_pre=0; overwrite = 0;end
			d5:if(done) begin ns=d6; address=5'd5;index=4'd5; start_pre=1; overwrite = 0;end
			   else begin ns=d5; address=5'd5;index=4'd5; start_pre=0; overwrite = 0;end
			d6:if(done) begin ns=d7; address=5'd6;index=4'd6; start_pre=1; overwrite = 0;end
			   else begin ns=d6; address=5'd6;index=4'd6; start_pre=0; overwrite = 0;end
			d7:if(done) begin ns=d8; address=5'd7;index=4'd7; start_pre=1; overwrite = 0;end
			   else begin ns=d7; address=5'd7;index=4'd7; start_pre=0; overwrite = 0;end
			d8:if(done) begin ns=d9; address=5'd8;index=4'd8; start_pre=1; overwrite = 0;end
			   else begin ns=d8; address=5'd8;index=4'd8; start_pre=0; overwrite = 0;end
			d9:if(done) begin ns=d10; address=5'd9;index=4'd9; start_pre=1; overwrite = 0;end
			   else begin ns=d9; address=5'd9;index=4'd9; start_pre=0; overwrite = 0;end
			d10:if(done) begin ns=d11; address=5'd10;index=4'd10; start_pre=1; overwrite = 0;end
			   else begin ns=d10; address=5'd10;index=4'd10; start_pre=0; overwrite = 0;end
			d11:if(done) begin ns=d12; address=5'd11;index=4'd11; start_pre=1; overwrite = 0;end
			   else begin ns=d11; address=5'd11;index=4'd11; start_pre=0; overwrite = 0;end
			d12:if(done) begin ns=d13; address=5'd12;index=4'd12; start_pre=1; overwrite = 0;end
			   else begin ns=d12; address=5'd12;index=4'd12; start_pre=0; overwrite = 0;end
			d13:if(done) begin ns=d14; address=5'd13;index=4'd13; start_pre=1; overwrite = 0;end
			   else begin ns=d13; address=5'd13;index=4'd13; start_pre=0; overwrite = 0;end
			d14:if(done) begin ns=d15; address=5'd14;index=4'd14; start_pre=1; overwrite = 0;end
			   else begin ns=d14; address=5'd14;index=4'd14; start_pre=0; overwrite = 0;end
			d15:if(done) begin ns=idle; address=5'd15;index=4'd15; start_pre=1; overwrite = 0;end
			   else begin ns=d15; address=5'd15;index=4'd15; start_pre=0; overwrite = 0;end
				
			idle:if(legal) begin 
					ns=c1; wren=1; address=switchPosition; overwrite=1;
					moving_data=q; movingPosition=switchPosition; clear = 0;
				end else begin 
					ns=idle; wren=0; address=5'd0;index=4'd0; overwrite=1;
					start_pre=0;clear = 0;
				end
			//move
			c1: begin ns = c2; wren=1;address=original_position;moving_data = moving_data1;overwrite = 1;end
			c2: begin ns = c3; wren=1;address=empty_position;moving_data=4'b0;start_pre=1;overwrite = 1;end 
			c3: ns = m1;
			m1: if(done) begin ns = m2;wren=0; address=empty_position;index=empty_position; start_pre=1;overwrite = 1; clear=1;end
				else begin ns = m1;wren=0; address=empty_position;index=empty_position; start_pre=0; overwrite = 0;clear=1;end
			m2: if(done) begin ns = m3;wren=0; address=empty_position;index=empty_position; start_pre=1;overwrite = 1; clear=1;end
				else begin ns = m2;wren=0; address=empty_position;index=empty_position; start_pre=0; overwrite = 0;clear=1;end
			m3: if(done) begin ns = idle;wren=0; address=original_position;index=original_position; start_pre=1; overwrite = 1;end
				else begin ns = m3;wren=0; address=original_position;index=original_position; start_pre=0; overwrite = 1;end		
		endcase
	end
	
	// delay the cycles for signal ready. 
	logic start_pre1;
	always_ff @(posedge clk) begin
		start_pre1<=start_pre;
		if(ps !=idle)
			start<=start_pre1;
			
		moving_data1<=moving_data;
	end
	logic [3:0] empty_position_pre;

	// change value when moving. 
	always_ff @(posedge clk) begin
		if(reset) begin
			ps<=r;
			counter<=4'b0;
		end else
			ps<=ns;
		if(ps ==w0)
			empty_position <=empty_po;
		if(ps ==c1)
			changingData<=data;
		if(overwrite && legal) begin
			
			if(control ==4'b1000) begin//up
				empty_position<= empty_position+4'd4;
				original_position <= empty_position;
			end else if (control ==4'b0100) begin //down
				empty_position<= empty_position-4'd4;
				original_position <= empty_position;
			end else if (control ==4'b0010) begin//left
				empty_position<= empty_position+4'd1;
				original_position <= empty_position;
			end else if (control ==4'b0001) begin//right
				empty_position<= empty_position-4'd1;
				original_position <= empty_position;
			end else 
				original_position <=empty_position;
		end
		if(legal)
			counter<=counter+4'd1;
	end
	
	assign drawPuzzle_done = (ps ==idle);
	assign color = !clear;
endmodule

//memory
module value_Position (address, clk, data, wren, q);
	input logic [4:0] address;
	input logic clk;
	input logic [3:0] data;
	input logic wren;
	output logic [3:0]q;
	logic [3:0] valueArray[15:0];
	always_ff @(posedge clk) begin
		if(wren)
			valueArray[address]= data;
	end
	assign q = valueArray[address];
endmodule
	
// Testing module for drawPuzzle module.
module drawPuzzle_testbench();
    logic clk, reset,shuffle;
	 logic [3:0] control;
	logic [10:0] x,y;
	logic drawPuzzle_done;
	logic [3:0] empty_position;
	logic value;
	logic [4:0]counter;
	logic [2:0] shuffle_index;
	

    drawPuzzle dut (.clk,.reset,.shuffle_index, .control, .x,.y, .drawPuzzle_done, .empty_position,.counter);

    parameter CLOCK_PERIOD = 100;
    initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

    integer i;
    initial begin
		reset <= 1;	shuffle_index<=0;	@(posedge clk);
		reset <= 0;						@(posedge clk);
		for (i=0;i<190000;i++)			@(posedge clk);
		control <=4'b0001;			@(posedge clk);
		control <=4'b0000;			@(posedge clk);
		for (i=0;i<2000;i++)			@(posedge clk);
		control <=4'b0010;			@(posedge clk);
		control <=4'b0000;			@(posedge clk);
		for (i=0;i<2000;i++)			@(posedge clk);
		/*control <=4'b0100;			@(posedge clk);
		control <=4'b0000;			@(posedge clk);
		for (i=0;i<1500;i++)			@(posedge clk);
		control <=4'b0001;			@(posedge clk);
		control <=4'b0000;			@(posedge clk);
		for (i=0;i<1500;i++)			@(posedge clk);*/
		$stop();
	end
endmodule