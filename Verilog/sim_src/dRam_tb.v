// DRAM test bench

`timescale 1 ns / 100 ps

module dRam_tb;

// Inputs

reg clk, MEM_WRITE;
reg [18:0] dAddr;
reg [7:0] d_in;

// Outputs

wire [7:0] d_out;

dRam dRam_1(clk, dAddr, d_in, MEM_WRITE, d_out);

//Create a 500MHz clock

always
    #1 clk = ~clk;

initial begin
    clk     =   1'b0;
    dAddr   =   19'd0;
    d_in    =   8'b0;
    MEM_WRITE = 1'b0;

    #2
    dAddr   =   19'd10;
    d_in    =   8'd255;
    MEM_WRITE   =   1;

    #2
    dAddr   =   19'd100;
    d_in    =   8'd5;
    MEM_WRITE   =   1;

    #2
    MEM_WRITE   =   0;

    #2
    dAddr   =   19'd10;

    #2
    dAddr   =   19'd100;
end

endmodule