/* ************************************************    
 *    Combinational Logic Ckt                  
 *    
 *    Module that gets Y Matrix Read Addresses.
 *    Inputs: 1. readEnable
 *            2. 256 Bits read data
 *            3. read Row number
 *
 *    Output: 1. Outputs 48 bit Row address where the data is present
 *
 *    ********************************************/

module getYMatAddress(readEnable, //clock, reset, 
                  gYMA_row, gYMA_readData, gYMA_row_addr1);//, gYMA_row_addr2 );

//input clock,reset;
input readEnable;
input [15:0] gYMA_row;
input [255:0] gYMA_readData;

output [10:0] gYMA_row_addr1;

reg [10:0] gYMA_row_addr1;


always@(*)
begin
   if(readEnable)
   begin
      casex((gYMA_row[3:0]))
      8'h0:    gYMA_row_addr1 = gYMA_readData[250:240];
      8'h1:    gYMA_row_addr1 = gYMA_readData[234:224];
      8'h2:    gYMA_row_addr1 = gYMA_readData[218:208];
      8'h3:    gYMA_row_addr1 = gYMA_readData[202:192];
      8'h4:    gYMA_row_addr1 = gYMA_readData[186:176];
      8'h5:    gYMA_row_addr1 = gYMA_readData[170:160];
      8'h6:    gYMA_row_addr1 = gYMA_readData[154:144];
      8'h7:    gYMA_row_addr1 = gYMA_readData[138:128];
      8'h8:    gYMA_row_addr1 = gYMA_readData[122:112];
      8'h9:    gYMA_row_addr1 = gYMA_readData[106:96];
      8'hA:    gYMA_row_addr1 = gYMA_readData[90:80];
      8'hB:    gYMA_row_addr1 = gYMA_readData[74:64];
      8'hC:    gYMA_row_addr1 = gYMA_readData[58:48];
      8'hD:    gYMA_row_addr1 = gYMA_readData[42:32];
      8'hE:    gYMA_row_addr1 = gYMA_readData[26:16];
      8'hF:    gYMA_row_addr1 = gYMA_readData[10:0]; //since this is the last col
      default: gYMA_row_addr1 = 11'h0;
      endcase
   end
   else
      gYMA_row_addr1 = 11'h0;
end //always@ block 

endmodule

