// Module: Program Counter

module pc( clk, RST, PCI, addr_in, BRANCH, addr_out);
    
input wire clk;                  // Clock
input wire RST;                  // Reset
input wire PCI;                  // PC Increment
input wire [7:0] addr_in;        // Next instruction address input
input wire BRANCH;               // Branch control signal

output reg [7:0] addr_out;       // Next instruction address output

always @ (posedge clk or posedge RST)
begin
    if (RST == 1)
        addr_out <= 8'b0;
    else
    begin
        if (BRANCH == 1)
            addr_out <= addr_in;
        else if (PCI == 1)
            addr_out <= addr_out + 8'b00000001;
        else
            addr_out = addr_out; 
    end
end

endmodule

//                                       ---------------------------------------------
//                             clk----->|                                             |-----> addr_out                 
//                             RST----->|                                             |
//                             PCI----->|                                             |
//                          BRANCH----->|                                             |                    
//                                      |              Program Counter                |
//                         addr_in----->|                                             |
//                                      |                                             |
//                                      |                                             |
//                                      |                                             |
//                                      |                                             |
//                                       ---------------------------------------------