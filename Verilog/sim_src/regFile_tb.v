// Register file test bench

`timescale 1 ns / 100 ps

module regFile_tb;

// Inputs

reg clk;
reg [3:0] RST_SEL, C_SEL, A_SEL, B_SEL;
reg [18:0] c_in;
reg [1:0] MEM;
reg [7:0] mem_data;

// Outputs

wire [18:0] a_out, b_out, dm_addr;
wire [7:0] dm_data;

regFile regFile1( clk, RST_SEL, C_SEL, c_in, A_SEL, B_SEL, MEM, mem_data, a_out, b_out, dm_addr, dm_data);

// Create a 50MHz clock
always
    #10 clk = ~clk;

initial begin
    clk = 1'b0;
    RST_SEL = 1'b0;
    C_SEL = 4'b0;
    c_in = 19'b0;
    A_SEL = 4'b0;
    B_SEL = 4'b0;
    MEM = 2'b0;
    mem_data = 8'b0;
    
    #10;
    RST_SEL = 4'b0001;
    
    #10;
    C_SEL = 4'd1;
    c_in = 19'd10;
    
    #10;
    A_SEL = 4'd1;
    B_SEL = 4'd2;
end
endmodule


