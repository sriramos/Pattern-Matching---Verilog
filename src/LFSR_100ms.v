// ECE6370
// Author: Manoj Kumar Cebol Sundarrajan, 0546
// Single_Digit_Timer
// The module is for the 100 millisecond timer.

module LFSR_100ms(clk, rst, Timer_Enable, LFSR_timeout);
  input clk, rst;
  input Timer_Enable; 

  output LFSR_timeout;

  reg[15:0] LFSR;
  reg LFSR_timeout;

  wire[15:0] LFSR_end;
  reg[6:0] count;       // 7 bits are enough to count 100

  assign LFSR_end = (LFSR == 16'b1011110100110001); // value at 50001th value of LFSR
//  assign LFSR_count = (LFSR == 16'b1101111010011000);

// 50000th value of LFSR 1101111010011000
  always @(posedge clk)
  begin
    if(rst == 0)
    begin
       LFSR <= 16'h0000;
       count <= 7'b0000000;
       LFSR_timeout <= 0;
    end
    else
    begin
    if(Timer_Enable == 1)
    begin
       if(LFSR_end)
       begin
         LFSR <= 16'h0000;
         count = count + 1;
         if(count == 7'b1100100)
         begin
            LFSR_timeout <= 1;
            count <= 7'b0000000;
         end         
       end

       else
       begin
          LFSR[0] <= ~LFSR[1] ^ LFSR[2] ^ LFSR[4] ^ LFSR[15];
          LFSR[15:1] <= LFSR[14:0];
          LFSR_timeout <= 0;
       end
    end
    else
    begin
       LFSR_timeout <= 0;
    end
    end
  end
  
endmodule
