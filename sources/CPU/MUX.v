`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/27 14:56:25
// Design Name: 
// Module Name: MUX
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


module MUX5
(
	input [4:0] A,B,C,
	input [1:0] switch,
	output reg [4:0] res
);
	always @ (A or B or C or switch)
		case (switch)
			2'b00: res=A;
			2'b01: res=B;
			2'b10: res=C;
		endcase
endmodule

module MUX32
(
	input [31:0] A,B,
	input switch,
	output [31:0] res
);
	assign res=(switch) ?B :A ;
endmodule

module MUX32_3
(
	input [31:0] A,B,C,
	input [1:0] switch,
	output reg [31:0] res
);
	always @ (A or B or C or switch)
		case (switch)
			2'b00: res=A;
			2'b01: res=B;
			2'b10: res=C;
		endcase
endmodule