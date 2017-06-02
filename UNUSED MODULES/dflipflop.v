`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:12:04 05/23/2017 
// Design Name: 
// Module Name:    dflipflop 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module dflipflop(
	input D,
	input RESET,
	input SET,
	input CLK,
	output reg Q
    );
	
	always @ (posedge CLK) begin
		if (RESET) Q <= SET;
		else Q <= D;
	end
endmodule
