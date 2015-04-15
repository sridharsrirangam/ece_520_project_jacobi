/* ***************************************************************
 * This module stores the addresses and the OneHot values of the
 * Diagonal and NonDiagonal elements to be written into the Y mem
 * as and when the done flags arrive. 
 * Once all the calculations are done, we first fetch the row(s)
 * and then overwrite the new data on the fetched row(s) back to
 * the same location. This process is repeated for both the sets
 * of data and once the computation is done, we set a done flag.
 *
 * Inputs: 1. 48bit {real,img} part from change.txt
 *         2. 11 bit Diagonal & Non Diag Addresses
 *         3. 4 bit Diag and Non Diag OneHot values
 *         4. DPDoneFlag and CPDoneFlag
 *         5. Two 256 bit yReadData
 *         6. 48 bit computed Y Diag value
 *         7. clock,reset, module enable
 *
 * Outputs: 1. 256bit op_writeData
 *          2. 11bit op_writeAddress, op_readStoreAddr
 *          3. 1bit op_WEbit
 *          4. 1bit op_filtEN/op_writeDone - To turn off filtEN.
 *                                           Needs better control
 *                                           logic since we need
 *                                           to consider output
 *                                           module's iteration
 * 
 *
 * ***************************************************************/

module busWriteY(input clock, input reset, input inModuleEnable,
      input cpDoneFlag, input dpDoneFlag,
      input [10:0] inDiagAddr, input [10:0] inNonDAddr,
      input [3:0] inDiagOH, input [3:0] inNonDiagOH,
      input [255:0] inYreadData1, input [255:0] inYreadData2,
      input [47:0] inYComputedVal,
      input [47:0] inYchngData, // concatenated value from change.txt

      output reg [255:0] op_writeData, output reg [10:0] op_writeAddress,
      output reg [10:0] op_readStoreAddr, output reg op_WEbit, 
      output reg op_writeDone
      );

/* Wires and Reg */
reg [1:0]      current_state, next_state;
reg [255:0]    tempStoreData;
reg [10:0]     tempDiagAddr1,tempDiagAddr2,tempNonDiagAddr1,tempNonDiagAddr2;
reg [3:0]      tempDiagOH1,tempDiagOH2,tempNonDiagOH1,tempNonDiagOH2;
reg [47:0]     tempComputedDiagVal1,tempComputedDiagVal2;
reg            tempDataSecond; // like temp_bit. 0 if we're loading first set of data. 1 otherwise
reg            tempDPFlag,tempCPFlag;

//Combinational logic
reg [10:0]     reg_tempDiagAddr1,reg_tempDiagAddr2,reg_tempNonDiagAddr1,reg_tempNonDiagAddr2;
reg [3:0]      reg_tempDiagOH1,reg_tempDiagOH2,reg_tempNonDiagOH1,reg_tempNonDiagOH2;


reg            reg_op_WEBit,reg_op_writeDone;
reg [255:0]    reg_op_writeData, reg_tempStoreData;
reg [10:0]     reg_op_writeAddress,reg_op_readStoreAddr;
reg [47:0]     reg_tempComputedDiagVal1,reg_tempComputedDiagVal2;
reg            reg_tempDataSecond; // like temp_bit. 0 if we're loading first set of data. 1 otherwise
reg            reg_tempDPFlag,reg_tempCPFlag;

//Wires
reg [47:0]     reg_wireComputedDiagVal;
reg [10:0]     reg_wireDiagAddr,reg_wireNonDiagAddr;
reg [3:0]      reg_wireDiagOH,reg_wireNonDiagOH;



/* parameters */
parameter s0 = 0,
          s1 = 1,
          s2 = 2,
          s3 = 3;

