module top(clock, reset,
      writeDoneFlag,
      top_chgTxt_row,top_chgTxt_col, 
      top_chgTxt_real,top_chgTxt_img, 
      top_opYval
      );

/********** Module Inputs and Outputs **************/
	input clock, reset;
   output wire writeDoneFlag;

   input [15:0]   top_chgTxt_row,top_chgTxt_col; //From change.txt
   input [23:0]   top_chgTxt_real, top_chgTxt_img;

   output [47:0] top_opYval;
// For fp_DW

   wire [47:0] top_op_fpIn1, top_op_fpIn2;
   wire        top_op_fpMode;
   
   wire  [47:0]      top_in_fpOut;


	
/************************ Wires *******************/	
	

   wire [255:0] top_ysram_ReadBus1;
   wire [255:0] top_ysram_ReadBus2;

   wire [10:0]  top_Y_addressline_1;
   wire [10:0]  top_Y_addressline_2;

   wire [10:0]  top_yram_WriteAddress;
   wire [255:0] top_y_WriteBus;

   wire top_WE_Y;
//For memories and instan
   wire [47:0] top_y_feed_mult, top_v_feed_mult;
   wire [47:0] top_accum_feed;

   wire [8:0]  top_sram_1_addressline_1,top_sram_1_addressline_2; 
   wire [8:0]  top_sram_2_addressline_1,top_sram_2_addressline_2; 
   wire [8:0]  top_sram_3_addressline_1,top_sram_3_addressline_2; 
   wire [8:0]  top_sram_4_addressline_1,top_sram_4_addressline_2; 
   wire [47:0] top_sram_1_readline_1,   top_sram_1_readline_2; 
   wire [47:0] top_sram_2_readline_1,   top_sram_2_readline_2; 
   wire [47:0] top_sram_3_readline_1,   top_sram_3_readline_2; 
   wire [47:0] top_sram_4_readline_1,   top_sram_4_readline_2; 
   wire [8:0]  top_sram1_WriteAddress1; 
   wire [8:0]  top_sram2_WriteAddress1; 
   wire [8:0]  top_sram3_WriteAddress1; 
   wire [8:0]  top_sram4_WriteAddress1; 
   wire top_WE_1; 
   wire top_WE_2; 
   wire top_WE_3; 
   wire top_WE_4; 
   wire [47:0] top_sram1_WriteBus1; 
   wire [47:0] top_sram2_WriteBus1; 
   wire [47:0] top_sram3_WriteBus1; 
   wire [47:0] top_sram4_WriteBus1; 


   wire [191:0] top_inImemData;
   wire [191:0] top_I_sram_ReadBus2;
   wire [7:0]   top_inImemAddr;


   wire [47:0]   top_in1_sub1,top_in2_sub1;
   wire [47:0]   top_opt_sub1;

   wire [47:0]   top_in1_adder1,top_in2_adder1;
   wire [47:0]   top_opt_adder1;
   wire          top_adder1_mode;

   wire [47:0]   top_in1_adder2,top_in2_adder2;
   wire [47:0]   top_opt_adder2;
   wire          top_adder2_mode;

   wire [47:0]   top_op_dividerIn1,top_op_dividerIn2;
   wire [47:0]   top_in_outputOfDivider;


