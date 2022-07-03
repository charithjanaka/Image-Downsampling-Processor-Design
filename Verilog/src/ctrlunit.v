// Module: Control Unit

`include "opdef.v"
`include "ctrlsigdef.v"

module ctrlunit (clk, start, instr, z_flag, status,PCI, RST_SEL, RST_PC, A_SEL, B_SEL, C_SEL, ALU_OP, IFETCH, MEM, BRANCH, STATE);

input wire clk;                                 // Clock
input wire start;                               // Processor start signal
input wire [7:0] instr;                         // Instruction
input wire z_flag;                              // Zero Flag
output reg status;                              // Status of the processor
output reg PCI;                                 // PC increment control signal
output reg [3:0] RST_SEL;                       // Register reset control signal
output reg RST_PC;                              // PC reset control signal
output reg [3:0] A_SEL;                         // Register select to A bus control signal
output reg [3:0] B_SEL;                         // Register select to B bus control signal
output reg [3:0] C_SEL;                         // Register to be written from C bus select control signal
output reg [3:0] ALU_OP;                        // ALU operation control signal
output reg IFETCH;                              // Instruction Fetch Control signal
output reg [1:0] MEM;                           // Memory control signal
output reg BRANCH;                              // Branch control signal
output reg [5:0] STATE;                         // Present state of the state machine

