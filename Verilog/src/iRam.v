// Module: instruction memory

module iRam (clk, iAddr, instr, FETCH);

input wire clk;                 // Clock
input wire [7:0] iAddr;         // Instruction Address
input wire FETCH;               // FETCH Control Signal
output reg [7:0] instr;         // Instruction Output

reg [7:0] iRAM [511:0];         // Instruction Memory -> 512 bytes

initial begin
    // Loading program into iRam
    $readmemb("C:\\Users\\Charith Janaka\\Desktop\\Sem_05\\CSD\\Processor_Design\\Repository\\Verilog\\src\\iraminit.txt", iRAM, 0, 9);
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


