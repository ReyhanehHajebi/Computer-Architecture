module Datapath (
  input clk, rst,
  input [1:0] ResultSrc,
  input [1:0] PCSrc,
  input MemWrite,
  input [2:0] ALUControl,
  input [2:0] ImmSrc,
  input ALUSrc,
  input RegWrite,
  output [6:0] opcode,
  output [2:0] funct3,
  output [6:0] funct7,
  output Zero
);

  wire [31:0] PC, PCPlus4, PCTarget, ImmExt, PCNext, ALUResult, Instr, Result, SrcA, WriteData, SrcB, ReadData;
  
  assign opcode = Instr[6:0];
  assign funct3 = Instr[14:12];
  assign funct7 = Instr[31:25];

  PCPlus4Adder ADDER_1(PC, PCPlus4);

  Adder ADDER_2(PC, ImmExt, PCTarget);

  ProgramCounter PCounter(clk, rst, PCNext, PC);

  MUX3to1 MUX_1(PCPlus4, PCTarget, ALUResult, PCSrc, PCNext);
  
  InstructionMemory IM(PC, Instr);
  
  RegisterFile RF(clk, rst, Instr[19:15], Instr[24:20], Instr[11:7], RegWrite, Result, SrcA, WriteData);
  
  ImmediateExtend IE(ImmSrc, Instr, ImmExt);
  
  MUX2to1 MUX_2(WriteData, ImmExt, ALUSrc, SrcB);
  
  ALU ALUFunc(SrcA, SrcB, ALUControl, ALUResult, Zero);
  
  DataMemory DM(ALUResult, WriteData, MemWrite, clk, ReadData);
  
  MUX4to1 MUX_3(ALUResult, ReadData, PCPlus4, ImmExt, ResultSrc, Result);

endmodule