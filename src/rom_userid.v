module rom_userid(clk, reset, userid_entered, address, internalid, userid, valid, access_rom, logout);
input clk, reset, logout, valid;
input [15:0] userid_entered, userid;
output access_rom;
reg access_rom;
output [3:0] internalid, address;
reg [3:0] internalid, address;
reg [3:0] state;
parameter INIT=0, ROM_ADDR=1, DELAY1=2, DELAY2=3, COMPARE=4, ROM_READ=5;
always@(posedge clk) begin

     if(reset==0)begin
	address<=4'b0000;
	access_rom<=0;
	state<=INIT;
        internalid<=4'b 0000;
	
     end

     else begin
	case(state)

	   INIT: begin
		address<=4'b0000;
                access_rom<=0;
                internalid<=4'b0000;
		if(valid==1)
               begin
		    state<=ROM_ADDR;
		end
		
		else begin
		    state<=INIT;
		end
	   end

	   ROM_ADDR:
           begin
		address <= address+4'b 0001;
		
		state<=DELAY1;
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
              if(userid_entered==userid)
                begin
                internalid<=address;
                state<=ROM_READ;
                end
              else
                 begin
                 state<=ROM_ADDR;
                 end
           end
	   ROM_READ:
           begin
	       if(logout==1)
                 begin
                 access_rom<=0;
                 state<=INIT;
                 end
               else
                  begin
                  access_rom<=1;
                  state<=ROM_READ;
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
