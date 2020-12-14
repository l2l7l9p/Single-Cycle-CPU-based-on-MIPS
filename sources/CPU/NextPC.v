`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/27 15:52:45
// Design Name: 
// Module Name: NextPC
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


module NextPC
	#(parameter width=32)
(
	input clk,branch,zero,reset,
	input [1:0] jmp,
	input [width-1:0] imm,ra,
	input [25:0] jmpInst,
	output reg [width-1:0] PC,PCplus4
);
	wire [width-1:0] nextPC1,nextPC2;
	
	MUX32 m4(.A(PCplus4),.B(PCplus4+{imm[29:0],2'b00}),.switch(branch&zero),.res(nextPC1));
	MUX32_3 m5(
		.A(nextPC1),
		.B({PCplus4[31:28],jmpInst,2'b00}),
		.C(ra),
		.switch(jmp),
		.res(nextPC2)
	);
	
	always @ (posedge clk)
		if (reset)
		begin
			PC=0;
			PCplus4=4;
		end else
		begin
			PC=nextPC2;
			PCplus4=PC+4;
		end
endmodule
