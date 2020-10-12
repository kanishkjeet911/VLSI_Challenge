//***********************A single port RAM is the one in which the reading and writing ops happen **************//
//***********************on a single bus i.e. one at a time*****************************************************//

module single_port_ram
( data,
 addr,
 we_re,  //we_re high for writing low for reading
 clk,
 reset
);
parameter data_width = 8 , addr_width =8; // parameterising so that we can use it further with other values
 
//************definind the buses***********//
inout [data_width-1:0]data;
input [addr_width-1:0]addr;
//****************************************//

//*********** input port*********//
input clk ,we_re,reset;
//******************************//

//**********creating memory*************//
reg [data_width-1:0]mem[0:addr_width-1];
//*************************************//

//***************buffer for output data**********//
reg [data_width -1 :0] outdata;
//**********************************************//

assign data = (!we_re)?outdata:8'hZZ; // since inout cannot be a reg type therefore need outdata as intermediate

integer i;

always @(posedge clk)
begin
if(!reset)
for (i=0; i<8; i=i+1)
   mem[i] <= 8'b0; // putting zero in every memory place

//****************write conditon***************//
else if(we_re)
   begin
      mem[addr] <= data ;
   end
//*****************************************//

//*************read operation*************//
else
   begin
      outdata <= mem[addr] ;
	  
   end
//******************************************//
end


endmodule


//*********************************Test Bench**************************************//
module dut_single_port_ram;

reg clk,we_re,reset,output_valid;//output valid is high if the data is read ***///
wire [7:0] data;
reg [7:0] output_value,addr;

single_port_ram a1(data,addr,we_re,clk,reset);

assign data = (output_valid ) ? output_value: 8'hZZ;

initial
begin
clk=0;
reset =0;
#10 reset =1;
#5 we_re =1;

output_valid =1;
output_value = 8'b00000100; //[using data it as input]this gives value to data signal
addr = 8'b0000010;

#4 we_re = 0;
output_valid =0 ; // now using data it as output 

addr =  8'b0000010;


end
always #4 clk =~clk;

endmodule