module RNIF (data, plnif, reset, clk, out);

    input plnif, clk, reset;
    input [15:0] data;
    output reg [15:0] out;

    always @(posedge clk)
    begin
        if(reset)
        begin
            out <= 16'b0;
        end else begin
            if(plnif) begin
                out <= data;
            end
        end
    end

endmodule