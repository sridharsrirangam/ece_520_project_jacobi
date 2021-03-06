/* *************************************************************
 * This module contains all the control and data logic for the 
 * Jacobi matrix solver.
 *
 * ************************************************************/

//(like  top.v)
//
module myDesign(clock, reset,
      writeDoneFlag,
      mydes_chgTxt_row,mydes_chgTxt_col, 
      mydes_chgTxt_real,mydes_chgTxt_img, 
      mydes_ySRAM_rowRead1,mydes_ySRAM_rowRead2,
      mydes_opYval,
      mydes_ydataWrite,
      mydes_op_yReadAddress1, mydes_op_yReadAddress2, mydes_op_yWriteAddress,
      mydes_op_yWriteEnable,

      mydes_op_fpIn1, mydes_op_fpIn2,
      mydes_op_fpMode,
      mydes_in_fpOut,

      //Integ
      mydes_y_feed_mult, mydes_v_feed_mult,
      mydes_accum_feed,

      sram_1_addressline_1,sram_1_addressline_2, 
      sram_2_addressline_1,sram_2_addressline_2, 
      sram_3_addressline_1,sram_3_addressline_2, 
      sram_4_addressline_1,sram_4_addressline_2, 
      sram_1_readline_1,sram_1_readline_2, 
      sram_2_readline_1,sram_2_readline_2, 
      sram_3_readline_1,sram_3_readline_2, 
      sram_4_readline_1,sram_4_readline_2, 

      sram1_WriteAddress1, 
      sram2_WriteAddress1, 
      sram3_WriteAddress1, 
      sram4_WriteAddress1, 
      WE_1, 
      WE_2, 
      WE_3, 
      WE_4, 
      sram1_WriteBus1, 
      sram2_WriteBus1, 
      sram3_WriteBus1, 
      sram4_WriteBus1, 

      mydes_inImemData,
      mydes_inImemAddr,

      mydes_in1_sub1,mydes_in2_sub1,
      mydes_opt_sub1,

      mydes_in1_adder1,mydes_in2_adder1,
      mydes_opt_adder1,
      mydes_adder1_mode,

      mydes_in1_adder2,mydes_in2_adder2,
      mydes_opt_adder2,
      mydes_adder2_mode,

      mydes_op_dividerIn1,mydes_op_dividerIn2,
      mydes_in_outputOfDivider
      );

/********** Module Inputs and Outputs **************/
	input clock, reset;

   output wire writeDoneFlag;

   input [15:0]   mydes_chgTxt_row,mydes_chgTxt_col; //From change.txt
   input [23:0]   mydes_chgTxt_real, mydes_chgTxt_img;
   input [255:0]  mydes_ySRAM_rowRead1;
   input [255:0]  mydes_ySRAM_rowRead2;

   output [47:0]   mydes_opYval;
   output [255:0]  mydes_ydataWrite;
   output [10:0]   mydes_op_yReadAddress1, mydes_op_yReadAddress2, mydes_op_yWriteAddress;
   output mydes_op_yWriteEnable;         
// For fp_DW

   output wire [47:0] mydes_op_fpIn1, mydes_op_fpIn2;
   output wire        mydes_op_fpMode;
   
   input  [47:0]      mydes_in_fpOut;


	
/************************ Wires *******************/	
	


   wire [10:0]  wire_yAddrOut1;
   wire [10:0]  wire_yAddrOut2;

   wire [10:0]  wire_yAddrWrite;
   wire [255:0] wire_yDataWrite;

   wire [10:0]   wire_writeDiagAddr,
                 wire_writeNonDiagAddr;
   wire [3:0]    wire_writeDiagOneHot,
               wire_writeNonDiagOneHot;
// For write logic

   wire bWY_cpDoneFlag, bWY_dpDoneFlag,bWY_inModuleEnable;
   wire [10:0]  bWY_inDiagAddr, bWY_inNonDAddr;
   wire [3:0]   bWY_inDiagOH, bWY_inNonDiagOH;
   wire [255:0] inYreadData1, inYreadData2;
   wire [47:0]  bWY_inYComputedVal;
   wire [47:0]  bWY_inYchngData;
   wire [255:0] bWY_op_writeData;     wire [10:0] bWY_op_writeAddress;
   wire [10:0]  bWY_op_readStoreAddr; wire bWY_op_WEbit; 
   wire bWY_op_writeDone;

// For roundRobin

   wire wire_updateYmoduleEnable, wire_writeYvalEnable,wire_integModEnable;
   wire wire_dataPathDoneFlag,wire_filtYopDone;

