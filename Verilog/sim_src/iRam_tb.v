// IRAM Test Bench

`timescale 1 ns / 100 ps

module iRAM_tb;

// Inputs

reg clk, FETCH;
reg [7:0] iAddr;

// Outputs

wire [7:0] instr;

iRam iRam1 (clk, iAddr, instr, FETCH);

//Create a 500MHz clock
always
    #1 clk = ~clk;

initial begin
    clk = 1'b0;
    FETCH = 1'b0;
    iAddr = 8'b0;

    #10
    iAddr = 8'b0;
    FETCH = 1'b1;

    #10
    iAddr = 8'd1;

    #10
    iAddr = 8'd2;

    #10
    iAddr = 8'd3;

    #10
    iAddr = 8'd4;
end

endmodule