`timescale 1ns/1ns
module TB();
    reg clk = 1'b0, rst;

     RISC_V_SINGLE_CYCLE CUT(clk, rst);
    
    always #8 clk = ~clk;
	
    initial
    begin
        rst     = 1'b1;
        #12 rst = 1'b0;
    	#1000 $stop;
    end
    
endmodule