module Divider(clock,in_diag,in_accum,opt_div);

input clock;
input [47:0] in_diag,in_accum;
output [47:0] opt_div;
wire [23:0] diag_real,diag_img,diag_real_sqr,diag_img_sqr,diag_conj_img;
wire [23:0] numerator_real,numerator_img,denominator;
wire [47:0] diag_conj,numerator;
wire [7:0] status_inst_1,status_inst_2;
wire [23:0] result_real,result_img;
assign diag_real=in_diag[47:24];
assign diag_img=in_diag[23:0];
assign diag_conj_img = {(~in_diag[23]),in_diag[22:0]};
assign diag_conj = {diag_real,diag_conj_img};
// multiplier template DW_fp_mult_inst( inst_a, inst_b,z_inst,clock);

DW_fp_mult_inst M_sqr_real( .inst_a(diag_real),.inst_b(diag_real),.z_inst(diag_real_sqr),.clock(clock));
DW_fp_mult_inst M_sqr_img(.inst_a(diag_img),.inst_b(diag_img),.z_inst(diag_img_sqr),.clock(clock));

mlt_cplx mult1(in_accum,diag_conj,numerator,clock);
fp_addsub_24 adder_Dividor(.in1(diag_real_sqr),.in2(diag_img_sqr),.mode(1'b0),.opt(denominator),.clock(clock));

assign numerator_real = numerator[47:24];
assign numerator_img = numerator[23:0];

fp_div Div_real(clock,numerator_real,denominator,3'b000,result_real,status_inst_1);
fp_div  Div_img(clock,numerator_img,denominator,3'b000,result_img,status_inst_2);

assign opt_div={result_real,result_img};

endmodule
