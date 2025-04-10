module EX_MEM_Reg(
  input clk,
  input rst,
  input [31:0] ALUResult_E,
  input [31:0] WriteData_E,
  input [31:0] PCPlus4_E,
  input [4:0] Rd_E,
  input [31:0] ExtImm_E,
  input RegWrite_E,
  input MemWrite_E,
  input [1:0] ResultSrc_E,
  output reg [31:0] ALUResult_M,
  output reg [31:0] WriteData_M,
  output reg [31:0] PCPlus4_M,
  output reg [4:0] Rd_M,
  output reg [31:0] ExtImm_M,
  output reg RegWrite_M,
  output reg MemWrite_M,
  output reg [1:0] ResultSrc_M
);

  always @(posedge clk) begin
	if(rst) begin
	  ALUResult_M <= 32'd0;
	  WriteData_M <= 32'd0;
	  PCPlus4_M <= 32'd0;
	  Rd_M <= 5'd0;
	  ExtImm_M <= 32'd0;
	  RegWrite_M <= 0;
	  MemWrite_M <= 0;
	  ResultSrc_M <= 2'd0;
	end
	else begin
	  ALUResult_M <= ALUResult_E;
	  WriteData_M <= WriteData_E;
	  PCPlus4_M <= PCPlus4_E;
	  Rd_M <= Rd_E;
	  ExtImm_M <= ExtImm_E;
	  RegWrite_M <= RegWrite_E;
	  MemWrite_M <= MemWrite_E;
	  ResultSrc_M <= ResultSrc_E;
	end
  end

endmodule