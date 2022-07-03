// Module: Data memory

module dRam (clk, dAddr, d_in, MEM_WRITE, d_out, extAddr, ext_d_out);

input wire clk;                 // Clock
input wire [18:0] dAddr;        // Data Address
input wire [7:0] d_in;          // Data to be written
input wire [1:0] MEM_WRITE;     // Memory Write control signal
output reg [7:0] d_out;         // Data Memory Output

input wire [18:0] extAddr;      // Externally accessible data memory address input
output reg [7:0] ext_d_out;     // Externally accessible data memory output

reg [7:0] dRAM [16910:0];          // Data Memory -> 262145 bytes

initial begin
    $readmemb("C:\\Users\\Charith Janaka\\Desktop\\Sem_05\\CSD\\Processor_Design\\Repository\\Verilog\\src\\draminit.txt", dRAM);
end

always @ (extAddr)
begin
    ext_d_out <= dRAM[extAddr];
end

always @ (posedge clk)
begin
    if (MEM_WRITE == 2'b10)
        dRAM[dAddr] <= d_in;
    else
        d_out <= dRAM[dAddr]; 
end
endmodule


//                                       ---------------------------------------------
//                             clk----->|                                             |-----> d_out               
//                                      |                                             |-----> ext_d_out
//                           dAddr----->|                                             |                    
//                            d_in----->|               Data Memory                   |
//                       MEM_WRITE----->|                                             |
//                                      |                                             |
//                         extAddr----->|                                             |
//                                       ---------------------------------------------


