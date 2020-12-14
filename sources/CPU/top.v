`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/27 15:35:37
// Design Name: 
// Module Name: top
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


module top
	#(parameter width=32)
(
	input clk,reset,
	output ovf,
	output [3:0] sm_wei,
    output [6:0] sm_duan
);
	// clk_1MHz
    integer clk_cnt;
    reg clk_1MHz;
    always @(posedge clk) 
        //if(clk_cnt==32'd50)
        if(clk_cnt==32'd100000000)
        begin
            clk_cnt <= 1'b0;
            clk_1MHz <= ~clk_1MHz;
        end else clk_cnt <= clk_cnt + 1'b1;
	initial begin
		clk_cnt=0;
		clk_1MHz=1;
	end
	
	wire [width-1:0] PC,instruction,PCplus4,W,A,B,ra,aluA,aluB,ALUres,imm,memres;
	wire [width-1:0] calcHi,calcLo,hi,lo;
	wire [4:0] addrw;
	wire [1:0] regDst,memToReg,jmp1,jmp2;
	wire aluSrcA,aluSrcB,regWrite,memRead,memWrite,branch,ExtOp,zero,zerobne,fakeovf;
	wire [3:0] aluop,aluCtr;
	
	NextPC nxtpc(
		.clk(clk_1MHz),
		.branch(branch),
		.zero(zerobne),
		.jmp(jmp2),
		.imm(imm),
		.ra(ra),
		.jmpInst(instruction[25:0]),
		.PC(PC),
		.PCplus4(PCplus4),
		.reset(reset)
	);
	
	memory mem(
		.rclk(clk),
		.wclk(clk_1MHz),
		.memWrite(memWrite),
		.memRead(memRead),
		.PC(PC),
		.DMadd(ALUres),
		.DMdata(B),
		.instruction(instruction),
		.DMres(memres)
	);
	
	control ctr(
		.opcode(instruction[31:26]),
		.regDst(regDst),
		.aluSrcB(aluSrcB),
		.regWrite(regWrite),
		.memRead(memRead),
		.memWrite(memWrite),
		.memToReg(memToReg),
		.branch(branch),
		.aluop(aluop),
		.jmp(jmp1),
		.ExtOp(ExtOp)
	);
	
	alucontrol aluct(
		.aluop(aluop),
		.funct(instruction[5:0]),
		.injmp(jmp1),
		.aluCtr(aluCtr),
		.aluSrcA(aluSrcA),
		.outjmp(jmp2)
	);
	
	MUX5 m1(
		.A(instruction[20:16]),
		.B(instruction[15:11]),
		.C(5'd31),
		.switch(regDst),
		.res(addrw)
	);
	Register regfile(
		.clk(clk_1MHz),
		.regWrite(regWrite),
		.addrA(instruction[25:21]),
		.addrB(instruction[20:16]),
		.addrW(addrw),
		.W(W),
		.A(A),
		.B(B),
		.ra(ra),
		.hi(hi),
		.lo(lo),
		.calcHi(calcHi),
		.calcLo(calcLo)
	);
	
	extended ex(.in(instruction[15:0]),.ExtOp(ExtOp),.out(imm));
	
	MUX32 m2A(.A(A),.B({27'b0,instruction[10:6]}),.switch(aluSrcA),.res(aluA));
	MUX32 m2B(.A(B),.B(imm),.switch(aluSrcB),.res(aluB));
	ALU alu(
		.A(aluA),
		.B(aluB),
		.aluCtr(aluCtr),
		.res(ALUres),
		.hi(hi),
		.lo(lo),
		.calcHi(calcHi),
		.calcLo(calcLo),
		.ovf(fakeovf),
		.zero(zero)
	);
	assign zerobne=zero^(instruction[31:26]==6'b000101);
	assign ovf=fakeovf&(instruction[31:26]==6'b001000 || instruction[5:0]==6'b100000);
	
	MUX32_3 m3(.A(ALUres),.B(memres),.C(PCplus4),.switch(memToReg),.res(W));
	
	display dsp(.clk(clk),.data({PC[7:0],W[7:0]}),.sm_wei(sm_wei),.sm_duan(sm_duan));
endmodule