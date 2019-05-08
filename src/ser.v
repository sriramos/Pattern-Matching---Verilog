module Final_Random_ser ( clk, reset, access, from_manoj, ld , difficulty, concat );
input clk, reset, ld ;
input[1:0] difficulty;
input from_manoj;
input access;


output wire[20:0] concat;
//output to_manoj;

 reg[6:0] display1, display2, display3;

    
  reg[1:0] count, count1, count2;
  reg[2:0] add1, add2, add3;

 reg[1:0]  count_clk, count_clk1, count_clk2;
 reg[1:0] two_cnt, two_cnt1, two_cnt2;

reg[3:0] state;
 parameter S0=4'b0000, S1=4'b0001, S2=4'b0010, S3=4'b0011, S4=4'b0100, S5=4'b0101, S6=4'b0110, S7=4'b0111;

always @ (posedge clk)
begin

if(reset == 0)
begin
display1<=7'b1111111;
display2<=7'b1111111;
display3<=7'b1111111;
count2<=2'b00;
count1<=2'b00;
count<=2'b00;
count_clk<=5'b00000;
count_clk1<=5'b00000;
count_clk2<=5'b00000;
two_cnt<=2'b00;
two_cnt1<=2'b00;
two_cnt2<=2'b00;
add1<=2'b00;
add2<=2'b00;
add3<=2'b00;

state<=S1;
end

else 
begin

if(access == 1)
begin

case(state)

S1:
begin

if(ld == 0)
begin
state<=S2;
end

else
begin
display1<=7'b1111111;
display2<=7'b1111111;
display3<=7'b1111111;
state<=S1;
end
end


S2:
begin

if(ld == 0)
begin

count<=count+1;
count1<=count1+2'b10;
count2<=count2+2'b11;


if(count_clk == 5'b11111)
begin
two_cnt<=two_cnt+1;
count_clk<=0;
end
else
begin
count_clk<=count_clk+1;
end


if(count_clk1 == 5'b01111)
begin
two_cnt1<=two_cnt1+1;
count_clk1<=0;
end
else
begin
count_clk1<=count_clk1+1;
end
 
if(count_clk2 == 5'b00111)
begin
two_cnt2<=two_cnt2+1;
count_clk2<=0;
end
else
begin
count_clk2<=count_clk2+1;
end

//end
state<=S2;
end

else
begin
state<=S3;
end

end



S3:
begin


if(count == 111)
count<=count-1;
if(count1 == 111)
count1<=count1-1;
if(count2 == 111)
count2<=count2-1;

if(two_cnt == 111)
two_cnt<=two_cnt+11;

if(two_cnt1 == 111)
two_cnt1<=two_cnt1+10;

if(two_cnt2 == 111)
two_cnt2<=two_cnt2+1;


state<=S4;
end

S4:
begin

if(count == two_cnt )
begin
if(two_cnt == 100)
two_cnt<=two_cnt+1;
else
two_cnt<=two_cnt+11;
end

if(count1 == two_cnt1 )
begin
if(two_cnt1 == 100)
two_cnt1<=two_cnt1 +1;
else
two_cnt1<=two_cnt1 +11;
end

if(count2 == two_cnt2 )
begin
if(two_cnt2 != 000)
two_cnt2<=~two_cnt2;
else
two_cnt2<=~two_cnt2+10;

end

state<=S5;
end

S5:
begin

add1<=count + two_cnt;
add2<=count1 + two_cnt1;
add3<=count2 + two_cnt2;
state<=S6;
end


S6:
begin

if(from_manoj)
begin

if(ld ==1)
begin

if(difficulty == 2'b00)
begin
display1[count]<=0;
display2[count + 1]<=0;
display3[count +3]<=0;
end

if(difficulty == 2'b01)
begin
display1[count]<=0;
display2[count1]<=0;
display3[count2]<=0;
display1[count +1]<=0;
display2[count1+3]<=0;
display3[count2 +2]<=0;
end

if((difficulty == 2'b10) | (difficulty == 2'b11))
begin
display1[count]<=0;
display2[count1]<=0;
display3[count2]<=0;
display1[count + 1]<=0;
display2[count1 +2]<=0;
display3[count2 +1]<=0;
display1[count + 3]<=0;
display2[count1 + 1]<=0;
display3[count2 +3]<=0;
end

end

else
state<=S7;
end

end



S7:
begin
display1<=7'b1111111;
display2<=7'b1111111;
display3<=7'b1111111;
state<=S1;
end

default:
begin
display1<=7'b1111111;
display2<=7'b1111111;
display3<=7'b1111111;
state<=S1;
end

endcase

end

end

end

assign concat = {display1, display2, display3};
endmodule