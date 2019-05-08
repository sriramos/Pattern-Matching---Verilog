module shiftregister1(clk, reset,in_toggle, push_button, out_toggle, logout, valid);
input clk, reset, logout, push_button;
input [3:0] in_toggle;
output reg [15:0] out_toggle;
output reg valid;
reg [15:0]b_int;
reg [1:0] count;
reg [2:0]state;
parameter state1=0, state2=1, state3=2, state4=3;

always @(posedge clk)
        begin
          if(reset==0)
             begin
              count<=2'b00;
              valid<=0;
              state<=state1;
              b_int<=16'b0000000000000000;
              out_toggle<=16'b0000000000000000;
             
             end
          else
             begin
                case(state)
                      state1:
                           begin
                            count<=2'b00;
                           valid<=0;
                           b_int<=16'b0000000000000000;
                           out_toggle<=16'b0000000000000000;
                          
                          
                              state<=state2;
                              
                              end
                     state2:
                             begin
                            if(push_button==1)
                                begin
                                count<=count+2'b01;
                                state<=state3;
                                end
                            else
                                begin
                               state<=state2;
                                end
                             end
                    state3:
                           begin
                           b_int[15:12]<=b_int[11:8];
                           b_int[11:8]<=b_int[7:4];
                           b_int[7:4]<=b_int[3:0];
                           b_int[3:0]<=in_toggle;
                          if(count==2'b00)
                             begin
                              state<=state4;
                             end
                          else
                              begin
                              state<=state2;
                              end
                            end
                   state4:
                         begin
                              valid<=1;
                              out_toggle<=b_int;
                        if(logout==1)
                           begin
                               state<=state1;
                            end
                       else
                           begin
                            state<=state4;
                            end
                         end
  
               endcase
          end
   end
endmodule
