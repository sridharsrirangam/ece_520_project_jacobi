
    // synopsys translate_off
//`include "/afs/unity.ncsu.edu/users/z/zwang25/Desktop/trial/mult_div_verify/DW_fp_div_48.v"

     //synopsys translate_on

module fp_div(clock, inst_a, inst_b, inst_rnd, z_inst, status_inst);

parameter sig_width = 17;
parameter exp_width = 6;
parameter ieee_compliance = 0;

input clock;
input [sig_width+exp_width : 0] inst_a;
input [sig_width+exp_width : 0] inst_b;
input [2 : 0] inst_rnd;
// input inst_op;
output [sig_width+exp_width : 0] z_inst;
output [7 : 0] status_inst;

reg [sig_width+exp_width : 0] z_inst,z_pipe1;
wire [sig_width+exp_width : 0] z;

reg [7 : 0] status_inst,status_pipe1;
wire [7 : 0] status;




always@(posedge clock)
begin
	z_inst<=z_pipe1;
	z_pipe1<=z;
	status_inst<=status_pipe1;
	status_pipe1<=status;
	
end
    // Instance of DW_fp_mult

    DW_fp_div_48 #(sig_width, exp_width, ieee_compliance)
	  U1 ( .a(inst_a), .b(inst_b), .rnd(inst_rnd), .z(z), .status(status));


endmodule

