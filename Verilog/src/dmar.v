// Module: Data Memory Address Redister (DMAR)

module dmar( clk, RST, DATA_EN, data_in, data_out);

input wire clk;                      // Clock
input wire RST  [3:0];               // Reset
input wire DATA_EN [3:0];            // Data Enable 
input wire data_in [18:0];           // Data to be written

output reg [18:0] data_out = 19'b0;  // Data output 

always @ (posedge clk)
begin
    if (RST == 4'b0001)
        data_out <= 19'b0;
    else
    begin
        if (DATA_EN == 4'b0001)
            data_out <= data_in;
        else
            data_out <= data_out;
    end
end

endmodule