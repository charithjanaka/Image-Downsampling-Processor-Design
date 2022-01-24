// Module: Program Counter
// Author: M.M.C.J.Bandara - 180065C
// 06/01/2022

module pc(
    input clk,                  // Clock
    input addr_in[7:0],         // Next instruction address input
    input RST,                  // Reset
    input BRANCH,               // Branch
    output reg [7:0] addr_out   // Next instruction address output
);

always @ (posedge clk)
begin
    if (RST == 1)
        addr_out <= 8'b00000000;
    else
    begin
        if (BRANCH == 1)
            addr_out <= addr_in;
        else
            addr_out <= addr_out + 8'b00000001; 
    end
end

endmodule