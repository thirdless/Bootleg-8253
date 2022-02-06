module MUX_1_2_16B (di1, di0, sel, do);
	input sel;
	input [15:0] di1, di0;
	output [15:0] do;

	assign do = sel ? di1 : di0;
endmodule