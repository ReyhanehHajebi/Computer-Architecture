`timescale 1ns/1ns
module BubbleSort(input clk, rst, start, output wire done);


wire inp1, inp2, enp1, enp2, ldp1, ldp2, ld1, ld2, rd, wr, m11, m12, m21, m22, cop1, cop2, cp;

datapath DP(.clk(clk), .rst(rst), .inp1(inp1), .inp2(inp2), .enp1(enp1), .enp2(enp2), .ldp1(ldp1), .ldp2(ldp2), .ld1(ld1), .ld2(ld2),
            .rd(rd), .wr(wr), .m11(m11), .m12(m12), .m21(m21), .m22(m22), .cop1(cop1), .cop2(cop2), .cp(cp));

controller CTR(.clk(clk), .rst(rst), .start(start), .cop1(cop1), .cop2(cop2), .cp(cp), .rd(rd), .wr(wr), .m11(m11), .m12(m12), .m21(m21), .m22(m22),
                 .inp1(inp1), .inp2(inp2), .ldp1(ldp1), .enp1(enp1), .ldp2(ldp2), .enp2(enp2), .ld1(ld1), .ld2(ld2), .done(done));

endmodule
