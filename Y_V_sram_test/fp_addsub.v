    // synopsys translate_off
//`include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_addsub.v"
     //synopsys translate_on

module fp_addsub( clock, inst_a, inst_b, inst_op, z_inst);

parameter sig_width = 17;
parameter exp_width = 6;
parameter ieee_compliance = 0;

input clock;
input [sig_width+exp_width : 0] inst_a;
input [sig_width+exp_width : 0] inst_b;
input inst_op;

output [sig_width+exp_width : 0] z_inst;

reg   [sig_width+exp_width : 0] z_inst_pipe1;//, z_inst_pipe2, z_inst_pipe3;//, z_inst_pipe4;
wire  [sig_width+exp_width : 0] z_inst_internal;

reg   [7 : 0] status_inst_pipe1;//, status_inst_pipe2, status_inst_pipe3;//, status_inst_pipe4;
wire  [7 : 0] status_inst_internal;

wire [2:0] inst_rnd;
//reg [23:0] input_reg_a, input_reg_b;
//reg input_reg_op;

assign inst_rnd = 3'b0;
// Instantiate the DesignWare IP Core
    DW_fp_addsub #(sig_width, exp_width, ieee_compliance)
	  U1 ( .a(inst_a), .b(inst_b), .rnd(inst_rnd), .op(inst_op), .z(z_inst_internal), .status(status_inst_internal));

always @(posedge clock) 
begin
       // input_reg_a <= inst_a;
       // input_reg_b <= inst_b;
       // input_reg_op <= inst_op;
//output to be registered by allowing 3 pipeline stages to be moved
        z_inst_pipe1 <= z_inst_internal;
       // z_inst_pipe2 <= z_ddinst_pipe1;
       // z_inst_pipe3 <= z_inst_pipe2;

        status_inst_pipe1 <= status_inst_internal;
       // status_inst_pipe2 <= status_inst_pipe1;
       // status_inst_pipe3 <= status_inst_pipe2;
end

assign z_inst = z_inst_pipe1;               

endmodule
