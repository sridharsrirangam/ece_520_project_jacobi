/* ************************************************
*    Inputs:    1. vsram Number 2 bits
*               2. vsram Column number 16 bits
*               3. Write Enable bit
*               4. 48 bit data input
*               5. clock,reset
*
*
*    Outputs:   1. Done Flag
*               2. vsramWriteAddr x 4
*               3. vsramwriteData x 4
*               4. vsramWriteEnable x 4
*               5. 
*
***************************************************/



module vSRAMwrite(input clock,  input reset,input enable,  
                    input [9:0] in_colNum_info,
                  input [47:0]  in_dataWriteVal,
		  input dividor_done,
		  input control_vsram_section,
                  output reg writeVsramDoneFlag,

                  output reg [8:0] sram_1_writeAddressline, 
                  output reg [8:0] sram_2_writeAddressline, 
                  output reg [8:0] sram_3_writeAddressline, 
                  output reg [8:0] sram_4_writeAddressline, 
                  output reg  sram_1_writeEnable, 
                  output reg  sram_2_writeEnable, 
                  output reg  sram_3_writeEnable, 
                  output reg  sram_4_writeEnable, 
                  output reg [47:0] sram_1_writeData, 
                  output reg [47:0] sram_2_writeData, 
                  output reg [47:0] sram_3_writeData, 
                  output reg [47:0] sram_4_writeData  
                 );

/* Wires and regs */

   reg reg_writeVsramDoneFlag;

   reg [8:0] reg_sram_1_writeAddressline; 
   reg [8:0] reg_sram_2_writeAddressline; 
   reg [8:0] reg_sram_3_writeAddressline; 
   reg [8:0] reg_sram_4_writeAddressline; 
   reg  reg_sram_1_writeEnable; 
   reg  reg_sram_2_writeEnable; 
   reg  reg_sram_3_writeEnable; 
   reg  reg_sram_4_writeEnable; 
   reg [47:0] reg_sram_1_writeData; 
   reg [47:0] reg_sram_2_writeData; 
   reg [47:0] reg_sram_3_writeData; 
   reg [47:0] reg_sram_4_writeData; 
   
   wire [1:0] in_vsramNum;
   wire [8:0] in_colNum;



/* Control logic */



assign in_vsramNum= in_colNum_info[1:0];
assign in_colNum= {control_vsram_section,in_colNum_info[9:2]};


always@(posedge clock)
begin
    if(~(reset&enable))
    begin
       writeVsramDoneFlag           <= 1'b0;

       sram_1_writeAddressline      <= 9'hff; 
       sram_2_writeAddressline      <= 9'hff; 
       sram_3_writeAddressline      <= 9'hff; 
       sram_4_writeAddressline      <= 9'hff; 
       sram_1_writeEnable           <= 1'b0;   
       sram_2_writeEnable           <= 1'b0;   
       sram_3_writeEnable           <= 1'b0;   
       sram_4_writeEnable           <= 1'b0;   
       sram_1_writeData             <= 48'b0;   
       sram_2_writeData             <= 48'b0;   
       sram_3_writeData             <= 48'b0;   
       sram_4_writeData             <= 48'b0;   
    end// reset
    else    
	
	begin
       writeVsramDoneFlag           <= reg_writeVsramDoneFlag; 
                                       
       sram_1_writeAddressline      <= reg_sram_1_writeAddressline; 
       sram_2_writeAddressline      <= reg_sram_2_writeAddressline; 
       sram_3_writeAddressline      <= reg_sram_3_writeAddressline; 
       sram_4_writeAddressline      <= reg_sram_4_writeAddressline; 
       sram_1_writeEnable           <= reg_sram_1_writeEnable;  
       sram_2_writeEnable           <= reg_sram_2_writeEnable;  
       sram_3_writeEnable           <= reg_sram_3_writeEnable;  
       sram_4_writeEnable           <= reg_sram_4_writeEnable;  
       sram_1_writeData             <= reg_sram_1_writeData;   
       sram_2_writeData             <= reg_sram_2_writeData;   
       sram_3_writeData             <= reg_sram_3_writeData;   
       sram_4_writeData             <= reg_sram_4_writeData;   
   	 end// not reset
	
   

