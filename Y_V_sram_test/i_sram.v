`timescale 1ns/100ps
// 65nm sram model
// size = 6kb, 1 read port, 1 write port, size = 240bit, @400K
// read data delay: 1ns.... To be the worst pessimistic...
// 

module i_sram (clock, WE, WriteAddress, ReadAddress1, ReadAddress2, WriteBus, ReadBus1, ReadBus2);
input  clock, WE; 
input  [7:0] WriteAddress, ReadAddress1, ReadAddress2; // Change as you change size of SRAM
input  [191:0] WriteBus;
output [191:0] ReadBus1, ReadBus2;


reg [191:0]   Register [0:255];   // 192*255 bits (i.e. a  6 kB) 
reg [191:0]   ReadBus1, ReadBus2;

// provide one write enable line per register
reg [255:0] WElines;
integer i;

// Write '1' into write enable line for selected register
// Note the 1 ns delay - THIS IS THE INPUT DELAY FOR THE MEMORY FOR SYNTHESIS
always@(*)
#1 WElines = (WE << WriteAddress);

always@(posedge clock)
    for (i=0; i<256; i=i+1)
      if (WElines[i]) Register[i] <= WriteBus;

// Note the 1 ns delay - this is the OUTPUT DELAY FOR THE MEMORY FOR SYNTHESIS
always@(*) 
  begin 
    #1   ReadBus1  =  Register[ReadAddress1];
		 ReadBus2  =  Register[ReadAddress2];
  end
endmodule
