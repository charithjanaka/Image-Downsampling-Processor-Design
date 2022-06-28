// test bench for top level module

`timescale 1 ns / 100 ps

module test;

// Inputs

reg clk, power_ON;

top_level_module top_level_module_(clk, power_ON);

// Create a 50MHz clock
always
    #10 clk = ~clk;

initial begin
    clk = 1'b0;
    power_ON = 1'b0;

    #10
    power_ON = 1'b1;
end

endmodule