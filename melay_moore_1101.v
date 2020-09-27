//*************************************THIS VERILOG CODE IMPLEMENTS A SEQUENCE DETECTOR OF 1101 USING MEALAY MACHINE******************************//
//************************************************************************************************************************************************//

module melay
( input x,
  input clk,
  input reset,
  output reg y

);

reg [2:0]state;
reg [2:0]next_state;

parameter A = 2'b00, B =2'b01 ,C =2'b10 ,D=2'b11;

always @(x or state)
begin
case(state)
A:begin next_state <= x?B:A ;y<=0 ;end
B:begin next_state <= x?C:A ;y<=0 ; end
C:begin next_state <= x?C:D ;y<=0 ; end
D:begin next_state <= x?B:A ;y<=x?1:0 ; end

endcase
 end

always @(posedge clk or negedge reset)
begin
if(!reset)begin
state <= A;
y <= 0; end
else
state <=next_state;

end

endmodule

module test_melay;
 wire y;
reg x,clk,reset;

melay m1(x,clk,reset,y);

initial
begin
clk =0;
x=1;
reset=0;
#10 reset =1;
#10 x=1;
#10 x=1;
#10 x=0;
#10 x=1;
#10 x=1;
#5 x=1;
#14 x=0;
#7 x=0;
#13 reset =0;
#1 reset =1;
#200 $finish;
end

always #6 clk =~clk;

endmodule



