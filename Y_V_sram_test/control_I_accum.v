module control_I_accum(clock,get_I_flag,I_column_info,I_sram_addressline_1,I_value_select);
input clock;
input get_I_flag;
input [9:0] I_column_info; //connect row_count in accum_control to this
output  [7:0] I_sram_addressline_1;
output  [1:0] I_value_select;
//reg [9:0] I_column_info_reg;


assign I_sram_addressline_1=I_column_info[9:2];
assign I_value_select=I_column_info[1:0];

/*
always@(posedge clock)
begin
if(get_I_flag)
begin
I_column_info_reg<=I_column_info;
I_sram_addressline_1<=I_column_info_reg[9:2];
I_value_select<=I_column_info_reg[1:0];
end
end
*/
endmodule

