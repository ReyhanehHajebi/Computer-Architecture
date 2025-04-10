module MainController(
  input [6:0] Opcode,
  output ALUSrc,
  output RegWrite,
  output MemWrite,
  output [1:0] Aluop,
  output [1:0] ResultSrc,
  output [2:0] ImmSrc,
  output Branch,
  output Jump,
  output JumpR
);

  reg [12:0] control;
  
  assign {ALUSrc, RegWrite, MemWrite, ResultSrc, Aluop, ImmSrc, Branch, Jump, JumpR} = control;
  
  
  
  always @(*) begin
    case(Opcode)
      7'b0110011 : control <= 13'b0100010xxx000; // R-type
      7'b0000011 : control <= 13'b1100100000000; // lw-type
      7'b0100011 : control <= 13'b101xx00001000; // S-type
	  7'b1100011 : control <= 13'b000xx01010100; // B-type
      7'b0010011 : control <= 13'b1100011000000; // I-type
      7'b1100111 : control <= 13'b1101000000001; // jalr-type
      7'b1101111 : control <= 13'bx1010xx011010; // jal-type
	  7'b0110111 : control <= 13'bx1011xx100000; // U-type (lui)
      default : control <= 13'bxxxxxxxxxxxx;
    endcase
  end
  
endmodule