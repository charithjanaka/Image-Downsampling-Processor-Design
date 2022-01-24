// Module: Program Counter
// Author: M.M.C.J.Bandara - 180065C
// 06/01/2022

module dmar(
    input clk,                      // Clock
    input  A_EN [3:0],              // Enable to A bus
    input  B_EN [3:0],              // Enable to B bus
    input  C_EN [3:0],              // Enable to be written from C bus
    input  RST  [3:0],              // Reset
    input  c_in [18:0],             // Data to be written from C bus
    output a_out [18:0],            // Output data to A bus
    output b_out [18:0],            // Output data to B bus
    output addr_out [18:0]          // Address output to data memory
);

reg [18:0] addr;
initial addr = 19'b0000000000000000000;

always @ (posedge clk)
begin
    if (RST == 1)
        addr <= 19'b0000000000000000000;
    else
    begin
        if (A_EN == 4'b0001)
            a_out <= addr;
        else if (B_EN == 4'b0001)
            b_out <= addr;
        else if (C_EN == 4'b0001)
            addr <= c_in;
        else
            addr_out <= addr;
    end
end

endmodule