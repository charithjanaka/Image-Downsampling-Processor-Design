// PC Test Bench

`timescale 1 ns / 100 ps

module pc_tb;

// Inputs

reg clk, RST, PCI, BRANCH;
reg [7:0] addr_in;

// Outputs

wire [7:0] addr_out;

pc pc1( clk, RST, PCI, addr_in, BRANCH, addr_out);

//Create a 500MHz clock
always
    #1 clk = ~clk;

initial begin
    clk = 1'b0;
    RST = 1'b0;
    PCI = 1'b0;
    BRANCH = 1'b0;
    addr_in = 8'b0;

    #10
    RST = 1'b1;

    #10
    RST = 1'b0;
    PCI = 1'b1;

    #10
    PCI = 1'b0;

    #10
    addr_in = 8'd12;
    BRANCH = 1'b1;

    #10
    BRANCH = 1'b0;
    PCI = 1'b1;
end

endmodule