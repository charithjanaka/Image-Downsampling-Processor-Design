// Module: A Bus

`include "ctrlsigdef.v"

module abus (A_SEL, DMAR, DMDR, R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11);

input wire clk;
input wire [3:0] A_SEL;
input wire [18:0] DMAR;
input wire [18:0] DMDR;
input wire [18:0] R0;
input wire [18:0] R1;
input wire [18:0] R2;
input wire [18:0] R3;
input wire [18:0] R4;
input wire [18:0] R5;
input wire [18:0] R6;
input wire [18:0] R7;
input wire [18:0] R8;
input wire [18:0] R9;
input wire [18:0] R10;
input wire [18:0] R11;
output reg [18:0] a_out = 19'b0;

always @  (A_SEL)
begin
    case (A_SEL)
        `asel_none: a_out <= 19'b0;
        4'b0001:    a_out <= DMAR;
        4'b0010:    a_out <= DMDR;
        4'b0011:    a_out <= R0;
        4'b0100:    a_out <= R1;
        4'b0101:    a_out <= R2;
        4'b0110:    a_out <= R3;
        4'b0111:    a_out <= R4;
        4'b1000:    a_out <= R5;
        4'b1001:    a_out <= R6;
        4'b1010:    a_out <= R7;
        4'b1011:    a_out <= R8;
        4'b1100:    a_out <= R9;
        4'b1101:    a_out <= R10;
        4'b1110:    a_out <= R11;
        default:    a_out <= 19'b0;
    endcase
end
endmodule



//                         ||
//              DMAR-----> || <-----A_SEL
//              DMDR-----> ||
//              R0  -----> ||
//              R1  -----> ||
//              R2  -----> ||
//              R3  -----> ||
//              R4  -----> ||
//              R5  -----> ||
//              R6  -----> ||
//              R7  -----> ||
//              R8  -----> ||
//              R8  -----> ||
//              R10 -----> ||
//              R11 -----> ||
//                         ||
//                        \  /
//                         \/


