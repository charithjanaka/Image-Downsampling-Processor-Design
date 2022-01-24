// Module: Program Counter
// Author: M.M.C.J.Bandara - 180065C
// 06/01/2022

module dmdr(
    input clk,                      // Clock
    input  A_EN [3:0],              // Enable to A bus
    input  B_EN [3:0],              // Enable to B bus
    input  C_EN [3:0],              // Enable to be written from C bus
    input  RST  [3:0],              // Reset
    input  c_in [18:0],             // Data to be written from C bus
    output mem_in [7:0]             // Data from data memory
    output a_out [18:0],            // Output data to A bus
    output b_out [18:0],            // Output data to B bus
    output mem_out [7:0]            // Output port to data memory
);

reg [18:0] data;
initial data = 19'b0000000000000000000;

always @ (posedge clk)
begin
    if (RST == 1)
        data <= 19'b0000000000000000000;
    else
    begin
        if (A_EN == 4'b0010)
            a_out <= data;
        else if (B_EN == 4'b0010)
            b_out <= data;
        else if (C_EN == 4'b0010)
            data <= c_in;
        else
            data <= {{11{0}},mem_in[7:0]};
    end
end

assign mem_out = data[7:0];

endmodule