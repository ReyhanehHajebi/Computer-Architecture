module IF_ID_Reg(
  input clk,
  input rst,
  input clr,
  input en,
  input [31:0] instr_F,
  input [31:0] PC_F,
  input [31:0] PCPlus4_F,
  output reg[31:0] instr_D,
  output reg[31:0] PC_D,
  output reg[31:0] PCPlus4_D
);

  always @(posedge clk) begin
	if(rst) begin
	  instr_D <= 32'd0;
	  PC_D <= 32'd0;
	  PCPlus4_D <= 32'd0;
	end
	else if(clr) begin
	  instr_D <= 32'd0;
	  PC_D <= 32'd0;
	  PCPlus4_D <= 32'd0;
	end
	else if(en) begin
	  instr_D <= instr_F;
	  PC_D <= PC_F;
	  PCPlus4_D <= PCPlus4_F;
	end
	else begin
	  instr_D <= instr_D;
	  PC_D <= PC_D;
	  PCPlus4_D <= PCPlus4_D;
	end
  end

endmodule