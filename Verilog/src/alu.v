// Module: Program Counter
// Author: M.M.C.J.Bandara - 180065C
// 07/01/2022

module alu( clk, A, B, ALU_SEL, alu_out, zero_flag);  

input clk;
input [3:0] ALU_SEL;
input [18:0] A;
input [18:0] B;

output reg [18:0] alu_result = 19'b0;
reg flag = 1'b0;

always @ (alu_result)
begin
    if (alu_result == 19'b0) zero_flag <= 1; else zero_flag = 0;
end    

always @ (posedge clk)
begin
    case (ALU_SEL)
        3'b000:                                         // INCR
            alu_result <= A + 19'b0000000000000000001;
        3'b001:                                         // ADDI & ADDR
            alu_result <= A + B;
        3'b010:                                         // SUBI & SUBR
            alu_result <= A - B;
        3'b011:                                         // SHL
            alu_result <= A << B;
        3'b100;                                         // SHR
            alu_result <= A >> B;
        3'b101:                                         // OR
            alu_result <= A | B;
        default:
            alu_result <= 19'b0; 
    end
end

endmodule