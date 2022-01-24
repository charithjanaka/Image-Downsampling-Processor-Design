// Module: Program Counter
// Author: M.M.C.J.Bandara - 180065C
// 07/01/2022

module mux2to1(   
    input [18:0]  a,
    input [7:0]   b,
    input [1:0] sel,
    output [18:0] out
);

always @ (a or b or sel)
begin
    case (sel)
        2'b01: out <= a;
        2'b11: out <= {{11{0}},b[7:0]};
    endcase
end

endmodule