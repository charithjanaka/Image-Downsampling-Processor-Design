// Module: Program Counter

module pc( clk, RST, addr_in, BRANCH, addr_out);
    
input wire clk;                  // Clock
input wire RST;                  // Reset
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
        else if (PCI)
            addr_out <= addr_out + 8'b1;
        else
            addr_out <= addr_out; 
    end
end

endmodule

//                                       ---------------------------------------------
//                             clk----->|                                             |-----> addr_out                 
//                             RST----->|                                             |
//                          BRANCH----->|                                             |                    
//                                      |              Program Counter                |
//                         addr_in----->|                                             |
//                                      |                                             |
//                                      |                                             |
//                                      |                                             |
//                                      |                                             |
//                                       ---------------------------------------------