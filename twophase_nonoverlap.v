`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:58:45 05/08/2017 
// Design Name: 
// Module Name:    twophase_nonoverlap 
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
module twophase_nonoverlap(
    input CLK_IN,
    output CLK_OUT,
    output CLK_OUT_N
    );

	wire PHI1, PHI2, ORR1, ORR2, B1, B2;
	
	norr norr1(CLK_IN, PHI2, ORR1);
	norr norr2(!CLK_IN, PHI1, ORR2);
	
//	inv inv1(ORR1, B1);
//	inv inv2(ORR2, B2);
//	
//	inv inv3(B1, PHI1);
//	inv inv4(B2, PHI2);
	
	assign #2 PHI1 = ORR1;
	assign #2 PHI2 = ORR2;
	
	assign CLK_OUT = PHI1;
	assign CLK_OUT_N = PHI2;
	
endmodule

module norr(
	input I1, 
	input I2,
	output O
	);
	
	assign O = !(I1|I2);
endmodule

module inv(
	input I,
	output O
	);
	
	assign O = !I;
endmodule