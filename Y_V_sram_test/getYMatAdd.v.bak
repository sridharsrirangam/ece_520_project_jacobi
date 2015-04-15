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
      8'h0:    gYMA_row_addr1 = gYMA_readData[249:240];
      8'h1:    gYMA_row_addr1 = gYMA_readData[233:224];
      8'h2:    gYMA_row_addr1 = gYMA_readData[217:208];
      8'h3:    gYMA_row_addr1 = gYMA_readData[201:192];
      8'h4:    gYMA_row_addr1 = gYMA_readData[185:176];
      8'h5:    gYMA_row_addr1 = gYMA_readData[169:160];
      8'h6:    gYMA_row_addr1 = gYMA_readData[153:144];
      8'h7:    gYMA_row_addr1 = gYMA_readData[137:128];
      8'h8:    gYMA_row_addr1 = gYMA_readData[121:112];
      8'h9:    gYMA_row_addr1 = gYMA_readData[105:96];
      8'hA:    gYMA_row_addr1 = gYMA_readData[89:80];
      8'hB:    gYMA_row_addr1 = gYMA_readData[73:64];
      8'hC:    gYMA_row_addr1 = gYMA_readData[57:48];
      8'hD:    gYMA_row_addr1 = gYMA_readData[41:32];
      8'hE:    gYMA_row_addr1 = gYMA_readData[25:16];
      8'hF:    gYMA_row_addr1 = gYMA_readData[9:0]; //since this is the last col
      default: gYMA_row_addr1 = 11'h0;
      endcase
   end
   else
      gYMA_row_addr1 = 11'h0;
end //always@ block 

endmodule

