// Module: Processor

module processor (clk, processor_start, read_data, instr, next_instr_addr, write_addr, write_data, IFETCH, MEM, STATE, status);

input wire clk;                                         // Clock
input wire processor_start;                             // Processor Start signal
input wire [7:0] read_data;                             // Data memory output data
input wire [7:0] instr;                                 // Instruction

output wire [7:0] next_instr_addr;                      // Next instruction address
output wire [18:0] write_addr;                          // Data memory write address
output wire [7:0] write_data;                           // Data memory write data
output wire IFETCH;                                     // Instruction Fetch control signal
output wire [1:0] MEM;                                  // Memory control signal
output wire [5:0] STATE;                                // State of the controller
output wire status;                                     // Status of the processor

// Buses
wire [18:0] a_bus;                                      // A-Bus
wire [18:0] b_bus;                                      // B-Bus
wire [18:0] c_bus;                                      // C-Bus
wire z_bus;                                             // z-Flag

// Interconnect wires - Ctrl Signals          
wire PCI;                                               // PC Increment control signal
wire [3:0] RST_SEL;                                     // Register file Reset register select
wire RST_PC;                                            // PC Reset control signal
wire [3:0] A_SEL;                                       // Register select control signal into A-Bus
wire [3:0] B_SEL;                                       // Register select control signal into B-Bus
wire [3:0] C_SEL;                                       // Register select control signal for writing from C-Bus
wire [3:0] ALU_OP;                                      // ALU Operation
wire BRANCH;                                            // Branch control signal        

// Interconnect wires - Other
wire [3:0] immediate;                                   // Immediate data
wire [7:0] ir_out;                                      // Instruction Register Output                                                                                                  
                               
// Instantiate Modules
alu alu_(
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



//                                                ----------------------------------------------
//                                               |                                              |
//                                      clk----->|                                              |-----> next_instr_addr
//                          processor_start----->|                                              |-----> FETCH
//                                               |                                              |
//                                    Instr----->|                                              |-----> write_addr
//                                read_data----->|                                              |-----> write_data
//                                               |                  Processor                   |-----> MEM
//                                               |                                              |
//                                               |                                              |-----> STATE
//                                               |                                              |-----> status
//                                               |                                              |
//                                               |                                              |        
//                                               |                                              |
//                                                ----------------------------------------------
//
