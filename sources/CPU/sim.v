`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/27 23:13:47
// Design Name: 
// Module Name: sim
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


module sim();
	reg clkin,reset;
	wire ovf;
	
	top tp(.clk(clkin),.reset(reset),.ovf(ovf));
	
	parameter PERIOD = 10; 
	always begin 
	clkin = 1'b0; 
	#(PERIOD / 2) clkin = 1'b1; 
	#(PERIOD / 2) ; 
	end
	
	initial begin 
	// Initialize Inputs 
	clkin = 0;
	reset=1;
	# 100;
	reset=0;
	end
endmodule
