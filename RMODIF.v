module RMODIF (data, PLMODIF, reset, clk, out);

    input PLMODIF, reset, clk;
    input [2:0] data;
    output reg [2:0] out;

    always @(posedge clk)
		if(reset)
			out <= 3'b0;
		else
			if(PLMODIF)
				out <= data;

endmodule