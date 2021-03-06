

module score_controller(clk,reset,player,internalid,lvl_inp,timeout,win,address,q,data,wren,disp_score,disp_score_max);

input clk,reset,player,win,timeout;
input [3:0] internalid,q;
input [1:0] lvl_inp;

output reg wren;
output reg [3:0] address,data,disp_score,disp_score_max;

reg [3:0] score,max_score;
reg [3:0] state;
reg player_max;

parameter INIT=0,WAIT_1=1,READ_MAX_SCORE=2,WAIT_2=3,READ_SCORE=4,WAIT_WIN=5,UPDATE_RAM=6,WAIT_3=7,UPDATE_MAX=8;

always @(posedge clk)
begin
	if(reset==0)
	begin
		address<=4'b0000;
		disp_score<=4'b0000;
		disp_score_max<=4'b0000;
		score<=4'b0000;
		max_score<=4'b0000;
		wren<=0;
		player_max<=0;
                state<=INIT;
	end
	else
	begin
        	case(state)
			INIT:
				begin
				 address<=4'b1111;
                                 disp_score<=4'b0000;
				 disp_score_max<=4'b0000;
				 score<=4'b0000;
				 max_score<=4'b0000;
				 wren<=0;
				 player_max<=0;
				 state<=WAIT_1;
				end
			WAIT_1:
				begin
				 state<=READ_MAX_SCORE;
				end
			READ_MAX_SCORE:
				begin
				 max_score<=q;
				 if(player==1)
 					begin
					 address<=internalid;
					 state<=WAIT_2;
				 	end
				end
			WAIT_2:
				begin
				 state<=READ_SCORE;
				end
			READ_SCORE:
				begin
				 score<=q;
				
				 state<=WAIT_WIN;
			   	end
			WAIT_WIN:
			        begin
				 wren<=1;
                                 if(timeout==1)
					begin
					  state<=UPDATE_RAM;
					end
				  else if(win==1)
					begin
					  if(lvl_inp==2'b00)
					  score<=score+4'b0001;
				 	  else if(lvl_inp==2'b01)
					  score<=score+4'b0010;
					  else 
						score<=score+4'b0011;
					end
                                  if(score>=max_score)
					begin
					 player_max<=1;
					 max_score<=score;
					end
      				  else player_max<=0;

					disp_score<=score;
					disp_score_max<=max_score;
				  
				end
			UPDATE_RAM:
				begin
				 data<=score;
                                 state<=WAIT_3;
				end
			WAIT_3:
				begin
                                 address<=4'b1111;
				 state<=UPDATE_MAX;
				end
                        UPDATE_MAX:
			 	begin
				 data<=max_score;
				 state<=INIT;
				end
		endcase
	end
end
endmodule
