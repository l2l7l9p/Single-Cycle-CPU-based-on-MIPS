`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/20 14:54:48
// Design Name: 
// Module Name: control
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


module control
(
	input [5:0] opcode,
	output reg [1:0] regDst,memToReg,jmp,
	output reg aluSrcB,regWrite,branch,ExtOp,
	output memRead,memWrite,
	output reg [3:0] aluop
);
	assign memRead=(opcode==6'b100011);
	assign memWrite=(opcode==6'b101011);
	always @ (opcode)
		case (opcode)
			// J
			6'b000010: begin	// j
				regDst = 2'b00;  aluSrcB = 0;  memToReg = 2'b00;
				regWrite = 0;
				branch = 0;  aluop = 4'b0000;  jmp = 2'b01;  ExtOp = 1;
			end
			6'b000011: begin	// jal
				regDst = 2'b10;  aluSrcB = 0;  memToReg = 2'b10;
				regWrite = 1;
				branch = 0;  aluop = 4'b0000;  jmp = 2'b01;  ExtOp = 1;
			end
			// R
			6'b000000: begin
				regDst = 2'b01;  aluSrcB = 0;  memToReg = 2'b00;
				regWrite = 1;
				branch = 0;  aluop = 4'b1111;  jmp = 2'b00;  ExtOp = 1;
			end
			// I
			6'b001000: begin	// addi
				regDst = 2'b00;  aluSrcB = 1;  memToReg = 2'b00; 
				regWrite = 1;
				branch = 0;  aluop = 4'b0010;  jmp = 2'b00;  ExtOp = 1;
			end
			6'b001001: begin	// addiu
				regDst = 2'b00;  aluSrcB = 1;  memToReg = 2'b00;
				regWrite = 1;
				branch = 0;  aluop = 4'b0010;  jmp = 2'b00;  ExtOp = 1;
			end
			6'b001100: begin	// andi
				regDst = 2'b00;  aluSrcB = 1;  memToReg = 2'b00;
				regWrite = 1;
				branch = 0;  aluop = 4'b0000;  jmp = 2'b00;  ExtOp = 0;
			end
			6'b001101: begin	// ori
				regDst = 2'b00;  aluSrcB = 1;  memToReg = 2'b00;
				regWrite = 1;
				branch = 0; aluop = 4'b0001; jmp = 2'b00; ExtOp = 0;
			end
			6'b001110: begin	// xori
				regDst = 2'b00;  aluSrcB = 1;  memToReg = 2'b00;
				regWrite = 1;
				branch = 0; aluop = 4'b1100; jmp = 2'b00; ExtOp = 0;
			end
			/*6'b001111: begin	// lui
				regDst = 2'b00;  aluSrcB = 1;  memToReg = 2'b00;
				regWrite = 1;
				branch = 0; aluop = 4'b1011; jmp = 2'b00; ExtOp = 1;
			end*/
			6'b100011: begin	// lw
				regDst = 2'b00;  aluSrcB = 1;  memToReg = 2'b01;
				regWrite = 1;
				branch = 0;  aluop = 4'b0010;  jmp = 2'b00;  ExtOp = 1;
			end
			6'b101011: begin	// sw
				regDst = 2'b00;  aluSrcB = 1;  memToReg = 2'b00;
				regWrite = 0;
				branch = 0; aluop = 4'b0010; jmp = 2'b00; ExtOp = 1;
			end
			6'b000100: begin	// beq
				regDst = 2'b00;  aluSrcB = 0;  memToReg = 2'b00;
				regWrite = 0;
				branch = 1; aluop = 4'b0110; jmp = 2'b00; ExtOp = 1;
			end
			6'b000101: begin	// bne
				regDst = 2'b00;  aluSrcB = 0;  memToReg = 2'b00;
				regWrite = 0;
				branch = 1; aluop = 4'b0110; jmp = 2'b00; ExtOp = 1;
			end
			6'b001010: begin	// slti
				regDst = 2'b00;  aluSrcB = 1;  memToReg = 2'b00;
				regWrite = 1;
				branch = 0; aluop = 4'b0111; jmp = 2'b00; ExtOp = 1;
			end
			6'b001011: begin	// sltiu
				regDst = 2'b00;  aluSrcB = 1;  memToReg = 2'b00;
				regWrite = 1;
				branch = 0; aluop = 4'b1111; jmp = 2'b00; ExtOp = 1;
			end
			default: begin		// default
				regDst = 2'b00;  aluSrcB = 0;  memToReg = 2'b00;
				regWrite = 0;
				branch = 0; aluop = 4'b0000; jmp = 2'b00; ExtOp = 0;
			end
		endcase
endmodule

module alucontrol
(
	input [3:0] aluop,
	input [5:0] funct,
	input [1:0] injmp,
	output reg [3:0] aluCtr,
	output aluSrcA,
	output [1:0] outjmp
);
	always @ (aluop or funct)
		if (aluop==4'b1111)
		begin
			casex (funct)
				6'b10000x: aluCtr=4'b0010;	// add addu
				6'b10001x: aluCtr=4'b0110;	// sub subu
				6'b100100: aluCtr=4'b0000;	// and
				6'b100101: aluCtr=4'b0001;	// or
				6'b100110: aluCtr=4'b1100;	// xor
				6'b100111: aluCtr=4'b0011;  // nor
				6'b101010: aluCtr=4'b0111;	// slt
				6'b101011: aluCtr=4'b1111;  // sltu
				6'b000x00: aluCtr=4'b1001;  // sll sllv
				6'b000x10: aluCtr=4'b1010;  // srl srlv
				6'b000x11: aluCtr=4'b1011;  // sra srav
				6'b011000: aluCtr=4'b1101;  // mult
				6'b011010: aluCtr=4'b1000;  // div
				6'b010000: aluCtr=4'b0100;  // mfhi
				6'b010010: aluCtr=4'b0101;  // mflo
				default: aluCtr=4'b1110;
			endcase
		end else aluCtr=aluop;
	// sll,slr,sra
	assign aluSrcA=(aluop==4'b1111 && (funct==6'd0 || funct==6'b000010 || funct==6'b000011));
	// jr
	assign outjmp=(aluop==4'b1111 && funct==6'b001000) ?2'b10 :injmp ;
endmodule