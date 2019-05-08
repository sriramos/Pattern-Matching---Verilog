// ECE6370
// Author: Manoj Kumar Cebol Sundarrajan, 0546
// ButtonShaper
// The module is for the button shaper which creates a single
// pulse output for a long button press.

module ButtonShaper(clk, rst, ButtonIn, ButtonOut);

   input clk, rst, ButtonIn;
   output ButtonOut;
   reg ButtonOut;

   parameter Start = 0, Pulse = 1, Delay = 2;

   reg[1:0] State, StateNext;

   always @(posedge clk)
   begin
      if(rst == 0)
      begin
         State <= Start;
      end
      
      else 
      begin
         State <=StateNext;
      end
   end


   always @(State,ButtonIn)
   begin
      case (State)
   
      Start:
      begin
         ButtonOut <= 0;
         if(ButtonIn == 0)
         begin
            StateNext <= Pulse;
         end
         else
         begin
            StateNext  <= Start;
         end
      end

      Pulse:
      begin
         ButtonOut <= 1;
         StateNext <= Delay;
      end

      Delay:
      begin
         ButtonOut <= 0;
         if(ButtonIn == 0)
         begin
            StateNext <= Delay;
         end
         else
         begin
           StateNext <= Start;
         end
   end
   endcase
   end
endmodule

