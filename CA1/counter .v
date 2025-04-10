`timescale 1ns/1ns
module counter5(input [4:0] pi, input clk, rst, init, inc, ld, output reg [4:0] po, output co);
    always @ (posedge clk, posedge rst) begin
        if(rst) po <= 5'b0;
        else begin
            if (ld) po <= pi;
            else if (init) po <= 5'b0;
            else if (inc) po <= po + 1;
        end
    end
    assign co = &po;
endmodule
