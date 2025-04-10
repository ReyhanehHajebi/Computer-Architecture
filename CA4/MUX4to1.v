module MUX4to1(
  input [31:0] inputA,
  input [31:0] inputB,
  input [31:0] inputC,
  input [31:0] inputD,
  input [1:0] select,
  output reg [31:0] out
);
  
  always @(*) begin
    case (select)
      2'b00: out = inputA;
      2'b01: out = inputB;
      2'b10: out = inputC;
	  2'b11: out = inputD;
      default: out = 0;
    endcase
  end

endmodule