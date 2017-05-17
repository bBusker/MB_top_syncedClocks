`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:58:11 05/17/2017 
// Design Name: 
// Module Name:    top 
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
module top(
	input USER_CLOCK,
	output MBI_CLK_MOD,
	output MBI_CLKN_MOD,
	output MBI_CLKL_MOD
    );
	
	wire			W_CLK_MOD;
	wire			W_CLKN_MOD;
	wire			W_CLKL_MOD;
	wire			W_FREQ_CHNG;
	wire 			W_PHASE0;
	wire			W_PHASE90;
	wire			W_PHASE180;
	wire			W_PHASE270;
	wire			W_TPNO_IN;
	wire			W_MUX1;
	wire			W_MUX2;
	
//	assign MBI_CLK_MOD = W_CLK_MOD;
//	assign MBI_CLKN_MOD = W_CLKN_MOD;
//	assign MBI_CLKL_MOD = W_CLKL_MOD;
	
	DCM_SP #(
		.CLKDV_DIVIDE(2.0),
		.CLKFX_DIVIDE(1),
		.CLKFX_MULTIPLY(4),
		.CLKIN_DIVIDE_BY_2("FALSE"),
		.CLKIN_PERIOD(10.0),
		.CLKOUT_PHASE_SHIFT("NONE"),
		.CLK_FEEDBACK("1X"),
		.DESKEW_ADJUST("SYSTEM_SYNCHRONOUS"),
		.DLL_FREQUENCY_MODE("LOW"),
		.DUTY_CYCLE_CORRECTION("TRUE"),
		.PHASE_SHIFT(0),
		.STARTUP_WAIT("FALSE")
	)
	DCM_phaseselect (
		.CLK0(W_PHASE0),
		.CLK90(W_PHASE90),
		.CLK180(W_PHASE180),
		.CLK270(W_PHASE270),
		.CLK2X(CLK2X),
		.CLK2X180(CLK2X180),
		.CLKIN(USER_CLOCK),
		.CLKFB(W_PHASE0),
		.PSEN(1'b0),
		.PSCLK(1'b0),
		.PSINCDEC(1'b0),
		.RST(1'b0)
	);
	
	assign W_CLKL_MOD = W_PHASE0;
		
	BUFGMUX BUFGMUX_inst_1 (
		.O(W_MUX1), // Clock MUX output
		.I0(W_PHASE0), // Clock0 input
		.I1(W_PHASE90), // Clock1 input
		.S(CLK_MOD_PHASE_SEL1) // Clock select input
	);
	
	BUFGMUX BUFGMUX_inst_2(
		.O(W_MUX2), // Clock MUX output
		.I0(W_PHASE180), // Clock0 input
		.I1(W_PHASE270), // Clock1 input
		.S(CLK_MOD_PHASE_SEL1) // Clock select input
	);
	
	BUFGMUX BUFGMUX_inst_3(
		.O(W_TPNO_IN), // Clock MUX output
		.I0(W_MUX1), // Clock0 input
		.I1(W_MUX2), // Clock1 input
		.S(CLK_MOD_PHASE_SEL2) // Clock select input
	);
	
	twophase_nonoverlap tpno(
		.CLK_IN(W_TPNO_IN),
		.CLK_OUT(W_CLK_MOD),
		.CLK_OUT_N(W_CLKN_MOD)
	);
	
	ODDR2 #(
	.DDR_ALIGNMENT("NONE"), // Sets output alignment to "NONE", "C0" or "C1"
	.INIT(1'b0), // Sets initial state of the Q output to 1'b0 or 1'b1
	.SRTYPE("SYNC") // Specifies "SYNC" or "ASYNC" set/reset
	) ODDR2_CLK_MOD_buf (
	.Q(MBI_CLK_MOD), // 1-bit DDR output data
	.C0(~W_CLK_MOD), // 1-bit clock input
	.C1(W_CLK_MOD), // 1-bit clock input
	.CE(1'b1), // 1-bit clock enable input
	.D0(1'b0), // 1-bit data input (associated with C0)
	.D1(1'b1), // 1-bit data input (associated with C1)
	.R(1'b0), // 1-bit reset input
	.S(1'b0) // 1-bit set input
	);

	ODDR2 #(
	.DDR_ALIGNMENT("NONE"), // Sets output alignment to "NONE", "C0" or "C1"
	.INIT(1'b0), // Sets initial state of the Q output to 1'b0 or 1'b1
	.SRTYPE("SYNC") // Specifies "SYNC" or "ASYNC" set/reset
	) ODDR2_CLKN_MOD_buf (
	.Q(MBI_CLKN_MOD), // 1-bit DDR output data
	.C0(~W_CLKN_MOD), // 1-bit clock input
	.C1(W_CLKN_MOD), // 1-bit clock input
	.CE(1'b1), // 1-bit clock enable input
	.D0(1'b0), // 1-bit data input (associated with C0)
	.D1(1'b1), // 1-bit data input (associated with C1)
	.R(1'b0), // 1-bit reset input
	.S(1'b0) // 1-bit set input
	);
	
	ODDR2 #(
	.DDR_ALIGNMENT("NONE"), // Sets output alignment to "NONE", "C0" or "C1"
	.INIT(1'b0), // Sets initial state of the Q output to 1'b0 or 1'b1
	.SRTYPE("SYNC") // Specifies "SYNC" or "ASYNC" set/reset
	) ODDR2_CLKL_MOD_buf (
	.Q(MBI_CLKL_MOD), // 1-bit DDR output data
	.C0(~W_CLKL_MOD), // 1-bit clock input
	.C1(W_CLKL_MOD), // 1-bit clock input
	.CE(1'b1), // 1-bit clock enable input
	.D0(1'b0), // 1-bit data input (associated with C0)
	.D1(1'b1), // 1-bit data input (associated with C1)
	.R(1'b0), // 1-bit reset input
	.S(1'b0) // 1-bit set input
	);


endmodule
