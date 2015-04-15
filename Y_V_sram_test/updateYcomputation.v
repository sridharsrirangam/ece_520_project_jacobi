module updateYcomputation (clock, reset, computationEnable,

      uYc_chgTxt_row,uYc_chgTxt_col,
      uYc_chgTxt_real, uYc_chgTxt_img,
      uYc_ySRAM_rowRead1,uYc_ySRAM_rowRead2, 

      uYc_yMatAddrOut1,uYc_yMatAddrOut2, 
      uYc_dataPathDoneFlag, uYc_filtYopDone,
      uYc_opYval, 
      uYc_writeDiagAddr, uYc_writeNonDiagAddr,
      uYc_writeDiagOneHot, uYc_writeNonDiagOneHot,

      // For fp_DW

      uYC_op_fpIn1, uYC_op_fpIn2,
      uYC_op_fpMode,
      uYC_in_fpOut

	   );
/********** Module Inputs and Outputs **************/
	   
	input clock;
	input	reset;
   input computationEnable;
	
   input [15:0]    uYc_chgTxt_row,uYc_chgTxt_col; //From change.txt
   input [23:0]    uYc_chgTxt_real, uYc_chgTxt_img;
   input [255:0]   uYc_ySRAM_rowRead1,uYc_ySRAM_rowRead2; //From Y SRAM
	


   output [10:0]   uYc_yMatAddrOut1,uYc_yMatAddrOut2; 
   output [47:0]   uYc_opYval;
   output          uYc_dataPathDoneFlag,uYc_filtYopDone;
   output [10:0]   uYc_writeDiagAddr,
                   uYc_writeNonDiagAddr;
   output [3:0]    uYc_writeDiagOneHot,
                   uYc_writeNonDiagOneHot;
// For fp_DW

   output wire [47:0] uYC_op_fpIn1, uYC_op_fpIn2;
   output wire        uYC_op_fpMode;
   
   input  [47:0]      uYC_in_fpOut;




/************************ Wires and Regs*********************/	
 //  wire [255:0] uYc_ySRAM_rowRead;
 wire          wire_execEnable,wire_dataOuNxtCycle, wire_execDoneFlag,wire_yAD_Enable;
 wire [47:0]   uYc_filtYval1,uYc_filtYval2; 
 wire [15:0]   uYc_opRowNum_from_filtY;
 wire [10:0]   uYc_writeDiagAddr,
               uYc_writeNonDiagAddr;
 wire [3:0]    uYc_writeDiagOneHot,
               uYc_writeNonDiagOneHot;

wire [10:0] wire_inAddr1, wire_inAddr2;
   

/***************** Modules Instantiation *******************/


updateY_datapath unit_dataPath1 (.clock(clock),.reset(reset), .executeEnableBit(wire_execEnable),
                     .yInVal1(uYc_filtYval1), .yInVal2(uYc_filtYval2), 
                     .op_yWriteVal(uYc_opYval), .op_DoneFlag(uYc_dataPathDoneFlag),
                     .op_ExDoneFlag(wire_execDoneFlag), .op_CPDoneFlag(uYc_filtYopDone),

                     //For fp_DW
                      .op_fpIn1(uYC_op_fpIn1), .op_fpIn2(uYC_op_fpIn2),
                      .op_fpMode(uYC_op_fpMode),
                      .in_fpOut(uYC_in_fpOut)

                    );


updateY_control unit_controlY1 (.clock(clock), .reset(reset), .exModDone(wire_execDoneFlag), .op_DataEN(wire_yAD_Enable), 
     .chng_row(uYc_chgTxt_row), .chng_col(uYc_chgTxt_col ), .dpModDoneFlag(uYc_dataPathDoneFlag),
     .chng_real(uYc_chgTxt_real),.chng_img(uYc_chgTxt_img),
     .ymem_data1(uYc_ySRAM_rowRead1), .ymem_data2(uYc_ySRAM_rowRead2), .filt_EN(computationEnable),
     .yMemDataReadyNextCycle(wire_dataOuNxtCycle),
     .yAddrIn1(wire_inAddr1), .yAddrIn2(wire_inAddr2),

     .op_y_row(uYc_opRowNum_from_filtY),  .op_EX_EN(wire_execEnable), 
     .op_yVal1(uYc_filtYval1), .op_yVal2(uYc_filtYval2),
     .op_yAddrDiag(uYc_writeDiagAddr), .op_yAddrNonDiag(uYc_writeNonDiagAddr), 
     .op_oneHotDiag(uYc_writeDiagOneHot),.op_oneHotNonDiag(uYc_writeNonDiagOneHot)
     

     );


yAddrDecodr unit_yAD1 (.clock(clock), .reset (reset), .yAD_enable(wire_yAD_Enable),
      .yAD_readRowNum(uYc_opRowNum_from_filtY), .yAD_readRowData(uYc_ySRAM_rowRead1), 
      .yAD_outAddr1(uYc_yMatAddrOut1), .yAD_outAddr2(uYc_yMatAddrOut2), // send to yMem 
      .yAD_dataOutNextCycle(wire_dataOuNxtCycle)
      );

	
assign wire_inAddr1 = uYc_yMatAddrOut1;
assign wire_inAddr2 = uYc_yMatAddrOut2;

endmodule

