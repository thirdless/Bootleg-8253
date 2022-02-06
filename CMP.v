module CMP (di1, di2, do_inegal, do_egal);
	input [15:0] di1, di2;
	output do_egal, do_inegal;

	assign do_egal = (di1 == di2);
	assign do_inegal = (di1 < di2);
endmodule