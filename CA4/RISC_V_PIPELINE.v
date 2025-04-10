module RISC_V_PIPELINE(input clk, rst);

  wire [1:0] ResultSrc;
  wire MemWrite;
  wire [2:0] ALUControl;
  wire [2:0] ImmSrc;
  wire ALUSrc;
  wire RegWrite;
  wire [6:0] Opcode;
  wire [2:0] funct3;
  wire [6:0] funct7;
  wire Branch;
  wire Jump;
  wire JumpR;
  
  Datapath DP(clk, rst, ResultSrc, MemWrite, ALUControl, ImmSrc, ALUSrc, RegWrite, Branch, Jump, JumpR, Opcode, funct3, funct7);
  
  Controller Control(Opcode, funct3, funct7, ALUSrc, RegWrite, MemWrite, ResultSrc, ImmSrc, ALUControl, Branch, Jump, JumpR);

endmodule