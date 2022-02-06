//IN: clk, reset, plnif, plmodif, p1, p2, os, c1, plnact
//OUT: valid, osa, resinit
module CONTROL (clk, reset, plnif, plmodif, p1, p2, os, c1, plnact, valid, osa, resinit);

    input clk, reset, plnif, plmodif, p1, p2, os, c1, plnact;
    output reg valid, osa, resinit;

    wire mod0;
    reg [3:0] cs, ns;

    parameter S0 = 4'b0000;
    parameter S1 = 4'b0001;
    parameter S2 = 4'b0010;
    parameter S3 = 4'b0011;
    parameter S4 = 4'b0100;
    parameter S5 = 4'b0101;
    parameter S6 = 4'b0110;
    parameter S7 = 4'b0111;
    parameter S8 = 4'b1000;
    parameter S9 = 4'b1001;
    parameter S10 = 4'b1010;

    assign mod0 = !(p1 || p2 || os);

    //elemente de memorare a starii curente
    always @(posedge clk)
        if(reset)
            cs <= S0;
        else
            cs <= ns;

    //logica de generare a iesirilor
    always @(cs)
        casex(cs)
            4'b00x0, 4'b0001: {valid, osa, resinit} = 3'b000;
            4'b0011: {valid, osa, resinit} = 3'b101;
            4'b0111: {valid, osa, resinit} = 3'b110;
            4'b010x, 4'b0110, 4'b100x, 4'b1010: {valid, osa, resinit} = 3'b100;
            default: {valid, osa, resinit} = 3'b000;
        endcase

    //logica de generare a starii viitoare
    always @(cs or plnif or plmodif or p1 or p2 or os or c1 or plnact)
        casex({cs, plnif, plmodif, p1, p2, os, c1, plnact})
            12'b0000_00xxxxx: ns = S0;
			12'b0000_10xxxxx: ns = S1;
			12'b0000_01xxxxx: ns = S2;

			12'b0001_x0xxxxx: ns = S1;
			12'b0001_x1xxxxx: ns = S3;

			12'b0010_0xxxxxx: ns = S2;
			12'b0010_1xxxxxx: ns = S3;

			12'b0011_xx1xxxx: ns = S5;
			12'b0011_xx01xxx: ns = S6;
			12'b0011_xx001xx: ns = S7;
			12'b0011_xx000xx: ns = S4;

			12'b0100_xx1xxxx: ns = S5;
			12'b0100_xx01xxx: ns = S6;
			12'b0100_xx001xx: ns = S7;
			12'b0100_xx000xx: ns = S4;

            12'b0101_xx0001x: ns = S4;
			12'b0101_xxxxx0x: ns = S5;
			12'b0101_xx1xx1x: ns = S5; // ~c1 + c1p1
			12'b0101_xxx1x1x: ns = S6;
			12'b0101_xxxx111: ns = S7;
			12'b0101_xxxx1x0: ns = S8;

            12'b0110_xx0001x: ns = S4;
			12'b0110_xx1xx1x: ns = S5;
			12'b0110_xxxxx0x: ns = S6;
			12'b0110_xxx1x1x: ns = S6;
			12'b0110_xxxx111: ns = S7;
			12'b0110_xxxx1x0: ns = S8;

            12'b0111_xx0001x: ns = S4;
			12'b0111_xx1xx11: ns = S5;
			12'b0111_xxx1x11: ns = S6;
			12'b0111_xxxxx0x: ns = S7;
			12'b0111_xxxx111: ns = S7;
			12'b0111_xxxx110: ns = S8;
			12'b0111_xxx1xx0: ns = S9;
			12'b0111_xx1xxx0: ns = S10;

            12'b1000_xx000xx: ns = S4;
			12'b1000_xx1xxx1: ns = S5;
			12'b1000_xxx1xx1: ns = S6;
			12'b1000_xxxx1x1: ns = S7;
			12'b1000_xxxx1x0: ns = S8;
			12'b1000_xxx1xx0: ns = S9;
			12'b1000_xx1xxx0: ns = S10;

            12'b1001_xx000xx: ns = S4;
			12'b1001_xx1xxx1: ns = S5;
			12'b1001_xxx1xx1: ns = S6;
			12'b1001_xxxx1x1: ns = S7;
			12'b1001_xxxx1x0: ns = S8;
			12'b1001_xxx1xx0: ns = S9;
			12'b1001_xx1xxx0: ns = S10;

			12'b1010_xx000xx: ns = S4;
			12'b1010_xx1xxx1: ns = S5;
			12'b1010_xxx1xx1: ns = S6;
			12'b1010_xxxx1x1: ns = S7;
			12'b1010_xxxx1x0: ns = S8;
			12'b1010_xxx1xx0: ns = S9;
			12'b1010_xx1xxx0: ns = S10;

            default: ns = S0;
        endcase

endmodule