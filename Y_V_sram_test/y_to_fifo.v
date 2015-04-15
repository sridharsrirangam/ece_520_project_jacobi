module y_to_fifo(Yin,
		v_value_1,v_value_2,v_value_3,v_value_4,
		y_1_col_info,y_2_col_info,y_3_col_info,y_4_col_info,
		y_feed_mult,v_feed_mult,
		clock,reset,enable,switch_from_fifo1_fifo2,y_diagonal,Y_eof_reg,zero_on_V);
input clock,reset,enable;
input switch_from_fifo1_fifo2;
input  [255:0] Yin;
input  [47:0] v_value_1,v_value_2,v_value_3,v_value_4;
output [47:0] y_feed_mult,v_feed_mult;
reg [47:0] y_feed_mult,v_feed_mult;
output  [15:0] y_1_col_info,y_2_col_info,y_3_col_info,y_4_col_info;
wire [15:0] y_1_col_info,y_2_col_info,y_3_col_info,y_4_col_info;
wire    [63:0] y1_stg1,y2_stg1,y3_stg1,y4_stg1;//1st flops of the 2 stage fifo
reg    [191:0] y_stg2;//2nd flops of the 2 stage fifo
reg    [191:0] v_stg1;
reg [255:0] Yin_reg;
reg [47:0] y_diagonal_pip1,y_diagonal_pip2,y_diagonal_pip3,y_diagonal_pip4,y_diagonal_pip5,y_diagonal_pip6;
output reg [47:0] y_diagonal;
output zero_on_V;
reg zero_on_V,zero_on_V_p2;
wire y_1_eof,y_2_eof,y_3_eof,y_4_eof;
wire Y_eof;
wire zero_on_V_p1;
reg [10:0] count_feed;
//reg zero_on_V_p1,zero_on_V_p2;
output reg Y_eof_reg;
reg v_non_zero;
///reg fifo_loaded;
assign	y1_stg1=Yin[255:192];
assign	y2_stg1=Yin[191:128];
assign	y3_stg1=Yin[127:64];
assign	y4_stg1=Yin[63:0];
	
//the y_n_col_info values will be sent ot control logic to be decoded and fetch v values acordingly

assign	y_1_col_info=y1_stg1[63:48];
assign	y_2_col_info=y2_stg1[63:48];
assign	y_3_col_info=y3_stg1[63:48];
assign	y_4_col_info=y4_stg1[63:48];

assign y_1_eof= ((&y1_stg1[63:61])&(~(|y1_stg1[60:0])));
assign y_2_eof= ((&y2_stg1[63:61])&(~(|y2_stg1[60:0])));
assign y_3_eof= ((&y3_stg1[63:61])&(~(|y3_stg1[60:0])));
assign y_4_eof= ((&y4_stg1[63:61])&(~(|y4_stg1[60:0])));
assign Y_eof = |{y_1_eof,y_2_eof,y_3_eof,y_4_eof};

always@(posedge clock)
	begin
   if(~(reset&enable))
   begin
      y_stg2<=192'b0;
   end
   else
   begin
	if(switch_from_fifo1_fifo2)
		y_stg2<={y1_stg1[47:0],y2_stg1[47:0],y3_stg1[47:0],y4_stg1[47:0]};
	else
		y_stg2<=y_stg2<<48;		
   end//reset or enable
end

always@(posedge clock)
	begin
   if(~(reset&enable))
   begin
      v_stg1<=192'b0;
   end
   else
   begin
	if(switch_from_fifo1_fifo2)
	begin
	v_stg1<={v_value_1,v_value_2,v_value_3,v_value_4};

	end
	else
	v_stg1<=v_stg1<<48;
	end
   end//reset

always@(posedge clock)
	begin
//	if(fifo_loaded)
//	begin
   if(~(reset&enable))
   begin
	v_feed_mult<=48'b0;
	y_feed_mult<=48'b0;
   end
   else
   begin
	v_feed_mult<=v_stg1[191:144];
	y_feed_mult<=y_stg2[191:144];
   end//reset


//	else
//	begin
//	y_feed_mult<=(y_feed_mult>>48);
//	v_feed_mult<=(v_feed_mult>>48);
//	end
	end

assign zero_on_V_p1=(|v_feed_mult);
//remove this

always@(posedge clock)
begin
	if(!reset)
	count_feed<=11'b0;
	else
	begin
	if(v_feed_mult==0)
	count_feed<=count_feed+1'b1;
	end
end

always@(posedge clock)
	begin
	if(!(reset&enable))
	v_non_zero<=1'b0;
	else
	begin
	if(v_feed_mult!==0)
	v_non_zero<=1'b1;
	end
	end

	
always@(posedge clock)
	begin
		if(~(reset&enable))
		begin
		zero_on_V_p2<=1'b1;
		zero_on_V<=1'b1;
		end
	        else
		begin
		if(v_non_zero)
			begin
			zero_on_V_p2<=zero_on_V_p1;
			zero_on_V<=zero_on_V_p2;
			end
		else
			begin
			zero_on_V<=1'b1;
			end
	
		end
      end

always@(posedge clock)
	begin
   if(~(reset&enable))
   begin
	y_diagonal_pip1<=48'b0;
   end
   else
   begin
	if(~(|v_feed_mult))
	y_diagonal_pip1<=y_feed_mult;
	end
   end
always@(posedge clock)
begin
   if(~(reset&enable))
   begin
      y_diagonal     <=48'b0;
      y_diagonal_pip6<=48'b0;
      y_diagonal_pip5<=48'b0;
      y_diagonal_pip4<=48'b0;
      y_diagonal_pip3<=48'b0;
      y_diagonal_pip2<=48'b0;
   end
   else
   begin
      y_diagonal<=y_diagonal_pip6;
      y_diagonal_pip6<=y_diagonal_pip5;
      y_diagonal_pip5<=y_diagonal_pip4;
      y_diagonal_pip4<=y_diagonal_pip3;
      y_diagonal_pip3<=y_diagonal_pip2;
      y_diagonal_pip2<=y_diagonal_pip1;
   end
end

always@(posedge clock)
	begin
   if(~(reset&enable))
   begin
	Yin_reg<=256'b0;
   end
   else
   begin
	Yin_reg<=Yin;
   end
	end

always@(posedge clock)
	begin
	if(~(reset&enable))
           Y_eof_reg<=1'b0;
	else
	begin
	   if(Y_eof)
	      Y_eof_reg<=1'b1;
 	   end
	end
endmodule
 
	
