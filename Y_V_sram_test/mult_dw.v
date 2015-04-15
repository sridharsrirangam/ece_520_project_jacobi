//synopsys translate_off
//`include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_mult.v"
//synopsys translate_on
module DW_fp_mult_inst( inst_a, inst_b,z_inst,clock);

parameter sig_width = 17;
parameter exp_width = 6;
parameter ieee_compliance = 1;

input clock;
input [sig_width+exp_width : 0] inst_a;
input [sig_width+exp_width: 0] inst_b;
//input [2 : 0] inst_rnd;
output reg [sig_width+exp_width: 0] z_inst;
wire [7 : 0] status_inst;
wire [sig_width+exp_width:0] z;
    // Instance of DW_fp_mult
    DW_fp_mult_48 #(sig_width, exp_width, ieee_compliance)
	  U1 ( .a(inst_a), .b(inst_b), .rnd(3'b000), .z(z), .status(status_inst) );

always@(posedge clock)
z_inst<=z;

endmodule
