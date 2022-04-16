// Module: B Bus

`include "ctrlsigdef.v"

module bbus (B_SEL, DMAR, DMDR, R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, MUX);

input wire clk;
input wire [3:0] B_SEL;
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
input wire [18:0] MUX;
output reg [18:0] b_out = 19'b0;

always @  (B_SEL)
begin
    case (B_SEL)
        `bsel_none: b_out <= 19'b0;
        4'b0001:    b_out <= DMAR;
        4'b0010:    b_out <= DMDR;
        4'b0011:    b_out <= R0;
        4'b0100:    b_out <= R1;
        4'b0101:    b_out <= R2;
        4'b0110:    b_out <= R3;
        4'b0111:    b_out <= R4;
        4'b1000:    b_out <= R5;
        4'b1001:    b_out <= R6;
        4'b1010:    b_out <= R7;
        4'b1011:    b_out <= R8;
        4'b1100:    b_out <= R9;
        4'b1101:    b_out <= R10;
        4'b1110:    b_out <= R11;
        `bsel_mux:  b_out <= MUX;
        default:    b_out <= 19'b0;
    endcase
end
endmodule



//                         ||
//              DMAR-----> || <-----B_SEL
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
//              MUX -----> ||
//                         ||
//                        \  /
//                         \/


