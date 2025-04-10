module ALU(
  input [31:0] operandA,
  input [31:0] operandB,
  input [2:0]  ALU_control,
  output reg [31:0] result,
  output reg Zero
);
  
  always @(*) begin
    case (ALU_control)
      3'b000: result = operandA + operandB;  // add(i)
      3'b001: begin
				result = operandA - operandB;  // sub
				Zero = (result == 0) ? 1 : 0; // beq
			  end
      3'b010: result = operandA & operandB;  // and(i)
      3'b011: result = operandA | operandB;  // or(i)
	  3'b100: Zero = (operandA == operandB) ? 0 : 1; // bne
      3'b101: begin
				result = ($signed(operandA) < $signed(operandB)) ? 1 : 0;  // slt(i)
				Zero = result; // blt
			  end
	  3'b110: Zero = ($signed(operandA) < $signed(operandB)) ? 0 : 1; // bge
	  3'b111: result = operandA ^ operandB; // xor(i)
      default: begin
				 result = 32'bx;
				 Zero = 1'bx;
			   end
    endcase
  end

endmodule
