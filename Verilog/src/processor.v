// Module: Processor

module processor (clk, processor_start, read_data, instr, next_instr_addr, write_addr, write_data, IFETCH, MEM, STATE, status);

input wire clk;
input wire processor_start;
input wire [7:0] read_data;
input wire [7:0] instr;

output wire [7:0] next_instr_addr;
output wire [18:0] write_addr;
output wire [7:0] write_data;
output wire IFETCH;
output wire [1:0] MEM;
output wire [5:0] STATE;
output wire status;

// Buses
wire [18:0] a_bus;
wire [18:0] b_bus;
wire [18:0] c_bus;
wire z_bus;

// Interconnect wires - Ctrl Signals          
wire PCI;  
wire [3:0] RST_SEL; 
wire RST_ALU;
wire RST_IR;
wire RST_PC; 
wire [3:0] A_SEL;                       
wire [3:0] B_SEL;                       
wire [3:0] C_SEL;                         
wire [3:0] ALU_OP;                                                                        
wire BRANCH;                                         

// Interconnect wires - Other
wire [3:0] immediate;
wire [7:0] ir_out;                                                                                                                                                         
                               
// Instantiate Modules
alu alu_(
            .clk(clk), 
            .RST(RST_ALU), 
            .ALU_OP(ALU_OP), 
            .a_in(a_bus), 
            .b_in(b_bus), 
            .alu_out(c_bus), 
            .z_flag(z_bus));

ctrlunit ctrlunit_(
                    .clk(clk), 
                    .start(processor_start),
                    .instr(ir_out), 
                    .z_flag(z_bus), 
                    .status(status),
                    .PCI(PCI), 
                    .RST_SEL(RST_SEL), 
                    .RST_ALU(RST_ALU), 
                    .RST_IR(RST_IR), 
                    .RST_PC(RST_PC), 
                    .A_SEL(A_SEL), 
                    .B_SEL(B_SEL), 
                    .C_SEL(C_SEL), 
                    .ALU_OP(ALU_OP), 
                    .IFETCH(IFETCH),
                    .MEM(MEM), 
                    .BRANCH(BRANCH), 
                    .STATE(STATE));
                    
ir ir_(
        .clk(clk), 
        .RST(RST_IR), 
        .ir_in(instr), 
        .immediate(immediate), 
        .ir_out(ir_out));

pc pc_(
        .clk(clk), 
        .RST(RST_PC), 
        .PCI(PCI), 
        .addr_in(c_bus[7:0]), 
        .BRANCH(BRANCH), 
        .addr_out(next_instr_addr));

regFile regfle_(
                    .clk(clk), 
                    .RST_SEL(RST_SEL), 
                    .C_SEL(C_SEL), 
                    .c_in(c_bus), 
                    .immediate(immediate),
                    .A_SEL(A_SEL), 
                    .B_SEL(B_SEL), 
                    .MEM(MEM), 
                    .mem_data(read_data),
                    .a_out(a_bus), 
                    .b_out(b_bus), 
                    .dm_addr(write_addr), 
                    .dm_data(write_data));
endmodule