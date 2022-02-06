module MUX_1_2_3B (di1, di0, sel, do);
	input sel;
	input [2:0] di1, di0;
	output [2:0] do;

	assign do = sel ? di1 : di0;
endmodule