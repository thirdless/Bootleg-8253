module DEC (di, do1, do2);
	input [15:0] di;
	output [15:0] do1, do2;

	assign do1 = di - 1;
	assign do2 = di - 2;
endmodule