`timescale 1ns/1ns
module controller(input clk,rst,start ,cop1 ,cop2 ,cp, output reg rd, wr, m11,m12, m21,m22, inp1,inp2,ldp1,enp1, ldp2, enp2, ld1, ld2 ,done);


parameter [4:0] idle = 0, init = 1, load= 2, read_1 = 3, read_2 = 4, comp= 5, swap_1= 6, swap_2 = 7, nothing = 8,mid = 9;
reg [3:0] ps, ns;
always @(ps, start, cop1 ,cop2 ,cp) begin
    {rd, wr, m11,m12, m21,m22, inp1,enp1, ldp2, enp2, ld1, ld2, done} = 13'b0;
    ns = idle;
    case(ps)
        idle: begin ns = start ? init : idle;
                    done = 1;
        end

        init: begin ns = start ? init : load ;
                    inp1 = 1;
        end

        load: begin ns = cop1 ? idle : read_1;
                        ldp2 = 1; 
        end

        read_1 : begin ns = read_2;
                         ld1 = 1;
                         rd = 1;
                         m11 = 1;
        end

        read_2: begin ns = comp;
                        ld2 = 1;
                        rd = 1;
                        m12 = 1;
        end

        comp: begin ns = cp ? swap_1 : nothing;
        end

        swap_1: begin ns = swap_2;
			m12 =1;
			m21 =1;
			wr= 1;
        end

        swap_2: begin ns = cop2 ? mid : read_1;
			m11 =1;
			m22 =1;
			wr= 1;
			enp2 =1;
        end

        nothing: begin ns = cop2 ? mid :read_2;
            enp2 = 1;
        end
        mid: begin ns = load;
            enp1 = 1;
        end
        default: ns = idle;
 
    endcase
end

always @(posedge clk,posedge rst) begin
    if (rst) ps <= idle;
    else ps <= ns;
end

endmodule
