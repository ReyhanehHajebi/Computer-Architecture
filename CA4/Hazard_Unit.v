module Hazard_Unit(
  input [6:0] opcode,
  input RegWrite_M,
  input [4:0] Rd_M,
  input RegWrite_W,
  input [4:0] Rd_W,
  input [4:0] Rs1_E,
  input [4:0] Rs2_E,
  input [4:0] Rd_E,
  input [4:0] Rs1_D,
  input [4:0] Rs2_D,
  input [1:0] ResultSrc_E,
  input [1:0] PCSrc_E,
  output reg [1:0] ForwardA_E,
  output reg [1:0] ForwardB_E,
  output reg Stall_D,
  output reg Stall_F,
  output reg Flush_D,
  output reg Flush_E
);

  reg [6:0] R_TYPE, LW, SW, I_Type, BR, JAL, JALR, LUI;
  assign  R_TYPE = 7'b0110011;
  assign  LW     = 7'b0000011;
  assign  SW     = 7'b0100011;
  assign  I_Type = 7'b0010011;
  assign  BR     = 7'b1100011;
  assign  JAL    = 7'b1101111;
  assign  JALR   = 7'b1100111;
  assign  LUI    = 7'b0110111; 
	
  always @(*) begin // Forwarding A
	if(RegWrite_M && (Rd_M != 5'd0) && (Rd_M == Rs1_E)) begin
		ForwardA_E <= 2'b10;
	end
	else if (RegWrite_W && (Rd_W != 5'd0) && (Rd_W == Rs1_E)) begin
	  ForwardA_E <= 2'b01;
	end
	else begin
	  ForwardA_E <= 2'b00;
	end
  end

  always @(*) begin  // Forwarding B
	if(RegWrite_M && (Rd_M != 5'd0) && (Rd_M == Rs2_E)) begin
	  ForwardB_E <= 2'b10;
	end
	else if (RegWrite_W && (Rd_W != 5'd0) && (Rd_W == Rs2_E)) begin
	  ForwardB_E <= 2'b01;
	end
	else begin
	  ForwardB_E <= 2'b00;
	end
  end
  
  wire lwStall;
  wire JorB; // Jump PCSrc
  
  assign lwStall = (((Rs1_D == Rd_E) || ((Rs2_D == Rd_E) && (opcode == R_TYPE || opcode == BR || opcode == SW)))
				   && (Rd_E != 5'd0) && ResultSrc_E == 2'b01) ? 1 : 0; // lw
  assign Stall_D = lwStall; // lw
  assign Stall_F = lwStall; // lw
  assign JorB = ((PCSrc_E == 2'b01) || (PCSrc_E == 2'b10)) ? 1 : 0; // Jump
  assign Flush_D = JorB; // Jump
  assign Flush_E = (JorB || lwStall) ? 1 : 0; // Jump or lw
  
endmodule