module ALUController(
  input [1:0] Aluop,
  input [2:0] funct3,
  input [6:0] funct7,
  output reg [2:0] Control
);

  wire funct7b5;
  
  assign funct7b5 = funct7[5];
  
  always @(*) begin
	case (Aluop)
	  2'b00 : Control <= 3'b000; //add
	  2'b01 : case(funct3)  // B-Type
				3'b000 : Control <= 3'b001; // beg
				3'b001 : Control <= 3'b100; // bne
				3'b100 : Control <= 3'b101; // blt
				3'b101 : Control <= 3'b110; // bge
				default : Control <= 3'bxxx;
			  endcase
	  2'b10 : case({funct7b5,funct3}) // R-Type
				4'b0000 : Control <= 3'b000; // add
				4'b1000 : Control <= 3'b001; // sub
				4'b0111 : Control <= 3'b010; // and
				4'b0110 : Control <= 3'b011; // or
				4'b0010 : Control <= 3'b101; // slt
				default : Control <= 3'bxxx;
			  endcase
	  2'b11 : case({funct7b5,funct3}) // I-Type
				4'b0000 : Control <= 3'b000; // addi
				4'b0010 : Control <= 3'b101; // slti
				4'b0100 : Control <= 3'b111; // xori
				4'b0110 : Control <= 3'b011; // ori
				default : Control <= 3'bxxx;
			  endcase
	  default : Control <= 3'bxxx;
	endcase
  end
	
endmodule