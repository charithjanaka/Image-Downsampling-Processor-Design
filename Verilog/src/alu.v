// Module: ALU

`include "aluopdef.v"

module alu( ALU_OP, a_in, b_in, alu_out, z_flag);  

input wire [3:0] ALU_OP;                // ALU Operation
input wire [18:0] a_in;                 // A-Bus input
input wire [18:0] b_in;                 // B-Bus input

output wire [18:0] alu_out;             // ALU Output
output wire z_flag;                     // Z-Flag

reg [18:0] alu_tmp;

always @ (*)
begin
    case (ALU_OP)
        `INCR:                                         
            alu_tmp <= a_in + 19'd1;
        `ADDI:                                        
            alu_tmp <= a_in + b_in;
        `SUBI:                                       
            alu_tmp <= a_in - b_in;
        `ADDR:                                        
            alu_tmp <= a_in + b_in;  
        `SUBR:                                         
            alu_tmp <= a_in - b_in;                
        `SHL:                                         
            alu_tmp <= a_in << b_in;
        `SHR:                                        
            alu_tmp <= a_in >> b_in;
        `OR:                                         
            alu_tmp <= a_in | b_in;
        `ABUS:                                        
            alu_tmp <= a_in;
        default:
            alu_tmp <= alu_tmp;
    endcase
end

assign alu_out = alu_tmp;
assign z_flag = (alu_tmp == 0);

endmodule


//                                       ---------------------------------------------
//                          ALU_OP----->|                                             |-----> c_out                  
//                                      |                                             |-----> z_flag                     
//                            a_in----->|                                             |
//                            b_in----->|                   ALU                       |
//                                      |                                             |
//                                      |                                             |
//                                      |                                             |
//                                       ---------------------------------------------