// For integrate module
   output wire [47:0] mydes_y_feed_mult, mydes_v_feed_mult;
   input [47:0] mydes_accum_feed;

   output wire [8:0]  sram_1_addressline_1,sram_1_addressline_2; 
   output wire [8:0]  sram_2_addressline_1,sram_2_addressline_2; 
   output wire [8:0]  sram_3_addressline_1,sram_3_addressline_2; 
   output wire [8:0]  sram_4_addressline_1,sram_4_addressline_2; 
   input [47:0] sram_1_readline_1,sram_1_readline_2; 
   input [47:0] sram_2_readline_1,sram_2_readline_2; 
   input [47:0] sram_3_readline_1,sram_3_readline_2; 
   input [47:0] sram_4_readline_1,sram_4_readline_2; 
   output [8:0] sram1_WriteAddress1; 
   output [8:0] sram2_WriteAddress1; 
   output [8:0] sram3_WriteAddress1; 
   output [8:0] sram4_WriteAddress1; 
   output wire WE_1; 
   output wire WE_2; 
   output wire WE_3; 
   output wire WE_4; 
   input [47:0] sram1_WriteBus1; 
   input [47:0] sram2_WriteBus1; 
   input [47:0] sram3_WriteBus1; 
   input [47:0] sram4_WriteBus1; 

   wire [10:0]  integ_wire_yAddr1, integ_wire_yAddr2;

   input [191:0] mydes_inImemData;
   output wire [7:0]   mydes_inImemAddr;


   wire wire_control_vsram_section,wire_vsram_read_control;
   wire wire_iter_done;

   output wire [47:0]   mydes_in1_sub1, mydes_in2_sub1;
   input [47:0]         mydes_opt_sub1;

   output wire [47:0]   mydes_in1_adder1,mydes_in2_adder1;
   input [47:0]         mydes_opt_adder1;
   output wire          mydes_adder1_mode;

   output wire [47:0]   mydes_in1_adder2,mydes_in2_adder2;
   input [47:0]         mydes_opt_adder2;
   output wire          mydes_adder2_mode;

   output wire [47:0]   mydes_op_dividerIn1,mydes_op_dividerIn2;
   input [47:0]         mydes_in_outputOfDivider;


 // For counter Control Mod
   wire wire_enableAccumCalc, wire_allItersDoneFlag;

 /*********Assign For testing ******/
   assign mydes_yMatOut1 = mydes_ySRAM_rowRead1;
   assign mydes_yMatOut2 = mydes_ySRAM_rowRead2;

   assign writeDoneFlag = wire_allItersDoneFlag;
/***************** Modules Instan *******************/
	updateYcomputation uYc_inst (	.clock(clock), .reset(reset),.computationEnable(wire_updateYmoduleEnable),

            .uYc_chgTxt_row(mydes_chgTxt_row),  .uYc_chgTxt_col(mydes_chgTxt_col),
            .uYc_chgTxt_real(mydes_chgTxt_real), .uYc_chgTxt_img(mydes_chgTxt_img),
            .uYc_ySRAM_rowRead1(mydes_ySRAM_rowRead1), .uYc_ySRAM_rowRead2(mydes_ySRAM_rowRead2), 
            .uYc_yMatAddrOut1(wire_yAddrOut1), .uYc_yMatAddrOut2(wire_yAddrOut2), 
            .uYc_dataPathDoneFlag(mydes_dataPathDoneFlag), .uYc_filtYopDone(mydes_filtYopDone),
            .uYc_opYval(mydes_opYval),// might not need this output
            .uYc_writeDiagAddr(wire_writeDiagAddr),     .uYc_writeNonDiagAddr(wire_writeNonDiagAddr),
            .uYc_writeDiagOneHot(wire_writeDiagOneHot), .uYc_writeNonDiagOneHot(wire_writeNonDiagOneHot),

      // For fp_DW

            .uYC_op_fpIn1(mydes_op_fpIn1), .uYC_op_fpIn2(mydes_op_fpIn2),
            .uYC_op_fpMode(mydes_op_fpMode),
            .uYC_in_fpOut(mydes_in_fpOut)
			);

//-----------------
   roundRobin rR_inst(.reset(reset), .clock(clock),     .soft_rst(wire_allItersDoneFlag),
      .in_updateYCtrlPathDoneFlag(mydes_filtYopDone),   .in_updateYwriteDoneFlag(bWY_op_writeDone),
      .op_updateYmoduleEnable(wire_updateYmoduleEnable),     .op_writeYvalEnable(wire_writeYvalEnable),
      .op_integrateModEnable(wire_integModEnable)
      );
//------------


