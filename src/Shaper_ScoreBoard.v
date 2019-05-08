

module Score_Shaper(Compare_Input, Clk, Rst, Shaper_Output);
input Compare_Input;
output reg Shaper_Output;
input Clk, Rst;

parameter Init=0,Pulse=1, Wait=2;

reg[1:0] State, StateNext;

always @ (posedge Clk)
 begin
  if(Rst==0)
   begin
   State<=Init;
   end
  else
   begin
   State<=StateNext;
   end
 end

always @ (Compare_Input, State)
 begin
  case(State)

   Init:
    begin
    Shaper_Output<=0;
    if(Compare_Input ==0)
     StateNext<=Init;
    else  
     StateNext<=Pulse;
    end

   Pulse:
    begin
    Shaper_Output<=1;
    StateNext<=Wait;
    end

   Wait:
    begin
    Shaper_Output<=0;
    if(Compare_Input ==1)
     StateNext<=Wait;
    else  
     StateNext<=Init;
    end
  endcase
 end
endmodule
