module MUX2to1(
  input [31:0] inputA,
  input [31:0] inputB,
  input select,
  output reg [31:0] out
);
  
  always @(*) begin
    if (select)
      out = inputB;
    else
      out = inputA;
  end

endmodule
