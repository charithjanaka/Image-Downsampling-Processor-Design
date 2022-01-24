// Module: Data Memory Data Register (DMDR)

module dmdr( clk, RST, DATA_EN, MEM_EN, data_in, mem_in, data_out);

input wire clk;                      // Clock
input wire RST [3:0];                // Reset
input wire DATA_EN [3:0];            // Data Enable 
input wire MEM_EN;                   // Memory Data Enable
input wire data_in [18:0];           // Data to be written
input wire mem_in [7:0];             // Data from Memory

output reg [18:0] data_out = 19'b0;  // Data output

always @ (posedge clk)
begin
    if (RST == 4'b0010)
        data <= 19'b0;
    else
    begin
        if (DATA_EN == 4'b0010)
            data_out <= data_in;
        else if (MEM_EN == 1)
            data_out <= {{11{0}},mem_in[7:0]};
        else
            data_out <= data_out;
    end
end

endmodule