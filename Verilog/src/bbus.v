// Module: B Bus

`include "ctrlsigdef.v"

module bbus (B_SEL, DMAR, DMDR, R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, IMM, b_out);

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
input wire [18:0] IMM;
output wire [18:0] b_out;

assign b_out = (B_SEL == `asel_none)?   19'b0 
              :(B_SEL == `DMAR)?        DMAR
              :(B_SEL == `DMDR)?        DMDR
              :(B_SEL == `R0)?          R0
              :(B_SEL == `R1)?          R1
              :(B_SEL == `R2)?          R2
              :(B_SEL == `R3)?          R3
              :(B_SEL == `R4)?          R4
              :(B_SEL == `R5)?          R5
              :(B_SEL == `R6)?          R6
              :(B_SEL == `R7)?          R7
              :(B_SEL == `R8)?          R8
              :(B_SEL == `R9)?          R9
              :(B_SEL == `R10)?         R10
              :(B_SEL == `R11)?         R11
              :(B_SEL == `bsel_imm)?    IMM
              : 19'b0;

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
//              IMM -----> ||
//                         ||
//                        \  /
//                         \/


