// Module: instruction memory

module iRam (clk, iAddr, instr, FETCH);

input wire clk;                 // Clock
input wire [7:0] iAddr;         // Instruction Address
input wire FETCH;               // FETCH Control Signal
output reg [7:0] instr = 8'b0;  // Instruction Output

reg [7:0] iRAM [255:0];         // Instruction Memory -> 256 bytes

initial begin
    // Loading program into iRam

end

always @ (posedge clk)
begin
    if (FETCH) begin
        instr <= iRAM [iAddr];
    end
end

//                                       ---------------------------------------------
//                             clk----->|                                             |-----> ins               
//                                      |                                             |
//                           iAddr----->|                                             |                    
//                           FETCH----->|             Instruction Memory              |
//                                      |                                             |
//                                      |                                             |
//                                      |                                             |
//                                       ---------------------------------------------


