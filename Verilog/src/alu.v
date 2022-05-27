// Module: ALU

module alu( clk, RST, ALU_OP, a_in, b_in, alu_out, z_flag);  

input wire clk;
input wire RST;
input [3:0] ALU_OP;
input [18:0] a_in;
input [18:0] b_in;

output reg [18:0] alu_out = 19'b0;
output reg z_flag = 1'b0;

reg z;

always @ (posedge clk or posedge RST)
begin
    if (RST)
        z_flag <= 1'b0;
    else
        z_flag <= z;
end    

always @ (a_in or b_in)
begin
    case (ALU_OP)
        4'b0001:                                         // INCR
            alu_out = a_in + 19'd1;
        4'b0010:                                         // ADDI
            alu_out = a_in + b_in;
        4'b0011:begin                                    // SUBI
            alu_out = a_in - b_in;
            z = (alu_out == 19'b0);
        end
        4'b0100:                                         // ADDR
            alu_out = a_in + b_in;  
        4'b0101: begin                                   // SUBR
            alu_out = a_in - b_in; 
            z = (alu_out == 19'b0); 
        end                  
        4'b0110:                                         // SHL
            alu_out = a_in << b_in;
        4'b0111:                                         // SHR
            alu_out = a_in >> b_in;
        4'b1000:                                         // OR
            alu_out = a_in | b_in;
        4'b1001:                                         // A Bus
            alu_out = a_in;
        default:
            alu_out = 19'b0; 
    endcase
end

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
