module ProgramCounter(
  input clk,
  input rst,
  input en,
  input [31:0] pcIn,
  output reg [31:0] pcOut
);
  
  always @(posedge clk) begin
    if (rst)
	  pcOut <= 32'd0;
	else if (en)
      pcOut <= pcIn;
	else
	  pcOut <= pcOut;
  end

endmodule
