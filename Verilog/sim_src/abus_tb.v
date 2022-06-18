// A BUS test bench

`timescale 1 ns / 100 ps

module abus_tb;

// Inputs
reg [3:0] A_SEL;
reg [18:0] DMAR, DMDR, R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11;

// Outputs
wire [18:0] a_out;

abus abus_1(A_SEL, DMAR, DMDR, R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, a_out);

//Create a 500MHz clock

initial begin
    A_SEL = 4'b0;
    DMAR  = 19'd1;
    DMDR  = 19'd2;
    R0    = 19'd3;
    R1    = 19'd4;
    R2    = 19'd5;
    R3    = 19'd6;
    R4    = 19'd7;
    R5    = 19'd8;
    R6    = 19'd9;
    R7    = 19'd10;
    R8    = 19'd11;
    R9    = 19'd12;
    R10   = 19'd13;
    R11   = 19'd14;

    #2
    A_SEL = 4'b0001;

    #2
    A_SEL = 4'b0010;

    #2
    A_SEL = 4'b0011;

    #2
    A_SEL = 4'b0100;

    #2
    A_SEL = 4'b0101;

    #2
    A_SEL = 4'b0110;

    #2
    A_SEL = 4'b0111;

    #2
    A_SEL = 4'b1000;

    #2
    A_SEL = 4'b1001;

    #2
    A_SEL = 4'b1010;

    #2
    A_SEL = 4'b1011;

    #2
    A_SEL = 4'b1100;

    #2
    A_SEL = 4'b1101;

    #2
    A_SEL = 4'b1110;

end

endmodule