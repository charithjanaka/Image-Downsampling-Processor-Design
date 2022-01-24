// Module: Program Counter
// Author: M.M.C.J.Bandara - 180065C
// 06/01/2022

module ir(
    input clk,                  // Clock
    input RST,                  // Reset
    input instr,                // Instruction
    output immediate,           // Immediate data output
    output out                  // Output to controller
);

reg [7:0] data;
initial data = 8'b00000000;

always @ (posedge clk)
begin
    if (RST == 1)
        data <= 8'b00000000;
    else
        data <= instr;
end

assign immediate = data;
assign out = data;

endmodule