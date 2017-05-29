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
	input [4:0] PHASE_SEL,
//	input RESET,
//	input [31:0] SR_SET,
	output CLK_OUT_MOD,
	output CLK_OUT_MODN,
	output CLK_OUT_MODL
);
	
	parameter SR_MODL_INIT = 32'hFFFF0000;
	
	wire W_SRL_FEEDBACK;
	wire [31:0] Q;
	reg [31:0] count;
	reg RESET;
	
	assign CLK_OUT_MOD = Q[15];
	assign CLK_OUT_MODN = Q[31];
	
	initial begin
		count = 1000;
		RESET = 1;
	end
	
	always @ (posedge CLK_IN) begin
		if (count > 0) count <= count - 1;
		else RESET <= 0;
	end
	
	SR32 clk_mod_sr (
		.D(Q[31]),
		.SET(32'hFFF00000),
		.CLK(CLK_IN),
		.Q(Q),
		.RESET(RESET)
	);
	
	SRLC32E #(
	.INIT(SR_MODL_INIT)// Initial Value of Shift Register
	) shiftreg_modl (
	.Q(CLK_OUT_MODL), // SRL data output
	.Q31(W_SRL_FEEDBACK), // SRL cascade output pin
	.A(PHASE_SEL), // 5-bit shift depth select input
	.CE(1'b1), // Clock enable input
	.CLK(CLK_IN), // Clock input
	.D(W_SRL_FEEDBACK) // SRL data input
	);	

endmodule
