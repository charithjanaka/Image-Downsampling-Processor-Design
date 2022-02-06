// Register file test bench

`timescale 1 ns / 100 ps

module regFile_tb;

// Inputs

reg clk, RST, C_EN, MEM_READ;
reg [3:0] RST_SEL, C_SEL, A_SEL, B_SEL;
reg [18:0] c_in;
reg [7:0] mem_data;

// Outputs

wire [18:0] a_out, b_out, dm_addr;
wire [7:0] dm_data;

regFile regFile_1(clk, RST, RST_SEL, C_EN, C_SEL, c_in, A_SEL, B_SEL, MEM_READ, mem_data, a_out, b_out, dm_addr, dm_data );

// Create a 50MHz clock
always
    #10 clk = ~clk;

initial begin
    clk = 1'b0;
    RST = 1'b0;
    C_EN = 1'b0;
    MEM_READ = 1'b0;
    RST_SEL = 4'b0;
    C_SEL = 4'b0;
    A_SEL = 4'b0;
    B_SEL = 4'b0;
    c_in = 19'b0;
    mem_data = 8'b0;
    
    #20;
    RST = 1'b1;
    RST_SEL = 4'b1;
    RST = 1'b0;
    
    #30;
    C_EN = 1'b1;
    C_SEL = 4'b1;
    c_in = 19'd10;
    
    #40;
    C_EN = 1'b0;
    A_SEL = 4'b1;
    B_SEL = 4'b0;
end
endmodule


