// Module: Instruction Register

module ir( clk, RST, ir_in, immediate, ir_out);
    
input wire clk;                  // Clock
input wire RST;                  // Reset
input wire [7:0] ir_in;          // Instruction
output wire [3:0] immediate;     // Immediate data output
output reg [7:0] ir_out;        // Output to controller

always @ (posedge clk or posedge RST)
begin
    if (RST == 1)
        ir_out <= 8'b0;
    else
        ir_out <= ir_in;
end

assign immediate = ir_out[3:0];

endmodule

//                                       ---------------------------------------------
//                             clk----->|                                             |-----> ir_out                 
//                             RST----->|                                             |-----> immediate
//                                      |                                             |                    
//                                      |             Instruction Register            |
//                           ir_in----->|                                             |
//                                      |                                             |
//                                      |                                             |
//                                       ---------------------------------------------