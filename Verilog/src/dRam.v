// Module: Data memory

module dRam (clk, dAddr, d_in, MEM_WRITE, d_out);

input wire clk;                 // Clock
input wire [18:0] dAddr;        // Data Address
input wire [7:0] d_in;          // Data to be written
input wire MEM_WRITE;           // Memory Write control signal
output reg [7:0] d_out = 8'b0;  // Data Memory Output

reg [7:0] dRAM [262144:0];      // Data Memory -> 262145 bytes

always @ (posedge clk)
begin
    if (MEM_WRITE)
        dRAM[dAddr] <= d_in;
    else
        d_out <= dRAM[dAddr]; 
end

//                                       ---------------------------------------------
//                             clk----->|                                             |-----> d_out               
//                                      |                                             |
//                           dAddr----->|                                             |                    
//                            d_in----->|               Data Memory                   |
//                       MEM_WRITE----->|                                             |
//                                      |                                             |
//                                      |                                             |
//                                       ---------------------------------------------


