// ECE6370
// Author: Manoj Kumar Cebol Sundarrajan, 0546
// SevenSeg_4to7
// The module decodes the 4 bit input to 7 bit 7 segment decoder output


module SevenSeg_4to7(inp,out);
  input[3:0] inp;
  output[6:0] out;
  reg[6:0] out;

  always @(inp)
  begin
    case(inp)
                           //  6543210       
      4'b0000 : begin out = 7'b1000000; end  //0
      4'b0001 : begin out = 7'b1111001; end  //1
      4'b0010 : begin out = 7'b0100100; end  //2
      4'b0011 : begin out = 7'b0110000; end  //3
      4'b0100 : begin out = 7'b0011001; end  //4
      4'b0101 : begin out = 7'b0010010; end  //5
      4'b0110 : begin out = 7'b0000010; end  //6
      4'b0111 : begin out = 7'b1111000; end  //7
      4'b1000 : begin out = 7'b0000000; end  //8
      4'b1001 : begin out = 7'b0011000; end  //9
      4'b1010 : begin out = 7'b0001000; end  //A
      4'b1011 : begin out = 7'b0000011; end  //b
      4'b1100 : begin out = 7'b1000110; end  //C
      4'b1101 : begin out = 7'b0100001; end  //d
      4'b1110 : begin out = 7'b0000110; end  //E
      4'b1111 : begin out = 7'b0001110; end  //F
      default : begin out = 7'b1111111; end  //No out
    endcase
  end
endmodule
    