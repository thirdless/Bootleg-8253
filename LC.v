//module LC (di, p1, p2, os);
module LC (in, P1, P2, OS);

    input [2:0] in;
    output reg P1, P2, OS;

    initial begin
        {P1, P2, OS} = 3'b000;
    end

    always @(in)
    begin
        if (in[2])
            P1 = 1;
        else
            begin
                if (in[1]) 
                    P2 = 1;
                else
                    OS = 1;
            end
    end

  /*  input [2:0] di;
	output reg p1, p2, os;

	always @(di)
		casex(di)
			3'b1xx: {p1,p2,os} = 3'b100;
			3'b01x: {p1,p2,os} = 3'b010;
			3'b001: {p1,p2,os} = 3'b001;
			default: {p1,p2,os} = 3'b000;
		endcase*/

endmodule