module CNT (clk, reset, inc, do);
	input clk, reset, inc;
	output reg [15:0] do;
	
	always @(posedge clk)
		if(reset)
			do <= 16'b0;
		else
			do <= do + inc;
endmodule