// Module: instruction memory

module iRam (clk, iAddr, instr, FETCH);

input wire clk;                 // Clock
input wire [7:0] iAddr;         // Instruction Address
input wire [1:0] FETCH;         // FETCH Control Signal
output reg [7:0] instr;         // Instruction Output

reg [7:0] iRAM [255:0];         // Instruction Memory -> 256 bytes

initial begin
    // Loading program into iRam
    iRAM[0] = 8'b00000001;
    iRAM[1] = 8'b00000010;
    iRAM[2] = 8'b00000011;
    iRAM[3] = 8'b00000100;
    iRAM[4] = 8'b00000101;
end

always @ (posedge clk)
begin
    if (FETCH == 2'b01) begin
        instr <= iRAM [iAddr];
    end
end

endmodule

//                                       ---------------------------------------------
//                             clk----->|                                             |-----> instr               
//                                      |                                             |
//                           iAddr----->|                                             |                    
//                           FETCH----->|             Instruction Memory              |
//                                      |                                             |
//                                      |                                             |
//                                      |                                             |
//                                       ---------------------------------------------


