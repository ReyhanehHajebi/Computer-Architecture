module Datapath (
  input clk, rst,
  input [1:0] ResultSrc_D,
  input MemWrite_D,
  input [2:0] ALUControl_D,
  input [2:0] ImmSrc_D,
  input ALUSrc_D,
  input RegWrite_D,
  input Branch_D,
  input Jump_D,
  input JumpR_D,
  output [6:0] opcode,
  output [2:0] funct3,
  output [6:0] funct7
);

  wire [31:0] PC_F, PCPlus4_F, PCNext_F, Instr_F;
  wire [31:0] PC_D, PCPlus4_D, ExtImm_D, Instr_D, RD1_D, RD2_D;
  wire [31:0] PC_E, PCPlus4_E, PCTarget_E, ExtImm_E, PCNext_E, ALUResult_E, SrcA_E, WriteData_E, SrcB_E, RD1_E, RD2_E;
  wire [31:0] PCPlus4_M, ExtImm_M, ALUResult_M, WriteData_M, ReadData_M;
  wire [31:0] PCPlus4_W, ExtImm_W, ALUResult_W, Result_W, ReadData_W;
  wire [4:0] Rs1_D, Rs2_D, Rd_D, Rs1_E, Rs2_E, Rd_E, Rd_M, Rd_W;
  wire RegWrite_W, RegWrite_E, RegWrite_M;
  wire MemWrite_E, MemWrite_M;
  wire ALUSrc_E;
  wire [1:0] ResultSrc_E, ResultSrc_M, ResultSrc_W;
  wire [2:0] ALUControl_E;
  wire Branch_E, Jump_E, JumpR_E;
  wire Zero_E;
  wire [1:0] PCSrc_E;
  
  wire [1:0] ForwardA_E, ForwardB_E;
  wire Stall_F, Stall_D, Flush_D, Flush_E;
  
  assign opcode = Instr_D[6:0];
  assign funct3 = Instr_D[14:12];
  assign funct7 = Instr_D[31:25];
  assign Rs1_D = Instr_D[19:15];
  assign Rs2_D = Instr_D[24:20];
  assign Rd_D = Instr_D[11:7];

  MUX3to1 MUX_F(PCPlus4_F, PCTarget_E, ALUResult_E, PCSrc_E, PCNext_F);
  
  // ...................Fetch
  
  ProgramCounter PCounter(clk, rst, ~Stall_F, PCNext_F, PC_F);
  
  InstructionMemory IM(PC_F, Instr_F);
  
  PCPlus4Adder ADDER_1(PC_F, PCPlus4_F);
  
  // Decode
  
  IF_ID_Reg FD_Reg(clk, rst, Flush_D, ~Stall_D, Instr_F, PC_F, PCPlus4_F, Instr_D, PC_D, PCPlus4_D);
  
  RegisterFile RF(clk, rst, Instr_D[19:15], Instr_D[24:20], Rd_W, RegWrite_W, Result_W, RD1_D, RD2_D);
  
  ImmediateExtend IE(ImmSrc_D, Instr_D, ExtImm_D);
  
  // ...................Execute
  
  ID_EX_Reg  DE_Reg(clk, rst, Flush_E, RD1_D, RD2_D, PC_D, PCPlus4_D, Rs1_D, Rs2_D, Rd_D, ExtImm_D, ALUSrc_D, RegWrite_D,
					MemWrite_D, ResultSrc_D, ALUControl_D, Branch_D, Jump_D, JumpR_D, RD1_E, RD2_E, PC_E, PCPlus4_E, Rs1_E,
					Rs2_E, Rd_E,ExtImm_E, ALUSrc_E, RegWrite_E, MemWrite_E, ResultSrc_E, ALUControl_E, Branch_E, Jump_E, JumpR_E
					);

  MUX3to1 MUX_ForwardA(RD1_E, Result_W, ALUResult_M, ForwardA_E, SrcA_E);
  
  MUX3to1 MUX_ForwardB(RD2_E, Result_W, ALUResult_M, ForwardB_E, WriteData_E);
  
  MUX2to1 MUX_E3(WriteData_E, ExtImm_E, ALUSrc_E, SrcB_E);
  
  Adder ADDER_2(PC_E, ExtImm_E, PCTarget_E);
  
  ALU ALUFunc(SrcA_E, SrcB_E, ALUControl_E, ALUResult_E, Zero_E);
  
  PCSrcGate PCG(Branch_E, Jump_E, JumpR_E, Zero_E, PCSrc_E);
  
  // ...................Memory
  
  EX_MEM_Reg EM_Reg(clk, rst, ALUResult_E, WriteData_E, PCPlus4_E, Rd_E, ExtImm_E, RegWrite_E, MemWrite_E, ResultSrc_E,
					ALUResult_M, WriteData_M, PCPlus4_M, Rd_M, ExtImm_M, RegWrite_M, MemWrite_M, ResultSrc_M
					);
  
  DataMemory DM(ALUResult_M, WriteData_M, MemWrite_M, clk, ReadData_M);
  
  // ...................Write Back
  
  MEM_WB_Reg MW_Reg(clk, rst, ALUResult_M, ReadData_M, PCPlus4_M, Rd_M, ExtImm_M, RegWrite_M, ResultSrc_M, ALUResult_W,
				ReadData_W, PCPlus4_W, Rd_W, ExtImm_W, RegWrite_W, ResultSrc_W
				);
  
  MUX4to1 MUX_W(ALUResult_W, ReadData_W, PCPlus4_W, ExtImm_W, ResultSrc_W, Result_W);
  
/*---------------------------------------------- Hazard Unit ----------------------------------------------*/
  
  Hazard_Unit HazardUnit(Instr_D[6:0], RegWrite_M, Rd_M, RegWrite_W, Rd_W, Rs1_E, Rs2_E, Rd_E, Rs1_D, Rs2_D, ResultSrc_E,
						 PCSrc_E, ForwardA_E, ForwardB_E, Stall_D, Stall_F, Flush_D, Flush_E
						 );

endmodule