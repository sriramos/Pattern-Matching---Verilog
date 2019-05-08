module authenticate_top_(clk,reset,in_toggle_userid,in_toggle_pswd,toggle_userid_out,userid_btn,pswd_btn,logout_btn,redled,greenled,authorise_bit, internalid);

  input clk,reset,userid_btn, pswd_btn,logout_btn;
  input [3:0]in_toggle_userid,in_toggle_pswd;

  output authorise_bit, greenled, redled;
  output [6:0] toggle_userid_out;

  output[3:0] internalid;
  
  wire access_rom,push_button1,push_button2;
  

 rom_userid_top rom_userid_top1(clk, reset, in_toggle_userid,internalid, access_rom, push_button1,logout);

rom_pswd_top rom_pswd_top1(clk, reset, in_toggle_pswd,internalid,access_rom,push_button2,logout,redled,greenled,authorise_bit); 



ButtonShaper ButtonShaper_1(clk, rst, userid_btn, push_button1);
ButtonShaper ButtonShaper_2(clk, rst, pswd_btn, push_button2);


SevenSeg_4to7 SevenSeg_4to7_3(in_toggle_userid, toggle_userid_out);

 
endmodule

