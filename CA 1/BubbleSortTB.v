`timescale 1ns/1ns
module BubbleSort_TB();

reg clk, rst, start;
wire done , read_mem , cmp;
wire [7:0] D2_out,D1_out,out_bus;
wire [4:0] addr;
wire [3:0] ps,ns;

BubbleSort bs (.clk(clk), .rst(rst), .start(start), .done(done));

always #10 clk = ~clk;

initial begin
clk = 0;
rst = 0;
start = 0;
#10 rst = 1;
#10 rst = 0;

#50 start = 1;
#50 start = 0;


#70000 $stop;
end

endmodule
