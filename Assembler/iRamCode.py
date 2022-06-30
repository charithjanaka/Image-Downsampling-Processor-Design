MachineCode = open("machine.txt", "r")
IRamCode = open("iramprogram.txt", "w")

lines = MachineCode.read().splitlines()

for i,line in enumerate(lines):
    IRamCode.write("iRAM["+str(i)+"] = "+"8'b"+line+";\n")

MachineCode.close()
IRamCode.close()
