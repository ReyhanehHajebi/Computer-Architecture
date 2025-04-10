module PCSrcGate( 
  input Branch,
  input Jump,
  input JumpR,
  input Zero,
  output reg [1:0] PCSrc
);

  always @(*) begin
    case({Branch,Jump,JumpR})
      3'b010: PCSrc = 2'b01; // jal
      3'b001: PCSrc = 2'b10; // jalr
      3'b100: PCSrc = {0,Zero}; // B-Type
	  3'b000: PCSrc = 2'b00; // other instr
	  default: PCSrc = 2'bxx;
	endcase
  end

endmodule