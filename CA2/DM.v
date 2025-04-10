module DataMemory(
  input [31:0] address,
  input [31:0] writeData,
  input MemWrite,
  input clk,
  output [31:0] readData
);
  
  reg [31:0] memory [0:65535];
  
  initial begin
    $readmemb("DM.txt", memory);
  end
  
  always @(posedge clk) begin
    if (MemWrite)
      memory[address[31:0]] <= writeData;
  end
	
  assign readData = memory[address[31:0]];

endmodule