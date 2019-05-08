// ECE6370
// Author: Manoj Kumar Cebol Sundarrajan, 0546
// Single_Digit_Timer
// The module is for the Single digit timer can be connected to more single digit timer.

module Single_Digit_Timer(clk, rst, Set_Timer, Timer_In, Timer_Out, DoNotBorrow_In, DoNotBorrow_Out, counter, reconfig);

   input clk, rst;
   input DoNotBorrow_In;
   input Timer_In;
   input[3:0] Set_Timer;
   input reconfig;

   output Timer_Out, DoNotBorrow_Out;
   output[3:0] counter;
  
   reg[3:0] counter; // 4 bits are enough to count down from 9
   reg Timer_Out, DoNotBorrow_Out;

   wire timeout_1s;

 
   always@(posedge clk)
   begin
      if(rst == 0)
      begin
        Timer_Out <= 0;
        DoNotBorrow_Out <= 0;
        counter <= 4'b1001;
      end

      else
      begin
         if(reconfig == 1)
         begin
            if(Set_Timer > 4'b1001)
            begin
                counter <= 4'b1001;
            end
            else
            begin
               counter <= Set_Timer;

             end
         end
         else
         begin
            
            if(Timer_In == 1)
            begin
				
				   counter <= counter-1;

               
               if(counter == 4'b0001)
               begin
                  if(DoNotBorrow_In == 1)
                  begin
                     DoNotBorrow_Out <= 1;
                  end
                  
               end
					else if(counter == 4'b0000)
					begin
					   counter <= 4'b1001;
						Timer_Out <= 1;
					end
					
					
            end
            else
            begin
               Timer_Out <= 0;
            end
         end
      end
   end
	
endmodule
