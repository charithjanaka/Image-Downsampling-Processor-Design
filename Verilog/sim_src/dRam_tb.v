// DRAM test bench

`timescale 1 ns / 100 ps

module dRam_tb;

// Inputs

reg clk;
reg [1:0] MEM_WRITE;
reg [18:0] dAddr;
reg [7:0] d_in;
integer i, file;

// Outputs

wire [7:0] d_out;

dRam dRam_1(.clk(clk), .dAddr(dAddr), .d_in(d_in), .MEM_WRITE(MEM_WRITE), .d_out(d_out));

//Create a 500MHz clock

always
    #10 clk = ~clk;

initial begin
    clk     =   1'b0;
    dAddr   =   19'd0;
    d_in    =   8'b0;
    MEM_WRITE = 2'b00;

    #10
    dAddr   =   19'd4;
    d_in    =   8'd20;
    MEM_WRITE   =   2'b10;

    #40
    MEM_WRITE   =   2'b00;

    #10
    file = $fopen("C:\\Users\\Charith Janaka\\Desktop\\Sem_05\\CSD\\Processor_Design\\Repository\\Verilog\\sim_src\\dramout.txt","w");

    #10
    for (i = 0; i < 11; i = i+1)
    begin
        @ (negedge clk)
        dAddr = i;
        $fwrite(file, "%d\n", d_out);
    end
   
    #10
    $fclose(file);

    #10
    $finish;
end

endmodule