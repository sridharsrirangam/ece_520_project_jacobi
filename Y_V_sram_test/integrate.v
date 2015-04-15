module integrate(clock,reset,enable,y_feed_mult,v_feed_mult,
	sram_1_addressline_1,sram_1_addressline_2,
	     sram_2_addressline_1,sram_2_addressline_2,
	     sram_3_addressline_1,sram_3_addressline_2,
	     sram_4_addressline_1,sram_4_addressline_2,
	 sram_1_readline_1,sram_1_readline_2,
	      sram_2_readline_1,sram_2_readline_2,
	      sram_3_readline_1,sram_3_readline_2,
	      sram_4_readline_1,sram_4_readline_2,
	Y_addressline_1,ReadAddress2,Yin,
	I_input,in1_sub1,in2_sub1,opt_sub1,I_sram_addressline_1,
		op_dividerIn1,op_dividerIn2,in_outputOfDivider,
		 sram_1_writeAddressline, 
                   sram_2_writeAddressline, 
                   sram_3_writeAddressline, 
                   sram_4_writeAddressline, 
                   sram_1_writeEnable, 
                   sram_2_writeEnable, 
                   sram_3_writeEnable, 
                   sram_4_writeEnable, 
                   sram_1_writeData, 
                   sram_2_writeData, 
                   sram_3_writeData, 
                   sram_4_writeData, 
		control_vsram_section,vsram_read_control,iter_done,

 		accum_feed,adder1_mode,adder2_mode,

		
 		in1_adder1, in2_adder1,opt_adder1,in1_adder2,in2_adder2,opt_adder2);

input clock,reset,enable;


output [47:0] y_feed_mult,v_feed_mult;


  
output  [ 8:0] sram_1_addressline_1,sram_1_addressline_2,
	     sram_2_addressline_1,sram_2_addressline_2,
	     sram_3_addressline_1,sram_3_addressline_2,
	     sram_4_addressline_1,sram_4_addressline_2;


input [ 47:0] sram_1_readline_1,sram_1_readline_2,
	      sram_2_readline_1,sram_2_readline_2,
	      sram_3_readline_1,sram_3_readline_2,
	      sram_4_readline_1,sram_4_readline_2;
input control_vsram_section;
output [8:0]       sram_1_writeAddressline, 
                   sram_2_writeAddressline, 
                   sram_3_writeAddressline, 
                   sram_4_writeAddressline;

output [47:0]      sram_1_writeData, 
                   sram_2_writeData, 
                   sram_3_writeData, 
                   sram_4_writeData;

output             sram_1_writeEnable, 
                   sram_2_writeEnable, 
                   sram_3_writeEnable, 
                   sram_4_writeEnable;

wire [47:0] result_I_minus_Accum;
wire [1:0] I_value_select;
wire [47:0]  accum_value;
input [191:0] I_input;
output [47:0] in1_sub1,in2_sub1;
input [47:0] opt_sub1;
output [7:0] I_sram_addressline_1;
wire [15:0] y_1_col_info,y_2_col_info,y_3_col_info,y_4_col_info; 
wire [1:0] sel_v1_v3,sel_v2_v4;
wire [2:0] v_ram_no_1,v_ram_no_2,v_ram_no_3,v_ram_no_4;

output [10:0] Y_addressline_1,ReadAddress2;
input [255:0] Yin;

wire switch_from_fifo1_fifo2;
wire [47:0] v_value_1,v_value_2,v_value_3,v_value_4;

wire [47:0] y_feed_mult,v_feed_mult;
wire [9:0] row_count,row_count_I;
wire get_I_flag;
wire [47:0] accum_out; 
input vsram_read_control;
wire dividor_done;

output [47:0] op_dividerIn1,op_dividerIn2;
input  [47:0] in_outputOfDivider;
wire [47:0] y_diagonal;
wire Y_eof_reg;

input [47:0] accum_feed; //input from multiplier.
output  adder1_mode,adder2_mode;

wire sel_add_even_odd; //select lines for muxes.
wire accum_done;

output [47:0] in1_adder1, in2_adder1;//these will have to be sent to adder 1
input  [47:0] opt_adder1;//this be be received from adder 1
output [47:0] in1_adder2,in2_adder2;//these will have to be sent to adder 2
input  [47:0] opt_adder2; //this will be received from adder 2
wire feedback_check2;
wire feedback_check1;
wire zero_on_V;


output iter_done; 

 y_to_fifo Y1(.Yin(Yin),
		.v_value_1(v_value_1),.v_value_2(v_value_2),.v_value_3(v_value_3),.v_value_4(v_value_4),
		.y_1_col_info(y_1_col_info),.y_2_col_info(y_2_col_info),.y_3_col_info(y_3_col_info),.y_4_col_info(y_4_col_info),
		.y_feed_mult(y_feed_mult),.v_feed_mult(v_feed_mult),
		.clock(clock),.reset(reset),.enable(enable),.switch_from_fifo1_fifo2(switch_from_fifo1_fifo2),.y_diagonal(y_diagonal),.Y_eof_reg(Y_eof_reg),			.zero_on_V(zero_on_V));

