module yv_control(y_1_col_info,y_2_col_info,y_3_col_info,y_4_col_info,
	     sram_1_addressline_1,sram_1_addressline_2,
	     sram_2_addressline_1,sram_2_addressline_2,
	     sram_3_addressline_1,sram_3_addressline_2,
	     sram_4_addressline_1,sram_4_addressline_2,
	     Y_addressline_1,
	     v_ram_no_1, v_ram_no_2, v_ram_no_3, v_ram_no_4,
	      switch_from_fifo1_fifo2,sel_v1_v3,sel_v2_v4,
	    reset,enable,clock,vsram_read_control);	

	

//input [2:0] v_ram_no_1, v_ram_no_2, v_ram_no_3, v_ram_no_4;
//input [ :0] v_column_1, v_column_2, v_column_3, v_column_4,
input clock,reset,enable;
reg [3:0] current_state,next_state;
output reg [ 8:0] sram_1_addressline_1,sram_1_addressline_2,
	     sram_2_addressline_1,sram_2_addressline_2,
	     sram_3_addressline_1,sram_3_addressline_2,
	     sram_4_addressline_1,sram_4_addressline_2;
output reg [10:0] Y_addressline_1;
output reg [1:0] sel_v1_v3,sel_v2_v4;
reg [8:0] address_line_1,address_line_2;
reg [2:0] count;
reg [10:0] row_num;
output reg switch_from_fifo1_fifo2;
input [15:0] y_1_col_info,y_2_col_info,y_3_col_info,y_4_col_info;
output [2:0]  v_ram_no_1, v_ram_no_2, v_ram_no_3, v_ram_no_4;
input vsram_read_control;

wire [2:0] y_1_newrow,y_2_newrow,y_3_newrow,y_4_newrow;
//wire [2:0] v_ram_no_1,v_ram_no_2,v_ram_no_3,v_ram_no_4;
wire [8:0] v_column_1,v_column_2,v_column_3,v_column_4;

assign y_1_newrow = &(y_1_col_info[15:13]);
assign y_2_newrow = &(y_2_col_info[15:13]);
assign y_3_newrow = &(y_3_col_info[15:13]);
assign y_4_newrow = &(y_4_col_info[15:13]);

assign v_ram_no_1 = y_1_newrow? 3'b100:y_1_col_info[1:0];
assign v_column_1 = {vsram_read_control,y_1_col_info[9:2]};

assign v_ram_no_2 = y_2_newrow? 3'b100:y_2_col_info[1:0];
assign v_column_2 = {vsram_read_control,y_2_col_info[9:2]};

assign v_ram_no_3 = y_3_newrow? 3'b100:y_3_col_info[1:0];
assign v_column_3 = {vsram_read_control,y_3_col_info[9:2]};

assign v_ram_no_4 = y_4_newrow? 3'b100:y_4_col_info[1:0];
assign v_column_4 = {vsram_read_control,y_4_col_info[9:2]};





always@(posedge clock)
begin
if(~(reset& enable))
current_state<=3'd0;
else
current_state<=next_state;
end


always@(*)
begin
//next_state=0;
sram_1_addressline_1=9'b0;
sram_1_addressline_2=9'b0;
sram_2_addressline_1=9'b0;
sram_2_addressline_2=9'b0;
sram_3_addressline_1=9'b0;
sram_3_addressline_2=9'b0;
sram_4_addressline_1=9'b0;
sram_4_addressline_2=9'b0;

case(current_state)

3'd0:
begin
	 if(enable) 
	 next_state=3'd1;
	 else 
		begin
		 next_state=3'd0;
		end
	 sel_v1_v3=2'b11;
	 sel_v2_v4=2'b11;
   row_num= 11'd63;
end

3'd1:
begin
Y_addressline_1=row_num;
next_state=3'd2;
switch_from_fifo1_fifo2<=1'b0;
end

3'd2: 
begin
	casex(v_ram_no_1)
	3'b000: sram_1_addressline_1=v_column_1; 
	3'b001: sram_2_addressline_1=v_column_1; 
	3'b010: sram_3_addressline_1=v_column_1; 
        3'b011: sram_4_addressline_1=v_column_1; 
        endcase 

	casex(v_ram_no_2)
	3'b000: sram_1_addressline_2=v_column_2; 
	3'b001: sram_2_addressline_2=v_column_2; 
	3'b010: sram_3_addressline_2=v_column_2; 
        3'b011: sram_4_addressline_2=v_column_2; 
	endcase
sel_v1_v3=2'b01;
sel_v2_v4=2'b01;
 next_state=3'd3;
end

3'd3:
begin

	casex(v_ram_no_3)
	3'b000: sram_1_addressline_1=v_column_3; 
	3'b001: sram_2_addressline_1=v_column_3; 
	3'b010: sram_3_addressline_1=v_column_3; 
        3'b011: sram_4_addressline_1=v_column_3; 
        endcase
        
	casex(v_ram_no_4)
	3'b000: sram_1_addressline_2=v_column_4; 
	3'b001: sram_2_addressline_2=v_column_4; 
	3'b010: sram_3_addressline_2=v_column_4; 
        3'b011: sram_4_addressline_2=v_column_4; 
        endcase
sel_v1_v3=2'b10;
sel_v2_v4=2'b10;
//row_num=row_num+1;
next_state=3'd4;
end

3'd4 : 
begin
	row_num=row_num+1;
	next_state=3'd1;
	switch_from_fifo1_fifo2<=1'b1;
end

endcase
end //end of always@(*)
/*
always@(posedge clock)
begin
	if(~reset) 
	count<=0;
	else if(count==3) 
		begin
		count<=0;
		switch_from_fifo1_fifo2<=1'b1;
		end
	else 
		begin
		count <= count+1;
		switch_from_fifo1_fifo2<=1'b0;
		end

end
*/
endmodule


