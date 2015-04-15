`timescale 1ns/100ps
// 65nm sram model
// size = 3kb, 2 read port, 2 write port, size = 48bit, @400K
// read data delay: 0.8ns.... To be the worst pessimistic...
// 4 interleaved small srams
//

module v_sram_op2 (clock, WE, WriteAddress1, WriteAddress2, ReadAddress1, ReadAddress2, WriteBus1, WriteBus2, ReadBus1, ReadBus2);
input  clock, WE; 
input  [8:0] WriteAddress1, WriteAddress2, ReadAddress1, ReadAddress2; // Change as you change size of SRAM
input  [47:0] WriteBus1, WriteBus2;
output [47:0] ReadBus1;
output [47:0] ReadBus2;

reg [47:0]   Register [0:511];   // 48*512 bits (i.e. a  3 kB) 
reg [47:0]   ReadBus1, ReadBus2;

// provide one write enable line per register
reg [511:0] WElines1, WElines2;
integer i;

// Write '1' into write enable line for selected register
// Note the 0.8 ns delay - THIS IS THE INPUT DELAY FOR THE MEMORY FOR SYNTHESIS
always@(*)	begin
#0.8 WElines1 = (WE << WriteAddress1);
	 WElines2 = (WE << WriteAddress1);
	 end

always@(posedge clock)	begin
    for (i=0; i<512; i=i+1)	begin
      if (WElines1[i]) Register[i] <= WriteBus1;
	  if (WElines2[i]) Register[i] <= WriteBus2;
	end
end  

// Note the 0.8 ns delay - this is the OUTPUT DELAY FOR THE MEMORY FOR SYNTHESIS
always@(*) 
  begin 
    #0.8   ReadBus1  =  Register[ReadAddress1];
    	 ReadBus2  =  Register[ReadAddress2];
  end
endmodule
