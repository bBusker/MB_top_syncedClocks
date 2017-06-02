`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:36:50 06/02/2017 
// Design Name: 
// Module Name:    modules_highfreq 
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
module modules_highfreq(
	input USER_CLOCK,
	input [
    );

	freqchng_clkgen_highfreq freqchng(
		.CLK_IN(USER_CLOCK),
		.RESET(1'b0),
		.LOCKED(LOCKED),
		.CLK_OUT_10MHz(W_FREQ[0]),
		.CLK_OUT_25MHz(W_FREQ[1]),
		.CLK_OUT_50MHz(W_FREQ[2])
	);
	
	freqchng_mux freqmux(
		.FREQ_IN(W_FREQ),
		.FREQ_SEL(W_FREQ_SEL),
		.FREQ_OUT(W_SELECTED_FREQ)
	);
	
	counter_nonoverlap_clkgen_highfreq nonoverlap_clkgen (
		.CLK_IN(W_SELECTED_FREQ),
		.FREQ_SEL(W_FREQ_SEL),
		.PHASE_SEL(W_PHASE_SEL),
		.DUTY_SEL(W_DUTY_SEL),
		.CLK_OUT_MOD(W_CLK_MOD),
		.CLK_OUT_MODN(W_CLKN_MOD),
		.CLK_OUT_MODL(W_CLKL_MOD)
	);

endmodule
