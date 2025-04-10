module ImmediateExtend(
  input [2:0] ImmSrc,
  input [31:0] instruction,
  output reg [31:0] immediate
);
  
  always @(*) begin
    case (ImmSrc)
      3'b000: immediate <= {{20{instruction[31]}}, instruction[31:20]}; // I-Type
      3'b001: immediate <= {{20{instruction[31]}}, instruction[31:25], instruction[11:7]}; // S-Type
      3'b011: immediate <= {{12{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21]}; // J-Type
      3'b010: immediate <= {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0}; // B-Type
      3'b100: immediate <= {instruction[31:12], 12'b0}; // U-Type
      default: immediate = 0; // Default case
    endcase
  end

endmodule