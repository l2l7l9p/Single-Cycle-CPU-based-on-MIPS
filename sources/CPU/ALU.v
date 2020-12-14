`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/06 14:47:50
// Design Name: 
// Module Name: ALU
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


module ALU
	#(parameter width=32)
(
	input [width-1:0] A,B,hi,lo,
	input [3:0] aluCtr,
	output reg [width-1:0] res,calcHi,calcLo,
	output reg ovf,zero				// ovf:overflow; zero:is0
);
	always @(A or B or aluCtr or hi or lo)
	begin
		ovf=0;
		zero=0;
		
		case (aluCtr)
			4'b0000: res=A&B;
			4'b0001: res=A|B;
			4'b0011: res=~(A|B);
			4'b1100: res=A^B;
			4'b1001: res=B<<A;
			4'b1010: res=B>>A;
			4'b1011: res=$signed(B)>>>A;
			4'b0010:
				begin
					res=A+B;
					ovf=(A[width-1] && B[width-1] && !res[width-1] || !A[width-1] && !B[width-1] && res[width-1]);
				end
			4'b0110:
				begin
					res=A-B;
					zero=(res==0);
				end
			4'b0111: res=($signed(A)<$signed(B));
			4'b1111: res=(A<B);
			4'b0100: res=hi;
			4'b0101: res=lo;
			default: res=0;
		endcase
		
		case (aluCtr)
			4'b1101: {calcHi,calcLo}=$signed(A)*$signed(B);
			4'b1000:
				begin
					calcHi=$signed(A)%$signed(B);
					calcLo=$signed(A)/$signed(B);
				end
			default: {calcHi,calcLo}={hi,lo};
		endcase
	end
endmodule