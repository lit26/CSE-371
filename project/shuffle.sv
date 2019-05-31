// EE 371 project
// Tianning Li, Mingcun Fan

// This module is the pre-assigned the shuffle value.

module shuffle(shuffle_index, address, data, empty_po);
	input logic [2:0] shuffle_index;
	input logic [4:0] address;
	output logic [3:0] data;
	output logic [3:0] empty_po;
	
	logic [63:0] shuffle_ram[7:0];
	logic [3:0] empty [7:0];
	
	//assign shuffle_ram[0]=64'h9BC2F745140683DA; //[9,11,12,2,15,7,4,5,1,4,0,6,8,3,13,10]
	assign shuffle_ram[0]=64'h0FEDCBA987654321; //[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,0]
	assign shuffle_ram[1]=64'h564712AE0B98FC3D; //[5,6,4,7,1,2,10,14,0,11,9,8,15,12,3,13]
	assign shuffle_ram[2]=64'h07A9C2B8FE3516D4; //[0,7,10,9,12,2,11,8,15,14,3,5,1,6,13,4]
	assign shuffle_ram[3]=64'h54376B820FCAED91; //[5,4,3,7,6,11,8,2,0,15,12,10,14,13,9,1]
	assign shuffle_ram[4]=64'hB96F18E43C0AD527; //[11,9,6,15,1,8,14,4,3,12,0,10,13,5,2,7]
	assign shuffle_ram[5]=64'hCEB237F45D9680A1; //[12,14,11,2,3,7,15,4,5,13,9,6,8,0,10,1]
	assign shuffle_ram[6]=64'h7E93F0684A5DB12C; //[7,14,9,3,15,0,6,8,4,10,5,13,11,1,2,12]
	assign shuffle_ram[7]=64'hE41390568FB2A7CD; //[14,4,1,3,9,0,5,6,8,15,11,2,10,7,12,13]
	
	logic [63:0] shuffle_puzzle;

	assign shuffle_puzzle = shuffle_ram[shuffle_index];
		
	assign data[0] = shuffle_puzzle[address * 4 + 6'd0];
	assign data[1] = shuffle_puzzle[address * 4 + 6'd1];
	assign data[2] = shuffle_puzzle[address * 4 + 6'd2];
	assign data[3] = shuffle_puzzle[address * 4 + 6'd3];
	
	assign empty[0] = 4'b1111;
	assign empty[1] = 4'b0111;
	assign empty[2] = 4'b1111;
	assign empty[3] = 4'b0111;
	assign empty[4] = 4'b0101;
	assign empty[5] = 4'b0010;
	assign empty[6] = 4'hA;
	assign empty[7] = 4'hA;
	
	assign empty_po = empty[shuffle_index];
	
endmodule 



