
//************************** 4 bit down counter **************************//
//************************************************************************//
module down_counter(output reg [3:0]out,input clk,input reset);

always @(posedge clk)
begin
if(!reset)
out <= 4'b1111;
else
begin
out <= out - 1 ;
end
end
endmodule

module test_down;
wire [3:0] out;
reg clk,reset;

down_counter a1(out,clk,reset);

initial
begin
clk = 0;
#1reset = 0;
#10 reset = 1'b1;
#23 reset =0;
#7 reset =1;
end
always #5 clk = ~clk;
endmodule