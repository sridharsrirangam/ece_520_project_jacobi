
module accumulator(clock,reset,yv_mult,sel_add_even_odd,
	in1_adder1,in2_adder1,in1_adder2,in2_adder2,
	opt_adder1,opt_adder2,
	adder1_mode,adder2_mode,
	accum_out,feedback_check1,feedback_check2,
        enable,zero_on_V        
);

input clock,reset,enable;
input zero_on_V;
input [47:0] yv_mult; //input from multiplier.
output [47:0] accum_out; //final output of accumulated sum.
output  adder1_mode,adder2_mode;

input sel_add_even_odd; //select lines for muxes.

output [47:0] in1_adder1, in2_adder1;//these will have to be sent to adder 1
input  [47:0] opt_adder1;//this be be received from adder 1
reg    [47:0] sum_even,sum_odd;//these will hold input values for adder 2
output [47:0] in1_adder2,in2_adder2;//these will have to be sent to adder 2
input  [47:0] opt_adder2; //this will be received from adder 2
reg    [47:0] in1_adder1_reg,in2_adder1_reg; //registers to give input to adder 1
output reg feedback_check2;
output wire feedback_check1;
wire sel_feedback_or_0;


always@(posedge clock)
	begin
//	if(sel_valueofmult_or_0)
        if(~(reset&enable))
        begin
           in1_adder1_reg<= 48'h0;
        end
        else
        begin
	   in1_adder1_reg<=yv_mult;
        end
//	else 
//	in1_adder1_reg<=48'b0;
	end

always@(posedge clock)
	begin
        if(~(reset&enable))
        begin
           in2_adder1_reg<= 48'h0;
        end
        else
        begin
	   if(sel_feedback_or_0)
	      in2_adder1_reg<=opt_adder1;
	   else
	      in2_adder1_reg<=48'b0;
	   end
        end

always@(posedge clock)
	begin
        if(~(reset&enable))
        begin
	    sum_even<=48'h0;
        end
        else
        begin
	   if(sel_add_even_odd)
	      sum_even<=opt_adder1;
	   else
	      sum_odd<=opt_adder1;
	   end
        end

assign feedback_check1=zero_on_V;
always@(posedge clock)
feedback_check2<=feedback_check1;

assign sel_feedback_or_0= feedback_check1&feedback_check2;



assign adder1_mode=1'b0;
assign adder2_mode=1'b0;
assign in1_adder1=in1_adder1_reg;
assign in2_adder1=in2_adder1_reg;
assign in1_adder2=sum_even;
assign in2_adder2=sum_odd;
assign accum_out=opt_adder2;
 
//remove the following later



endmodule