/* modules */
always@(posedge clock)
begin
   if(~(reset & inModuleEnable))
   begin
      op_writeData          <= 256'b0;
      op_writeAddress       <= 11'b0;
      op_WEbit              <= 1'b0;
      op_readStoreAddr      <= 11'b0;
      op_writeDone          <= 1'b0;

      tempStoreData         <= 256'b0;
      tempDataSecond        <= 1'b0;

      current_state         <= s0;

   end//reset
   else
   begin
      op_writeData          <= reg_op_writeData;
      op_writeAddress       <= reg_op_writeAddress;
      op_WEbit              <= reg_op_WEBit;
      op_readStoreAddr      <= reg_op_readStoreAddr;
      op_writeDone          <= reg_op_writeDone;

      tempStoreData         <= reg_tempStoreData;
      tempDataSecond        <= reg_tempDataSecond;

      current_state         <= next_state;
   end// not reset and enable

   if(~reset)
   begin
      tempDiagAddr1         <= 11'b0;
      tempDiagAddr2         <= 11'b0;
      tempNonDiagAddr1      <= 11'b0;
      tempNonDiagAddr2      <= 11'b0;
      tempDiagOH1           <= 4'b0;
      tempDiagOH2           <= 4'b0;
      tempNonDiagOH1        <= 4'b0;
      tempNonDiagOH2        <= 4'b0;
      tempComputedDiagVal1  <= 48'b0;
      tempComputedDiagVal2  <= 48'b0;
      tempDPFlag            <= 1'b0;
      tempCPFlag            <= 1'b0;
   end
   else
   begin
      tempDiagAddr1         <= reg_tempDiagAddr1;
      tempDiagAddr2         <= reg_tempDiagAddr2;
      tempNonDiagAddr1      <= reg_tempNonDiagAddr1;
      tempNonDiagAddr2      <= reg_tempNonDiagAddr2;
      tempDiagOH1           <= reg_tempDiagOH1;
      tempDiagOH2           <= reg_tempDiagOH2;
      tempNonDiagOH1        <= reg_tempNonDiagOH1;
      tempNonDiagOH2        <= reg_tempNonDiagOH2;
      tempComputedDiagVal1  <= reg_tempComputedDiagVal1;
      tempComputedDiagVal2  <= reg_tempComputedDiagVal2;
      tempDPFlag            <= reg_tempDPFlag;
      tempCPFlag            <= reg_tempCPFlag;
   end// reset
end// posedge clock

