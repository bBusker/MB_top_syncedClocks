// file: freqchng_clkgen.v
// 
// (c) Copyright 2008 - 2011 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
//----------------------------------------------------------------------------
// User entered comments
//----------------------------------------------------------------------------
// None
//
//----------------------------------------------------------------------------
// "Output    Output      Phase     Duty      Pk-to-Pk        Phase"
// "Clock    Freq (MHz) (degrees) Cycle (%) Jitter (ps)  Error (ps)"
//----------------------------------------------------------------------------
// CLK_OUT1_____3.200______0.000______50.0______345.093____235.738
// CLK_OUT2_____6.349______0.000______50.0______301.292____235.738
// CLK_OUT3____16.000______0.000______50.0______250.390____235.738
// CLK_OUT4____30.769______0.000______50.0______219.322____235.738
// CLK_OUT5____66.667______0.000______50.0______187.234____235.738
// CLK_OUT6___133.333______0.000______50.0______163.191____235.738
//
//----------------------------------------------------------------------------
// "Input Clock   Freq (MHz)    Input Jitter (UI)"
//----------------------------------------------------------------------------
// __primary_________100.000____________0.010

`timescale 1ps/1ps

(* CORE_GENERATION_INFO = "freqchng_clkgen,clk_wiz_v3_6,{component_name=freqchng_clkgen,use_phase_alignment=true,use_min_o_jitter=false,use_max_i_jitter=false,use_dyn_phase_shift=false,use_inclk_switchover=false,use_dyn_reconfig=false,feedback_source=FDBK_AUTO,primtype_sel=PLL_BASE,num_out_clk=6,clkin1_period=10.0,clkin2_period=10.0,use_power_down=false,use_reset=true,use_locked=true,use_inclk_stopped=false,use_status=false,use_freeze=false,use_clk_valid=false,feedback_type=SINGLE,clock_mgr_type=MANUAL,manual_override=false}" *)
module freqchng_clkgen
 (// Clock in ports
  input         CLK_IN,
  // Clock out ports
  output        CLK_OUT_100khz,
  output        CLK_OUT_200khz,
  output        CLK_OUT_500khz,
  output        CLK_OUT_1mhz,
  output        CLK_OUT_2mhz,
  output        CLK_OUT_4mhz,
  // Status and control signals
  input         RESET,
  output        LOCKED
 );

  // Input buffering
  //------------------------------------
  BUFG clkin1_buf
   (.O (clkin1),
    .I (CLK_IN));

//	assign clkin1 = CLK_IN;

  // Clocking primitive
  //------------------------------------
  // Instantiation of the PLL primitive
  //    * Unused inputs are tied off
  //    * Unused outputs are labeled unused
  wire [15:0] do_unused;
  wire        drdy_unused;
  wire        clkfbout;
  wire        clkfbout_buf;

  PLL_BASE
  #(.BANDWIDTH              ("OPTIMIZED"),
    .CLK_FEEDBACK           ("CLKFBOUT"),
    .COMPENSATION           ("SYSTEM_SYNCHRONOUS"),
    .DIVCLK_DIVIDE          (1),
    .CLKFBOUT_MULT          (4),
    .CLKFBOUT_PHASE         (0.000),
    .CLKOUT0_DIVIDE         (125),
    .CLKOUT0_PHASE          (0.000),
    .CLKOUT0_DUTY_CYCLE     (0.500),
    .CLKOUT1_DIVIDE         (63),
    .CLKOUT1_PHASE          (0.000),
    .CLKOUT1_DUTY_CYCLE     (0.500),
    .CLKOUT2_DIVIDE         (25),
    .CLKOUT2_PHASE          (0.000),
    .CLKOUT2_DUTY_CYCLE     (0.500),
    .CLKOUT3_DIVIDE         (13),
    .CLKOUT3_PHASE          (0.000),
    .CLKOUT3_DUTY_CYCLE     (0.500),
    .CLKOUT4_DIVIDE         (6),
    .CLKOUT4_PHASE          (0.000),
    .CLKOUT4_DUTY_CYCLE     (0.500),
    .CLKOUT5_DIVIDE         (3),
    .CLKOUT5_PHASE          (0.000),
    .CLKOUT5_DUTY_CYCLE     (0.500),
    .CLKIN_PERIOD           (10.0),
    .REF_JITTER             (0.010))
  pll_base_inst
    // Output clocks
   (.CLKFBOUT              (clkfbout),
    .CLKOUT0               (clkout0),
    .CLKOUT1               (clkout1),
    .CLKOUT2               (clkout2),
    .CLKOUT3               (clkout3),
    .CLKOUT4               (clkout4),
    .CLKOUT5               (clkout5),
    // Status and control signals
    .LOCKED                (LOCKED),
    .RST                   (1'b0),
     // Input clock control
    .CLKFBIN               (clkfbout_buf),
    .CLKIN                 (clkin1));


  // Output buffering
  //-----------------------------------
  BUFG clkf_buf
   (.O (clkfbout_buf),
    .I (clkfbout));

//  BUFG clkout1_buf
//   (.O   (CLK_OUT_100khz),
//    .I   (clkout0));
//
//  BUFG clkout2_buf
//   (.O   (CLK_OUT_200khz),
//    .I   (clkout1));
//
//  BUFG clkout3_buf
//   (.O   (CLK_OUT_500khz),
//    .I   (clkout2));
//
//  BUFG clkout4_buf
//   (.O   (CLK_OUT_1mhz),
//    .I   (clkout3));
//
//  BUFG clkout5_buf
//   (.O   (CLK_OUT_2mhz),
//    .I   (clkout4));
//
//  BUFG clkout6_buf
//   (.O   (CLK_OUT_4mhz),
//    .I   (clkout5));

	assign CLK_OUT_100khz = clkout0;
	assign CLK_OUT_200khz = clkout1;
	assign CLK_OUT_500khz = clkout2;
	assign CLK_OUT_1mhz = clkout3;
	assign CLK_OUT_2mhz = clkout4;
	assign CLK_OUT_4mhz = clkout5;

endmodule
