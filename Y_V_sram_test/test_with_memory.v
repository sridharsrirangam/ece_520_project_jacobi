`timescale 1 ns / 1 ns
module test_fixture;
reg clock,reset;
wire enable;
//reg enable;

wire [47:0] y_feed_mult,v_feed_mult;
wire [47:0] mult_result;
wire sel_add_even_odd,sel_feedback_or_0,accum_done;
wire [47:0] accum_feed;
wire [47:0] in1_adder1,in2_adder1,in1_adder2,in2_adder2;
wire [47:0] opt_adder1,opt_adder2;
wire adder1_mode,adder2_mode;
wire [47:0] accum_out;

wire  [ 8:0] sram_1_addressline_1,sram_1_addressline_2,
	     sram_2_addressline_1,sram_2_addressline_2,
	     sram_3_addressline_1,sram_3_addressline_2,
	     sram_4_addressline_1,sram_4_addressline_2;


wire [ 47:0] sram_1_readline_1,sram_1_readline_2,
	      sram_2_readline_1,sram_2_readline_2,
	      sram_3_readline_1,sram_3_readline_2,
	      sram_4_readline_1,sram_4_readline_2;

wire [8:0] sram1_WriteAddress1,sram1_WriteAdress2;
wire [8:0] sram2_WriteAddress1,sram2_WriteAdress2;
wire [8:0] sram3_WriteAddress1,sram3_WriteAdress2;
wire [8:0] sram4_WriteAddress1,sram4_WriteAdress2;

wire [47:0] sram1_WriteBus1,sram1_WriteBus2;
wire [47:0] sram2_WriteBus1,sram2_WriteBus2;
wire [47:0] sram3_WriteBus1,sram3_WriteBus2;
wire [47:0] sram4_WriteBus1,sram4_WriteBus2;
wire [15:0] y_1_col_info,y_2_col_info,y_3_col_info,y_4_col_info; 
wire [1:0] sel_v1_v3,sel_v2_v4;
wire [2:0] v_ram_no_1,v_ram_no_2,v_ram_no_3,v_ram_no_4;

wire [10:0] yram_WriteAddress;
wire [10:0] Y_addressline_1,ReadAddress2;
wire [255:0] ReadBus2,Yin;
wire [255:0] y_WriteBus;
wire WE_1,WE_2,WE_3,WE_4,WE_Y,WE_I;

wire [47:0] v_value_1,v_value_2,v_value_3,v_value_4;
wire  [7:0] WriteAddress_I,I_sram_addressline_1, I_sram_ReadAddress2; // Change as you change size of SRAM
wire  [191:0] I_WriteBus;
wire [191:0] I_sram_ReadBus2, I_input;
wire [1:0] I_value_select;
wire [47:0]  accum_value;
wire [47:0] in1_sub1,in2_sub1;
wire [47:0] opt_sub1;
wire [47:0] result_I_minus_Accum;
wire [9:0] row_count; 
wire feedback_check1,feedback_check2;
wire [47:0] op_dividerIn1,op_dividerIn2;
wire  [47:0] in_outputOfDivider;
wire control_vsram_section,vsram_read_control;
//reg control_vsram_section,vsram_read_control;
wire iter_done;
wire op_allItersDoneFlag;
initial
begin
clock=1'b1;
$readmemh("vmem_datasingle_op2a.mem",memory.V_1_sram.Register);
$readmemh("vmem_datasingle_op2b.mem",memory.V_2_sram.Register);
$readmemh("vmem_datasingle_op2c.mem",memory.V_3_sram.Register);
$readmemh("vmem_datasingle_op2d.mem",memory.V_4_sram.Register);
$readmemh("ymem_datasingle.mem",memory.Y_sram.Register);
$readmemh("imem_datasingle.mem",memory.I_sram.Register);
#10 reset=1'b0;
#10 reset=1'b1;
  //  enable=1'b1;
//	control_vsram_section=1'b1;
//	vsram_read_control=1'b0;
//#1700 enable=1'b0;
//#10 enable=1'b1;
//control_vsram_section=1'b0;
//	vsram_read_control=1'b1;


end
always #5 clock=~clock;

integrate I1(.clock(clock),.reset(reset),.enable(enable),.y_feed_mult(y_feed_mult),.v_feed_mult(v_feed_mult),.sel_add_even_odd(sel_add_even_odd),.accum_done(accum_done),.sram_1_addressline_1(sram_1_addressline_1),.sram_1_addressline_2(sram_1_addressline_2),
	     .sram_2_addressline_1(sram_2_addressline_1),.sram_2_addressline_2(sram_2_addressline_2),
	     .sram_3_addressline_1(sram_3_addressline_1),.sram_3_addressline_2(sram_3_addressline_2),
	     .sram_4_addressline_1(sram_4_addressline_1),.sram_4_addressline_2(sram_4_addressline_2),
	 .sram_1_readline_1(sram_1_readline_1),.sram_1_readline_2(sram_1_readline_2),
	      .sram_2_readline_1(sram_2_readline_1),.sram_2_readline_2(sram_2_readline_2),
	      .sram_3_readline_1(sram_3_readline_1),.sram_3_readline_2(sram_3_readline_2),
	      .sram_4_readline_1(sram_4_readline_1),.sram_4_readline_2(sram_4_readline_2),.Y_addressline_1(Y_addressline_1),.ReadAddress2(ReadAddress2),.Yin(Yin),	
	.I_input(I_input),.in1_sub1(in1_sub1),.in2_sub1(in2_sub1),.opt_sub1(opt_sub1),.result_I_minus_Accum(result_I_minus_Accum),.I_sram_addressline_1(I_sram_addressline_1),.accum_out(accum_out),.feedback_check1(feedback_check1),.feedback_check2(feedback_check2),.op_dividerIn1(op_dividerIn1),.op_dividerIn2(op_dividerIn2),.in_outputOfDivider(in_outputOfDivider),.sram_1_writeAddressline(sram1_WriteAddress1), 
                   .sram_2_writeAddressline(sram2_WriteAddress1), 
                   .sram_3_writeAddressline(sram3_WriteAddress1), 
                   .sram_4_writeAddressline(sram4_WriteAddress1), 
                   .sram_1_writeEnable(WE_1), 
                   .sram_2_writeEnable(WE_2), 
                   .sram_3_writeEnable(WE_3), 
                   .sram_4_writeEnable(WE_4), 
                   .sram_1_writeData(sram1_WriteBus1), 
                   .sram_2_writeData(sram2_WriteBus1), 
                   .sram_3_writeData(sram3_WriteBus1), 
                   .sram_4_writeData(sram4_WriteBus1), 
		.control_vsram_section(control_vsram_section),.vsram_read_control(vsram_read_control),.iter_done(iter_done),
 		.accum_feed(accum_feed),.adder1_mode(adder1_mode),.adder2_mode(adder2_mode),

 		.in1_adder1(in1_adder1), .in2_adder1(in2_adder1),.opt_adder1(opt_adder1),.in1_adder2(in1_adder2),.in2_adder2(in2_adder2),.opt_adder2(opt_adder2));




 fp_designware fp_designware(.clock(clock),
  		    	.y_feed_mult(y_feed_mult),.v_feed_mult(v_feed_mult),
 			.accum_feed(accum_feed),
 			.in1_adder1(in1_adder1),.in2_adder1(in2_adder1),.in1_adder2(in1_adder2),.in2_adder2(in2_adder2),
			 .opt_adder1(opt_adder1),.opt_adder2(opt_adder2),
			 .adder1_mode(adder1_mode),.adder2_mode(adder2_mode),
 			.in1_sub1(in1_sub1),.in2_sub1(in2_sub1),
 			.opt_sub1(opt_sub1),
 			.op_dividerIn1(op_dividerIn1),.op_dividerIn2(op_dividerIn2),
 			.in_outputOfDivider(in_outputOfDivider));
memory memory(clock, sram_1_addressline_1,sram_1_addressline_2,
	     sram_2_addressline_1,sram_2_addressline_2,
	     sram_3_addressline_1,sram_3_addressline_2,
	     sram_4_addressline_1,sram_4_addressline_2,

              sram_1_readline_1,sram_1_readline_2,
	      sram_2_readline_1,sram_2_readline_2,
	      sram_3_readline_1,sram_3_readline_2,
	      sram_4_readline_1,sram_4_readline_2,

 sram1_WriteAddress1,sram1_WriteAdress2,
 sram2_WriteAddress1,sram2_WriteAdress2,
 sram3_WriteAddress1,sram3_WriteAdress2,
 sram4_WriteAddress1,sram4_WriteAdress2,


 sram1_WriteBus1,sram1_WriteBus2,
 sram2_WriteBus1,sram2_WriteBus2,
 sram3_WriteBus1,sram3_WriteBus2,
 sram4_WriteBus1,sram4_WriteBus2,


yram_WriteAddress,
Y_addressline_1,ReadAddress2,
ReadBus2,Yin,
y_WriteBus,
 WE_1,WE_2,WE_3,WE_4,WE_Y,WE_I,

WriteAddress_I,I_sram_addressline_1, I_sram_ReadAddress2,
 I_WriteBus,
 I_sram_ReadBus2, I_input);



controlCounterIter countrol_iter_count(.reset(reset),.clock(clock),
                    .in_accumCalcDoneFlag(iter_done),.in_enableEntireModule(1'b1),

                    .op_enableAccumCalc(enable),.op_allItersDoneFlag(op_allItersDoneFlag),
      .op_control_vsram_section(control_vsram_section),.op_vsram_read_control(vsram_read_control));



endmodule


