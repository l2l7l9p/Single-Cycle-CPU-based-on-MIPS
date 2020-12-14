`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/27 16:27:49
// Design Name: 
// Module Name: extended
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


module extended
	#(parameter half=16)
(
	input [half-1:0] in,
	input ExtOp,
	output reg [31:0] out
);
	always @ (in or ExtOp)
		out=(ExtOp) ?{{half{in[half-1]}},in} :{{half{1'b0}},in} ;
endmodule