yv_control Y_C(.y_1_col_info(y_1_col_info),.y_2_col_info(y_2_col_info),.y_3_col_info(y_3_col_info),.y_4_col_info(y_4_col_info),
	     .sram_1_addressline_1(sram_1_addressline_1),.sram_1_addressline_2(sram_1_addressline_2),
	     .sram_2_addressline_1(sram_2_addressline_1),.sram_2_addressline_2(sram_2_addressline_2),
	     .sram_3_addressline_1(sram_3_addressline_1),.sram_3_addressline_2(sram_3_addressline_2),
	     .sram_4_addressline_1(sram_4_addressline_1),.sram_4_addressline_2(sram_4_addressline_2),
	     .Y_addressline_1(Y_addressline_1),
	    .switch_from_fifo1_fifo2(switch_from_fifo1_fifo2),.sel_v1_v3(sel_v1_v3),.sel_v2_v4(sel_v2_v4),
             .v_ram_no_1(v_ram_no_1), .v_ram_no_2(v_ram_no_2), .v_ram_no_3(v_ram_no_3), .v_ram_no_4(v_ram_no_4),

	    .reset(reset),.enable(enable),.clock(clock),.vsram_read_control(vsram_read_control));	

V_from_Y V_Y(.v_ram_no_1(v_ram_no_1),.v_ram_no_2(v_ram_no_2),.v_ram_no_3(v_ram_no_3),.v_ram_no_4(v_ram_no_4),
		.sel_v1_v3(sel_v1_v3),.sel_v2_v4(sel_v2_v4),
		.v_value_1(v_value_1),.v_value_2(v_value_2),.v_value_3(v_value_3),.v_value_4(v_value_4),
		.clock(clock),.reset(reset),.enable(enable),
		 .sram_1_readline_1(sram_1_readline_1),.sram_1_readline_2(sram_1_readline_2),
	         .sram_2_readline_1(sram_2_readline_1),.sram_2_readline_2(sram_2_readline_2),
	         .sram_3_readline_1(sram_3_readline_1),.sram_3_readline_2(sram_3_readline_2),
	         .sram_4_readline_1(sram_4_readline_1),.sram_4_readline_2(sram_4_readline_2));


accum_control A_C(.feedback_check1(feedback_check1),.feedback_check2(feedback_check2),.accum_done(accum_done),.get_I_flag(get_I_flag),.sel_add_even_odd(sel_add_even_odd
),.row_count(row_count),.row_count_I(row_count_I),.clock(clock),.reset(reset),.enable(enable),.zero_on_V(zero_on_V));

//I subtract
I_subtract_accum I_sub_accum(.I_input(I_input),.accum_value(accum_out),
                                .in1_sub1(in1_sub1),.in2_sub1(in2_sub1),.opt_sub1(opt_sub1),
                                .result_I_minus_Accum(result_I_minus_Accum),.I_value_select(I_value_select),
                               .get_I_flag(get_I_flag),.clock(clock), .enable(enable), .reset(reset)
                              );

control_I_accum control_I(.clock(clock),.get_I_flag(accum_done),
                       .I_column_info(row_count_I),.I_sram_addressline_1(I_sram_addressline_1),
  .I_value_select(I_value_select));

divider_wrap  Div1(.in_dividend(result_I_minus_Accum),.in_divider(y_diagonal),
    .in_outputOfDivider(in_outputOfDivider),.op_dividerIn1(op_dividerIn1),.op_dividerIn2(op_dividerIn2),.op_dividerResult(op_dividerResult));

dividor_done div_done(.clock(clock),.enable(enable),.reset(reset),.accum_done(accum_done),.dividor_done(dividor_done));
iter_done_calc iter_done_cal(.dividor_done(dividor_done),.Y_eof_reg(Y_eof_reg),.iter_done(iter_done),.clock(clock),.reset(reset),.enable(enable));

vSRAMwrite vSramWrite( .clock(clock),  .reset(reset),.enable(enable),  
                   .in_colNum_info(row_count),
                     .in_dataWriteVal(in_outputOfDivider),
		   .dividor_done(dividor_done),
		   .control_vsram_section(control_vsram_section),
                  .writeVsramDoneFlag(writeVsramDoneFlag),

                   .sram_1_writeAddressline(sram_1_writeAddressline), 
                   .sram_2_writeAddressline(sram_2_writeAddressline), 
                   .sram_3_writeAddressline(sram_3_writeAddressline), 
                   .sram_4_writeAddressline(sram_4_writeAddressline), 
                   .sram_1_writeEnable(sram_1_writeEnable), 
                   .sram_2_writeEnable(sram_2_writeEnable), 
                   .sram_3_writeEnable(sram_3_writeEnable), 
                   .sram_4_writeEnable(sram_4_writeEnable), 
                   .sram_1_writeData(sram_1_writeData), 
                   .sram_2_writeData(sram_2_writeData), 
                   .sram_3_writeData(sram_3_writeData), 
                   .sram_4_writeData(sram_4_writeData)  
                 );

accumulator accum1(.clock(clock),.reset(reset),.yv_mult(accum_feed),.sel_add_even_odd(sel_add_even_odd),
	.in1_adder1(in1_adder1),.in2_adder1(in2_adder1),.in1_adder2(in1_adder2),.in2_adder2(in2_adder2),
	.opt_adder1(opt_adder1),.opt_adder2(opt_adder2),
	.adder1_mode(adder1_mode),.adder2_mode(adder2_mode),
	.accum_out(accum_out),.feedback_check1(feedback_check1),.feedback_check2(feedback_check2),.enable(enable),.zero_on_V(zero_on_V));


endmodule
