// Module: Instruction Register

module ir( ir_in, immediate, ir_out);
    
input wire [7:0] ir_in;           // Instruction
output wire [3:0] immediate;      // Immediate data output
output reg [7:0] ir_out;          // Output to controller

always @ (*)
begin
    ir_out <= ir_in;
end

assign immediate = ir_out[3:0];

endmodule

//                                       ---------------------------------------------
//                           ir_in----->|                                             |-----> ir_out                 
//                                      |                                             |-----> immediate
//                                      |                                             |                    
//                                      |             Instruction Register            |
//                                      |                                             |
//                                      |                                             |
//                                      |                                             |
//                                       ---------------------------------------------