always @ (posedge clk)
begin
    case (STATE)
        `IDLE:begin
            PCI         <=      1'b0;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b1;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            IFETCH      <=      1'b0;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            if (start) begin
                STATE   <=      `FETCH;
            end
        end
    
        `FETCH:begin
            PCI         <=      1'b0;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            IFETCH      <=      1'b1;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `FETCH1;
        end

        `FETCH1:begin
            PCI         <=      1'b0;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            IFETCH      <=      1'b0;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `FETCH2;
        end

        `FETCH2: begin
            PCI         <=      1'b1;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            IFETCH      <=      1'b0;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      {2'b0, instr[7:4]};
        end

        `CLR: begin
            PCI         <=      1'b0;
            RST_SEL     <=      instr[3:0];
            RST_PC      <=      1'b0;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            IFETCH      <=      1'b0;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `FETCH;
        end

        `LOAD: begin
            PCI         <=      1'b0;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            IFETCH      <=      1'b0;
            MEM         <=      `dm_read;
            BRANCH      <=      `branch_none;

            STATE       <=      `FETCH;
        end


        `STORE: begin
            PCI         <=      1'b0;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            IFETCH      <=      1'b0;
            MEM         <=      `dm_write;
            BRANCH      <=      `branch_none;

            STATE       <=      `FETCH;
        end

        `COPY: begin
            PCI         <=      1'b0;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      `asel_none;                 // COPY R1, R2 ; R1 <= R2
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            IFETCH      <=      1'b1;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `COPY2;
        end

        `COPY2: begin
            PCI         <=      1'b0;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            IFETCH      <=      1'b0;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `COPY3;
        end

        `COPY3: begin
            PCI         <=      1'b1;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      instr[3:0];
            B_SEL       <=      `bsel_none;
            C_SEL       <=      instr[7:4];
            ALU_OP      <=      `alu_abus;
            IFETCH      <=      1'b0;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `FETCH;
        end

        `INCR: begin
            PCI         <=      1'b0;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      instr[3:0];
            B_SEL       <=      `bsel_none;
            C_SEL       <=      instr[3:0];
            ALU_OP      <=      `alu_incr;
            IFETCH      <=      1'b0;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `FETCH;
        end

        `ADDI: begin
            PCI         <=      1'b0;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            IFETCH      <=      1'b1;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `ADDI2;
        end

        `ADDI2: begin
            PCI         <=      1'b0;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            IFETCH      <=      1'b0;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `ADDI3;
        end

        `ADDI3: begin
            PCI         <=      1'b1;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      instr[7:4];
            B_SEL       <=      `bsel_imm;
            C_SEL       <=      instr[7:4];
            ALU_OP      <=      `alu_addi;
            IFETCH      <=      1'b0;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `FETCH;
        end

        `ADDR: begin
            PCI         <=      1'b0;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            IFETCH      <=      1'b1;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `ADDR2;
        end

        `ADDR2: begin
            PCI         <=      1'b0;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            IFETCH      <=      1'b0;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `ADDR3;
        end

        `ADDR3: begin
            PCI         <=      1'b1;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      instr[7:4];
            B_SEL       <=      instr[3:0];
            C_SEL       <=      instr[7:4];
            ALU_OP      <=      `alu_addr;
            IFETCH      <=      1'b0;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `FETCH;
        end

        `SUBI: begin
            PCI         <=      1'b0;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            IFETCH      <=      1'b1;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `SUBI2;
        end

        `SUBI2: begin
            PCI         <=      1'b0;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            IFETCH      <=      1'b0;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `SUBI3;
        end

        `SUBI3: begin
            PCI         <=      1'b1;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      instr[7:4];
            B_SEL       <=      `bsel_imm;
            C_SEL       <=      instr[7:4];
            ALU_OP      <=      `alu_subi;
            IFETCH      <=      1'b0;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `FETCH;
        end

        `SUBR: begin
            PCI         <=      1'b0;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            IFETCH      <=      1'b1;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `SUBR2;
        end

        `SUBR2: begin
            PCI         <=      1'b0;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            IFETCH      <=      1'b0;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `SUBR3;
        end

        `SUBR3: begin
            PCI         <=      1'b1;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      instr[7:4];
            B_SEL       <=      instr[3:0];
            C_SEL       <=      instr[7:4];
            ALU_OP      <=      `alu_subr;
            IFETCH      <=      1'b0;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `FETCH;
        end

        `SHL: begin
            PCI         <=      1'b0;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            IFETCH      <=      1'b1;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `SHL2;
        end

        `SHL2: begin
            PCI         <=      1'b0;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            IFETCH      <=      1'b0;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `SHL3;
        end

        `SHL3: begin
            PCI         <=      1'b1;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      instr[7:4];
            B_SEL       <=      `bsel_imm;
            C_SEL       <=      instr[7:4];
            ALU_OP      <=      `alu_shl;
            IFETCH      <=      1'b0;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `FETCH;
        end

        `SHR: begin
            PCI         <=      1'b0;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            IFETCH      <=      1'b1;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `SHR2;
        end

        `SHR2: begin
            PCI         <=      1'b0;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            IFETCH      <=      1'b0;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `SHR3;
        end

        `SHR3: begin
            PCI         <=      1'b1;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      instr[7:4];
            B_SEL       <=      `bsel_imm;
            C_SEL       <=      instr[7:4];
            ALU_OP      <=      `alu_shr;
            IFETCH      <=      1'b0;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `FETCH;
        end

        `JPNZ: begin
            PCI         <=      1'b0;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            IFETCH      <=      1'b0;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;  

            if (z_flag == 1) begin
                STATE   <=      `FETCH;
            end
            else begin
                STATE   <=      `JPNZ2;
            end
        end

        `JPNZ2: begin
            PCI         <=      1'b0;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      instr[3:0];
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_pc;
            ALU_OP      <=      `alu_abus;
            IFETCH      <=      1'b0;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_br;

            STATE       <=      `FETCH;
        end

        `OR: begin
            PCI         <=      1'b0;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            IFETCH      <=      1'b1;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `OR2;
        end

        `OR2: begin
            PCI         <=      1'b0;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            IFETCH      <=      1'b0;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;

            STATE       <=      `OR3;
        end

        `OR3: begin
            PCI         <=      1'b1;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      instr[7:4];
            B_SEL       <=      instr[3:0];
            C_SEL       <=      instr[7:4];
            ALU_OP      <=      `alu_or;
            IFETCH      <=      1'b0;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none;  

            STATE       <=      `FETCH;
        end

        `ENDP: begin
            PCI         <=      1'b0;
            RST_SEL     <=      `rst_none;
            RST_PC      <=      1'b0;
            A_SEL       <=      `asel_none;
            B_SEL       <=      `bsel_none;
            C_SEL       <=      `csel_none;
            ALU_OP      <=      `alu_none;
            IFETCH      <=      1'b0;
            MEM         <=      `mem_none;
            BRANCH      <=      `branch_none; 
            status      <=      1'b1; 

            STATE       <=      `IDLE;
        end

        default: STATE  <=      `IDLE;
    endcase
end

endmodule