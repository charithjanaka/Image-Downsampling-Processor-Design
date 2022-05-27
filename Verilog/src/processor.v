// Module: Processor

module processor (clk, status);

input wire clk;
input wire [1:0] status;

// Instruction Menory connections
wire [7:0] iAddr;
wire FETCH;
wire [7:0] instr;

// Data Memory connections
wire [18:0] dAddr;
wire [7:0] d_in;
wire MEM_WRITE;
wire d_out;

// A-Bus connections
wire [3:0] A_SEL;
wire [18:0] DMAR_A;
wire [18:0] DMDR_A;
wire [18:0] R0_A;
wire [18:0] R1_A;
wire [18:0] R2_A;
wire [18:0] R3_A;
wire [18:0] R4_A;
wire [18:0] R5_A;
wire [18:0] R6_A;
wire [18:0] R7_A;
wire [18:0] R8_A;
wire [18:0] R9_A;
wire [18:0] R10_A;
wire [18:0] R11_A;
wire [18:0] a_out_A;

// B-Bus connections
wire [3:0] B_SEL;
wire [18:0] DMAR_B;
wire [18:0] DMDR_B;
wire [18:0] R0_B;
wire [18:0] R1_B;
wire [18:0] R2_B;
wire [18:0] R3_B;
wire [18:0] R4_B;
wire [18:0] R5_B;
wire [18:0] R6_B;
wire [18:0] R7_B;
wire [18:0] R8_B;
wire [18:0] R9_B;
wire [18:0] R10_B;
wire [18:0] R11_B;
wire [18:0] b_out_B;

// ALU connections
wire RST_ALU;
wire [3:0] ALU_OP;
wire [18:0] a_in;
wire [18:0] b_in;
wire [18:0] alu_out;
wire z_flag;

// Instruction Register connections
wire RST_IR;                 
wire [3:0] immediate;
wire ir_out; 

// PC connections
wire RST_PC;              
wire PCI;                  
wire [7:0] addr_in_pc;
wire BRANCH;

// Register File connections
wire RST_REG;                     
wire [3:0] RST_SEL;
wire C_EN;                  
wire [3:0] C_SEL;
wire [18:0] c_in;             
wire MEM_READ;              
wire [7:0] mem_data;
output wire [18:0] a_out;            // a bus output
output wire [18:0] b_out;            // b bus output
output wire [18:0] dm_addr;          // Data memory address output
output wire [7:0] dm_data;           // Data memory write data output

// Control Unit connections                                                                                 
wire [3:0] RST_REG;                                            
wire [3:0] C_SEL;                                  
wire MEM = 2'b0;                                                              
wire [1:0] MUX2_CTRL;                         

// Instantiate Modules

// 
iRam iram (.clk(clk), .iAddr(iAddr), .FETCH(FETCH), .instr(instr));

endmodule