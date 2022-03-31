// Module: Control Unit

`include "opdef.v"
`include "ctrlsigdef.v"

module ctrlunit (clk, instr, z_flag, status, RST, A_SEL, B_SEL, C_SEL, ALU_OP, MEM_WRITE, BRANCH, MUX2_CTRL, STATE);

input wire clk;                                 // Clock
input wire [7:0] instr;                         // Instruction
input wire z_flag;                              // Zero Flag
input wire [1:0] status;                        // Status of the processor
output reg PCI = 1'b0;                          // PC increment control signal
output reg [3:0] RST = 4'b0;                    // Register reset control signal
output reg [3:0] A_SEL = 4'b0;                  // Register select to A bus control signal
output reg [3:0] B_SEL = 4'b0;                  // Register select to B bus control signal
output reg [3:0] C_SEL = 4'b0;                  // Register to be written from C bus select control signal
output reg [3:0] ALU_OP = 4'b0;                 // ALU operation control signal
output reg MEM = 2'b0;                          // Memory control signal
output reg IR_EN = 1'b0;                        // Instruction register write enable control signal
output reg BRANCH = 1'b0;                       // Branch control signal
output reg [1:0] MUX2_CTRL = 2'b0;              // Mux2 control signal
output reg [5:0] STATE = 6'd0;                  // Present state of the state machine

