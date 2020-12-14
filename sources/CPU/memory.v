`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/27 16:57:29
// Design Name: 
// Module Name: memory
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


module memory
	#(parameter width=32, effiPCwidth=6, effiDATAwidth=3)
(
	input rclk,wclk,memWrite,memRead,
	input [width-1:0] PC,DMdata,DMadd,
	output [width-1:0] instruction,DMres
);
	Instruction_Memory31_24 imem31_24(
		.clka(rclk),
		.ena(1'b1),
		.addra(PC[effiPCwidth+1:2]),
		.douta(instruction[31:24])
	);
	Instruction_Memory23_16 imem23_16(
		.clka(rclk),
		.ena(1'b1),
		.addra(PC[effiPCwidth+1:2]),
		.douta(instruction[23:16])
	);
	Instruction_Memory15_8 imem15_8(
		.clka(rclk),
		.ena(1'b1),
		.addra(PC[effiPCwidth+1:2]),
		.douta(instruction[15:8])
	);
	Instruction_Memory7_0 imem7_0(
		.clka(rclk),
		.ena(1'b1),
		.addra(PC[effiPCwidth+1:2]),
		.douta(instruction[7:0])
	);
	
	Data_Memory dmem31_24(
		.clka(wclk),
		.ena(1'b1),
		.wea(memWrite),
		.addra(DMadd[effiDATAwidth+1:2]),
		.dina(DMdata[31:24]),
		.clkb(rclk),
		.enb(memRead),
		.addrb(DMadd[effiDATAwidth+1:2]),
		.doutb(DMres[31:24])
	);
	Data_Memory dmem23_16(
		.clka(wclk),
		.ena(1'b1),
		.wea(memWrite),
		.addra(DMadd[effiDATAwidth+1:2]),
		.dina(DMdata[23:16]),
		.clkb(rclk),
		.enb(memRead),
		.addrb(DMadd[effiDATAwidth+1:2]),
		.doutb(DMres[23:16])
	);
	Data_Memory dmem15_8(
		.clka(wclk),
		.ena(1'b1),
		.wea(memWrite),
		.addra(DMadd[effiDATAwidth+1:2]),
		.dina(DMdata[15:8]),
		.clkb(rclk),
		.enb(memRead),
		.addrb(DMadd[effiDATAwidth+1:2]),
		.doutb(DMres[15:8])
	);
	Data_Memory dmem7_0(
		.clka(wclk),
		.ena(1'b1),
		.wea(memWrite),
		.addra(DMadd[effiDATAwidth+1:2]),
		.dina(DMdata[7:0]),
		.clkb(rclk),
		.enb(memRead),
		.addrb(DMadd[effiDATAwidth+1:2]),
		.doutb(DMres[7:0])
	);
endmodule