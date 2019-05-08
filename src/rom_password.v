module rom_password(clk, reset, password_entered, address, internalid, password,valid, access_rom, logout, redled, greenled,authorise_bit);
input clk, reset, logout, valid;
input [15:0] password_entered, password;
input access_rom;
output reg authorise_bit;
output reg greenled, redled;
input [3:0] internalid;
output [3:0] address;
reg [3:0] address;
reg [3:0] state;
parameter INIT=0, ROM_ADDR=1, DELAY1=2, DELAY2=3, COMPARE=4, PASS=5;
always@(posedge clk)
    begin

     if(reset==0)
     begin
	address<=4'b0000;
	authorise_bit<=0;
	state<=INIT;
        greenled<=0;
        redled<=0;
     end

     else 
     begin
	case(state)

	   INIT: 
              begin
		address<=4'b0000;
                authorise_bit<=0;
                greenled<=0;
                redled<=0;
		if(access_rom==1)
                begin
		    state<=ROM_ADDR;
		end
		
		else
                begin
		    state<=INIT;
		end
	     end

	   ROM_ADDR:
           begin
		if(valid==1)
                  begin
                  address<=internalid;
                  state<=DELAY1;
                  end
	   end

	   DELAY1: 
            begin
		state<=DELAY2;
	   end

	   DELAY2: 
           begin
		state<=COMPARE;
	   end
          COMPARE:
          begin
              if(password_entered==password)
                begin
                state<=PASS;
               
                end
              else
                 begin
                greenled<=0;
               redled<=1;
               authorise_bit<=0;
                 state<=INIT;
                 end
           end
	   PASS:
           begin
                greenled<=1;
                redled<=0;
               authorise_bit<=1;
	       if(logout==1)
                 begin
                 state<=INIT;
                 end
               else
                  begin
                  state<=PASS;
                  end
	   end

	   default: 
           begin
		state<=INIT;
	   end
 	endcase
    end

  end
endmodule
