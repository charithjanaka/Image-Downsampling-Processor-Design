// Control signals Definitions

// RST control signals
`define rst_none        4'b0000

// A_SEL control signals
`define asel_none       4'b0000

// B_SEL control signals
`define bsel_none       4'b0000
`define bsel_imm        4'b1111

// C_SEL control signals
`define csel_none       4'b0000
`define csel_pc         4'b1111

// ALU control signals
`define alu_none        4'b0000
`define alu_incr        4'b0001
`define alu_addi        4'b0010
`define alu_subi        4'b0011
`define alu_addr        4'b0100
`define alu_subr        4'b0101
`define alu_shl         4'b0110
`define alu_shr         4'b0111
`define alu_or          4'b1000
`define alu_abus        4'b1001

// Memory control signals
`define mem_none        2'b00
`define dm_write        2'b10
`define dm_read         2'b11

// IR control signals
`define ir_none         1'b0
`define ir_en           1'b1

// Branch control signals
`define branch_none     1'b0
`define branch_br       1'b1

// Mux2 control signals
`define mux2_none       2'b00
`define mux2_reg        2'b01
`define mux2_imm        2'b10