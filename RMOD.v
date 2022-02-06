module RMOD (clk, reset, pl, di, do);
	input clk, reset, pl;
	input [2:0] di;
	output reg [2:0] do;

	always @(posedge clk)
		if(reset)
			do <= 3'b0;
		else
			if(pl)
				do <= di;
endmodule