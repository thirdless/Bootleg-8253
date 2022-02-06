module RN (clk, reset, pl, di, do);
	input clk, reset, pl;
	input [15:0] di;
	output reg [15:0] do;

	always @(posedge clk)
		if(reset)
			do <= 16'b0;
		else
			if(pl)
				do <= di;
endmodule