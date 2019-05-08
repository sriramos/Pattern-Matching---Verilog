// ECE6370
// Author: Manoj Kumar Cebol Sundarrajan, 0546
// Timer_Controller
// The module is to control the timer. It turns of the timer when it gets timeout signal

module Timer_Controller(Config_Enable, Timer_Enable, Timer_TimeOut);
  
  input Config_Enable, Timer_TimeOut;
  output Timer_Enable;

  reg Timer_Enable;


  always @(Config_Enable, Timer_TimeOut)
  begin

    if(Config_Enable == 1 && Timer_TimeOut == 0)
    begin
       Timer_Enable = 1;
    end

    else
    begin
       Timer_Enable = 0;
    end

  end 
endmodule
