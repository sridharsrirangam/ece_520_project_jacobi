module memory(clock, sram_1_addressline_1,sram_1_addressline_2,
	     sram_2_addressline_1,sram_2_addressline_2,
	     sram_3_addressline_1,sram_3_addressline_2,
	     sram_4_addressline_1,sram_4_addressline_2,

              sram_1_readline_1,sram_1_readline_2,
	      sram_2_readline_1,sram_2_readline_2,
	      sram_3_readline_1,sram_3_readline_2,
	      sram_4_readline_1,sram_4_readline_2,

 sram1_WriteAddress1,sram1_WriteAdress2,
 sram2_WriteAddress1,sram2_WriteAdress2,
 sram3_WriteAddress1,sram3_WriteAdress2,
 sram4_WriteAddress1,sram4_WriteAdress2,


 sram1_WriteBus1,sram1_WriteBus2,
 sram2_WriteBus1,sram2_WriteBus2,
 sram3_WriteBus1,sram3_WriteBus2,
 sram4_WriteBus1,sram4_WriteBus2,


yram_WriteAddress,
Y_addressline_1,ReadAddress2,
ReadBus2,ReadBus1,
y_WriteBus,
 WE_1,WE_2,WE_3,WE_4,WE_Y,WE_I,

WriteAddress_I,I_sram_addressline_1, I_sram_ReadAddress2,
 I_WriteBus,
 I_sram_ReadBus2, I_sram_ReadBus1);




input clock;
//inputs and outputs of Y sram



input  [ 8:0] sram_1_addressline_1,sram_1_addressline_2,
	     sram_2_addressline_1,sram_2_addressline_2,
	     sram_3_addressline_1,sram_3_addressline_2,
	     sram_4_addressline_1,sram_4_addressline_2;


output [ 47:0] sram_1_readline_1,sram_1_readline_2,
	      sram_2_readline_1,sram_2_readline_2,
	      sram_3_readline_1,sram_3_readline_2,
	      sram_4_readline_1,sram_4_readline_2;

input [8:0] sram1_WriteAddress1,sram1_WriteAdress2;
input [8:0] sram2_WriteAddress1,sram2_WriteAdress2;
input [8:0] sram3_WriteAddress1,sram3_WriteAdress2;
input [8:0] sram4_WriteAddress1,sram4_WriteAdress2;


output [47:0] sram1_WriteBus1,sram1_WriteBus2;
output [47:0] sram2_WriteBus1,sram2_WriteBus2;
output [47:0] sram3_WriteBus1,sram3_WriteBus2;
output [47:0] sram4_WriteBus1,sram4_WriteBus2;


input [10:0] yram_WriteAddress;
input [10:0] Y_addressline_1,ReadAddress2;
output [255:0] ReadBus2,ReadBus1;
input [255:0] y_WriteBus;
input WE_1,WE_2,WE_3,WE_4,WE_Y,WE_I;

input  [7:0] WriteAddress_I,I_sram_addressline_1, I_sram_ReadAddress2; // Change as you change size of SRAM
input [191:0] I_WriteBus;
output [191:0] I_sram_ReadBus2, I_sram_ReadBus1;


y_sram Y_sram(.clock(clock),.WE(WE_Y),.WriteAddress(yram_WriteAddress),.ReadAddress1(Y_addressline_1),.ReadAddress2(ReadAddress2),.WriteBus(y_WriteBus),.ReadBus1(ReadBus1),.ReadBus2(ReadBus2));

//template - v_sram_op2 (clock, WE, WriteAddress1, WriteAddress2, ReadAddress1, ReadAddress2, WriteBus1, WriteBus2, ReadBus1, ReadBus2);

v_sram_op2 V_1_sram(.clock(clock),.WE(WE_1),.WriteAddress1(sram1_WriteAddress1),.WriteAddress2(sram1_WriteAdress1),
                    .ReadAddress1(sram_1_addressline_1),.ReadAddress2(sram_1_addressline_2),
                    .WriteBus1(sram1_WriteBus1),.WriteBus2(sram1_WriteBus1),.ReadBus1(sram_1_readline_1),.ReadBus2(sram_1_readline_2));

v_sram_op2 V_2_sram(.clock(clock),.WE(WE_2),.WriteAddress1(sram2_WriteAddress1),.WriteAddress2(sram2_WriteAdress1),.ReadAddress1(sram_2_addressline_1),.ReadAddress2(sram_2_addressline_2),.WriteBus1(sram2_WriteBus1),.WriteBus2(sram2_WriteBus1),.ReadBus1(sram_2_readline_1),.ReadBus2(sram_2_readline_2));

v_sram_op2 V_3_sram(.clock(clock),.WE(WE_3),.WriteAddress1(sram3_WriteAddress1),.WriteAddress2(sram3_WriteAdress1),.ReadAddress1(sram_3_addressline_1),.ReadAddress2(sram_3_addressline_2),.WriteBus1(sram3_WriteBus1),.WriteBus2(sram3_WriteBus1),.ReadBus1(sram_3_readline_1),.ReadBus2(sram_3_readline_2));

v_sram_op2 V_4_sram(.clock(clock),.WE(WE_4),.WriteAddress1(sram4_WriteAddress1),.WriteAddress2(sram4_WriteAdress1),
                      .ReadAddress1(sram_4_addressline_1),.ReadAddress2(sram_4_addressline_2),
                      .WriteBus1(sram4_WriteBus1),.WriteBus2(sram4_WriteBus1),.ReadBus1(sram_4_readline_1),.ReadBus2(sram_4_readline_2));

i_sram I_sram(.clock(clock), .WE(WE_I), .WriteAddress(WriteAddress_I), .ReadAddress1(I_sram_addressline_1), .ReadAddress2(I_sram_addressline2), .WriteBus(I_sram_WriteBus), .ReadBus1(I_sram_ReadBus1), .ReadBus2(I_sram_ReadBus2));




endmodule
  
