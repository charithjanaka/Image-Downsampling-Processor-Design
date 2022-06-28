// Module: instruction memory

module iRam (clk, iAddr, instr, FETCH);

input wire clk;                 // Clock
input wire [7:0] iAddr;         // Instruction Address
input wire FETCH;               // FETCH Control Signal
output reg [7:0] instr;         // Instruction Output

reg [7:0] iRAM [511:0];         // Instruction Memory -> 256 bytes

initial begin
    // Loading program into iRam
    iRAM[0] = 8'b00010001;
    iRAM[1] = 8'b00100010;
    //iRAM[2] = 8'b01000000;
    //iRAM[3] = 8'b00110010;
    //iRAM[4] = 8'b01010001;
    //iRAM[5] = 8'b00100001;
    //iRAM[6] = 8'b01000000;
    //iRAM[7] = 8'b01000010;
    //iRAM[8] = 8'b01110000;
    //iRAM[9] = 8'b00110100;

end

always @ (posedge clk)
begin
    if (FETCH) begin
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