busArbit busArbit_inst(.reset(reset),
       .in_yComputeModuleEnable(wire_updateYmoduleEnable),   .in_yWriteModuleEnable(wire_writeYvalEnable),.in_integrateModEnable(wire_integModEnable),

       .in_controlPathReadAddr1(wire_yAddrOut1),   .in_controlPathReadAddr2(wire_yAddrOut2),
       .in_controlPathWE(1'b0),          .in_controlPathWriteAddr(11'h7ff),
       .in_controlPathWriteData(256'b0),

       .in_writePathReadAddr1(bWY_op_writeAddress), .in_writePathReadAddr2(bWY_op_readStoreAddr),
       .in_writePathWE(bWY_op_WEbit),        .in_writePathWriteAddr(bWY_op_writeAddress),
       .in_writePathWriteData(bWY_op_writeData),

       .in_computePathReadAddr1(integ_wire_yAddr1), .in_computePathReadAddr2(integ_wire_yAddr2),
       .in_computePathWE(1'b0),          .in_computePathWriteAddr(11'h7ff),
       .in_computePathWriteData(256'b0),

       .op_yReadAddress1(mydes_op_yReadAddress1), .op_yReadAddress2(mydes_op_yReadAddress2),
       .op_yWriteEnable(mydes_op_yWriteEnable),  .op_yWriteAddress(mydes_op_yWriteAddress),
       .op_writeData(mydes_ydataWrite)

      );
//------------

busWriteY busWriteY_inst(.clock(clock), .reset(reset), .inModuleEnable(wire_writeYvalEnable),
      .cpDoneFlag(mydes_filtYopDone),    .dpDoneFlag(mydes_dataPathDoneFlag),
      .inDiagAddr(wire_writeDiagAddr),    .inNonDAddr(wire_writeNonDiagAddr),
      .inDiagOH(wire_writeDiagOneHot),        .inNonDiagOH(wire_writeNonDiagOneHot),
      .inYreadData1(mydes_ySRAM_rowRead1),  .inYreadData2(mydes_ySRAM_rowRead2),
      .inYComputedVal(mydes_opYval),
      .inYchngData({mydes_chgTxt_real,mydes_chgTxt_img}), 

      .op_writeData(bWY_op_writeData),     .op_writeAddress(bWY_op_writeAddress),
      .op_readStoreAddr(bWY_op_readStoreAddr), .op_WEbit(bWY_op_WEbit), 
      .op_writeDone(bWY_op_writeDone)
      );


integrate integ_inst(.clock(clock),.reset(reset),.enable(wire_enableAccumCalc),

      .y_feed_mult(mydes_y_feed_mult),.v_feed_mult(mydes_v_feed_mult),
      .accum_feed(mydes_accum_feed),

      .sram_1_addressline_1(sram_1_addressline_1),.sram_1_addressline_2(sram_1_addressline_2),
	   .sram_2_addressline_1(sram_2_addressline_1),.sram_2_addressline_2(sram_2_addressline_2),
	   .sram_3_addressline_1(sram_3_addressline_1),.sram_3_addressline_2(sram_3_addressline_2),
	   .sram_4_addressline_1(sram_4_addressline_1),.sram_4_addressline_2(sram_4_addressline_2),

	   .sram_1_readline_1(sram_1_readline_1),.sram_1_readline_2(sram_1_readline_2),
	   .sram_2_readline_1(sram_2_readline_1),.sram_2_readline_2(sram_2_readline_2),
	   .sram_3_readline_1(sram_3_readline_1),.sram_3_readline_2(sram_3_readline_2),
	   .sram_4_readline_1(sram_4_readline_1),.sram_4_readline_2(sram_4_readline_2),

      .Y_addressline_1(integ_wire_yAddr1),.ReadAddress2(integ_wire_yAddr2),
      .Yin(mydes_ySRAM_rowRead1),	

      .I_input(mydes_inImemData),.I_sram_addressline_1(mydes_inImemAddr),
//___________________________________________________________________________________________________
      .in1_sub1(mydes_in1_sub1),.in2_sub1(mydes_in2_sub1),.opt_sub1(mydes_opt_sub1),

      .op_dividerIn1(mydes_op_dividerIn1),.op_dividerIn2(mydes_op_dividerIn2), 
      .in_outputOfDivider(mydes_in_outputOfDivider),
//----------------------------------------------------------------------------------------------------
      .sram_1_writeAddressline(sram1_WriteAddress1), 
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

		.control_vsram_section(wire_control_vsram_section),.vsram_read_control(wire_vsram_read_control),
                              .iter_done(wire_iter_done),

      .in1_adder1(mydes_in1_adder1), .in2_adder1(mydes_in2_adder1),
      .opt_adder1(mydes_opt_adder1), .adder1_mode(mydes_adder1_mode),

      .in1_adder2(mydes_in1_adder2), .in2_adder2 (mydes_in2_adder2),
      .opt_adder2(mydes_opt_adder2), .adder2_mode(mydes_adder2_mode)

      );

// Control Counter for Iter
controlCounterIter controlCounterIter_inst( .reset(reset), .clock(clock),
                           .in_accumCalcDoneFlag(wire_iter_done), .in_enableEntireModule(wire_integModEnable),

                           .op_enableAccumCalc(wire_enableAccumCalc), 
                           .op_allItersDoneFlag(wire_allItersDoneFlag),
                           .op_control_vsram_section(wire_control_vsram_section),   
                           .op_vsram_read_control(wire_vsram_read_control)	
      );


endmodule
