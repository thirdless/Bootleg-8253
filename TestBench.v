module TestBench;

reg clk, reset, cs, wr, a0;
reg [15:0] data;

TIMER TIMER(clk, reset, data, cs, wr, a0, out);

initial begin
    clk = 1'b0;
    forever #1 clk = ~clk;
end

initial begin
/*    clk = 1'b0;
    forever #1 clk = ~clk;
    reset = 1'b1;
    data = 16'b0;
    cs = 1'b0;
    wr = 1'b0;
    a0 = 1'b0;

    #2;
    reset = 1'b0;
    cs = 1'b1;
    wr = 1'b0;
    a0 = 1'b0;
    
    #2;
    data = 16'b0000111100000000;
    a0 = 1'b1;

    #2;
    cs = 1'b0;
    wr = 1'b0;
    a0 = 1'b0;

    #10;
    data = 16'b0000111100000000;
    wr = 1'b1; */

    reset = 1'b1;
    data = 16'b101;
    wr = 1'b1;
    a0 = 1'b0;
    cs = 1'b0;

    #2;
    wr = 1'b1;
    reset = 1'b0;
    cs = 1'b1;
    a0 = 1'b1;
    data = 16'b100;

    #2;
    a0 = 1'b0;
    data = 16'b110;

    #100 $finish;
end

initial begin
    $dumpfile("test.vcd"); $dumpvars;
end


endmodule