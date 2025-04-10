module ID_EX_Reg(
  input clk,
  input rst,
  input clr,
  input [31:0] RD1_D,
  input [31:0] RD2_D,
  input [31:0] PC_D,
  input [31:0] PCPlus4_D,
  input [4:0] Rs1_D,
  input [4:0] Rs2_D,
  input [4:0] Rd_D,
  input [31:0] ExtImm_D,
  input ALUSrc_D,
  input RegWrite_D,
  input MemWrite_D,
  input [1:0] ResultSrc_D,
  input [2:0] ALUControl_D,
  input Branch_D,
  input Jump_D,
  input JumpR_D,
  output reg [31:0] RD1_E,
  output reg [31:0] RD2_E,
  output reg [31:0] PC_E,
  output reg [31:0] PCPlus4_E,
  output reg [4:0] Rs1_E,
  output reg [4:0] Rs2_E,
  output reg [4:0] Rd_E,
  output reg [31:0] ExtImm_E,
  output reg ALUSrc_E,
  output reg RegWrite_E,
  output reg MemWrite_E,
  output reg [1:0] ResultSrc_E,
  output reg [2:0] ALUControl_E,
  output reg Branch_E,
  output reg Jump_E,
  output reg JumpR_E
);

  always @(posedge clk) begin
	if(rst) begin
      RD1_E <= 32'd0;
      RD2_E <= 32'd0;
	  PC_E <= 32'd0;
	  PCPlus4_E <= 32'd0;
	  Rs1_E <= 5'd0;
	  Rs2_E <= 5'd0;
	  Rd_E <= 5'd0;
	  ExtImm_E <= 32'd0;
	  ALUSrc_E <= 0;
	  RegWrite_E <= 0;
	  MemWrite_E <= 0;
	  ResultSrc_E <= 2'd0;
	  ALUControl_E <= 3'd0;
	  Branch_E <= 0;
	  Jump_E <= 0;
      JumpR_E <= 0;
	end
	else if(clr) begin
      RD1_E <= 32'd0;
      RD2_E <= 32'd0;
	  PC_E <= 32'd0;
	  PCPlus4_E <= 32'd0;
	  Rs1_E <= 5'd0;
	  Rs2_E <= 5'd0;
	  Rd_E <= 5'd0;
	  ExtImm_E <= 32'd0;
	  ALUSrc_E <= 0;
	  RegWrite_E <= 0;
	  MemWrite_E <= 0;
	  ResultSrc_E <= 2'd0;
	  ALUControl_E <= 3'd0;
	  Branch_E <= 0;
	  Jump_E <= 0;
      JumpR_E <= 0;
	end
	else begin
      RD1_E <= RD1_D;
      RD2_E <= RD2_D;
	  PC_E <= PC_D;
	  PCPlus4_E <= PCPlus4_D;
	  Rs1_E <= Rs1_D;
	  Rs2_E <= Rs2_D;
	  Rd_E <= Rd_D;
	  ExtImm_E <= ExtImm_D;
	  ALUSrc_E <= ALUSrc_D;
	  RegWrite_E <= RegWrite_D;
	  MemWrite_E <= MemWrite_D;
	  ResultSrc_E <= ResultSrc_D;
	  ALUControl_E <= ALUControl_D;
	  Branch_E <= Branch_D;
	  Jump_E <= Jump_D;
      JumpR_E <= JumpR_D;
	end
  end

endmodule