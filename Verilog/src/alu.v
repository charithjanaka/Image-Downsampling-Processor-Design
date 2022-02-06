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
        3'b000:                                         // INCR
            alu_out = a_in + 19'd1;
        3'b001:                                         // ADDI
            alu_out = a_in + b_in;
        3'b010:begin                                    // SUBI
            alu_out = a_in - b_in;
            z = (alu_out == 19'b0);
        end
        3'b011:                                         // ADDR
            alu_out = a_in + b_in;  
        3'b100: begin                                   // SUBR
            alu_out = a_in - b_in; 
            z = (alu_out == 19'b0); 
        end                  
        3'b101:                                         // SHL
            alu_out = a_in << b_in;
        3'b110:                                         // SHR
            alu_out = a_in >> b_in;
        3'b111:                                         // OR
            alu_out = a_in | b_in;
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
