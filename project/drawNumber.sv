// EE 371 project
// Tianning Li, Mingcun Fan

// This module will draw the number according to the value and starting point.
// It will output x, y and whether the number is done drawing.
module drawNumber(clk, reset, start,  start_x, start_y,value,x,y,number_done);
	input logic clk, reset,start;
	input logic [3:0] value;
	input logic [10:0]start_x, start_y;
	output logic [10:0]x,y;
	output logic number_done;
	logic [10:0] x0,y0,x1,y1,x_pre,y_pre;
	logic done,done_pre, linereset;
	line_drawer lines (.clk, .reset(linereset),
				.x0, .y0, .x1, .y1, .x(x_pre), .y(y_pre), .done(done_pre));
	delay delay3_Cycle(clk,x_pre,y_pre,done_pre,x,y,done);


	/*	
		 1
		____
		|  | 2
	7	|  |
		---- 3
		|  |
	6	|  | 4
		----
		5
	*/

	logic [10:0] one_digit_x10, one_digit_x11, one_digit_y10, one_digit_y11, 
				 one_digit_x20, one_digit_x21, one_digit_y20, one_digit_y21,
				 one_digit_x30, one_digit_x31, one_digit_y30, one_digit_y31,
				 one_digit_x40, one_digit_x41, one_digit_y40, one_digit_y41,
				 one_digit_x50, one_digit_x51, one_digit_y50, one_digit_y51,
				 one_digit_x60, one_digit_x61, one_digit_y60, one_digit_y61,
				 one_digit_x70, one_digit_x71, one_digit_y70, one_digit_y71,
				 ten_digit_one_x10, ten_digit_one_x11, ten_digit_one_y10, ten_digit_one_y11,
				 two_digit_x10, two_digit_x11, two_digit_y10, two_digit_y11, 
				 two_digit_x20, two_digit_x21, two_digit_y20, two_digit_y21,
				 two_digit_x30, two_digit_x31, two_digit_y30, two_digit_y31,
				 two_digit_x40, two_digit_x41, two_digit_y40, two_digit_y41,
				 two_digit_x50, two_digit_x51, two_digit_y50, two_digit_y51,
				 two_digit_x60, two_digit_x61, two_digit_y60, two_digit_y61,
				 two_digit_x70, two_digit_x71, two_digit_y70, two_digit_y71;

	// For number of one digit
	assign one_digit_x10 = start_x+11'd40;
	assign one_digit_x11 = start_x+11'd60;
	assign one_digit_y10 = start_y+11'd20;
	assign one_digit_y11 = start_y+11'd20;

	assign one_digit_x20 = start_x+11'd60;
	assign one_digit_x21 = start_x+11'd60;
	assign one_digit_y20 = start_y+11'd20;
	assign one_digit_y21 = start_y+11'd50; 

	assign one_digit_x30 = start_x+11'd40;
	assign one_digit_x31 = start_x+11'd60;
	assign one_digit_y30 = start_y+11'd50;
	assign one_digit_y31 = start_y+11'd50;

	assign one_digit_x40 = start_x+11'd60;
	assign one_digit_x41 = start_x+11'd60;
	assign one_digit_y40 = start_y+11'd50;
	assign one_digit_y41 = start_y+11'd80; 

	assign one_digit_x50 = start_x+11'd40;
	assign one_digit_x51 = start_x+11'd60;
	assign one_digit_y50 = start_y+11'd80;
	assign one_digit_y51 = start_y+11'd80;

	assign one_digit_x60 = start_x+11'd40;
	assign one_digit_x61 = start_x+11'd40;
	assign one_digit_y60 = start_y+11'd50;
	assign one_digit_y61 = start_y+11'd80; 

	assign one_digit_x70 = start_x+11'd40;
	assign one_digit_x71 = start_x+11'd40;
	assign one_digit_y70 = start_y+11'd20;
	assign one_digit_y71 = start_y+11'd50;

	// For number of two digit
	assign ten_digit_one_x10 = start_x+11'd25;
	assign ten_digit_one_x11 = start_x+11'd25;
	assign ten_digit_one_y10 = start_y+11'd20;
	assign ten_digit_one_y11 = start_y+11'd80;

	parameter r_shift = 11'd10;
	assign two_digit_x10 = start_x+11'd40+r_shift;
	assign two_digit_x11 = start_x+11'd60+r_shift;
	assign two_digit_y10 = start_y+11'd20;
	assign two_digit_y11 = start_y+11'd20;

	assign two_digit_x20 = start_x+11'd60+r_shift;
	assign two_digit_x21 = start_x+11'd60+r_shift;
	assign two_digit_y20 = start_y+11'd20;
	assign two_digit_y21 = start_y+11'd50; 

	assign two_digit_x30 = start_x+11'd40+r_shift;
	assign two_digit_x31 = start_x+11'd60+r_shift;
	assign two_digit_y30 = start_y+11'd50;
	assign two_digit_y31 = start_y+11'd50;

	assign two_digit_x40 = start_x+11'd60+r_shift;
	assign two_digit_x41 = start_x+11'd60+r_shift;
	assign two_digit_y40 = start_y+11'd50;
	assign two_digit_y41 = start_y+11'd80; 

	assign two_digit_x50 = start_x+11'd40+r_shift;
	assign two_digit_x51 = start_x+11'd60+r_shift;
	assign two_digit_y50 = start_y+11'd80;
	assign two_digit_y51 = start_y+11'd80;

	assign two_digit_x60 = start_x+11'd40+r_shift;
	assign two_digit_x61 = start_x+11'd40+r_shift;
	assign two_digit_y60 = start_y+11'd50;
	assign two_digit_y61 = start_y+11'd80; 

	assign two_digit_x70 = start_x+11'd40+r_shift;
	assign two_digit_x71 = start_x+11'd40+r_shift;
	assign two_digit_y70 = start_y+11'd20;
	assign two_digit_y71 = start_y+11'd50;
				
	enum {s0, s11, s12, s21, s22, s23, s24, s25, s31, s32, s33, s34, s35,s41, s42, s43, s44,
			s51, s52, s53, s54, s55, s61, s62, s63, s64, s65, s66, s71, s72, s73, s81, s82, s83,
			s84, s85, s86, s87, s91, s92, s93, s94, s95, s101, s102, s103, s104, s105, s106, s107,
			s111, s112, s113, s121, s122, s123, s124, s125, s126, s131, s132, s133, s134, s135, s136,
			s141, s142, s143, s144, s145, s151, s152, s153, s154, s155, s156, s_end}ps, ns;
	
	// Drawing each number.
	always_comb begin
		ns=s0;x0=0;y0=0;x1=0;y1=0;
		case(ps)
			s0: if (start) begin 
					if(value ==4'd0)begin ns = s_end;x0=0;y0=0;x1=0;y1=0;end
					else if (value==4'd1) begin ns = s11;x0=0;y0=0;x1=0;y1=0;end
					else if(value==4'd2) begin ns = s21;x0=0;y0=0;x1=0;y1=0;end
					else if(value==4'd3) begin ns = s31;x0=0;y0=0;x1=0;y1=0;end
					else if(value==4'd4) begin ns = s41;x0=0;y0=0;x1=0;y1=0;end
					else if(value==4'd5) begin ns = s51;x0=0;y0=0;x1=0;y1=0;end
					else if(value==4'd6) begin ns = s61;x0=0;y0=0;x1=0;y1=0;end
					else if(value==4'd7) begin ns = s71;x0=0;y0=0;x1=0;y1=0;end
					else if(value==4'd8) begin ns = s81;x0=0;y0=0;x1=0;y1=0;end
					else if(value==4'd9) begin ns = s91;x0=0;y0=0;x1=0;y1=0;end
					else if(value==4'd10) begin ns = s101;x0=0;y0=0;x1=0;y1=0;end
					else if(value==4'd11) begin ns = s111;x0=0;y0=0;x1=0;y1=0;end
					else if(value==4'd12) begin ns = s121;x0=0;y0=0;x1=0;y1=0;end
					else if(value==4'd13) begin ns = s131;x0=0;y0=0;x1=0;y1=0;end
					else if(value==4'd14) begin ns = s141;x0=0;y0=0;x1=0;y1=0;end
					else if(value==4'd15) begin ns = s151;x0=0;y0=0;x1=0;y1=0;end
				 end else begin 
					ns=s0;x0=0;y0=0;x1=0;y1=0;
				 end

			// draw number one
			s11: if (done) begin 
					ns = s12; x0=one_digit_x20; y0=one_digit_y20;x1=one_digit_x21;y1 = one_digit_y21;
				 end else begin 
					ns = s11; x0=one_digit_x20; y0=one_digit_y20;x1=one_digit_x21;y1 = one_digit_y21;
				 end
			s12: if (done) begin 
					ns = s_end; x0=one_digit_x40; y0=one_digit_y40;x1=one_digit_x41;y1 = one_digit_y41;
				 end else begin 
					ns = s12; x0=one_digit_x40; y0=one_digit_y40;x1=one_digit_x41;y1 = one_digit_y41;
				 end

			//draw number two
			s21: if (done) begin 
					ns = s22; x0=one_digit_x10; y0=one_digit_y10;x1=one_digit_x11;y1 = one_digit_y11;
				 end else begin 
					ns = s21; x0=one_digit_x10; y0=one_digit_y10;x1=one_digit_x11;y1 = one_digit_y11;
				 end
			s22: if (done) begin 
					ns = s23; x0=one_digit_x20; y0=one_digit_y20;x1=one_digit_x21;y1 = one_digit_y21;
				 end else begin 
					ns = s22; x0=one_digit_x20; y0=one_digit_y20;x1=one_digit_x21;y1 = one_digit_y21;
				 end
			s23: if (done) begin 
					ns = s24; x0=one_digit_x30; y0=one_digit_y30;x1=one_digit_x31;y1 = one_digit_y31;
				 end else begin 
					ns = s23; x0=one_digit_x30; y0=one_digit_y30;x1=one_digit_x31;y1 = one_digit_y31;
				 end
			s24: if (done) begin 
					ns = s25; x0=one_digit_x60; y0=one_digit_y60;x1=one_digit_x61;y1 = one_digit_y61;
				 end else begin 
					ns = s24; x0=one_digit_x60; y0=one_digit_y60;x1=one_digit_x61;y1 = one_digit_y61;
				 end
			s25: if (done) begin 
					ns = s_end; x0=one_digit_x50; y0=one_digit_y50;x1=one_digit_x51;y1 = one_digit_y51;
				 end else begin 
					ns = s25; x0=one_digit_x50; y0=one_digit_y50;x1=one_digit_x51;y1 = one_digit_y51;
				 end

			//draw number three
			s31: if (done) begin 
					ns = s32; x0=one_digit_x10; y0=one_digit_y10;x1=one_digit_x11;y1 = one_digit_y11;
				 end else begin 
					ns = s31; x0=one_digit_x10; y0=one_digit_y10;x1=one_digit_x11;y1 = one_digit_y11;
				 end
			s32: if (done) begin 
					ns = s33; x0=one_digit_x20; y0=one_digit_y20;x1=one_digit_x21;y1 = one_digit_y21;
				 end else begin 
					ns = s32; x0=one_digit_x20; y0=one_digit_y20;x1=one_digit_x21;y1 = one_digit_y21;
				 end
			s33: if (done) begin 
					ns = s34; x0=one_digit_x30; y0=one_digit_y30;x1=one_digit_x31;y1 = one_digit_y31;
				 end else begin 
					ns = s33; x0=one_digit_x30; y0=one_digit_y30;x1=one_digit_x31;y1 = one_digit_y31;
				 end
			s34: if (done) begin 
					ns = s35; x0=one_digit_x40; y0=one_digit_y40;x1=one_digit_x41;y1 = one_digit_y41;
				 end else begin 
					ns = s34; x0=one_digit_x40; y0=one_digit_y40;x1=one_digit_x41;y1 = one_digit_y41;
				 end
			s35: if (done) begin 
					ns = s_end; x0=one_digit_x50; y0=one_digit_y50;x1=one_digit_x51;y1 = one_digit_y51;
				 end else begin 
					ns = s35; x0=one_digit_x50; y0=one_digit_y50;x1=one_digit_x51;y1 = one_digit_y51;
				 end

			//draw number four
			s41: if (done) begin 
					ns = s42; x0=one_digit_x70; y0=one_digit_y70;x1=one_digit_x71;y1 = one_digit_y71;
				 end else begin 
					ns = s41; x0=one_digit_x70; y0=one_digit_y70;x1=one_digit_x71;y1 = one_digit_y71;
				 end
			s42: if (done) begin 
					ns = s43; x0=one_digit_x20; y0=one_digit_y20;x1=one_digit_x21;y1 = one_digit_y21;
				 end else begin 
					ns = s42; x0=one_digit_x20; y0=one_digit_y20;x1=one_digit_x21;y1 = one_digit_y21;
				 end
			s43: if (done) begin 
					ns = s44; x0=one_digit_x30; y0=one_digit_y30;x1=one_digit_x31;y1 = one_digit_y31;
				 end else begin 
					ns = s43; x0=one_digit_x30; y0=one_digit_y30;x1=one_digit_x31;y1 = one_digit_y31;
				 end
			s44: if (done) begin 
					ns = s_end; x0=one_digit_x40; y0=one_digit_y40;x1=one_digit_x41;y1 = one_digit_y41;
				 end else begin 
					ns = s44; x0=one_digit_x40; y0=one_digit_y40;x1=one_digit_x41;y1 = one_digit_y41;
				 end

			//draw number five
			s51: if (done) begin 
					ns = s52; x0=one_digit_x10; y0=one_digit_y10;x1=one_digit_x11;y1 = one_digit_y11;
				 end else begin 
					ns = s51; x0=one_digit_x10; y0=one_digit_y10;x1=one_digit_x11;y1 = one_digit_y11;
				 end
			s52: if (done) begin 
					ns = s53; x0=one_digit_x70; y0=one_digit_y70;x1=one_digit_x71;y1 = one_digit_y71;
				 end else begin 
					ns = s52; x0=one_digit_x70; y0=one_digit_y70;x1=one_digit_x71;y1 = one_digit_y71;
				 end
			s53: if (done) begin 
					ns = s54; x0=one_digit_x30; y0=one_digit_y30;x1=one_digit_x31;y1 = one_digit_y31;
				 end else begin 
					ns = s53; x0=one_digit_x30; y0=one_digit_y30;x1=one_digit_x31;y1 = one_digit_y31;
				 end
			s54: if (done) begin 
					ns = s55; x0=one_digit_x40; y0=one_digit_y40;x1=one_digit_x41;y1 = one_digit_y41;
				 end else begin 
					ns = s54; x0=one_digit_x40; y0=one_digit_y40;x1=one_digit_x41;y1 = one_digit_y41;
				 end
			s55: if (done) begin 
					ns = s_end; x0=one_digit_x50; y0=one_digit_y50;x1=one_digit_x51;y1 = one_digit_y51;
				 end else begin 
					ns = s55; x0=one_digit_x50; y0=one_digit_y50;x1=one_digit_x51;y1 = one_digit_y51;
				 end

			//draw number six
			s61: if (done) begin 
					ns = s62; x0=one_digit_x10; y0=one_digit_y10;x1=one_digit_x11;y1 = one_digit_y11;
				 end else begin 
					ns = s61; x0=one_digit_x10; y0=one_digit_y10;x1=one_digit_x11;y1 = one_digit_y11;
				 end
			s62: if (done) begin 
					ns = s63; x0=one_digit_x70; y0=one_digit_y70;x1=one_digit_x71;y1 = one_digit_y71;
				 end else begin 
					ns = s62; x0=one_digit_x70; y0=one_digit_y70;x1=one_digit_x71;y1 = one_digit_y71;
				 end
			s63: if (done) begin 
					ns = s64; x0=one_digit_x30; y0=one_digit_y30;x1=one_digit_x31;y1 = one_digit_y31;
				 end else begin 
					ns = s63; x0=one_digit_x30; y0=one_digit_y30;x1=one_digit_x31;y1 = one_digit_y31;
				 end
			s64: if (done) begin 
					ns = s65; x0=one_digit_x40; y0=one_digit_y40;x1=one_digit_x41;y1 = one_digit_y41;
				 end else begin 
					ns = s64; x0=one_digit_x40; y0=one_digit_y40;x1=one_digit_x41;y1 = one_digit_y41;
				 end
			s65: if (done) begin 
					ns = s66; x0=one_digit_x50; y0=one_digit_y50;x1=one_digit_x51;y1 = one_digit_y51;
				 end else begin 
					ns = s65; x0=one_digit_x50; y0=one_digit_y50;x1=one_digit_x51;y1 = one_digit_y51;
				 end
			s66: if (done) begin 
					ns = s_end; x0=one_digit_x60; y0=one_digit_y60;x1=one_digit_x61;y1 = one_digit_y61;
				 end else begin 
					ns = s66; x0=one_digit_x60; y0=one_digit_y60;x1=one_digit_x61;y1 = one_digit_y61;
				 end

			//draw number seven
			s71: if (done) begin 
					ns = s72; x0=one_digit_x10; y0=one_digit_y10;x1=one_digit_x11;y1 = one_digit_y11;
				 end else begin 
					ns = s71; x0=one_digit_x10; y0=one_digit_y10;x1=one_digit_x11;y1 = one_digit_y11;
				 end
			s72: if (done) begin 
					ns = s73; x0=one_digit_x20; y0=one_digit_y20;x1=one_digit_x21;y1 = one_digit_y21;
				 end else begin 
					ns = s72; x0=one_digit_x20; y0=one_digit_y20;x1=one_digit_x21;y1 = one_digit_y21;
				 end
			s73: if (done) begin 
					ns = s_end; x0=one_digit_x40; y0=one_digit_y40;x1=one_digit_x41;y1 = one_digit_y41;
				 end else begin 
					ns = s73; x0=one_digit_x40; y0=one_digit_y40;x1=one_digit_x41;y1 = one_digit_y41;
				 end

			//draw number eight
			s81: if (done) begin 
					ns = s82; x0=one_digit_x10; y0=one_digit_y10;x1=one_digit_x11;y1 = one_digit_y11;
				 end else begin 
					ns = s81; x0=one_digit_x10; y0=one_digit_y10;x1=one_digit_x11;y1 = one_digit_y11;
				 end
			s82: if (done) begin 
					ns = s83; x0=one_digit_x20; y0=one_digit_y20;x1=one_digit_x21;y1 = one_digit_y21;
				 end else begin 
					ns = s82; x0=one_digit_x20; y0=one_digit_y20;x1=one_digit_x21;y1 = one_digit_y21;
				 end
			s83: if (done) begin 
					ns = s84; x0=one_digit_x70; y0=one_digit_y70;x1=one_digit_x71;y1 = one_digit_y71;
				 end else begin 
					ns = s83; x0=one_digit_x70; y0=one_digit_y70;x1=one_digit_x71;y1 = one_digit_y71;
				 end
			s84: if (done) begin 
					ns = s85; x0=one_digit_x30; y0=one_digit_y30;x1=one_digit_x31;y1 = one_digit_y31;
				 end else begin 
					ns = s84; x0=one_digit_x30; y0=one_digit_y30;x1=one_digit_x31;y1 = one_digit_y31;
				 end
			s85: if (done) begin 
					ns = s86; x0=one_digit_x40; y0=one_digit_y40;x1=one_digit_x41;y1 = one_digit_y41;
				 end else begin 
					ns = s85; x0=one_digit_x40; y0=one_digit_y40;x1=one_digit_x41;y1 = one_digit_y41;
				 end
			s86: if (done) begin 
					ns = s87; x0=one_digit_x50; y0=one_digit_y50;x1=one_digit_x51;y1 = one_digit_y51;
				 end else begin 
					ns = s86; x0=one_digit_x50; y0=one_digit_y50;x1=one_digit_x51;y1 = one_digit_y51;
				 end
			s87: if (done) begin 
					ns = s_end; x0=one_digit_x60; y0=one_digit_y60;x1=one_digit_x61;y1 = one_digit_y61;
				 end else begin 
					ns = s87; x0=one_digit_x60; y0=one_digit_y60;x1=one_digit_x61;y1 = one_digit_y61;
				 end
				 
			// draw number nine
			s91: if (done) begin 
					ns = s92; x0=one_digit_x10; y0=one_digit_y10;x1=one_digit_x11;y1 = one_digit_y11;
				 end else begin 
					ns = s91; x0=one_digit_x10; y0=one_digit_y10;x1=one_digit_x11;y1 = one_digit_y11;
				 end
			s92: if (done) begin 
					ns = s93; x0=one_digit_x20; y0=one_digit_y20;x1=one_digit_x21;y1 = one_digit_y21;
				 end else begin 
					ns = s92; x0=one_digit_x20; y0=one_digit_y20;x1=one_digit_x21;y1 = one_digit_y21;
				 end
			s93: if (done) begin 
					ns = s94; x0=one_digit_x30; y0=one_digit_y30;x1=one_digit_x31;y1 = one_digit_y31;
				 end else begin 
					ns = s93; x0=one_digit_x30; y0=one_digit_y30;x1=one_digit_x31;y1 = one_digit_y31;
				 end
			s94: if (done) begin 
					ns = s95; x0=one_digit_x40; y0=one_digit_y40;x1=one_digit_x41;y1 = one_digit_y41;
				 end else begin 
					ns = s94; x0=one_digit_x40; y0=one_digit_y40;x1=one_digit_x41;y1 = one_digit_y41;
				 end
			s95: if (done) begin 
					ns = s_end; x0=one_digit_x70; y0=one_digit_y70;x1=one_digit_x71;y1 = one_digit_y71;
				 end else begin 
					ns = s95; x0=one_digit_x70; y0=one_digit_y70;x1=one_digit_x71;y1 = one_digit_y71;
				 end

			// draw number ten
			
			s101: if (done) begin 
					ns = s102; x0=ten_digit_one_x10; y0=ten_digit_one_y10;x1=ten_digit_one_x11;y1 = ten_digit_one_y11;
				 end else begin 
					ns = s101; x0=ten_digit_one_x10; y0=ten_digit_one_y10;x1=ten_digit_one_x11;y1 = ten_digit_one_y11;
				 end
			s102: if (done) begin 
					ns = s103; x0=two_digit_x20; y0=two_digit_y20;x1=two_digit_x21;y1 = two_digit_y21;
				 end else begin 
					ns = s102; x0=two_digit_x20; y0=two_digit_y20;x1=two_digit_x21;y1 = two_digit_y21;
				 end
			s103: if (done) begin 
					ns = s104; x0=two_digit_x40; y0=two_digit_y40;x1=two_digit_x41;y1 = two_digit_y41;
				 end else begin 
					ns = s103; x0=two_digit_x40; y0=two_digit_y40;x1=two_digit_x41;y1 = two_digit_y41;
				 end
			s104: if (done) begin 
					ns = s105; x0=two_digit_x10; y0=two_digit_y10;x1=two_digit_x11;y1 = two_digit_y11;
				 end else begin 
					ns = s104; x0=two_digit_x10; y0=two_digit_y10;x1=two_digit_x11;y1 = two_digit_y11;
				 end
			s105: if (done) begin 
					ns = s106; x0=two_digit_x50; y0=two_digit_y50;x1=two_digit_x51;y1 = two_digit_y51;
				 end else begin 
					ns = s105; x0=two_digit_x50; y0=two_digit_y50;x1=two_digit_x51;y1 = two_digit_y51;
				 end
			s106: if (done) begin 
					ns = s107; x0=two_digit_x60; y0=two_digit_y60;x1=two_digit_x61;y1 = two_digit_y61;
				 end else begin 
					ns = s106; x0=two_digit_x60; y0=two_digit_y60;x1=two_digit_x61;y1 = two_digit_y61;
				 end
			s107: if (done) begin 
					ns = s_end; x0=two_digit_x70; y0=two_digit_y70;x1=two_digit_x71;y1 = two_digit_y71;
				 end else begin 
					ns = s107; x0=two_digit_x70; y0=two_digit_y70;x1=two_digit_x71;y1 = two_digit_y71;
				 end

			// draw number eleven
			s111: if (done) begin 
					ns = s112; x0=ten_digit_one_x10; y0=ten_digit_one_y10;x1=ten_digit_one_x11;y1 = ten_digit_one_y11;
				 end else begin 
					ns = s111; x0=ten_digit_one_x10; y0=ten_digit_one_y10;x1=ten_digit_one_x11;y1 = ten_digit_one_y11;
				 end
			s112: if (done) begin 
					ns = s113; x0=two_digit_x20; y0=two_digit_y20;x1=two_digit_x21;y1 = two_digit_y21;
				 end else begin 
					ns = s112; x0=two_digit_x20; y0=two_digit_y20;x1=two_digit_x21;y1 = two_digit_y21;
				 end
			s113: if (done) begin 
					ns = s_end; x0=two_digit_x40; y0=two_digit_y40;x1=two_digit_x41;y1 = two_digit_y41;
				 end else begin 
					ns = s113; x0=two_digit_x40; y0=two_digit_y40;x1=two_digit_x41;y1 = two_digit_y41;
				 end

			// draw number twelve
			s121: if (done) begin 
					ns = s122; x0=ten_digit_one_x10; y0=ten_digit_one_y10;x1=ten_digit_one_x11;y1 = ten_digit_one_y11;
				 end else begin 
					ns = s121; x0=ten_digit_one_x10; y0=ten_digit_one_y10;x1=ten_digit_one_x11;y1 = ten_digit_one_y11;
				 end
			s122: if (done) begin 
					ns = s123; x0=two_digit_x10; y0=two_digit_y10;x1=two_digit_x11;y1 = two_digit_y11;
				 end else begin 
					ns = s122; x0=two_digit_x10; y0=two_digit_y10;x1=two_digit_x11;y1 = two_digit_y11;
				 end
			s123: if (done) begin 
					ns = s124; x0=two_digit_x20; y0=two_digit_y20;x1=two_digit_x21;y1 = two_digit_y21;
				 end else begin 
					ns = s123; x0=two_digit_x20; y0=two_digit_y20;x1=two_digit_x21;y1 = two_digit_y21;
				 end
			s124: if (done) begin 
					ns = s125; x0=two_digit_x30; y0=two_digit_y30;x1=two_digit_x31;y1 = two_digit_y31;
				 end else begin 
					ns = s124; x0=two_digit_x30; y0=two_digit_y30;x1=two_digit_x31;y1 = two_digit_y31;
				 end
			s125: if (done) begin 
					ns = s126; x0=two_digit_x50; y0=two_digit_y50;x1=two_digit_x51;y1 = two_digit_y51;
				 end else begin 
					ns = s125; x0=two_digit_x50; y0=two_digit_y50;x1=two_digit_x51;y1 = two_digit_y51;
				 end
			s126: if (done) begin 
					ns = s_end; x0=two_digit_x60; y0=two_digit_y60;x1=two_digit_x61;y1 = two_digit_y61;
				 end else begin 
					ns = s126; x0=two_digit_x60; y0=two_digit_y60;x1=two_digit_x61;y1 = two_digit_y61;
				 end

			// draw number thirteen
			s131: if (done) begin 
					ns = s132; x0=ten_digit_one_x10; y0=ten_digit_one_y10;x1=ten_digit_one_x11;y1 = ten_digit_one_y11;
				 end else begin 
					ns = s131; x0=ten_digit_one_x10; y0=ten_digit_one_y10;x1=ten_digit_one_x11;y1 = ten_digit_one_y11;
				 end
			s132: if (done) begin 
					ns = s133; x0=two_digit_x10; y0=two_digit_y10;x1=two_digit_x11;y1 = two_digit_y11;
				 end else begin 
					ns = s132; x0=two_digit_x10; y0=two_digit_y10;x1=two_digit_x11;y1 = two_digit_y11;
				 end
			s133: if (done) begin 
					ns = s134; x0=two_digit_x20; y0=two_digit_y20;x1=two_digit_x21;y1 = two_digit_y21;
				 end else begin 
					ns = s133; x0=two_digit_x20; y0=two_digit_y20;x1=two_digit_x21;y1 = two_digit_y21;
				 end
			s134: if (done) begin 
					ns = s135; x0=two_digit_x30; y0=two_digit_y30;x1=two_digit_x31;y1 = two_digit_y31;
				 end else begin 
					ns = s134; x0=two_digit_x30; y0=two_digit_y30;x1=two_digit_x31;y1 = two_digit_y31;
				 end
			s135: if (done) begin 
					ns = s136; x0=two_digit_x50; y0=two_digit_y50;x1=two_digit_x51;y1 = two_digit_y51;
				 end else begin 
					ns = s135; x0=two_digit_x50; y0=two_digit_y50;x1=two_digit_x51;y1 = two_digit_y51;
				 end
			s136: if (done) begin 
					ns = s_end; x0=two_digit_x40; y0=two_digit_y40;x1=two_digit_x41;y1 = two_digit_y41;
				 end else begin 
					ns = s136; x0=two_digit_x40; y0=two_digit_y40;x1=two_digit_x41;y1 = two_digit_y41;
				 end

			// draw number fourteen 
			s141: if (done) begin 
					ns = s142; x0=ten_digit_one_x10; y0=ten_digit_one_y10;x1=ten_digit_one_x11;y1 = ten_digit_one_y11;
				 end else begin 
					ns = s141; x0=ten_digit_one_x10; y0=ten_digit_one_y10;x1=ten_digit_one_x11;y1 = ten_digit_one_y11;
				 end
			s142: if (done) begin 
					ns = s143; x0=two_digit_x70; y0=two_digit_y70;x1=two_digit_x71;y1 = two_digit_y71;
				 end else begin 
					ns = s142; x0=two_digit_x70; y0=two_digit_y70;x1=two_digit_x71;y1 = two_digit_y71;
				 end
			s143: if (done) begin 
					ns = s144; x0=two_digit_x20; y0=two_digit_y20;x1=two_digit_x21;y1 = two_digit_y21;
				 end else begin 
					ns = s143; x0=two_digit_x20; y0=two_digit_y20;x1=two_digit_x21;y1 = two_digit_y21;
				 end
			s144: if (done) begin 
					ns = s145; x0=two_digit_x30; y0=two_digit_y30;x1=two_digit_x31;y1 = two_digit_y31;
				 end else begin 
					ns = s144; x0=two_digit_x30; y0=two_digit_y30;x1=two_digit_x31;y1 = two_digit_y31;
				 end
			s145: if (done) begin 
					ns = s_end; x0=two_digit_x40; y0=two_digit_y40;x1=two_digit_x41;y1 = two_digit_y41;
				 end else begin 
					ns = s145; x0=two_digit_x40; y0=two_digit_y40;x1=two_digit_x41;y1 = two_digit_y41;
				 end

			//draw number fifteen
			s151: if (done) begin 
					ns = s152; x0=ten_digit_one_x10; y0=ten_digit_one_y10;x1=ten_digit_one_x11;y1 = ten_digit_one_y11;
				 end else begin 
					ns = s151; x0=ten_digit_one_x10; y0=ten_digit_one_y10;x1=ten_digit_one_x11;y1 = ten_digit_one_y11;
				 end
			s152: if (done) begin 
					ns = s153; x0=two_digit_x10; y0=two_digit_y10;x1=two_digit_x11;y1 = two_digit_y11;
				 end else begin 
					ns = s152; x0=two_digit_x10; y0=two_digit_y10;x1=two_digit_x11;y1 = two_digit_y11;
				 end
			s153: if (done) begin 
					ns = s154; x0=two_digit_x70; y0=two_digit_y70;x1=two_digit_x71;y1 = two_digit_y71;
				 end else begin 
					ns = s153; x0=two_digit_x70; y0=two_digit_y70;x1=two_digit_x71;y1 = two_digit_y71;
				 end
			s154: if (done) begin 
					ns = s155; x0=two_digit_x30; y0=two_digit_y30;x1=two_digit_x31;y1 = two_digit_y31;
				 end else begin 
					ns = s154; x0=two_digit_x30; y0=two_digit_y30;x1=two_digit_x31;y1 = two_digit_y31;
				 end
			s155: if (done) begin 
					ns = s156; x0=two_digit_x50; y0=two_digit_y50;x1=two_digit_x51;y1 = two_digit_y51;
				 end else begin 
					ns = s155; x0=two_digit_x50; y0=two_digit_y50;x1=two_digit_x51;y1 = two_digit_y51;
				 end
			s156: if (done) begin 
					ns = s_end; x0=two_digit_x40; y0=two_digit_y40;x1=two_digit_x41;y1 = two_digit_y41;
				 end else begin 
					ns = s156; x0=two_digit_x40; y0=two_digit_y40;x1=two_digit_x41;y1 = two_digit_y41;
				 end

			s_end: begin ns = s0; end 
		endcase
	end
	assign number_done = (ps ==s_end);

	// assign the value for start the drawing.
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

endmodule

// The testing module for the drawNumber module.
module drawNumber_testbench();
    logic clk, reset,start;
	logic [3:0]value;
	logic [10:0]start_x, start_y;
	logic [10:0]x,y;
	logic number_done;

    drawNumber dut (.clk,.reset, .start, .start_x, .start_y,.value,.x,.y,.number_done);

    parameter CLOCK_PERIOD = 100;
    initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

    integer i;
	 integer j;
    initial begin
		reset<=1;start_x <= 11'd0;start_y <=11'd0;					@(posedge clk);
		reset<=0;@(posedge clk);
		/*for (i=1;i<=15;i++) begin
			value <= i;start <= 1;										@(posedge clk);
			start <= 0;													@(posedge clk);
			for(j=1;j<300;j++)					 @(posedge clk);
		end*/
		value <=4'd8;start <= 1;	@(posedge clk);
		start <= 0;													@(posedge clk);
		for(j=1;j<300;j++)					 @(posedge clk);
		
		$stop();
	end
endmodule