// Module: Program Counter
// Author: M.M.C.J.Bandara - 180065C
// 06/01/2022

module zero(
    input clk,                  // Clock
    input ALU_EN;               // Enable input port from ALU
    input OUT_EN;               // Enable output port to Controller
    input alu_in;               // Input port
    input RST;                  // Reset signal
    output out;                 // Output port
);

reg data;
initial data = 1'b0;

always @ (posedge clk)
begin
    if (RST == 1)
        data <= 1'b0;
    else
        if (ALU_EN == 1'b1)
            data <= alu_in;
        else if (OUT_EN == 1'b1)
            out <= data;
end

endmodule