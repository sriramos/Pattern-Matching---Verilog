// ECE6370
// Author: Manoj Kumar Cebol Sundarrajan, 0546
// Timer1s
// The module is the 500ms second timer.

module Timer500ms(clk, rst, Timer_Enable, timeout);

   input clk,rst;
   input Timer_Enable;

   output timeout;

   reg timeout;
   reg[3:0] counter; // 4 bits are enough to count 10

   wire LFSR_timeout;


   LFSR_100ms LFSR_100ms_1(clk,rst, Timer_Enable, LFSR_timeout);

   always@(posedge clk)
   begin
      if(rst == 0)
      begin
        timeout <= 0;
        counter <= 4'b0000;
      end

      else
      begin

         if(LFSR_timeout == 1)
         begin
            counter = counter + 1;
            if(counter == 4'b0101)
            begin
               timeout <= 1;
               counter <= 4'b0000;
            end
         end
         else
         begin
            timeout <= 0;
         end

      end
   end
endmodule