end// posedge clk
	
always@(*)
begin
    if(dividor_done)
    begin
        reg_writeVsramDoneFlag           = 1'b1;

        case(in_vsramNum)
        2'd0: begin
                                                     
            reg_sram_1_writeAddressline      = in_colNum;
            reg_sram_2_writeAddressline      = 9'h1ff;
            reg_sram_3_writeAddressline      = 9'h1ff;
            reg_sram_4_writeAddressline      = 9'h1ff;
            reg_sram_1_writeEnable           = 1'b1; 
            reg_sram_2_writeEnable           = 1'b0; 
            reg_sram_3_writeEnable           = 1'b0; 
            reg_sram_4_writeEnable           = 1'b0; 
            reg_sram_1_writeData             = in_dataWriteVal;
            reg_sram_2_writeData             = 48'b0;
            reg_sram_3_writeData             = 48'b0;
            reg_sram_4_writeData             = 48'b0;
        end// d0
        2'd1: begin
                                                     
            reg_sram_1_writeAddressline      = 9'h1ff;
            reg_sram_2_writeAddressline      = in_colNum;
            reg_sram_3_writeAddressline      = 9'h1ff;
            reg_sram_4_writeAddressline      = 9'h1ff;
            reg_sram_1_writeEnable           = 1'b0; 
            reg_sram_2_writeEnable           = 1'b1; 
            reg_sram_3_writeEnable           = 1'b0; 
            reg_sram_4_writeEnable           = 1'b0; 
            reg_sram_1_writeData             = 48'b0;
            reg_sram_2_writeData             = in_dataWriteVal;
            reg_sram_3_writeData             = 48'b0;
            reg_sram_4_writeData             = 48'b0;
        end// d1
        2'd2: begin
                                                     
            reg_sram_1_writeAddressline      = 9'h1ff;
            reg_sram_2_writeAddressline      = 9'h1ff;
            reg_sram_3_writeAddressline      = in_colNum;
            reg_sram_4_writeAddressline      = 9'h1ff;
            reg_sram_1_writeEnable           = 1'b0; 
            reg_sram_2_writeEnable           = 1'b0; 
            reg_sram_3_writeEnable           = 1'b1; 
            reg_sram_4_writeEnable           = 1'b0; 
            reg_sram_1_writeData             = 48'b0;
            reg_sram_2_writeData             = 48'b0;
            reg_sram_3_writeData             = in_dataWriteVal;
            reg_sram_4_writeData             = 48'b0;
        end// d2
        2'd3: begin
                                                     
            reg_sram_1_writeAddressline      = 9'h1ff;
            reg_sram_2_writeAddressline      = 9'h1ff;
            reg_sram_3_writeAddressline      = 8'hff;
            reg_sram_4_writeAddressline      = in_colNum;
            reg_sram_1_writeEnable           = 1'b0; 
            reg_sram_2_writeEnable           = 1'b0; 
            reg_sram_3_writeEnable           = 1'b0; 
            reg_sram_4_writeEnable           = 1'b1; 
            reg_sram_1_writeData             = 48'b0;
            reg_sram_2_writeData             = 48'b0;
            reg_sram_3_writeData             = 48'b0;
            reg_sram_4_writeData             = in_dataWriteVal;
        end// d3
        
        endcase
    end//end of write enable
    else
    begin
       reg_writeVsramDoneFlag           = 1'b0;
                                                
       reg_sram_1_writeAddressline      = 9'h1ff;
       reg_sram_2_writeAddressline      = 9'h1ff;
       reg_sram_3_writeAddressline      = 9'h1ff;
       reg_sram_4_writeAddressline      = 9'h1ff;
       reg_sram_1_writeEnable           = 1'b0; 
       reg_sram_2_writeEnable           = 1'b0; 
       reg_sram_3_writeEnable           = 1'b0; 
       reg_sram_4_writeEnable           = 1'b0; 
       reg_sram_1_writeData             = 48'b0;
       reg_sram_2_writeData             = 48'b0;
       reg_sram_3_writeData             = 48'b0;
       reg_sram_4_writeData             = 48'b0;

    end// writeEnable is 0
end // 


endmodule



