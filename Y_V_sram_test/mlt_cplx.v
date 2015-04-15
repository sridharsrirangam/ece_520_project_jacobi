module mlt_cplx(in1,in2,op,clock);
parameter width=48;//tested for 8 bits..change per requirement
parameter msb =(width)/2;
parameter lsb =(width-2)/2;
input [47 :0] in1,in2;
input clock;
output  [47 :0] op;
wire [23 :0] m_r_t,m_i_t;
wire [23 :0] in1_r,in1_i,in2_r,in2_i;
wire [23 :0] m_rr,m_ii,m_ri,m_ir;
//wire [7:0] status1,status2,status3,status4,status5,status6;

assign in1_r=in1[47:24];
assign in1_i=in1[23:0];
assign in2_r=in2[47:24];
assign in2_i=in2[23:0];


//assign in1_r=24'h620000;
//assign in1_i=24'h0;
//assign in2_r=24'h620000;
//assign in2_i=24'h0;*/

DW_fp_mult_inst m1(in1_r,in2_r,m_rr,clock);
DW_fp_mult_inst m2(in1_i,in2_i,m_ii,clock);
DW_fp_mult_inst m3(in1_r,in2_i,m_ri,clock);
DW_fp_mult_inst m4(in1_i,in2_r,m_ir,clock);
fp_addsub_24 a1(m_rr,m_ii,1'b1,m_r_t,clock);
fp_addsub_24 a2(m_ri,m_ir,1'b0,m_i_t,clock); 

assign	op = {m_r_t,m_i_t};
endmodule
