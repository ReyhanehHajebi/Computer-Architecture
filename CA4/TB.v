`timescale 1ns/1ns
module TB();
    reg clk = 1'b0, rst;

     RISC_V_PIPELINE CUT(clk, rst);
    
    always #2 clk = ~clk;
	
    initial
    begin
        rst     = 1'b1;
        #3 rst = 1'b0;
    	#1000 $stop;
    end
    
endmodule