`timescale 1ns/1ns
module register8(input [7:0] pi, input clk, rst, ld, output reg [7:0] po);
    always @(posedge clk, posedge rst) begin
        if (rst)
            po <= 8'b0;
        else
            po <= (ld) ? pi : po;
    end
endmodule

