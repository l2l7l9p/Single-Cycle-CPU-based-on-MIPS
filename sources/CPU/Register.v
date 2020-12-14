`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/27 15:38:50
// Design Name: 
// Module Name: Register
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Register
	#(parameter width=32)
(
	input clk,regWrite,
	input [4:0] addrA,addrB,addrW,
	input [width-1:0] W,calcHi,calcLo,
	output [width-1:0] A,B,ra,
	output reg [width-1:0] hi,lo
);
	reg [width-1:0] tmp [0:31];
	
	integer i;
	initial	begin
		for(i=0; i<32; i=i+1) tmp[i]=0;
		hi=0;
		lo=0;
	end
	
	always @ (posedge clk)
		if (regWrite)
		begin
			tmp[addrW]=W;
			hi=calcHi;
			lo=calcLo;
		end
	
	assign A=tmp[addrA];
	assign B=tmp[addrB];
	assign ra=tmp[5'd31];
endmodule
