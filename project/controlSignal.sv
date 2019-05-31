// EE 371 project
// Tianning Li, Mingcun Fan

// This module will output the control signal for the system.
// It will only true for one cycle no matter the input is true
// for how many cycles. 
module controlSignal(clk,reset, inputSignal, outputSignal);
	input logic clk,reset,inputSignal;
	output logic outputSignal;
	logic outputSignal_pre;

	// assign the outputs signal.
	always_ff @(posedge clk) begin
		if(reset)
			outputSignal_pre<=0;
		else if (inputSignal)
			outputSignal_pre<=1;
		else if (!inputSignal)
			outputSignal_pre<=0;
			
		if(inputSignal && !outputSignal_pre)
			outputSignal<=1;
		else
			outputSignal<=0;
	end
endmodule

// The testing module for the controlSignal module.
module controlSignal_testbench();
   logic clk,reset,inputSignal;
	logic outputSignal;

	 controlSignal dut(.clk,.reset, .inputSignal, .outputSignal);

    parameter CLOCK_PERIOD = 100;
    initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

    integer i;
	 integer j;
    initial begin
		reset<=1;		 @(posedge clk);
		reset<=0; @(posedge clk);	
							 @(posedge clk);
							 @(posedge clk);
		inputSignal <=1;@(posedge clk);
							 @(posedge clk);
							 @(posedge clk);							 
		inputSignal <=0;@(posedge clk);
		@(posedge clk);
							 @(posedge clk);	
							 @(posedge clk);
							 @(posedge clk);
		inputSignal <=1;@(posedge clk);					 
		inputSignal <=0;@(posedge clk);
		
		
		$stop();
	end
endmodule