module MEM_WB_Reg(
  input clk,
  input rst,
  input [31:0] ALUResult_M,
  input [31:0] ReadData_M,
  input [31:0] PCPlus4_M,
  input [4:0] Rd_M,
  input [31:0] ExtImm_M,
  input RegWrite_M,
  input [1:0] ResultSrc_M,
  output reg [31:0] ALUResult_W,
  output reg [31:0] ReadData_W,
  output reg [31:0] PCPlus4_W,
  output reg [4:0] Rd_W,
  output reg [31:0] ExtImm_W,
  output reg RegWrite_W,
  output reg [1:0] ResultSrc_W
);

  always @(posedge clk) begin
	if(rst) begin
	  ALUResult_W <= 32'd0;
	  ReadData_W <= 32'd0;
	  PCPlus4_W <= 32'd0;
	  Rd_W <= 5'd0;
	  ExtImm_W <= 32'd0;
	  RegWrite_W <= 0;
	  ResultSrc_W <= 2'd0;
	end
	else begin
	  ALUResult_W <= ALUResult_M;
	  ReadData_W <= ReadData_M;
	  PCPlus4_W <= PCPlus4_M;
	  Rd_W <= Rd_M;
	  ExtImm_W <= ExtImm_M;
	  RegWrite_W <= RegWrite_M;
	  ResultSrc_W <= ResultSrc_M;
	end
  end

endmodule