always @ (posedge clk)
begin
    case (STATE)
        `END:begin
            PCI         <=      1'b0;
            RST         <=      `rst_none;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            MEM         <=      `mem_none;
            IR_EN       <=      `ir_none;
            BRANCH      <=      `branch_none;
            MUX2_CTRL   <=      `mux2_none;

            if (status == 2'b01) begin
                STATE   <=      `FETCH;
                status  <=      2'b10;
            end
            else begin
                status  <=      2'b00;
            end
        end

        `FETCH:begin
            PCI         <=      1'b0;
            RST         <=      `rst_none;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            MEM         <=      `im_read;
            IR_EN       <=      `ir_en;
            BRANCH      <=      `branch_none;
            MUX2_CTRL   <=      `mux2_none;

            STATE       <=      `FETCH2;
        end

        `FETCH2: begin
            PCI         <=      1'b1;
            RST         <=      `rst_none;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            MEM         <=      `mem_none;
            IR_EN       <=      `ir_none;
            BRANCH      <=      `branch_none;
            MUX2_CTRL   <=      `mux2_none;

            STATE       <=      {2'b0, instr[7:4]};
        end

        `CLR: begin
            PCI         <=      1'b0;
            RST         <=      instr[3:0];
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            MEM         <=      `mem_none;
            IR_EN       <=      `ir_none;
            BRANCH      <=      `branch_none;
            MUX2_CTRL   <=      `mux2_none;

            STATE       <=      `FETCH;
        end

        `LOAD: begin
            PCI         <=      1'b0;
            RST         <=      `rst_none;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            MEM         <=      `dm_read;
            IR_EN       <=      `ir_none;
            BRANCH      <=      `branch_none;
            MUX2_CTRL   <=      `mux2_none;

            STATE       <=      `FETCH;
        end

        `STORE: begin
            PCI         <=      1'b0;
            RST         <=      `rst_none;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            MEM         <=      `dm_write;
            IR_EN       <=      `ir_none;
            BRANCH      <=      `branch_none;
            MUX2_CTRL   <=      `mux2_none;

            STATE       <=      `FETCH;
        end

        `COPY: begin
            PCI         <=      1'b0;
            RST         <=      `rst_none;
            A_SEL       <=      `asel_none;                 // COPY R1, R2 ; R1 <= R2
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            MEM         <=      `im_read;
            IR_EN       <=      `ir_en;
            BRANCH      <=      `branch_none;
            MUX2_CTRL   <=      `mux2_none;

            STATE       <=      `COPY2;
        end

        `COPY2: begin
            PCI         <=      1'b1;
            RST         <=      `rst_none;
            A_SEL       <=      instr[3:0];
            B_SEL       <=      `bsel_none;
            C_SEL       <=      instr[7:4];
            ALU_OP      <=      `alu_abus;
            MEM         <=      `mem_none;
            IR_EN       <=      `ir_none;
            BRANCH      <=      `branch_none;
            MUX2_CTRL   <=      `mux2_none;

            STATE       <=      `FETCH;
        end

        `INCR: begin
            PCI         <=      1'b0;
            RST         <=      `rst_none;
            A_SEL       <=      instr[3:0];
            B_SEL       <=      `bsel_none;
            C_SEL       <=      instr[3:0];
            ALU_OP      <=      `alu_incr;
            MEM         <=      `mem_none;
            IR_EN       <=      `ir_none;
            BRANCH      <=      `branch_none;
            MUX2_CTRL   <=      `mux2_none;

            STATE       <=      `FETCH;
        end

        `ADDI: begin
            PCI         <=      1'b0;
            RST         <=      `rst_none;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            MEM         <=      `im_read;
            IR_EN       <=      `ir_en;
            BRANCH      <=      `branch_none;
            MUX2_CTRL   <=      `mux2_none;

            STATE       <=      `ADDI2;
        end

        `ADDI2: begin
            PCI         <=      1'b1;
            RST         <=      `rst_none;
            A_SEL       <=      instr[7:4];
            B_SEL       <=      `bsel_none;
            C_SEL       <=      instr[7:4];
            ALU_OP      <=      `alu_addi;
            MEM         <=      `mem_none;
            IR_EN       <=      `ir_none;
            BRANCH      <=      `branch_none;
            MUX2_CTRL   <=      `mux2_imm;

            STATE       <=      `FETCH;
        end

        `ADDR: begin
            PCI         <=      1'b0;
            RST         <=      `rst_none;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            MEM         <=      `im_read;
            IR_EN       <=      `ir_en;
            BRANCH      <=      `branch_none;
            MUX2_CTRL   <=      `mux2_none;

            STATE       <=      `ADDR2;
        end

        `ADDR2: begin
            PCI         <=      1'b1;
            RST         <=      `rst_none;
            A_SEL       <=      instr[7:4];
            B_SEL       <=      instr[3:0];
            C_SEL       <=      instr[7:4];
            ALU_OP      <=      `alu_addr;
            MEM         <=      `mem_none;
            IR_EN       <=      `ir_none;
            BRANCH      <=      `branch_none;
            MUX2_CTRL   <=      `mux2_none;

            STATE       <=      `FETCH;
        end

        `SUBI: begin
            PCI         <=      1'b0;
            RST         <=      `rst_none;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            MEM         <=      `im_read;
            IR_EN       <=      `ir_en;
            BRANCH      <=      `branch_none;
            MUX2_CTRL   <=      `mux2_none;

            STATE       <=      `SUBI2;
        end

        `SUBI2: begin
            PCI         <=      1'b1;
            RST         <=      `rst_none;
            A_SEL       <=      instr[7:4];
            B_SEL       <=      `bsel_none;
            C_SEL       <=      instr[7:4];
            ALU_OP      <=      `alu_subi;
            MEM         <=      `mem_none;
            IR_EN       <=      `ir_none;
            BRANCH      <=      `branch_none;
            MUX2_CTRL   <=      `mux2_imm;

            STATE       <=      `FETCH;
        end

        `SUBR: begin
            PCI         <=      1'b0;
            RST         <=      `rst_none;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            MEM         <=      `im_read;
            IR_EN       <=      `ir_en;
            BRANCH      <=      `branch_none;
            MUX2_CTRL   <=      `mux2_none;

            STATE       <=      `SUBR2;
        end

        `SUBR2: begin
            PCI         <=      1'b1;
            RST         <=      `rst_none;
            A_SEL       <=      instr[7:4];
            B_SEL       <=      instr[3:0];
            C_SEL       <=      instr[7:4];
            ALU_OP      <=      `alu_subr;
            MEM         <=      `mem_none;
            IR_EN       <=      `ir_none;
            BRANCH      <=      `branch_none;
            MUX2_CTRL   <=      `mux2_none;

            STATE       <=      `FETCH;
        end

        `SHL: begin
            PCI         <=      1'b0;
            RST         <=      `rst_none;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            MEM         <=      `im_read;
            IR_EN       <=      `ir_en;
            BRANCH      <=      `branch_none;
            MUX2_CTRL   <=      `mux2_none;

            STATE       <=      `SHL2;
        end

        `SHL2: begin
            PCI         <=      1'b1;
            RST         <=      `rst_none;
            A_SEL       <=      instr[7:4];
            B_SEL       <=      `bsel_none;
            C_SEL       <=      instr[7:4];
            ALU_OP      <=      `alu_shl;
            MEM         <=      `mem_none;
            IR_EN       <=      `ir_none;
            BRANCH      <=      `branch_none;
            MUX2_CTRL   <=      `mux2_imm;

            STATE       <=      `FETCH;
        end

        `SHR: begin
            PCI         <=      1'b0;
            RST         <=      `rst_none;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            MEM         <=      `im_read;
            IR_EN       <=      `ir_en;
            BRANCH      <=      `branch_none;
            MUX2_CTRL   <=      `mux2_none;

            STATE       <=      `SHR2;
        end

        `SHR2: begin
            PCI         <=      1'b1;
            RST         <=      `rst_none;
            A_SEL       <=      instr[7:4];
            B_SEL       <=      `bsel_none;
            C_SEL       <=      instr[7:4];
            ALU_OP      <=      `alu_shr;
            MEM         <=      `mem_none;
            IR_EN       <=      `ir_none;
            BRANCH      <=      `branch_none;
            MUX2_CTRL   <=      `mux2_imm;

            STATE       <=      `FETCH;
        end

        `JPNZ: begin
            PCI         <=      1'b0;
            RST         <=      `rst_none;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            MEM         <=      `mem_none;
            IR_EN       <=      `ir_none;
            BRANCH      <=      `branch_none;
            MUX2_CTRL   <=      `mux2_none;

            if (z_flag == 1) begin
                STATE   <=      `JPNZ2;
            end
            else begin
                STATE   <=      `FETCH;
            end
        end

        `JPNZ2: begin
            PCI         <=      1'b0;
            RST         <=      `rst_none;
            A_SEL       <=      instr[3:0];
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_pc;
            ALU_OP      <=      `alu_abus;
            MEM         <=      `mem_none;
            IR_EN       <=      `ir_none;
            BRANCH      <=      `branch_br;
            MUX2_CTRL   <=      `mux2_none;

            STATE       <=      `FETCH;
        end

        `OR: begin
            PCI         <=      1'b0;
            RST         <=      `rst_none;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            MEM         <=      `im_read;
            IR_EN       <=      `ir_en;
            BRANCH      <=      `branch_none;
            MUX2_CTRL   <=      `mux2_none;

            STATE       <=      `OR2;
        end

        `OR2: begin
            PCI         <=      1'b1;
            RST         <=      `rst_none;
            A_SEL       <=      instr[7:4];
            B_SEL       <=      instr[3:0];
            C_SEL       <=      instr[7:4];
            ALU_OP      <=      `alu_or;
            MEM         <=      `mem_none;
            IR_EN       <=      `ir_none;
            BRANCH      <=      `branch_none;
            MUX2_CTRL   <=      `mux2_none;

            STATE       <=      `FETCH;
        end

        `NOOP: begin
            PCI         <=      1'b0;
            RST         <=      `rst_none;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            MEM         <=      `mem_none;
            IR_EN       <=      `ir_none;
            BRANCH      <=      `branch_none;
            MUX2_CTRL   <=      `mux2_none;

            STATE       <=      `FETCH;
        end

        default: STATE  <=      `END;

    endcase
end

endmodule