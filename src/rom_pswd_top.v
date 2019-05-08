module rom_pswd_top(clk, reset, in_toggle,internalid,access_rom,push_button,logout,redled,greenled,authorise_bit);

 input clk, reset, logout,push_button,access_rom;
 input [3:0] in_toggle;
 output redled,greenled,authorise_bit;
  
  input [3:0] internalid;

  wire valid;
  wire [15:0]password,password_entered;
  wire [3:0]address;

 
  

  shiftregister1 shiftregister_test1(clk,reset,in_toggle,push_button,password_entered,logout,valid);

  rom_password rom_password1(clk, reset, password_entered,address, internalid, password,valid, access_rom, logout, redled, greenled,authorise_bit);

 

 ROM_PSWD ROM_PSWD_1(address,clk,password);

endmodule 