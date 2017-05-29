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
	input d,
	input reset,
	input set,
	input clk,
	output reg q
    );
	
	always @ (posedge clk) begin
		if (reset) begin
			q <= set;
		end
		else begin
			q <= d;
		end
	end
endmodule