always@(*)
begin
   reg_tempDPFlag           = dpDoneFlag;
   reg_tempCPFlag           = cpDoneFlag;

   case(current_state)
   s0:
   begin

      if(tempDPFlag & (~(tempCPFlag)))
         next_state               = s0;
      else if(tempDPFlag & (~(tempCPFlag)))
         next_state               = s1;
      else
         next_state               = s1;



      if(dpDoneFlag&(~(cpDoneFlag)))
      begin
         reg_tempDiagAddr1        = inDiagAddr;
         reg_tempNonDiagAddr1     = inNonDAddr;
         reg_tempDiagOH1          = inDiagOH;
         reg_tempNonDiagOH1       = inNonDiagOH;
         reg_tempComputedDiagVal1 = inYComputedVal;

         reg_tempDiagAddr2        = 11'h7ff;
         reg_tempNonDiagAddr2     = 11'h7ff;
         reg_tempDiagOH2          = 4'b0;
         reg_tempNonDiagOH2       = 4'b0;
         reg_tempComputedDiagVal2 = 48'b0;

         reg_op_WEBit             = 1'b0;
         reg_op_writeDone         = 1'b0;
         reg_op_writeData         = 256'b0; 
         reg_op_writeAddress      = 11'h7ff;
         reg_op_readStoreAddr     = 11'h7ff;

         reg_tempStoreData        = 256'b0;
         reg_tempDataSecond       = 1'b0;



      end// dpDoneFlag=1, cpDoneFlag=0
      else if(dpDoneFlag&cpDoneFlag)
      begin
         reg_tempDiagAddr2        = inDiagAddr;
         reg_tempNonDiagAddr2     = inNonDAddr;
         reg_tempDiagOH2          = inDiagOH;
         reg_tempNonDiagOH2       = inNonDiagOH;
         reg_tempComputedDiagVal2 = inYComputedVal;

         reg_tempDiagAddr1        = tempDiagAddr1;
         reg_tempNonDiagAddr1     = tempNonDiagAddr1;
         reg_tempDiagOH1          = tempDiagOH1;
         reg_tempNonDiagOH1       = tempNonDiagOH1;
         reg_tempComputedDiagVal1 = tempComputedDiagVal1;

         reg_op_WEBit             = 1'b0;
         reg_op_writeDone         = 1'b0;
         reg_op_writeData         = 256'b0; 
         reg_op_writeAddress      = 11'h7ff;
         reg_op_readStoreAddr     = 11'h7ff;

         reg_tempStoreData        = 256'b0;
         reg_tempDataSecond       = 1'b0;


      end// dpDoneFlag=1, cpDoneFlag=1
      else
      begin

         reg_tempDiagAddr1        = tempDiagAddr1;
         reg_tempNonDiagAddr1     = tempNonDiagAddr1;
         reg_tempDiagOH1          = tempDiagOH1;
         reg_tempNonDiagOH1       = tempNonDiagOH1;
         reg_tempComputedDiagVal1 = tempComputedDiagVal1;

         reg_tempDiagAddr2        = tempDiagAddr2;
         reg_tempNonDiagAddr2     = tempNonDiagAddr2;
         reg_tempDiagOH2          = tempDiagOH2;
         reg_tempNonDiagOH2       = tempNonDiagOH2;
         reg_tempComputedDiagVal2 = tempComputedDiagVal2;

         reg_op_WEBit             = 1'b0;
         reg_op_writeDone         = 1'b0;
         reg_op_writeData         = 256'b0; 
         reg_op_writeAddress      = 11'h7ff;
         reg_op_readStoreAddr     = 11'h7ff;

         reg_tempStoreData        = 256'b0;
         reg_tempDataSecond       = 1'b0;


      end// end-else
   end//s0
   s1:
   begin // which row(s) to fetch
      reg_wireComputedDiagVal = (tempDataSecond?tempComputedDiagVal2:tempComputedDiagVal1);// mux
      reg_wireDiagAddr        = (tempDataSecond?tempDiagAddr2:tempDiagAddr1);
      reg_wireNonDiagAddr     = (tempDataSecond?tempNonDiagAddr2:tempNonDiagAddr1);
      reg_wireDiagOH          = (tempDataSecond?tempDiagOH2:tempDiagOH1);
      reg_wireNonDiagOH       = (tempDataSecond?tempNonDiagOH2:tempNonDiagOH1);


      reg_tempDiagAddr1        = tempDiagAddr1;
      reg_tempNonDiagAddr1     = tempNonDiagAddr1;
      reg_tempDiagOH1          = tempDiagOH1;
      reg_tempNonDiagOH1       = tempNonDiagOH1;
      reg_tempComputedDiagVal1 = tempComputedDiagVal1;

      reg_tempDiagAddr2        = tempDiagAddr2;
      reg_tempNonDiagAddr2     = tempNonDiagAddr2;
      reg_tempDiagOH2          = tempDiagOH2;
      reg_tempNonDiagOH2       = tempNonDiagOH2;
      reg_tempComputedDiagVal2 = tempComputedDiagVal2;

      reg_op_WEBit             = 1'b0;
      reg_op_writeDone         = 1'b0;
      reg_op_writeData         = 256'b0; 

      reg_tempStoreData        = 256'b0;
      reg_tempDataSecond       = tempDataSecond; // retain value

      next_state               = s2;

      
      if(reg_wireNonDiagAddr == reg_wireDiagAddr)
      begin // both Diag and NonDiag are in the same row
         reg_op_writeAddress      = reg_wireDiagAddr; // or Nondiag. both are the same
         reg_op_readStoreAddr     = 11'h7ff; // second row is not needed
         
      end // both equal
      else
      begin// both not equal
         reg_op_writeAddress      = reg_wireDiagAddr; // 
         reg_op_readStoreAddr     = reg_wireNonDiagAddr;// fetch both rows
      end //end- both not equal


   end//s1
   s2:
   begin
      reg_wireComputedDiagVal = (tempDataSecond?tempComputedDiagVal2:tempComputedDiagVal1);// mux
      reg_wireDiagAddr        = (tempDataSecond?tempDiagAddr2:tempDiagAddr1);
      reg_wireNonDiagAddr     = (tempDataSecond?tempNonDiagAddr2:tempNonDiagAddr1);
      reg_wireDiagOH          = (tempDataSecond?tempDiagOH2:tempDiagOH1);
      reg_wireNonDiagOH       = (tempDataSecond?tempNonDiagOH2:tempNonDiagOH1);
      

      reg_tempDiagAddr1        = tempDiagAddr1;
      reg_tempNonDiagAddr1     = tempNonDiagAddr1;
      reg_tempDiagOH1          = tempDiagOH1;
      reg_tempNonDiagOH1       = tempNonDiagOH1;
      reg_tempComputedDiagVal1 = tempComputedDiagVal1;

      reg_tempDiagAddr2        = tempDiagAddr2;
      reg_tempNonDiagAddr2     = tempNonDiagAddr2;
      reg_tempDiagOH2          = tempDiagOH2;
      reg_tempNonDiagOH2       = tempNonDiagOH2;
      reg_tempComputedDiagVal2 = tempComputedDiagVal2;

      reg_op_WEBit             = 1'b1; 


      if(reg_wireNonDiagAddr == reg_wireDiagAddr)
      begin // both Diag and NonDiag are in the same row
         
         case(reg_wireDiagOH|reg_wireNonDiagOH) // since both are on the same line
         4'b0011: // store in last two places
         begin
            reg_op_writeData  = {inYreadData1[255:112],reg_wireComputedDiagVal,inYreadData1[63:48],inYchngData};
         end// 
         4'b0101: 
         begin
            reg_op_writeData  = {inYreadData1[255:176],reg_wireComputedDiagVal,inYreadData1[127:48],inYchngData};
         end// 
         4'b0110: 
         begin
            reg_op_writeData  = {inYreadData1[255:176],reg_wireComputedDiagVal,inYreadData1[127:112],inYchngData,inYreadData1[63:0]};
         end// 
         4'b1010: 
         begin
            reg_op_writeData  = {inYreadData1[255:240],reg_wireComputedDiagVal,inYreadData1[191:112],inYchngData,inYreadData1[63:0]};
         end// 
         4'b1100: 
         begin
            reg_op_writeData  = {inYreadData1[255:240],reg_wireComputedDiagVal,inYreadData1[191:176],inYchngData,inYreadData1[127:0]};
         end// 
         4'b1001: 
         begin
            reg_op_writeData  = {inYreadData1[255:240],reg_wireComputedDiagVal,inYreadData1[191:48],inYchngData};
         end// 
         default:// should never come here. make this 0 later
         begin
            reg_op_writeData  = 256'b0;
         end
         endcase

         reg_tempStoreData        = 256'b0;
         reg_op_readStoreAddr     = 11'h7ff; // second row is not needed
         reg_op_writeAddress      = reg_wireDiagAddr; // or Nondiag. both are the same

         reg_tempDataSecond       = (tempDataSecond?1'b0:1'b1); 
         
         next_state               = (tempDataSecond?s0:s1); 

         reg_op_writeDone         = (tempDataSecond?1'b1:1'b0); 
         
      end // both equal
      else
      begin// both not equal
         
         //Diag
         case(reg_wireDiagOH)
         4'b0001: // store in last place
         begin
            reg_op_writeData  = {inYreadData1[255:48],reg_wireComputedDiagVal};
         end// 
         4'b0010: 
         begin
            reg_op_writeData  = {inYreadData1[255:112],reg_wireComputedDiagVal,inYreadData1[63:0]};
         end// 
         4'b0100: 
         begin
            reg_op_writeData  = {inYreadData1[255:176],reg_wireComputedDiagVal,inYreadData1[127:0]};
         end// 
         4'b1000: 
         begin
            reg_op_writeData  = {inYreadData1[255:240],reg_wireComputedDiagVal,inYreadData1[191:0]};
         end// 
         default:// should never come here. make this 0 later
         begin
            reg_op_writeData  = 256'b0;
         end
         endcase
         
         //NonDiag
         case(reg_wireNonDiagOH)
         4'b0001: // store in last place
         begin
            reg_tempStoreData  = {inYreadData2[255:48],inYchngData};
         end// 
         4'b0010: 
         begin
            reg_tempStoreData  = {inYreadData2[255:112],inYchngData,inYreadData2[63:0]};
         end// 
         4'b0100: 
         begin
            reg_tempStoreData  = {inYreadData2[255:176],inYchngData,inYreadData2[127:0]};
         end// 
         4'b1000: 
         begin
            reg_tempStoreData  = {inYreadData2[255:240],inYchngData,inYreadData2[191:0]};
         end// 
         default:// should never come here. make this 0 later
         begin
            reg_tempStoreData  = 256'b0;
         end
         endcase

         reg_op_readStoreAddr     = reg_wireNonDiagAddr;
         reg_op_writeAddress      = reg_wireDiagAddr; 

         next_state               = s3; // need to send next row of data

         reg_tempDataSecond       = tempDataSecond;

         reg_op_writeDone         = 1'b0;

      end //end- both not equal


   end//s2
   s3:
   begin
      reg_wireComputedDiagVal = (tempDataSecond?tempComputedDiagVal2:tempComputedDiagVal2);// mux
      reg_wireDiagAddr        = (tempDataSecond?tempNonDiagAddr2:tempDiagAddr1);
      reg_wireNonDiagAddr     = (tempDataSecond?tempNonDiagAddr2:tempNonDiagAddr1);
      reg_wireDiagOH          = (tempDataSecond?tempDiagOH2:tempDiagOH1);
      reg_wireNonDiagOH       = (tempDataSecond?tempNonDiagOH2:tempNonDiagOH1);

      reg_tempDiagAddr1        = tempDiagAddr1;
      reg_tempNonDiagAddr1     = tempNonDiagAddr1;
      reg_tempDiagOH1          = tempDiagOH1;
      reg_tempNonDiagOH1       = tempNonDiagOH1;
      reg_tempComputedDiagVal1 = tempComputedDiagVal1;

      reg_tempDiagAddr2        = tempDiagAddr2;
      reg_tempNonDiagAddr2     = tempNonDiagAddr2;
      reg_tempDiagOH2          = tempDiagOH2;
      reg_tempNonDiagOH2       = tempNonDiagOH2;
      reg_tempComputedDiagVal2 = tempComputedDiagVal2;

      reg_op_WEBit             = 1'b1; 

      reg_op_writeAddress      = reg_wireNonDiagAddr;
      reg_op_writeData         = tempStoreData;

      reg_tempDataSecond       = (tempDataSecond?1'b0:1'b1); 
      
      next_state               = (tempDataSecond?s0:s1); 

      reg_op_writeDone         = (tempDataSecond?1'b1:1'b0); 
   end//s3
   endcase

end//awlays@(*)

endmodule
