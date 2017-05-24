`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:13:08 05/19/2017 
// Design Name: 
// Module Name:    shiftreg_tpno 
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
module shiftreg_nonoverlap_clkgen(
	input CLK_IN,
	output CLK_OUT_MOD,
	output CLK_OUT_MODN,
	output CLK_OUT_MODL
   );

	parameter SR_MOD_INIT_1 = 16'hFFF0;
	parameter SR_MOD_INIT_2 = 16'h0000;
	parameter SR_MODL_INIT = 32'hFFFF0000;
	
	wire W_SRL_CASCADE;

	SRLC16E #(
	.INIT(SR_MOD_INIT_1)// Initial Value of Shift Register
	) shiftreg_mod1 (
	.Q(CLK_OUT_MOD), // SRL data output
	.Q15(W_SRL_CASCADE), // SRL cascade output pin
	.A0(1'b1), // 4-bit shift depth select input
	.A1(1'b1),
	.A2(1'b1),
	.A3(1'b1),
	.CE(1'b1), // Clock enable input
	.CLK(CLK_IN), // Clock input
	.D(CLK_OUT_MODN) // SRL data input
	);

	SRLC16E #(
	.INIT(SR_MOD_INIT_2)// Initial Value of Shift Register
	) shiftreg_mod2 (
	.Q(CLK_OUT_MODN), // SRL data output
	.Q15(Q15), // SRL cascade output pin
	.A0(1'b1), // 4-bit shift depth select input
	.A1(1'b1),
	.A2(1'b1),
	.A3(1'b1),
	.CE(1'b1), // Clock enable input
	.CLK(CLK_IN), // Clock input
	.D(W_SRL_CASCADE) // SRL data input
	);
	
	SRLC32E #(
	.INIT(SR_MODL_INIT)// Initial Value of Shift Register
	) shiftreg_modl (
	.Q(CLK_OUT_MODL), // SRL data output
	.Q31(Q31), // SRL cascade output pin
	.A(5'b11111), // 5-bit shift depth select input
	.CE(1'b1), // Clock enable input
	.CLK(CLK_IN), // Clock input
	.D(CLK_OUT_MODL) // SRL data input
	);	

endmodule
