`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:58:11 05/17/2017 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices:	Spartan 6 lx25t
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
	input 			USER_CLOCK,
	input	[2:0] 	W_FREQ_SEL,
	input [4:0]		W_PHASE_SEL,
	output 			MBI_CLK_MOD,
	output 			MBI_CLKN_MOD,
	output 			MBI_CLKL_MOD
	
//	input				OK_FIFO_WRITE,
//	input				OK_FIFO_DATA,
//	input				OK_FIFO_CLOCK
);
	
	wire				W_CLK_MOD;
	wire				W_CLKN_MOD;
	wire				W_CLKL_MOD;
	wire	[5:0]		W_FREQ;
	wire				W_SELECTED_FREQ;
	wire				W_FIFO_FULL;
	wire				W_FIFO_DATA;

	reg	[31:0]	SR_SET;
	reg				SR_RESET;
	reg	[5:0]		COUNT;
	reg				R_FIFO_READ;
	
//	always @ (posedge W_SELECTED_FREQ) begin
//		if (W_FIFO_FULL) begin
//			R_FIFO_READ <= 1;
//			COUNT <= 6'b011111;
//		end
//		else if (COUNT > 0) begin
//			SR_SET[COUNT] <= W_FIFO_DATA;	
//			COUNT <= COUNT - 1;
//			SR_RESET <= 1;
//		end
//		else begin
//			SR_RESET <= 0;
//			R_FIFO_READ <= 0;
//		end
//	end

//	dutychng_fifo dutychng (
//		.wr_clk(OK_FIFO_CLOCK),
//		.din(OK_FIFO_DATA),
//		.wr_en(OK_FIFO_WRITE),
//		.rd_clk(W_SELECTED_FREQ),
//		.dout(W_FIFO_DATA),
//		.rd_en(R_FIFO_READ),
//		.full(W_FIFO_FULL),
//		.rst(1'b0)
//	);
	
	freqchng_clkgen freqchng(
		.CLK_IN(USER_CLOCK),
		.RESET(1'b0),
		.LOCKED(LOCKED),
		.CLK_OUT_100khz(W_FREQ[0]),
		.CLK_OUT_200khz(W_FREQ[1]),
		.CLK_OUT_500khz(W_FREQ[2]),
		.CLK_OUT_1mhz(W_FREQ[3]),
		.CLK_OUT_2mhz(W_FREQ[4]),
		.CLK_OUT_4mhz(W_FREQ[5])
	);
	
	freqchng_mux freqmux(
		.FREQ_IN(W_FREQ),
		.FREQ_SEL(W_FREQ_SEL),
		.FREQ_OUT(W_SELECTED_FREQ)
	);
		
	shiftreg_nonoverlap_clkgen tpno (
		.CLK_IN(W_SELECTED_FREQ),
		.PHASE_SEL(W_PHASE_SEL),
		.RESET(SR_RESET),
		.CLK_OUT_MOD(W_CLK_MOD),
		.CLK_OUT_MODN(W_CLKN_MOD),
		.CLK_OUT_MODL(W_CLKL_MOD)
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
	
	//test
endmodule
