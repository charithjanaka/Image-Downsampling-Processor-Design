# CSD Processor Design Assignment
# Assembler
# Created by: Charith Janaka

# Convert decimals to binary
def decTObin(num):
    bnum = bin(num).replace("0b", "")
    return "0"*(4-len(bnum))+bnum

# Dictionary containing ISA and mapped binary codes
ISA = {"CLR":"0001", "LOAD":"0010", "STORE":"0011", "COPY":"0100", "INCR":"0101", "ADDI":"0110", "ADDR":"0111", "SUBI":"1000", "SUBR":"1001", "SHL":"1010", "SHR":"1011", "JPNZ":"1100", "OR":"1101", "NOOP":"1110", "ENDP":"1111"}

# Dictionary containing Registers and mapped binary codes
REG = {"DMAR":"0001", "DMDR":"0010", "R0":"0011", "R1":"0100", "R2":"0101", "R3":"0110", "R4":"0111", "R5":"1000", "R6":"1001", "R7":"1010", "R8":"1011", "R9":"1100", "R10":"1101", "R11":"1110"}

instrs = []

# Reading Assembly Code
AssemblyCode = open("test.txt","r")
instrs = AssemblyCode.read().splitlines() 

# Generating Machine Code
MachineCode = open("machine.txt", "w")

NoIns = len(instrs)


for instr in instrs:
    
    OP = instr.split(" ")
    if (len(OP) == 1):                                      # Single Operand Instructions
        mIns_0 = ISA[OP[0]] + "0000"
        MachineCode.write(mIns_0 + "\n")
        print(mIns_0)

    elif (len(OP) == 2):                                    # Two Operand Instructions
        mIns = ISA[OP[0]] + REG[OP[1]]
        MachineCode.write(mIns + "\n")
        print(mIns)
        
    else:                                                   # Three Operand Instructions
        mIns_1 = ISA[OP[0]] + "0000"
        MachineCode.write(mIns_1 + "\n")
        print(mIns_1)
        if (OP[2] in REG):                                  # Case I - Third operand is a Register
            mIns_2 = REG[OP[1]] + REG[OP[2]]
            MachineCode.write(mIns_2 + "\n")
            print(mIns_2)
        else:                                               # Case II - Third operand is an immediate
            mIns_3 = REG[OP[1]] + decTObin(int(OP[2]))
            MachineCode.write(mIns_3 + "\n")
            print(mIns_3)

AssemblyCode.close()
MachineCode.close()

print("Completed...")
