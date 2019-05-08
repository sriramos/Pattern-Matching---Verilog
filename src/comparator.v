module compare_outputs(sriram_op, manoj_op, signal_out);
input[20:0] sriram_op, manoj_op;
output reg signal_out;

always @(sriram_op, manoj_op )
begin
if(sriram_op == manoj_op)
signal_out<= 1'b1;
else
signal_out<= 1'b0;
end
endmodule
