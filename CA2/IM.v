module InstructionMemory(
  input [31:0] address,
  output reg [31:0] instruction
);
  
  reg [31:0] memory [0:65535];


  initial begin
    $readmemb("IM.txt", memory);
  end
  
  always @(*) begin
    instruction <= memory[{2'b00,address[31:2]}];
  end

endmodule