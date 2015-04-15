/* ***************************************************************
 *
 * Decodes the address of Y from row/col obtained from change.txt
 * and outputs two lines  (2x 256 bits)  of content at the output.
 * It takes two clock cycles to give output from the row computed.
 * If the input is an address. It just sends out the same thing.
 * Might need an extra ReadEnable signal in/out of the module.
 * The value of yAD_readRowData only matters in the second Clk 
 * cycle. 
 *
 * ***************************************************************/

module yAddrDecodr(clock, reset, yAD_enable,
      yAD_readRowNum,yAD_readRowData,
      yAD_outAddr1,yAD_outAddr2,
      yAD_dataOutNextCycle
      );

/* Inputs and Outputs */
input clock,reset, yAD_enable;
input [15:0] yAD_readRowNum;
input [255:0] yAD_readRowData;

output [10:0] yAD_outAddr1,yAD_outAddr2;
output yAD_dataOutNextCycle;


/* Wires and Reg */
reg [10:0] yAD_outAddr1,yAD_outAddr2;

wire [10:0] wire_outAddr1; 
reg reg_readEn;
reg yAD_dataOutNextCycle, temp_bit; //temp_bit is used to determine whether to fetch
                                    //Row 0-63 or the actual row.
reg [15:0] temp_oldRow;

always@(posedge clock)
begin
   if(~(reset & yAD_enable)) //synhronous reset
   begin
      yAD_outAddr1         <= 11'h7FF; 
      yAD_outAddr2         <= 11'h7FF;
      yAD_dataOutNextCycle <= 1'b0;
      temp_bit             <= 1'b1;
      reg_readEn           <= 1'b0;
      temp_oldRow          <= 11'h7ff;
   end
   else
   begin
      if((&yAD_readRowNum)&yAD_enable)
      begin
         yAD_outAddr1         <= yAD_outAddr1 + 2'd2;
         yAD_outAddr2         <= yAD_outAddr2 + 2'd2;
         reg_readEn           <= 1'b1;
         temp_bit             <= 1'b1;
         yAD_dataOutNextCycle <= 1'b0;
      end//-if &readRow
      else
      begin
         if(temp_bit)
         begin
            yAD_outAddr1         <= (yAD_readRowNum>>4);
            yAD_outAddr2         <= 11'h7FF;
            reg_readEn           <= 1'b1;
            temp_bit             <= 1'b0;
            temp_oldRow          <= yAD_readRowNum;

            if(yAD_enable)
               yAD_dataOutNextCycle <= 1'b1;  //FSM dependent output
            else
               yAD_dataOutNextCycle <= 1'b0;  //FSM dependent output
         end
         else
         begin
            yAD_outAddr1         <= wire_outAddr1;
            yAD_outAddr2         <= wire_outAddr1 + 1'd1; //Ripple Carry Adder
            reg_readEn           <= 1'b1;
            yAD_dataOutNextCycle <= 1'b0;
            temp_bit             <= 1'b1;
         end
      end//else- &readRow

   end //If - else for reset
end


/* modules */

getYMatAddress gY2 (.gYMA_row(temp_oldRow), .gYMA_readData(yAD_readRowData),
                        .gYMA_row_addr1(wire_outAddr1) , .readEnable(reg_readEn));
endmodule
