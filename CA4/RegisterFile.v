module RegisterFile(
  input clk, rst,
  input [4:0] rs1,
  input [4:0] rs2,
  input [4:0] rd,
  input regWrite,
  input [31:0] writeData,
  output [31:0] readData1,
  output [31:0] readData2
);
  
  reg [31:0] registers [31:0]; // Register file with 32 registers
  
  integer i;
  always @(negedge clk) begin
    if (rst)
	  for (i = 0; i < 32 ; i = i+1)
        registers[i] <= 32'd0;
    else if (regWrite) begin
      registers[rd] <= writeData; // Write data to the specified register
    end
  end
  
  assign readData1 = (rs1 == 5'b0) ? 32'd0 : registers[rs1]; // Read data from rs1 register
  assign readData2 = (rs2 == 5'b0) ? 32'd0 : registers[rs2]; // Read data from rs2 register

endmodule
