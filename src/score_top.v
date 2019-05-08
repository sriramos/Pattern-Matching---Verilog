

module score_top(clk,reset,lvl_inp,timeout,player,internalid,win,disp_score,disp_score_max);

input clk,reset,player,win,timeout;
input [1:0] lvl_inp;
input [3:0] internalid;

output [3:0]disp_score,disp_score_max;

wire [3:0] address,data,q;
wire wren;


score_controller scorecont1(clk,reset,player,internalid,lvl_inp,timeout,win,address,q,data,wren,disp_score,disp_score_max);

RAM_SCORE ramscore1(address,clk,data,wren,q);

endmodule

