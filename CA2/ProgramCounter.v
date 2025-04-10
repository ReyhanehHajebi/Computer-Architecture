module ProgramCounter(
  input clk,rst,
  input [31:0] pcIn,
  output reg [31:0] pcOut
);
  
  always @(posedge clk) begin
    if (rst)
	  pcOut <= 32'd0;
	else
      pcOut <= pcIn; // Update the program counter with the new value
  end

endmodule
