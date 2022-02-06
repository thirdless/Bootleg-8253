module OUT_GEN (valid, p1, p2, os, osa, c1, ch, out);

    input valid, p1, p2, os, osa, c1, ch;
    output reg out;

    always @(valid or p1 or p2 or os or osa or c1 or ch)
        casex({valid, p1, p2, os, osa})
            5'b0xxxx: out = 1'b0;
            5'b11xxx: out = ch;
            5'b101xx: out = c1;
            5'b10011: out = c1;
            5'b10010: out = 1'b0;
            default: out = 1'b0;
        endcase

endmodule