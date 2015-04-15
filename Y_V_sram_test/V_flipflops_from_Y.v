module V_from_Y(v_ram_no_1,v_ram_no_2,v_ram_no_3,v_ram_no_4,
		sel_v1_v3,sel_v2_v4,
		v_value_1,v_value_2,v_value_3,v_value_4,
		clock,reset,enable,
		 sram_1_readline_1,sram_1_readline_2,
	         sram_2_readline_1,sram_2_readline_2,
	         sram_3_readline_1,sram_3_readline_2,
	         sram_4_readline_1,sram_4_readline_2);

input [2:0] v_ram_no_1, v_ram_no_2, v_ram_no_3, v_ram_no_4;
input [1:0] sel_v1_v3,sel_v2_v4; //these are used to select the cycle where values are fetched In cycle 1 or in 2
       
input [ 47:0] sram_1_readline_1,sram_1_readline_2,
	      sram_2_readline_1,sram_2_readline_2,
	      sram_3_readline_1,sram_3_readline_2,
	      sram_4_readline_1,sram_4_readline_2;

input clock,reset,enable;
output reg [47:0] v_value_1,v_value_2,v_value_3,v_value_4;


always@(posedge clock)
begin
if(~(reset&enable))
	begin
	v_value_1<=48'b0;
	v_value_2<=48'b0;	
	v_value_3<=48'b0;
	v_value_4<=48'b0;
	end
else
	begin
	if(sel_v1_v3==2'b01)
		begin
		casex(v_ram_no_1)
		3'b000:v_value_1<=sram_1_readline_1;
		3'b001:v_value_1<=sram_2_readline_1;
		3'b010:v_value_1<=sram_3_readline_1;
		3'b011:v_value_1<=sram_4_readline_1;
        	3'b1xx:v_value_1<=48'b0;
		endcase
		end
	if(sel_v2_v4==2'b01)
		begin
		casex(v_ram_no_2)
		3'b000:v_value_2<=sram_1_readline_2;
		3'b001:v_value_2<=sram_2_readline_2;
		3'b010:v_value_2<=sram_3_readline_2;
		3'b011:v_value_2<=sram_4_readline_2;
        	3'b1xx:v_value_2<=48'b0;
		endcase
		end
	if(sel_v1_v3==2'b10)
		begin
		casex(v_ram_no_3)
		3'b000:v_value_3<=sram_1_readline_1;
		3'b001:v_value_3<=sram_2_readline_1;
		3'b010:v_value_3<=sram_3_readline_1;
		3'b011:v_value_3<=sram_4_readline_1;
        	3'b1xx:v_value_3<=48'b0;
		endcase
		end
	if(sel_v2_v4==2'b10)
		begin
		casex(v_ram_no_4)
		3'b000:v_value_4<=sram_1_readline_2;
		3'b001:v_value_4<=sram_2_readline_2;
		3'b010:v_value_4<=sram_3_readline_2;
		3'b011:v_value_4<=sram_4_readline_2;
        	3'b1xx:v_value_4<=48'b0;
		endcase
		end

	end
end

endmodule





