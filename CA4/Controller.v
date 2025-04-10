module Controller(
  input [6:0] Opcode,
  input [2:0] funct3,
  input [6:0] funct7,
  output ALUSrc,
  output RegWrite,
  output MemWrite,
  output [1:0] ResultSrc,
  output [2:0] ImmSrc,
  output [2:0] ALUControl,
  output Branch,
  output Jump,
  output JumpR
);

  wire [1:0] Aluop;
	
  MainController MC(Opcode, ALUSrc, RegWrite, MemWrite, Aluop, ResultSrc, ImmSrc, Branch, Jump, JumpR);
	
  ALUController AC(Aluop, funct3, funct7, ALUControl);
  
endmodule