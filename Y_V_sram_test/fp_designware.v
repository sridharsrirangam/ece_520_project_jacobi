module fp_designware(clock,
  		    	y_feed_mult,v_feed_mult,
 			accum_feed,
 			in1_adder1,in2_adder1,in1_adder2,in2_adder2,
			 opt_adder1,opt_adder2,
			 adder1_mode,adder2_mode,
 			in1_sub1,in2_sub1,
 			opt_sub1,
 			op_dividerIn1,op_dividerIn2,
 			in_outputOfDivider,
			in1_adder_adeesh,in2_adder_adeesh,opt_adder_adeesh,
			adder_mode_adeesh
);
input clock;
input  [47:0] y_feed_mult,v_feed_mult;
output [47:0] accum_feed;
input  [47:0] in1_adder1,in2_adder1,in1_adder2,in2_adder2;
output [47:0] opt_adder1,opt_adder2;
input         adder1_mode,adder2_mode;
input  [47:0] in1_sub1,in2_sub1;
input  [47:0] opt_sub1;
input  [47:0] op_dividerIn1,op_dividerIn2;
output [47:0] in_outputOfDivider;

input         adder_mode_adeesh;
input  [47:0] in1_adder_adeesh,in2_adder_adeesh;
output [47:0] opt_adder_adeesh;

mlt_cplx Mult__bfr_accum(.in1(y_feed_mult),.in2(v_feed_mult),.op(accum_feed),.clock(clock));

addsub_cplx Adder1(.in1(in1_adder1),.in2(in2_adder1),.mode(adder1_mode),.op(opt_adder1),.clock(clock));


addsub_cplx Adder2(.in1(in1_adder2),.in2(in2_adder2),.mode(adder2_mode),.op(opt_adder2),.clock(clock));

addsub_cplx Adder_adeesh(.in1(in1_adder_adeesh),.in2(in2_adder_adeesh),.mode(adder_mode_adeesh),.op(opt_adder_adeesh),.clock(clock));

addsub_cplx Subtractor(.in1(in1_sub1),.in2(in2_sub1),.mode(1'b1),.op(opt_sub1),.clock(clock));

Divider dividor(.clock(clock),.in_diag(op_dividerIn2),.in_accum(op_dividerIn1),.opt_div(in_outputOfDivider));

endmodule
