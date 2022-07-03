// Module: instruction memory

module iRam (clk, iAddr, instr, FETCH);

input wire clk;                 // Clock
input wire [7:0] iAddr;         // Instruction Address
input wire FETCH;               // FETCH Control Signal
output reg [7:0] instr;         // Instruction Output

reg [7:0] iRAM [511:0];         // Instruction Memory -> 512 bytes

initial begin
    // Loading program into iRam
    $readmemb("C:\\Users\\Charith Janaka\\Desktop\\Sem_05\\CSD\\Processor_Design\\Repository\\Verilog\\src\\iraminit.txt", iRAM);
    //iRAM[0] = 8'b00010001;
    //iRAM[1] = 8'b00100010;
    //iRAM[2] = 8'b01000000;
    //iRAM[3] = 8'b11010010;
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


