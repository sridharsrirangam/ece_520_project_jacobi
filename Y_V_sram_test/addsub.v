   // synopsys translate_off
//`include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_addsub.v"

     //synopsys translate_on
module fp_addsub_24(in1,in2,mode,opt,clock);
parameter sig_width = 17;
parameter exp_width = 6;
parameter ieee_compliance = 1;
input [sig_width+exp_width : 0] in1;
input [sig_width+exp_width: 0] in2;
input clock;
output [sig_width+exp_width :0]opt;
wire [7:0] status;
wire [sig_width+exp_width:0] opt_reg;
input mode;
reg [23:0] opt;

    DW_fp_addsub #(sig_width, exp_width, ieee_compliance)
	  U1 ( .a(in1), .b(in2), .rnd(3'b000), .op(mode), .z(opt_reg), .status(status));

always@(posedge clock)
begin
opt<=opt_reg;
end
endmodule


