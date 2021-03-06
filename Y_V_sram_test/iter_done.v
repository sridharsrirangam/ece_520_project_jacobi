module iter_done_calc(dividor_done,Y_eof_reg,iter_done,clock,reset,enable);

input clock,enable,reset;
input dividor_done,Y_eof_reg;
output reg iter_done;

reg dividor_done_reg,Y_eof_p1,Y_eof_p2,Y_eof_p3,Y_eof_p4,Y_eof_p5,Y_eof_p6,Y_eof_p7,Y_eof_p8,Y_eof_p9,Y_eof_p10,Y_eof_p11,Y_eof_p12,Y_eof_p13,Y_eof_p14,
	Y_eof_p15,Y_eof_t;
always@(posedge clock)
begin
if(!reset)
	iter_done<=1'b0;
else
	begin
	if(!enable)
	iter_done<=1'b0;
	else if(dividor_done&&Y_eof_t)
	iter_done<=1'b1;
	end
end
always@(posedge clock)
begin
dividor_done_reg<=dividor_done;
Y_eof_p1<=Y_eof_reg;
Y_eof_p2<=Y_eof_p1;
Y_eof_p3<=Y_eof_p2;
Y_eof_p4<=Y_eof_p3;
Y_eof_p5<=Y_eof_p4;
Y_eof_p6<=Y_eof_p5;
Y_eof_p7<=Y_eof_p6;
Y_eof_p8<=Y_eof_p7;
Y_eof_p9<=Y_eof_p8;
Y_eof_p10 <=Y_eof_p9;
Y_eof_p11 <=Y_eof_p10;
Y_eof_p12 <=Y_eof_p11;
//Y_eof_p13 <=Y_eof_p12;
//Y_eof_p14 <=Y_eof_p13;
//Y_eof_p15 <=Y_eof_p14;

Y_eof_t<=Y_eof_p12;
end


endmodule
