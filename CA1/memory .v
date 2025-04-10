module memory(clk, rst, rd, wr, addressBus, writeData ,readyMem, readData);
  
  input clk,rst, rd, wr;
  input [7:0] writeData; 
  input [4:0]addressBus;
  
  output reg readyMem ;
  output [7:0] readData;
   
  reg [7:0] memory[0:31];
  reg [7:0] out;
  
  integer i;

  initial begin
    for(i = 0; i < 32; i = i+1)
      memory[i] = 8'b0; 
      $readmemb( "mem_data.txt" ,memory,0 ,31 );   
  end

  always @(posedge clk, posedge rst)
  begin
  if (rst == 1'b1)
    begin
	for ( i = 0 ; i < 32 ; i = i + 1 )
	    memory[i] = 8'b0;
      $readmemb("mem_data.txt" , memory , 0 , 31);
	    readyMem <= 1'b0;
    end
	// sync write
  else if(clk == 1'b1)
        begin
          if(wr == 1'b1)
            begin
	            readyMem = 1'b0;
              memory[addressBus] = writeData;
              $writememb("mem_data.txt",memory,0 ,31);
	            readyMem = 1'b1;
            end
      
        end
  end

  //async read
  always @( posedge rd , addressBus ) begin
    if ( rd == 1'b1 )
	    begin
	      readyMem = 1'b0;
        out = memory[addressBus];
	      readyMem = 1'b1;
	    end
  end
  assign readData = (readyMem == 1'b1 && wr == 1'b0) ? out :8'bz ;

endmodule




