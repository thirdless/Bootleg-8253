module ADD (di, do);
	input [15:0] di;
	output [15:0] do;

	assign do = {1'b0, di[15:1]} + {15'b0, di[0]} - 1;
endmodule