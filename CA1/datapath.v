`timescale 1ns/1ns
module datapath(input clk, rst, inp1, inp2, enp1, enp2, ldp1, ldp2, ld1, ld2, rd, wr, m11, m12, m21, m22, output wire cop1, cop2, cp);

wire [4:0] pi1, po1, pi2, po2, addressBus;
wire [7:0] writedata;
wire [7:0] D2_out, D1_out, readData;

assign inp2 = 0;
assign ldo1 =0;
assign pi1 = 8'b0;
assign pi2 = po1 + 1;
assign cp = (D1_out > D2_out)?1 :0;
assign addressBus = m11 ? po1 : (m12 ? po2 : 1'bz);
assign writedata = m21 ? D1_out : (m22 ? D2_out:1'bz);


counter5 counter1 (pi1, clk, rst, inp1, enp1, ldp1, po1, cop1);
counter5 counter2 (pi2, clk, rst, inp2, enp2, ldp2, po2, cop2);

register8 register1 (readData, clk, rst, ld1, D1_out);
register8 register2 (readData, clk, rst, ld2, D2_out);

memory memory(clk, rst, rd, wr, addressBus,  writedata, rdyMem, readData);


endmodule
