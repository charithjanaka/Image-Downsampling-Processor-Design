// test bench for top level module

`timescale 1 ns / 100 ps

module test;

// Inputs

reg clk, power_ON;
reg [18:0] dRamAddr;

wire processor_status;
wire [7:0] dRamOut;

integer i, file;

top_level_module top_level_module_(clk, power_ON, processor_status, dRamAddr, dRamOut);

// Create a 50MHz clock
always
    #10 clk = ~clk;

initial begin
    clk = 1'b0;
    power_ON = 1'b0;

    #10
    power_ON = 1'b1;

    #62500000
    file = $fopen("C:\\Users\\Charith Janaka\\Desktop\\Sem_05\\CSD\\Processor_Design\\Repository\\Verilog\\sim_src\\dramout.txt","w");

    #10
    for (i = 140; i < 271; i = i+1)
    begin
        @ (posedge clk)
        dRamAddr = i;
        $fwrite(file, "%d\n", dRamOut);
    end
    
    $fclose(file);
    $finish;

end

endmodule