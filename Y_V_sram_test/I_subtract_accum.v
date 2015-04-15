module I_subtract_accum(I_input,accum_value,in1_sub1,in2_sub1,opt_sub1,result_I_minus_Accum,I_value_select,get_I_flag,clock,enable,reset);
input clock,get_I_flag,enable,reset;
input [1:0] I_value_select;
input [47:0]  accum_value;
input [191:0] I_input;
//reg [191:0] I_input_reg;
output [47:0] in1_sub1,in2_sub1;
input [47:0] opt_sub1;
output [47:0] result_I_minus_Accum;
reg [47:0] I_value;

always@(posedge clock)
begin	
     if(~(reset&enable))
     begin
     I_value <= 48'h0;
     end
     else
	if(get_I_flag)
	begin
	case(I_value_select)
	2'd0: I_value<=I_input[191:144];
	2'd1: I_value<=I_input[143:96];
	2'd2: I_value<=I_input[95:48];
	2'd3: I_value<=I_input[47:0];
	endcase
     end
end

assign in1_sub1=I_value;
assign in2_sub1=accum_value;
assign result_I_minus_Accum=opt_sub1;
endmodule
