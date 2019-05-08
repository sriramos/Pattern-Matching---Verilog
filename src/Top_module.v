module Top_module(clk, rst, Level, Load, Shift, my_value, counter_1_7, counter_2_7, disp_score_7, disp_score_max_7, in_toggle_userid, in_toggle_pswd, toggle_userid_out, userid_btn,pswd_btn, redled, greenled);

    input clk, rst;
    input Load, Shift;
	 input[1:0] Level;
						      //test
	 wire access_BS;						//test
	 input[3:0] in_toggle_userid, in_toggle_pswd;
	 input userid_btn,pswd_btn;
	 
	 output[6:0] counter_1_7, counter_2_7, disp_score_7, disp_score_max_7, toggle_userid_out;
	 
    output[20:0] my_value;
	 output redled,greenled;
	 
	 wire[20:0] final_Out;

    wire Load_BS, Shift_BS;
	 wire[20:0] concat;
	 wire to_Sriram;
	 wire timeout;
	 
	 
	 wire Timer_Enable;
	 wire Timer_In_0, Timer_In_1;
	 wire DNB_0, DNB_1;
	 wire[3:0] counter_1, counter_2; 
	 wire signal_out_BS, signal_out;
	 wire[3:0] disp_score,disp_score_max;
	 wire[3:0] internalid;
	 wire authorise_bit;
	 wire userid_btn_BS;

    ButtonShaper ButtonShaper_1(clk, rst, Load, Load_BS);
    ButtonShaper ButtonShaper_2(clk, rst, Shift, Shift_BS);
	 ButtonShaper ButtonShaper_4(clk, rst, DNB_0, timeout);
	 

	 Score_Shaper Score_Shaper_3(authorise_bit, clk, rst, access_BS);
	 ButtonShaper ButtonShaper_5(clk, rst, userid_btn, userid_btn_BS);
	 
	 
	 //user idand pwd
	 
	 authenticate_top_ authenticate_top_1(clk,reset,in_toggle_userid,in_toggle_pswd,toggle_userid_out,userid_btn_BS,pswd_btn,timeout,redled,greenled,authorise_bit, internalid);

    Game_model_3 Game_model_3_1(clk, rst, Level, Load_BS, Shift_BS, my_value, concat, to_Sriram, final_Out);
	 Final_Random_ser Final_Random_ser_1( clk, rst, 1'b1, to_Sriram, Load , Level, concat );
	 
	 //timing circuit
	 
	 Timer_Controller Timer_Controller_1(1'b1, Timer_Enable, DNB_0);
	 Timer1s Timer1s_1(clk, rst, Timer_Enable, Timer_In_0);
	 
	 Single_Digit_Timer Single_Digit_Timer_1(clk, rst, 4'b1111, Timer_In_0, Timer_In_1, DNB_1, DNB_0, counter_1, access_BS);
    Single_Digit_Timer Single_Digit_Timer_2(clk, rst, 4'b1111, Timer_In_1, Timer_Out, 1'b1, DNB_1, counter_2, access_BS);
    SevenSeg_4to7 SevenSeg_4to7_1(counter_1, counter_1_7);
    SevenSeg_4to7 SevenSeg_4to7_2(counter_2, counter_2_7);

    //scoreboard
    compare_outputs compare_outputs_1(concat, final_Out, signal_out);
	 Score_Shaper Score_Shaper_2(signal_out, clk, rst, signal_out_BS);
	 score_top score_top_1(clk,rst, Level, timeout, 1'b1, internalid, signal_out_BS, disp_score, disp_score_max);
	 SevenSeg_4to7 SevenSeg_4to7_3(disp_score, disp_score_7);
    SevenSeg_4to7 SevenSeg_4to7_4(disp_score_max, disp_score_max_7);
	 
	
	 
    	 
endmodule