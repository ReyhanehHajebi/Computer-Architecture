module RISC_V_SINGLE_CYCLE(input clk, rst);

  wire [1:0] ResultSrc;
  wire MemWrite;
  wire [2:0] ALUControl;
  wire [2:0] ImmSrc;
  wire ALUSrc;
  wire RegWrite;
  wire [6:0] opcode;
  wire [2:0] funct3;
  wire [6:0] funct7;
  wire Zero;
  wire [1:0] PCSrc;
  
  Datapath DP(clk, rst, ResultSrc, PCSrc, MemWrite, ALUControl, ImmSrc, ALUSrc, RegWrite, opcode, funct3, funct7, Zero);
  
  Controller Control(opcode, funct3, funct7, Zero, ALUSrc, RegWrite, MemWrite, ResultSrc, ImmSrc, ALUControl, PCSrc);

endmodule