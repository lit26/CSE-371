// EE 371 project
// Tianning Li, Mingcun Fan

// This module will check the movement is legal, output the switching position and whether it 
// is legal.
module move(control, empty_position,switchPosition,legal);
	input logic [3:0] control,empty_position;	
	output logic [3:0] switchPosition;
	output logic legal;
	parameter none = 4'b0000,
				 up = 4'b1000,
				 down = 4'b0100,
				 left = 4'b0010,
				 right = 4'b0001;
	
	always_comb begin
		case(control)
			//no input
			none: switchPosition=empty_position;
			//input up
			up: if (empty_position <4'd12)
					switchPosition=empty_position+4'd4;
				 else
					switchPosition=empty_position;
			//input down
			down: if (empty_position>4'd3)
						switchPosition=empty_position-4'd4;
					else
						switchPosition=empty_position;
			//input left
			left: if ((empty_position!=4'd3)&&(empty_position!=4'd7)&&(empty_position!=4'd11)&&(empty_position!=4'd15))
						switchPosition=empty_position+4'd1;
					else
						switchPosition=empty_position;
			//input right
			right: if ((empty_position!=4'd0)&&(empty_position!=4'd4)&&(empty_position!=4'd8)&&(empty_position!=4'd12))
						switchPosition=empty_position-4'd1;
					else
						switchPosition=empty_position;
			default: switchPosition=empty_position;
		endcase
	end
	assign legal = (empty_position != switchPosition);

endmodule

// Tesing module for the move module.
module move_testbench();
	logic [3:0] control,empty_position;	
	logic [3:0] switchPosition;
	logic legal;

    move dut (.control,.switchPosition, .empty_position,.legal);
    
    integer i;
    initial begin
		control=4'b0001;empty_position=4'd15;#10;
		control=4'b0010;empty_position=4'd15;#10;
		control=4'b0010;empty_position=4'd14;#10;
	end
endmodule
	