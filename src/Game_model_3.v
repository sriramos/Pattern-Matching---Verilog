module Game_model_3(clk, rst, Level, Load, Shift, my_value, actual, to_Sriram, final_Out );
    
   input clk, rst;
   input Load, Shift;
   input[1:0] Level;
	input[20:0] actual;

   output[20:0] my_value;
	output[20:0] final_Out;
	
	output to_Sriram;
	reg to_Sriram;

   reg[4:0] State;
	reg[2:0] Timer_Counter;


   reg[4:0] Counter_1;
   reg[4:0] Counter_2;
   reg[4:0] Counter_3;
	

   reg Timer_Enable;

   reg[3:0] Load_Counter;
	reg[2:0] Internal_Counter;

   wire timeout;

   reg[20:0] Out;
   reg[20:0] my_value; 
   reg[20:0] final_Out;       

   parameter S0=5'b00000, S0_OFF=5'b00001, S0_NEXT=5'b00010, S1=5'b00011, S1_OFF=5'b00100, S1_NEXT=5'b00101;
   parameter S2=5'b00110, S2_OFF=5'b00111, S2_NEXT=5'b01000, S3=5'b01001, S3_OFF=5'b01010, S3_NEXT=5'b01011;
   parameter S4=5'b01110, S4_OFF=5'b01111, S4_NEXT=5'b10000, S5=5'b10001, S5_OFF=5'b10010, S5_NEXT=5'b10011;
   parameter DISPLAY=5'b10100, WAIT=5'b10101, TRANSFER=5'b10110, INTERMEDIATE=5'b10111;

   Timer500ms Timer500ms_1(clk, rst, Timer_Enable, timeout);

   always@(posedge clk)
   begin
      if(rst == 0)
      begin
         Out <= 21'b111111111111111111111;
         State <= DISPLAY;
         my_value <= 21'b111111111111111111111;
         Counter_1 <= 5'b00000;
         Counter_2 <= 5'b00111;
         Counter_3 <= 5'b01110;
         Timer_Enable <= 0;
         Load_Counter <= 4'b0000;
         final_Out <= 21'b111111111111111111111;
			Timer_Counter <= 3'b000;
			to_Sriram <= 0;
			Internal_Counter <= 3'b000;
      end
      else
      begin
         Timer_Enable <= 1;						  // for testing 
         case(State)
			
			   DISPLAY:
            begin
				   Out <= 21'b111111111111111111111;
					//final_Out <= 21'b111111111111111111111;
					Load_Counter <= 4'b0000;
				   Counter_1 <= 5'b00000;
               Counter_2 <= 5'b00111;
               Counter_3 <= 5'b01110;
				   
				   to_Sriram <= 1;
				   Timer_Counter <= 3'b000;
				   if(Load == 1 )
				   begin
						State <= INTERMEDIATE;
					end
					else
					begin
					   my_value <= 21'b111111111111111111111;
						State <= DISPLAY;
					end
            end
				
				INTERMEDIATE:
				begin
				   if(timeout == 1)
					begin
					   if(Internal_Counter == 3'b011)
						begin
						   State <= WAIT;
							Internal_Counter = 3'b000;
						end
						else
						begin
						   Internal_Counter = Internal_Counter + 1;
						end
					end
				end
				
				WAIT:
				begin
				   to_Sriram <= 0;
					my_value <= actual;
				   if(timeout == 1)
					begin
					   if(Timer_Counter == 3'b111)
						begin
						   Timer_Counter <= 3'b000;
							State <= S0;
						end
						else
						begin
					      Timer_Counter = Timer_Counter + 1;
							State <= WAIT;
						end
					end
					else
					begin
					   State <= WAIT;
					end
				end

            S0:
            begin
            	             //098765432109876543210
               my_value <= 21'b111111111111111111110;
               
               if(Shift == 1)
               begin
                  State <= S0_NEXT;
               end

               else if(Load == 1)
               begin
                  Load_Counter <= Load_Counter + 1;
                  if(Out[0] == 1)
                  begin
                     Out[0] <= 0;
                  end
                  else
                  begin
                     Out[0] <= 1;
                  end

                  if(Level == 2'b00)
                  begin
                     if(Load_Counter == 4'b0000)
                     begin
                        State <= S2;							
                     end
                     else
                     begin
                        Counter_1 <= 5'b00000;
                        State <= S0;
                     end
                  end
                  else if(Level == 2'b01)
                  begin
                     if(Load_Counter == 4'b0001)
                     begin
                        State <= S2;							
                     end
                     else
                     begin
                        Counter_1 <= 5'b00000;
                        State <= S0;
                     end
                  end
                  else if(Level > 2'b01)
                  begin
                     if(Load_Counter == 4'b0010)
                     begin
                        State <= S2;							
                     end
                     else
                     begin
                        Counter_1 <= 5'b00000;
                        State <= S0;
                     end
                  end
               end
               
               else if(timeout == 1)
               begin
                  State <= S0_OFF;
               end

               else
               begin
                  State <= S0;
               end
            end

            S0_OFF:
            begin
               my_value <= 21'b111111111111111111111;

               if(Shift == 1)
               begin
                  State <= S0_NEXT;
               end
               
               else if(Load == 1)
               begin
                  Load_Counter <= Load_Counter + 1;
                  if(Out[0] == 1)
                  begin
                     Out[0] <= 0;
                  end
                  else
                  begin
                     Out[0] <= 1;
                  end

                  if(Level == 2'b00)
                  begin
                     if(Load_Counter == 4'b0000)
                     begin
                        State <= S2;							
                     end
                     else
                     begin
                        Counter_1 <= 5'b00000;
                        State <= S0;
                     end
                  end
                  else if(Level == 2'b01)
                  begin
                     if(Load_Counter == 4'b0001)
                     begin
                        State <= S2;							
                     end
                     else
                     begin
                        Counter_1 <= 5'b00000;
                        State <= S0;
                     end
                  end
                  else if(Level > 2'b01)
                  begin
                     if(Load_Counter == 4'b0010)
                     begin
                        State <= S2;							
                     end
                     else
                     begin
                        Counter_1 <= 5'b00000;
                        State <= S0;
                     end
                  end
               end
               
               else if(timeout == 1)
               begin
                  State <= S0;
               end
               else
               begin
                  State <= S0_OFF;
               end
            end

            S0_NEXT:
            begin
               
               Counter_1 <= 5'b00001;
               my_value[20:1] <= my_value[19:0];
               my_value[0] <= 1;
               State <= S1;

            end

            S1:
            begin

               my_value[Counter_1] <= 0;

               if(Shift == 1)
               begin
                  State <= S1_NEXT; 
               end
               
               else if(Load == 1)
               begin
                  Load_Counter <= Load_Counter + 1;
                  if(Out[Counter_1] == 1)
                  begin
                     Out[Counter_1] <= 0;
                  end
                  else
                  begin
                     Out[Counter_1] <= 1;
                  end

                  if(Level == 2'b00)
                  begin
                     if(Load_Counter == 4'b0000)
                     begin
                        State <= S2;							
                     end
                     else
                     begin
                        Counter_1 <= 5'b00000;
                        State <= S0;
                     end
                  end
                  else if(Level == 2'b01)
                  begin
                     if(Load_Counter == 4'b0001)
                     begin
                        State <= S2;							
                     end
                     else
                     begin
                        Counter_1 <= 5'b00000;
                        State <= S0;
                     end
                  end
                  else if(Level > 2'b01)
                  begin
                     if(Load_Counter == 4'b0010)
                     begin
                        State <= S2;							
                     end
                     else
                     begin
                        Counter_1 <= 5'b00000;
                        State <= S0;
                     end
                  end
               end
               
               else if(timeout == 1)
               begin
                  State <= S1_OFF;
               end
               else
               begin
                  State <= S1;
               end
            end

            S1_OFF:
            begin
               my_value[Counter_1] <= 1;

               if(Shift == 1)
               begin
                  State <= S1_NEXT;
               end
               
               else if(Load == 1)
               begin
                  Load_Counter <= Load_Counter + 1;
                  if(Out[Counter_1] == 1)
                  begin
                     Out[Counter_1] <= 0;
                  end
                  else
                  begin
                     Out[Counter_1] <= 1;
                  end

                  if(Level == 2'b00)
                  begin
                     if(Load_Counter == 4'b0000)
                     begin
                        State <= S2;							
                     end
                     else
                     begin
                        Counter_1 <= 5'b00000;
                        State <= S0;
                     end
                  end
                  else if(Level == 2'b01)
                  begin
                     if(Load_Counter == 4'b0001)
                     begin
                        State <= S2;							
                     end
                     else
                     begin
                        Counter_1 <= 5'b00000;
                        State <= S0;
                     end
                  end
                  else if(Level > 2'b01)
                  begin
                     if(Load_Counter == 4'b0010)
                     begin
                        State <= S2;							
                     end
                     else
                     begin
                        Counter_1 <= 5'b00000;
                        State <= S0;
                     end
                  end
               end
               
               else if(timeout == 1)
               begin
                  State <= S1;
               end
               else
               begin
                  State <= S1_OFF;
               end
            end

            S1_NEXT:
            begin

                  if(Counter_1 != 5'b00110)
                  begin
                     my_value[20:1] <= my_value[19:0];
                     my_value[0] <= 1;

                     State <= S1;
                     Counter_1 <= Counter_1 + 1;
                  end
                  else
                  begin
                     State <= S0;
                  end
            end

            S2:
            begin
            	             //098765432109876543210
               my_value <= 21'b111111111111101111111;
               
               if(Shift == 1)
               begin
                  State <= S2_NEXT;
               end

               else if(Load == 1)
               begin
                  Load_Counter <= Load_Counter + 1;
                  if(Out[7] == 1)
                  begin
                     Out[7] <= 0;
                  end
                  else
                  begin
                     Out[7] <= 1;
                  end

                  if(Level == 2'b00)
                  begin
                     if(Load_Counter == 4'b0001)
                     begin
                        State <= S4;							
                     end
                     else
                     begin
                        Counter_2 <= 5'b00111;
                        State <= S2;
                     end
                  end
                  else if(Level == 2'b01)
                  begin
                     if(Load_Counter == 4'b0011)
                     begin
                        State <= S4;							
                     end
                     else
                     begin
                        Counter_2 <= 5'b00111;
                        State <= S2;
                     end
                  end
                  else if(Level > 2'b01)
                  begin
                     if(Load_Counter == 4'b0101)
                     begin
                        State <= S4;						
                     end
                     else
                     begin
                        Counter_2 <= 5'b00111;
                        State <= S2;
                     end
                  end
               end
               
               else if(timeout == 1)
               begin
                  State <= S2_OFF;
               end
               else
               begin
                  State <= S2;
               end
            end

            S2_OFF:
            begin
               my_value <= 21'b111111111111111111111;

               if(Shift == 1)
               begin
                  State <= S2_NEXT;
               end
               
               else if(Load == 1)
               begin
                  Load_Counter <= Load_Counter + 1;
                  if(Out[7] == 1)
                  begin
                     Out[7] <= 0;
                  end
                  else
                  begin
                     Out[7] <= 1;
                  end

                  if(Level == 2'b00)
                  begin
                     if(Load_Counter == 4'b0001)
                     begin
                        State <= S4;							
                     end
                     else
                     begin
                        Counter_2 <= 5'b00111;
                        State <= S2;
                     end
                  end
                  else if(Level == 2'b01)
                  begin
                     if(Load_Counter == 4'b0011)
                     begin
                        State <= S4;							
                     end
                     else
                     begin
                        Counter_2 <= 5'b00111;
                        State <= S2;
                     end
                  end
                  else if(Level > 2'b01)
                  begin
                     if(Load_Counter == 4'b0101)
                     begin
                        State <= S4;						
                     end
                     else
                     begin
                        Counter_2 <= 5'b00111;
                        State <= S2;
                     end
                  end
               end
               
               else if(timeout == 1)
               begin
                  State <= S2;
               end
               else
               begin
                  State <= S2_OFF;
               end
            end

            S2_NEXT:
            begin
               
               Counter_2 <= 5'b01000;
               my_value[20:1] <= my_value[19:0];
               my_value[0] <= 1;
               State <= S3;

            end

            S3:
            begin

               my_value[Counter_2] <= 0;

               if(Shift == 1)
               begin
                  State <= S3_NEXT; 
               end
               
               else if(Load == 1)
               begin
                  Load_Counter <= Load_Counter + 1;
                  if(Out[Counter_2] == 1)
                  begin
                     Out[Counter_2] <= 0;
                  end
                  else
                  begin
                     Out[Counter_2] <= 1;
                  end

                  if(Level == 2'b00)
                  begin
                     if(Load_Counter == 4'b0001)
                     begin
                        State <= S4;							
                     end
                     else
                     begin
                        Counter_2 <= 5'b00111;
                        State <= S2;
                     end
                  end
                  else if(Level == 2'b01)
                  begin
                     if(Load_Counter == 4'b0011)
                     begin
                        State <= S4;							
                     end
                     else
                     begin
                        Counter_2 <= 5'b00111;
                        State <= S2;
                     end
                  end
                  else if(Level > 2'b01)
                  begin
                     if(Load_Counter == 4'b0101)
                     begin
                        State <= S4;						
                     end
                     else
                     begin
                        Counter_2 <= 5'b00111;
                        State <= S2;
                     end
                  end
               end
               
               else if(timeout == 1)
               begin
                  State <= S3_OFF;
               end
               else
               begin
                  State <= S3;
               end
            end

            S3_OFF:
            begin
               my_value[Counter_2] <= 1;

               if(Shift == 1)
               begin
                  State <= S3_NEXT;
               end
               
               else if(Load == 1)
               begin
                  Load_Counter <= Load_Counter + 1;
                  if(Out[Counter_2] == 1)
                  begin
                     Out[Counter_2] <= 0;
                  end
                  else
                  begin
                     Out[Counter_2] <= 1;
                  end

                  if(Level == 2'b00)
                  begin
                     if(Load_Counter == 4'b0001)
                     begin
                        State <= S4;							
                     end
                     else
                     begin
                        Counter_2 <= 5'b00111;
                        State <= S2;
                     end
                  end
                  else if(Level == 2'b01)
                  begin
                     if(Load_Counter == 4'b0011)
                     begin
                        State <= S4;							
                     end
                     else
                     begin
                        Counter_2 <= 5'b00111;
                        State <= S2;
                     end
                  end
                  else if(Level > 2'b01)
                  begin
                     if(Load_Counter == 4'b0101)
                     begin
                        State <= S4;						
                     end
                     else
                     begin
                        Counter_2 <= 5'b00111;
                        State <= S2;
                     end
                  end
               end
               
               else if(timeout == 1)
               begin
                  State <= S3;
               end
               else
               begin
                  State <= S3_OFF;
               end
            end

            S3_NEXT:
            begin

                  if(Counter_2 != 5'b01101)
                  begin
                     my_value[20:1] <= my_value[19:0];
                     my_value[0] <= 1;

                     State <= S3;
                     Counter_2 <= Counter_2 + 1;
                  end
                  else
                  begin
                     State <= S2;
                  end
            end


            S4:
            begin
            	             //098765432109876543210
               my_value <= 21'b111111011111111111111;
               
               if(Shift == 1)
               begin
                  State <= S4_NEXT;
               end

               else if(Load == 1)
               begin
                  Load_Counter <= Load_Counter + 1;
                  if(Out[14] == 1)
                  begin
                     Out[14] <= 0;
                  end
                  else
                  begin
                     Out[14] <= 1;
                  end

                  if(Level == 2'b00)
                  begin
                     if(Load_Counter == 4'b0010)
                     begin
                        State <= TRANSFER;
                     end
                     else
                     begin
                        Counter_3 <= 5'b01110;
                        State <= S4;
                     end
                  end
                  else if(Level == 2'b01)
                  begin
                     if(Load_Counter == 4'b0101)
                     begin
                        State <= TRANSFER;
                     end
                     else
                     begin
                        Counter_3 <= 5'b01110;
                        State <= S4;
                     end
                  end
                  else if(Level > 2'b01)
                  begin
                     if(Load_Counter == 4'b1000)
                     begin
                        State <= TRANSFER;					
                     end
                     else
                     begin
                        Counter_3 <= 5'b01110;
                        State <= S4;
                     end
                  end
               end
               
               else if(timeout == 1)
               begin
                  State <= S4_OFF;
               end
               else
               begin
                  State <= S4;
               end
            end

            S4_OFF:
            begin
               my_value <= 21'b111111111111111111111;

               if(Shift == 1)
               begin
                  State <= S4_NEXT;
               end
               
               else if(Load == 1)
               begin
                  Load_Counter <= Load_Counter + 1;
                  if(Out[14] == 1)
                  begin
                     Out[14] <= 0;
                  end
                  else
                  begin
                     Out[14] <= 1;
                  end

                  if(Level == 2'b00)
                  begin
                     if(Load_Counter == 4'b0010)
                     begin
                        State <= TRANSFER;
                     end
                     else
                     begin
                        Counter_3 <= 5'b01110;
                        State <= S4;
                     end
                  end
                  else if(Level == 2'b01)
                  begin
                     if(Load_Counter == 4'b0101)
                     begin
                        State <= TRANSFER;
                     end
                     else
                     begin
                        Counter_3 <= 5'b01110;
                        State <= S4;
                     end
                  end
                  else if(Level > 2'b01)
                  begin
                     if(Load_Counter == 4'b1000)
                     begin
                        State <= TRANSFER;				
                     end
                     else
                     begin
                        Counter_3 <= 5'b01110;
                        State <= S4;
                     end
                  end
               end
               
               else if(timeout == 1)
               begin
                  State <= S4;
               end
               else
               begin
                  State <= S4_OFF;
               end
            end

            S4_NEXT:
            begin
               
               Counter_3 <= 5'b01111;
               my_value[20:1] <= my_value[19:0];
               my_value[0] <= 1;
               State <= S5;

            end

            S5:
            begin

               my_value[Counter_3] <= 0;

               if(Shift == 1)
               begin
                  State <= S5_NEXT; 
               end
               
               else if(Load == 1)
               begin
                  Load_Counter <= Load_Counter + 1;
                  if(Out[Counter_3] == 1)
                  begin
                     Out[Counter_3] <= 0;
                  end
                  else
                  begin
                     Out[Counter_3] <= 1;
                  end

                  if(Level == 2'b00)
                  begin
                     if(Load_Counter == 4'b0010)
                     begin
                        State <= TRANSFER;					
                     end
                     else
                     begin
                        Counter_3 <= 5'b01110;
                        State <= S4;
                     end
                  end
                  if(Level == 2'b01)
                  begin
                     if(Load_Counter == 4'b0101)
                     begin
                        State <= TRANSFER;					
                     end
                     else
                     begin
                        Counter_3 <= 5'b01110;
                        State <= S4;
                     end
                  end
                  if(Level > 2'b01)
                  begin
                     if(Load_Counter == 4'b1000)
                     begin
                        State <= TRANSFER;					
                     end
                     else
                     begin
                        Counter_3 <= 5'b01110;
                        State <= S4;
                     end
                  end
               end
               
               else if(timeout == 1)
               begin
                  State <= S5_OFF;
               end
               else
               begin
                  State <= S5;
               end
            end

            S5_OFF:
            begin
               my_value[Counter_3] <= 1;

               if(Shift == 1)
               begin
                  State <= S5_NEXT;
               end
               
               else if(Load == 1)
               begin
                  Load_Counter <= Load_Counter + 1;
                  if(Out[Counter_3] == 1)
                  begin
                     Out[Counter_3] <= 0;
                  end
                  else
                  begin
                     Out[Counter_3] <= 1;
                  end

                  if(Level == 2'b00)
                  begin
                     if(Load_Counter == 4'b0010)
                     begin
                        State <= TRANSFER;					
                     end
                     else
                     begin
                        Counter_3 <= 5'b01110;
                        State <= S4;
                     end
                  end
                  if(Level == 2'b01)
                  begin
                     if(Load_Counter == 4'b0101)
                     begin
                        State <= TRANSFER;					
                     end
                     else
                     begin
                        Counter_3 <= 5'b01110;
                        State <= S4;
                     end
                  end
                  if(Level > 2'b01)
                  begin
                     if(Load_Counter == 4'b1000)
                     begin
                        State <= TRANSFER;				
                     end
                     else
                     begin
                        Counter_3 <= 5'b01110;
                        State <= S4;
                     end
                  end
               end
               
               else if(timeout == 1)
               begin
                  State <= S5;
               end
               else
               begin
                  State <= S5_OFF;
               end
            end

            S5_NEXT:
            begin
               if(Counter_3 != 5'b10100)
               begin
                  my_value[20:1] <= my_value[19:0];
                  my_value[0] <= 1;

                  State <= S5;
                  Counter_3 <= Counter_3 + 1;
               end
               else
               begin
                  State <= S4;
               end
            end
				
				TRANSFER:
				begin
				   State <= DISPLAY;
					final_Out <= Out;
				end

            default:
            begin
               Out <= 21'b111111111111111111111;
               State <= DISPLAY;
               my_value <= 21'b111111111111111111111;
               Counter_1 <= 5'b00000;
               Counter_2 <= 5'b00111;
               Counter_3 <= 5'b01110;
               Timer_Enable <= 0;
               Load_Counter <= 4'b0000;
               final_Out <= 21'b111111111111111111111;
			      Timer_Counter <= 3'b000;
			      to_Sriram <= 0;
					Internal_Counter = 3'b000;
            end

         endcase
      end
   end

endmodule