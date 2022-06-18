// Module: A Bus

`include "ctrlsigdef.v"
`include "regdef.v"

module abus (A_SEL, DMAR, DMDR, R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, a_out);

input wire  [3:0]   A_SEL;
input wire  [18:0]  DMAR;
input wire  [18:0]  DMDR;
input wire  [18:0]  R0;
input wire  [18:0]  R1;
input wire  [18:0]  R2;
input wire  [18:0]  R3;
input wire  [18:0]  R4;
input wire  [18:0]  R5;
input wire  [18:0]  R6;
input wire  [18:0]  R7;
input wire  [18:0]  R8;
input wire  [18:0]  R9;
input wire  [18:0]  R10;
input wire  [18:0]  R11;
output wire [18:0]  a_out;
    
assign a_out = (A_SEL == `asel_none)?   19'b0 
              :(A_SEL == `DMAR)?        DMAR
              :(A_SEL == `DMDR)?        DMDR
              :(A_SEL == `R0)?          R0
              :(A_SEL == `R1)?          R1
              :(A_SEL == `R2)?          R2
              :(A_SEL == `R3)?          R3
              :(A_SEL == `R4)?          R4
              :(A_SEL == `R5)?          R5
              :(A_SEL == `R6)?          R6
              :(A_SEL == `R7)?          R7
              :(A_SEL == `R8)?          R8
              :(A_SEL == `R9)?          R9
              :(A_SEL == `R10)?         R10
              :(A_SEL == `R11)?         R11
              : 19'b0;
                    
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


