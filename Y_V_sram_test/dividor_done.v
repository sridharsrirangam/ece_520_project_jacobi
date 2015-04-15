module dividor_done(clock,enable,reset,accum_done,dividor_done);
input clock,enable,reset;
input accum_done;
output reg dividor_done;
reg pipe1,pipe2,pipe3,pipe4;

always@(posedge clock)
begin
   if(~(reset&enable))
   begin
      pipe1<=1'b0;
      pipe2<=1'b0;
      pipe3<=1'b0;
      pipe4<=1'b0;
      dividor_done<=1'b0;
   end
   else
   begin
      pipe1<=accum_done;
      pipe2<=pipe1;
      pipe3<=pipe2;
      pipe4<=pipe3;
      dividor_done<=pipe4;
   end
end




endmodule


