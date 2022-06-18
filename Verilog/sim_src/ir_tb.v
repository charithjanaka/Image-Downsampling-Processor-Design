// IR test bench

`timescale 1 ns / 100 ps

module ir_tb;

// Inputs

reg clk, RST;
reg [7:0] ir_in;

// Outputs

wire [7:0] ir_out;
wire [3:0] immediate;

ir ir1( clk, RST, ir_in, immediate, ir_out);

//Create a 500MHz clock
always
    #1 clk = ~clk;

initial begin
    clk = 1'b0;
    RST = 1'b0;
    ir_in = 8'b0;

    #10
    ir_in = 8'b00000001;

    #10
    ir_in = 8'b00001000;

    #10
    ir_in = 8'b10000011;

end

endmodule