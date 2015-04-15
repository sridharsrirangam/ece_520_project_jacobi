`timescale 1ns/100ps
// 65nm sram model
// size = 57.6kB, 2 read port, 1 write port, size = 256bit, @400K
// read data delay: 3ns.... To be the worst pessimistic...
//


module y_sram (clock, WE, WriteAddress, ReadAddress1, ReadAddress2, WriteBus, ReadBus1, ReadBus2);
input  clock, WE; 
input  [10:0] WriteAddress, ReadAddress1, ReadAddress2; // Change as you change size of SRAM
input  [255:0] WriteBus;
output [255:0] ReadBus1;
output [255:0] ReadBus2;

reg [255:0]   Register [0:1799];   // 256*1800 bits (i.e. a  57.6 kB) 
reg [255:0] ReadBus1;
reg [255:0] ReadBus2;

// provide one write enable line per register
reg [1799:0] WElines;
integer i;

// Write '1' into write enable line for selected register
// Note the 3 ns delay - THIS IS THE INPUT DELAY FOR THE MEMORY FOR SYNTHESIS
always@(*)
#3 WElines = (WE << WriteAddress);
// Learn how to set the specific delay on this single port....

always@(posedge clock)
    for (i=0; i<1800; i=i+1)
      if (WElines[i]) Register[i] <= WriteBus;

// Note the 3 ns delay - this is the OUTPUT DELAY FOR THE MEMORY FOR SYNTHESIS
always@(*) 
  begin 
    #3   ReadBus1  =  Register[ReadAddress1];
	 ReadBus2  =  Register[ReadAddress2];
  end
endmodule
