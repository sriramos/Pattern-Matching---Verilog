module rom_userid_top(clk, reset, in_toggle,internalid, access_rom, push_button,logout);

 input clk, reset, logout,push_button;
 input [3:0] in_toggle;
 output access_rom;
  
 output [3:0] internalid;

  wire valid;
  wire [15:0]userid,userid_entered;
  wire [3:0]address;

 shiftregister1 shiftregister_test(clk, reset,in_toggle,push_button,userid_entered, logout, valid); 

 rom_userid rom_userid_1(clk, reset, userid_entered, address, internalid, userid, valid, access_rom, logout);

 ROM_USER_ID ROM_USER_ID_1(address,clk,userid);

endmodule 