// Register file test bench

`timescale 1 ns / 100 ps

module alu_tb;

// Inputs

reg clk, RST;
reg [3:0] ALU_OP;
reg [18:0] a_in;
reg [18:0] b_in;

// Outputs

wire [18:0] alu_out;
wire z_flag;

alu alu_1(clk, RST, ALU_OP, a_in, b_in, alu_out, z_flag);

//Create a 500MHz clock
always
    #1 clk = ~clk;

initial begin
    clk = 1'b0;
    RST = 1'b0;
    ALU_OP = 4'b0;
    a_in = 19'b0;
    b_in = 19'b0;
    
    #10; // INCR
    a_in = 19'b0000000000000000001;
    ALU_OP = 4'b0001;

    #10; // ADDI
    a_in = 19'b0000000000000000001;
    b_in = 19'b0000000000000000010;
    ALU_OP = 4'b0010;

    #10; // SUBI
    a_in = 19'b0000000000000000100;
    b_in = 19'b0000000000000000100;
    ALU_OP = 4'b0011;
    
    #10; // ADDR
    a_in = 19'b0000000000000000001;
    b_in = 19'b0000000000000000001;
    ALU_OP = 4'b0100;

    #10; // SUBR
    a_in = 19'b0000000000000001000;
    b_in = 19'b0000000000000000001;
    ALU_OP = 4'b0101;

    #10; // SHL
    a_in = 19'b0000000000000000100;
    b_in = 19'b0000000000000000001;
    ALU_OP = 4'b0110;

    #10; // SHR
    a_in = 19'b0000000000000100000;
    b_in = 19'b0000000000000000001;
    ALU_OP = 4'b0111;

    #10; // OR
    a_in = 19'b0000000000000000100;
    b_in = 19'b0000000000000000001;
    ALU_OP = 4'b1000;

    #10; // ABUS
    a_in = 19'b0000000000000000010;
    ALU_OP = 4'b1001; 

end
endmodule