/***************** Modules Instan *******************/
myDesign myDes_inst(.clock(clock), .reset(reset),
      .writeDoneFlag(writeDoneFlag),
      .mydes_chgTxt_row(top_chgTxt_row),     .mydes_chgTxt_col(top_chgTxt_col), 
      .mydes_chgTxt_real(top_chgTxt_real),    .mydes_chgTxt_img(top_chgTxt_img), 
      .mydes_ySRAM_rowRead1(top_ysram_ReadBus1), .mydes_ySRAM_rowRead2(top_ysram_ReadBus2),
      .mydes_opYval(top_opYval),
      .mydes_ydataWrite(top_y_WriteBus),
      .mydes_op_yReadAddress1(top_Y_addressline_1),  .mydes_op_yReadAddress2(top_Y_addressline_2),
      .mydes_op_yWriteAddress(top_yram_WriteAddress), .mydes_op_yWriteEnable(top_WE_Y),

      //For fp_DW
      .mydes_op_fpIn1(top_op_fpIn1), .mydes_op_fpIn2(top_op_fpIn2),
      .mydes_op_fpMode(top_op_fpMode),
      .mydes_in_fpOut(top_in_fpOut),
      .mydes_y_feed_mult(top_y_feed_mult), .mydes_v_feed_mult(top_v_feed_mult),
      .mydes_accum_feed(top_accum_feed),

      .sram_1_addressline_1(top_sram_1_addressline_1),.sram_1_addressline_2(top_sram_1_addressline_2), 
      .sram_2_addressline_1(top_sram_2_addressline_1),.sram_2_addressline_2(top_sram_2_addressline_2), 
      .sram_3_addressline_1(top_sram_3_addressline_1),.sram_3_addressline_2(top_sram_3_addressline_2), 
      .sram_4_addressline_1(top_sram_4_addressline_1),.sram_4_addressline_2(top_sram_4_addressline_2), 
      .sram_1_readline_1(top_sram_1_readline_1),.sram_1_readline_2(top_sram_1_readline_2), 
      .sram_2_readline_1(top_sram_2_readline_1),.sram_2_readline_2(top_sram_2_readline_2), 
      .sram_3_readline_1(top_sram_3_readline_1),.sram_3_readline_2(top_sram_3_readline_2), 
      .sram_4_readline_1(top_sram_4_readline_1),.sram_4_readline_2(top_sram_4_readline_2), 

      .sram1_WriteAddress1(top_sram1_WriteAddress1), 
      .sram2_WriteAddress1(top_sram2_WriteAddress1), 
      .sram3_WriteAddress1(top_sram3_WriteAddress1), 
      .sram4_WriteAddress1(top_sram4_WriteAddress1), 
      .WE_1(top_WE_1), 
      .WE_2(top_WE_2), 
      .WE_3(top_WE_3), 
      .WE_4(top_WE_4), 
      .sram1_WriteBus1(top_sram1_WriteBus1), 
      .sram2_WriteBus1(top_sram2_WriteBus1), 
      .sram3_WriteBus1(top_sram3_WriteBus1), 
      .sram4_WriteBus1(top_sram4_WriteBus1), 

      .mydes_inImemData(top_inImemData),
      .mydes_inImemAddr(top_inImemAddr),

      .mydes_in1_sub1(top_in1_sub1),.mydes_in2_sub1(top_in2_sub1),
      .mydes_opt_sub1(top_opt_sub1),

      .mydes_in1_adder1(top_in1_adder1),.mydes_in2_adder1(top_in2_adder1),
      .mydes_opt_adder1(top_opt_adder1),
      .mydes_adder1_mode(top_adder1_mode),

      .mydes_in1_adder2(top_in1_adder2),.mydes_in2_adder2(top_in2_adder2),
      .mydes_opt_adder2(top_opt_adder2),
      .mydes_adder2_mode(top_adder2_mode),

      .mydes_op_dividerIn1(top_op_dividerIn1),.mydes_op_dividerIn2(top_op_dividerIn2),
      .mydes_in_outputOfDivider(top_in_outputOfDivider)
      );

 memory memory(.clock(clock),
		      .sram_1_addressline_1(top_sram_1_addressline_1),.sram_1_addressline_2(top_sram_1_addressline_2),
	              .sram_2_addressline_1(top_sram_2_addressline_1),.sram_2_addressline_2(top_sram_2_addressline_2),
	              .sram_3_addressline_1(top_sram_3_addressline_1),.sram_3_addressline_2(top_sram_3_addressline_2),
	              .sram_4_addressline_1(top_sram_4_addressline_1),.sram_4_addressline_2(top_sram_4_addressline_2),

              .sram_1_readline_1(top_sram_1_readline_1),.sram_1_readline_2(top_sram_1_readline_2),
	      .sram_2_readline_1(top_sram_2_readline_1),.sram_2_readline_2(top_sram_2_readline_2),
	      .sram_3_readline_1(top_sram_3_readline_1),.sram_3_readline_2(top_sram_3_readline_2),
	      .sram_4_readline_1(top_sram_4_readline_1),.sram_4_readline_2(top_sram_4_readline_2),

 .sram1_WriteAddress1(top_sram1_WriteAddress1),.sram1_WriteAdress2(top_sram1_WriteAddress1),
 .sram2_WriteAddress1(top_sram2_WriteAddress1),.sram2_WriteAdress2(top_sram2_WriteAddress1),
 .sram3_WriteAddress1(top_sram3_WriteAddress1),.sram3_WriteAdress2(top_sram3_WriteAddress1),
 .sram4_WriteAddress1(top_sram4_WriteAddress1),.sram4_WriteAdress2(top_sram4_WriteAddress1),


 .sram1_WriteBus1(top_sram1_WriteBus1),.sram1_WriteBus2(top_sram1_WriteBus1),
 .sram2_WriteBus1(top_sram2_WriteBus1),.sram2_WriteBus2(top_sram2_WriteBus1),
 .sram3_WriteBus1(top_sram3_WriteBus1),.sram3_WriteBus2(top_sram3_WriteBus1),
 .sram4_WriteBus1(top_sram4_WriteBus1),.sram4_WriteBus2(top_sram4_WriteBus1),


.yram_WriteAddress(top_yram_WriteAddress),
.Y_addressline_1(top_Y_addressline_1),.ReadAddress2(top_Y_addressline_2),
.ReadBus2(top_ysram_ReadBus2),.ReadBus1(top_ysram_ReadBus1),
.y_WriteBus(top_y_WriteBus),
.WE_1(top_WE_1),
.WE_2(top_WE_2),
.WE_3(top_WE_3),
.WE_4(top_WE_4),
.WE_Y(top_WE_Y),
.WE_I(1'b0),

.WriteAddress_I(top_WriteAddress_I),.I_sram_addressline_1(top_inImemAddr), .I_sram_ReadAddress2(top_inImemAddr),
.I_WriteBus(top_I_WriteBus),
.I_sram_ReadBus2(top_I_sram_ReadBus2), .I_sram_ReadBus1(top_inImemData));

fp_designware fp_designware(.clock(clock),
  		    	    .y_feed_mult(top_y_feed_mult),.v_feed_mult(top_v_feed_mult),
 			    .accum_feed(top_accum_feed),
 			    .in1_adder1(top_in1_adder1), .in2_adder1(top_in2_adder1),.in1_adder2(top_in1_adder2),.in2_adder2(top_in2_adder2),
			    .opt_adder1(top_opt_adder1), .opt_adder2(top_opt_adder2),
			    .adder1_mode(top_adder1_mode),.adder2_mode(top_adder2_mode),
 			    .in1_sub1(top_in1_sub1),   .in2_sub1(top_in2_sub1),
 			    .opt_sub1(top_opt_sub1),
 			    .op_dividerIn1(top_op_dividerIn1),.op_dividerIn2(top_op_dividerIn2),
 			    .in_outputOfDivider(top_in_outputOfDivider),
			    .in1_adder_adeesh(top_op_fpIn1),.in2_adder_adeesh(top_op_fpIn2),.opt_adder_adeesh(top_in_fpOut),
			    .adder_mode_adeesh(top_op_fpMode)
);

endmodule
