// Module: ALU

`include "aluopdef.v"

module alu( clk, RST, ALU_OP, a_in, b_in, alu_out, z_flag);  

input wire clk;
input wire RST;
input wire [3:0] ALU_OP;
input wire [18:0] a_in;
input wire [18:0] b_in;

output wire [18:0] alu_out;
output wire z_flag;

reg [18:0] alu_tmp;

always @ (posedge clk)
begin

    if (RST) begin
        alu_tmp <= 19'b0;
    end

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
            alu_tmp <= 19'b0; 
    endcase
end

assign alu_out = alu_tmp;
assign z_flag = (alu_tmp == 0);

endmodule








//                                       ---------------------------------------------
//                             clk----->|                                             |-----> c_out                  
//                             RST----->|                                             |-----> z_flag                     
//                                      |                                             |
//                          ALU_OP----->|                                             |
//                                      |                   ALU                       |
//                            a_in----->|                                             |
//                            b_in----->|                                             |
//                                      |                                             |
//                                      |                                             |
//                                       ---------------------------------------------
