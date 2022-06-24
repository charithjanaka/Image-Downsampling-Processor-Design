// Top Level Module

module top_level_module(clk, power_ON);

input wire clk;
input wire power_ON;

// Instruction Memory related wires
wire [7:0] i_ram_address_bus;
wire [7:0] i_ram_data_bus;

// Data Memory related wires
wire [18:0] d_ram_address_bus;
wire [7:0]  d_ram_data_in_bus;
wire [7:0]  d_ram_data_out_bus;

// Commom wires for Ins & Data memory
wire [1:0] mem_ctrl_bus;

// Processor related wires
wire processor_status;
wire [5:0] processor_STATE_bus;

// Instantiation of Modules

iRam iRam_(
            .clk(clk), 
            .iAddr(i_ram_address_bus), 
            .instr(i_ram_data_bus), 
            .FETCH(mem_ctrl_bus));

dRam dRam_(
            .clk(clk), 
            .dAddr(d_ram_address_bus), 
            .d_in(d_ram_data_in_bus), 
            .MEM_WRITE(mem_ctrl_bus), 
            .d_out(d_ram_data_out_bus));

processor processor_(
            .clk(clk), 
            .read_data(d_ram_data_out_bus), 
            .instr(i_ram_data_bus), 
            .next_instr_addr(i_ram_address_bus), 
            .write_addr(d_ram_address_bus), 
            .write_data(d_ram_data_in_bus), 
            .MEM(mem_ctrl_bus), 
            .STATE(processor_STATE_bus), 
            .status(processor_status));
            
endmodule