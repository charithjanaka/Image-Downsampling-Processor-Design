// Module: Register File

module regFile( clk, RST, RST_SEL, C_EN, C_SEL, c_in, A_SEL, B_SEL, MEM_READ, mem_data, a_out, b_out, dm_addr, dm_data);

input wire clk;                      // Clock
input wire RST;                      // Reset
input wire [3:0] RST_SEL;            // Reset selection
input wire C_EN;                     // C bus Enable 
input wire [3:0] C_SEL;              // C bus selection
input wire [18:0] c_in;              // C bus input data
input wire [3:0] A_SEL;              // A bus selection
input wire [3:0] B_SEL;              // B bus selection
input wire MEM_READ;                 // Memory read
input wire [7:0] mem_data;           // Data memory read data input
output wire [18:0] a_out;            // a bus output
output wire [18:0] b_out;            // b bus output
output wire [18:0] dm_addr;          // Data memory address output
output wire [7:0] dm_data;           // Data memory write data output

reg [18:0] regs[13:0];



always @ (posedge clk or posedge RST)
begin
    if (RST == 1)
        regs[RST_SEL] <= 19'b0;
    else if (MEM_READ == 1)
        regs[1] <= {{11{0}},mem_data[7:0]};
    else
    begin
        if (C_EN == 1)
            regs[C_SEL] <= c_in;
    end
end

assign a_out = regs[A_SEL];
assign b_out = regs[B_SEL];
assign dm_addr = regs[0];
assign dm_data = regs[1][7:0];

endmodule

//                                       ---------------------------------------------
//                             clk----->|                                             |-----> a_out                  
//                             RST----->|                                             |-----> b_out                     
//                         RST_SEL----->|                                             |
//                                      |                                             |-----> dm_addr
//                            C_EN----->|                                             |-----> dm_data
//                           C_SEL----->|                                             |
//                            c_in----->|               Register File                 |
//                                      |                                             |
//                           A_SEL----->|                                             |
//                           B_SEL----->|                                             |
//                                      |                                             |
//                        MEM_READ----->|                                             |
//                        mem_data----->|                                             |
//                                      |                                             |
//                                       ---------------------------------------------