//---------------------------------------------------------------------------------/////
//---------- This is the code for an Arbiter with 4 slaves contesting for access--/////
//--------------------------------------------------------------------------------/////

module arbiter
(
input   clk,
input   reset,
input   req1,
input   req2,
input   req3,
input   req4,
output reg  gnt1,
output reg  gnt2,
output reg  gnt3,
output reg  gnt4
);
reg [2:0]state ,next_state;

parameter idle = 3'b000, GNT1 = 3'b001, GNT2 =3'b010 ,GNT3=3'b011,GNT4=3'b100;

//------------------------------------------------------------------------------------//
//--------------------------Combinational Part for assigning of the next state-------//
//----------------------------------------------------------------------------------//
always @ (req1 ,req2,req3,req4,state)
begin
case(state)
idle: begin 
    {gnt1,gnt2,gnt3,gnt4} <= 4'b0000;
    if(req1)
       next_state <= GNT1;
    else if (req2)
       next_state <= GNT2;
    else if (req3)
       next_state <= GNT3;
    else if (req4)
       next_state <= GNT4;
	else
	   next_state <= idle;
    end
	
GNT1: begin
    gnt1<= 1;
    if(req1)
         next_state <= GNT1 ;
    else
        next_state <= idle;	
end

GNT2: begin
    gnt2 <= 1; // granting the acces
    if(req2)
     	next_state <= GNT2; 
	else
	    next_state <= idle;
end

GNT3: begin
    gnt3 <= 1;
    if(req3)
      	next_state <= GNT3;
    else
        next_state <= idle;
end


GNT4: begin
    gnt4 <= 1;
    if(req4)
     	next_state <= GNT4;
    else
        next_state <= idle;
end

endcase

end
 
//----------------------------------------------------------------------------------------------//
//------- Sequential Part  where we merge both combinational and seq ---------------------------//
//----------------------------------------------------------------------------------------------//

always @ (posedge clk)
begin
if(!reset)
begin
state <= idle;
{gnt1,gnt2,gnt3,gnt4 } <= 4'b0000;

end

else
state <= next_state;

end 

endmodule