`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:29:46 05/25/2017 
// Design Name: 
// Module Name:    SR32 
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
module SR32(
	input  [31:0]	SET,
	input 			D,
	input				CLK,
	input				RESET,
	output [31:0]	Q
);

	dflipflop ff0 (
		.D(D),
		.RESET(RESET),
		.SET(SET[0]),
		.CLK(CLK),
		.Q(Q[0])
	);
	
	genvar i;
	generate
	for (i=1;i<32;i=i+1) begin: ff_gen
		dflipflop ff (
			.D(Q[i-1]),
			.RESET(RESET),
			.SET(SET[i]),
			.CLK(CLK),
			.Q(Q[i])
		);
	end
	endgenerate
	
endmodule
