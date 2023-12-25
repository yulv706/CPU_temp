// megafunction wizard: %ALTGXB%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: altgxb 

// ============================================================
// File Name: altpcie_serdes_1sgx_x4_15625.v
// Megafunction Name(s):
// 			altgxb
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 5.1 Build 176 10/26/2005 SJ Full Version
// ************************************************************


//Copyright (C) 1991-2005 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, Altera MegaCore Function License 
//Agreement, or other applicable license agreement, including, 
//without limitation, that your use is for the sole purpose of 
//programming logic devices manufactured by Altera and sold by 
//Altera or its authorized distributors.  Please refer to the 
//applicable agreement for further details.


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module altpcie_serdes_1sgx_x4_15625 (
	inclk,
	pll_areset,
	pllenable,
	rx_cruclk,
	rx_enacdet,
	rx_in,
	rxanalogreset,
	rxdigitalreset,
	tx_coreclk,
	tx_in,
	txdigitalreset,
	coreclk_out,
	pll_locked,
	rx_clkout,
	rx_freqlocked,
	rx_locked,
	rx_out,
	rx_patterndetect,
	rx_syncstatus,
	tx_out);

	input	[0:0]  inclk;
	input	[0:0]  pll_areset;
	input	[0:0]  pllenable;
	input	[0:0]  rx_cruclk;
	input	[3:0]  rx_enacdet;
	input	[3:0]  rx_in;
	input	[3:0]  rxanalogreset;
	input	[3:0]  rxdigitalreset;
	input	[3:0]  tx_coreclk;
	input	[79:0]  tx_in;
	input	[3:0]  txdigitalreset;
	output	[0:0]  coreclk_out;
	output	[0:0]  pll_locked;
	output	[3:0]  rx_clkout;
	output	[3:0]  rx_freqlocked;
	output	[3:0]  rx_locked;
	output	[79:0]  rx_out;
	output	[7:0]  rx_patterndetect;
	output	[7:0]  rx_syncstatus;
	output	[3:0]  tx_out;

	wire [7:0] sub_wire0;
	wire [3:0] sub_wire1;
	wire [79:0] sub_wire2;
	wire [0:0] sub_wire3;
	wire [3:0] sub_wire4;
	wire [3:0] sub_wire5;
	wire [3:0] sub_wire6;
	wire [7:0] sub_wire7;
	wire [0:0] sub_wire8;
	wire [7:0] rx_patterndetect = sub_wire0[7:0];
	wire [3:0] tx_out = sub_wire1[3:0];
	wire [79:0] rx_out = sub_wire2[79:0];
	wire [0:0] coreclk_out = sub_wire3[0:0];
	wire [3:0] rx_locked = sub_wire4[3:0];
	wire [3:0] rx_freqlocked = sub_wire5[3:0];
	wire [3:0] rx_clkout = sub_wire6[3:0];
	wire [7:0] rx_syncstatus = sub_wire7[7:0];
	wire [0:0] pll_locked = sub_wire8[0:0];

	altgxb	altgxb_component (
				.pll_areset (pll_areset),
				.rx_enacdet (rx_enacdet),
				.rx_cruclk (rx_cruclk),
				.pllenable (pllenable),
				.inclk (inclk),
				.rx_in (rx_in),
				.tx_in (tx_in),
				.rxanalogreset (rxanalogreset),
				.tx_coreclk (tx_coreclk),
				.rxdigitalreset (rxdigitalreset),
				.txdigitalreset (txdigitalreset),
				.rx_patterndetect (sub_wire0),
				.tx_out (sub_wire1),
				.rx_out (sub_wire2),
				.coreclk_out (sub_wire3),
				.rx_locked (sub_wire4),
				.rx_freqlocked (sub_wire5),
				.rx_clkout (sub_wire6),
				.rx_syncstatus (sub_wire7),
				.pll_locked (sub_wire8)
				// synopsys translate_off
				,
				.rx_we (),
				.rx_coreclk (),
				.rx_channelaligned (),
				.rx_bisterr (),
				.rx_slpbk (),
				.rx_aclr (),
				.rx_fifoalmostempty (),
				.tx_aclr (),
				.rx_bistdone (),
				.rx_signaldetect (),
				.tx_forcedisparity (),
				.tx_vodctrl (),
				.rx_equalizerctrl (),
				.rx_a1a2size (),
				.tx_srlpbk (),
				.rx_errdetect (),
				.rx_re (),
				.rx_disperr (),
				.rx_locktodata (),
				.tx_preemphasisctrl (),
				.rx_rlv (),
				.rx_fifoalmostfull (),
				.rx_bitslip (),
				.rx_a1a2sizeout (),
				.rx_locktorefclk (),
				.rx_ctrldetect (),
				.tx_ctrlenable ()
				// synopsys translate_on
				);
	defparam
		altgxb_component.align_pattern = "P0101111100",
		altgxb_component.align_pattern_length = 10,
		altgxb_component.allow_gxb_merging = "OFF",
		altgxb_component.channel_width = 20,
		altgxb_component.clk_out_mode_reference = "ON",
		altgxb_component.consider_enable_tx_8b_10b_i1i2_generation = "ON",
		altgxb_component.consider_instantiate_transmitter_pll_param = "ON",
		altgxb_component.cru_inclock_period = 6400,
		altgxb_component.data_rate = 2500,
		altgxb_component.data_rate_remainder = 0,
		altgxb_component.disparity_mode = "ON",
		altgxb_component.dwidth_factor = 2,
		altgxb_component.enable_tx_8b_10b_i1i2_generation = "OFF",
		altgxb_component.equalizer_ctrl_setting = 20,
		altgxb_component.flip_rx_out = "OFF",
		altgxb_component.flip_tx_in = "OFF",
		altgxb_component.force_disparity_mode = "OFF",
		altgxb_component.for_engineering_sample_device = "OFF",
		altgxb_component.instantiate_transmitter_pll = "ON",
		altgxb_component.intended_device_family = "Stratix GX",
		altgxb_component.loopback_mode = "NONE",
		altgxb_component.lpm_type = "altgxb",
		altgxb_component.number_of_channels = 4,
		altgxb_component.number_of_quads = 1,
		altgxb_component.operation_mode = "DUPLEX",
		altgxb_component.pll_bandwidth_type = "LOW",
		altgxb_component.pll_inclock_period = 6400,
		altgxb_component.preemphasis_ctrl_setting = 10,
		altgxb_component.protocol = "CUSTOM",
		altgxb_component.reverse_loopback_mode = "NONE",
		altgxb_component.run_length_enable = "OFF",
		altgxb_component.rx_bandwidth_type = "NEW_LOW",
		altgxb_component.rx_data_rate = 2500,
		altgxb_component.rx_data_rate_remainder = 0,
		altgxb_component.rx_enable_dc_coupling = "OFF",
		altgxb_component.rx_force_signal_detect = "ON",
		altgxb_component.rx_ppm_setting = 1000,
		altgxb_component.signal_threshold_select = 530,
		altgxb_component.tx_termination = 2,
		altgxb_component.use_8b_10b_mode = "OFF",
		altgxb_component.use_auto_bit_slip = "ON",
		altgxb_component.use_channel_align = "OFF",
		altgxb_component.use_double_data_mode = "ON",
		altgxb_component.use_equalizer_ctrl_signal = "OFF",
		altgxb_component.use_generic_fifo = "OFF",
		altgxb_component.use_preemphasis_ctrl_signal = "OFF",
		altgxb_component.use_rate_match_fifo = "OFF",
		altgxb_component.use_rx_clkout = "ON",
		altgxb_component.use_rx_coreclk = "OFF",
		altgxb_component.use_rx_cruclk = "ON",
		altgxb_component.use_self_test_mode = "OFF",
		altgxb_component.use_symbol_align = "ON",
		altgxb_component.use_tx_coreclk = "ON",
		altgxb_component.use_vod_ctrl_signal = "OFF",
		altgxb_component.vod_ctrl_setting = 800;


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: ADD_GENERIC_FIFO_WE_SYNCH_REGISTER STRING "0"
// Retrieval info: PRIVATE: ALIGN_PATTERN STRING "0101111100"
// Retrieval info: PRIVATE: ALIGN_PATTERN_LENGTH STRING "10"
// Retrieval info: PRIVATE: CHANNEL_WIDTH STRING "20"
// Retrieval info: PRIVATE: CLK_OUT_MODE_REFERENCE STRING "1"
// Retrieval info: PRIVATE: DEV_FAMILY STRING "Stratix GX"
// Retrieval info: PRIVATE: ENABLE_TX_8B_10B_I1I2_GENERATION STRING "0"
// Retrieval info: PRIVATE: EQU_SETTING STRING "2"
// Retrieval info: PRIVATE: FLIP_ALIGN_PATTERN STRING "0"
// Retrieval info: PRIVATE: FLIP_RX_OUT STRING "0"
// Retrieval info: PRIVATE: FLIP_TX_IN STRING "0"
// Retrieval info: PRIVATE: FOR_ENGINEERING_SAMPLE_DEVICE STRING "0"
// Retrieval info: PRIVATE: GXB_QUAD_MERGE STRING "0"
// Retrieval info: PRIVATE: INFINIBAND_INVALID_CODE STRING "0"
// Retrieval info: PRIVATE: INSTANTIATE_TRANSMITTER_PLL STRING "1"
// Retrieval info: PRIVATE: LOOPBACK_MODE NUMERIC "0"
// Retrieval info: PRIVATE: MEGAFN_PORT_INFO_0 STRING "inclk;pll_areset;rx_in;rx_coreclk;rx_cruclk"
// Retrieval info: PRIVATE: MEGAFN_PORT_INFO_1 STRING "rx_aclr;rx_bitslip;rx_enacdet;rx_we;rx_re"
// Retrieval info: PRIVATE: MEGAFN_PORT_INFO_2 STRING "rx_slpbk;rx_a1a2size;rx_equalizerctrl;rx_locktorefclk;rx_locktodata"
// Retrieval info: PRIVATE: MEGAFN_PORT_INFO_3 STRING "tx_in;tx_coreclk;tx_aclr;tx_ctrlenable;tx_forcedisparity"
// Retrieval info: PRIVATE: MEGAFN_PORT_INFO_4 STRING "tx_srlpbk;tx_vodctrl;tx_preemphasisctrl;txdigitalreset;rxdigitalreset"
// Retrieval info: PRIVATE: MEGAFN_PORT_INFO_5 STRING "rxanalogreset;pllenable;pll_locked;coreclk_out;rx_out"
// Retrieval info: PRIVATE: MEGAFN_PORT_INFO_6 STRING "rx_clkout;rx_locked;rx_freqlocked;rx_rlv;rx_syncstatus"
// Retrieval info: PRIVATE: MEGAFN_PORT_INFO_7 STRING "rx_patterndetect;rx_ctrldetect;rx_errdetect;rx_disperr;rx_signaldetect"
// Retrieval info: PRIVATE: MEGAFN_PORT_INFO_8 STRING "rx_fifoalmostempty;rx_fifoalmostfull;rx_channelaligned;rx_bisterr;rx_bistdone"
// Retrieval info: PRIVATE: MEGAFN_PORT_INFO_9 STRING "rx_a1a2sizeout;tx_out"
// Retrieval info: PRIVATE: NUMBER_OF_CHANNELS STRING "4"
// Retrieval info: PRIVATE: OP_MODE STRING "Duplex"
// Retrieval info: PRIVATE: PLL_ACLR STRING "1"
// Retrieval info: PRIVATE: PLL_BANDWIDTH_TYPE STRING "LOW"
// Retrieval info: PRIVATE: PLL_DC_COUPLING STRING "1"
// Retrieval info: PRIVATE: PLL_ENABLE STRING "1"
// Retrieval info: PRIVATE: PLL_LOCKED STRING "1"
// Retrieval info: PRIVATE: PREEMPHASIS_SETTING STRING "2"
// Retrieval info: PRIVATE: PREEMPHASIS_SIGNAL STRING "0"
// Retrieval info: PRIVATE: PROTOCOL STRING "CUSTOM"
// Retrieval info: PRIVATE: REVERSE_LOOPBACK_MODE NUMERIC "0"
// Retrieval info: PRIVATE: RLV STRING "5"
// Retrieval info: PRIVATE: RX_A1A2 STRING "0"
// Retrieval info: PRIVATE: RX_A1A2SIZEOUT STRING "0"
// Retrieval info: PRIVATE: RX_BANDWIDTH_TYPE STRING "LOW"
// Retrieval info: PRIVATE: RX_BASE_INPUT_TYPE STRING ""
// Retrieval info: PRIVATE: RX_BISTDONE STRING "0"
// Retrieval info: PRIVATE: RX_BISTERR STRING "0"
// Retrieval info: PRIVATE: RX_BITSLIP STRING "0"
// Retrieval info: PRIVATE: RX_CLKOUT STRING "1"
// Retrieval info: PRIVATE: RX_CLR STRING "1"
// Retrieval info: PRIVATE: RX_CTRLDETECT STRING "0"
// Retrieval info: PRIVATE: RX_DATA_RATE STRING "2500.00"
// Retrieval info: PRIVATE: RX_DISPERR STRING "0"
// Retrieval info: PRIVATE: RX_ENACDET STRING "1"
// Retrieval info: PRIVATE: RX_ERRDETECT STRING "0"
// Retrieval info: PRIVATE: RX_FIFOALMOSTEMPTY STRING "0"
// Retrieval info: PRIVATE: RX_FIFOALMOSTFULL STRING "0"
// Retrieval info: PRIVATE: RX_FIFOEMPTY STRING "0"
// Retrieval info: PRIVATE: RX_FIFOFULL STRING "0"
// Retrieval info: PRIVATE: RX_FORCE_SIGNAL_DETECT STRING "1"
// Retrieval info: PRIVATE: RX_FREQLOCKED STRING "1"
// Retrieval info: PRIVATE: RX_FREQUENCY STRING "156.25"
// Retrieval info: PRIVATE: RX_LOCKED STRING "1"
// Retrieval info: PRIVATE: RX_LOCKTODATA STRING "0"
// Retrieval info: PRIVATE: RX_LOCKTOREFCLK STRING "0"
// Retrieval info: PRIVATE: RX_PATTERNDETECT STRING "1"
// Retrieval info: PRIVATE: RX_PPM_SETTING STRING "1000"
// Retrieval info: PRIVATE: RX_SIGDET STRING "0"
// Retrieval info: PRIVATE: RX_SYNCSTATUS STRING "1"
// Retrieval info: PRIVATE: SELF_TEST_MODE NUMERIC "-1"
// Retrieval info: PRIVATE: SIGNAL_THRESHOLD_SELECT STRING "530"
// Retrieval info: PRIVATE: TX_BASE_INPUT_TYPE STRING ""
// Retrieval info: PRIVATE: TX_CLR STRING "1"
// Retrieval info: PRIVATE: TX_DATA_RATE STRING "2500.00"
// Retrieval info: PRIVATE: TX_FORCE_DISPARITY STRING "0"
// Retrieval info: PRIVATE: TX_FREQUENCY STRING "156.25"
// Retrieval info: PRIVATE: TX_PLL_LOCKED STRING "1"
// Retrieval info: PRIVATE: TX_TERMINATION STRING "100"
// Retrieval info: PRIVATE: USE_8B10B_DECODER STRING "0"
// Retrieval info: PRIVATE: USE_8B10B_ENCODER STRING "0"
// Retrieval info: PRIVATE: USE_8B_10B_MODE STRING "OFF"
// Retrieval info: PRIVATE: USE_AUTO_BIT_SLIP NUMERIC "1"
// Retrieval info: PRIVATE: USE_CRUCLK_FROM_PLL STRING "1"
// Retrieval info: PRIVATE: USE_DC_COUPLING STRING "0"
// Retrieval info: PRIVATE: USE_EQUALIZER STRING "0"
// Retrieval info: PRIVATE: USE_EXTERNAL_TX_TERMINATION STRING "0"
// Retrieval info: PRIVATE: USE_GENERIC_FIFO STRING "0"
// Retrieval info: PRIVATE: USE_RATE_MATCH_FIFO STRING "0"
// Retrieval info: PRIVATE: USE_RLV STRING "0"
// Retrieval info: PRIVATE: USE_RX_CORECLK STRING "0"
// Retrieval info: PRIVATE: USE_RX_CRUCLK STRING "1"
// Retrieval info: PRIVATE: USE_TX_CORECLK STRING "1"
// Retrieval info: PRIVATE: VERSION STRING "4.0"
// Retrieval info: PRIVATE: VOD_SETTING STRING "800"
// Retrieval info: PRIVATE: VOD_SIGNAL STRING "0"
// Retrieval info: PRIVATE: XGM_RXANALOGRESET STRING "1"
// Retrieval info: LIBRARY: altgxb altgxb.all
// Retrieval info: CONSTANT: ALIGN_PATTERN STRING "P0101111100"
// Retrieval info: CONSTANT: ALIGN_PATTERN_LENGTH NUMERIC "10"
// Retrieval info: CONSTANT: ALLOW_GXB_MERGING STRING "OFF"
// Retrieval info: CONSTANT: CHANNEL_WIDTH NUMERIC "20"
// Retrieval info: CONSTANT: CLK_OUT_MODE_REFERENCE STRING "ON"
// Retrieval info: CONSTANT: CONSIDER_ENABLE_TX_8B_10B_I1I2_GENERATION STRING "ON"
// Retrieval info: CONSTANT: CONSIDER_INSTANTIATE_TRANSMITTER_PLL_PARAM STRING "ON"
// Retrieval info: CONSTANT: CRU_INCLOCK_PERIOD NUMERIC "6400"
// Retrieval info: CONSTANT: DATA_RATE NUMERIC "2500"
// Retrieval info: CONSTANT: DATA_RATE_REMAINDER NUMERIC "0"
// Retrieval info: CONSTANT: DISPARITY_MODE STRING "ON"
// Retrieval info: CONSTANT: DWIDTH_FACTOR NUMERIC "2"
// Retrieval info: CONSTANT: ENABLE_TX_8B_10B_I1I2_GENERATION STRING "OFF"
// Retrieval info: CONSTANT: EQUALIZER_CTRL_SETTING NUMERIC "20"
// Retrieval info: CONSTANT: FLIP_RX_OUT STRING "OFF"
// Retrieval info: CONSTANT: FLIP_TX_IN STRING "OFF"
// Retrieval info: CONSTANT: FORCE_DISPARITY_MODE STRING "OFF"
// Retrieval info: CONSTANT: FOR_ENGINEERING_SAMPLE_DEVICE STRING "OFF"
// Retrieval info: CONSTANT: INSTANTIATE_TRANSMITTER_PLL STRING "ON"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Stratix GX"
// Retrieval info: CONSTANT: LOOPBACK_MODE STRING "NONE"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altgxb"
// Retrieval info: CONSTANT: NUMBER_OF_CHANNELS NUMERIC "4"
// Retrieval info: CONSTANT: NUMBER_OF_QUADS NUMERIC "1"
// Retrieval info: CONSTANT: OPERATION_MODE STRING "DUPLEX"
// Retrieval info: CONSTANT: PLL_BANDWIDTH_TYPE STRING "LOW"
// Retrieval info: CONSTANT: PLL_INCLOCK_PERIOD NUMERIC "6400"
// Retrieval info: CONSTANT: PREEMPHASIS_CTRL_SETTING NUMERIC "10"
// Retrieval info: CONSTANT: PROTOCOL STRING "CUSTOM"
// Retrieval info: CONSTANT: REVERSE_LOOPBACK_MODE STRING "NONE"
// Retrieval info: CONSTANT: RUN_LENGTH_ENABLE STRING "OFF"
// Retrieval info: CONSTANT: RX_BANDWIDTH_TYPE STRING "NEW_LOW"
// Retrieval info: CONSTANT: RX_DATA_RATE NUMERIC "2500"
// Retrieval info: CONSTANT: RX_DATA_RATE_REMAINDER NUMERIC "0"
// Retrieval info: CONSTANT: RX_ENABLE_DC_COUPLING STRING "OFF"
// Retrieval info: CONSTANT: RX_FORCE_SIGNAL_DETECT STRING "ON"
// Retrieval info: CONSTANT: RX_PPM_SETTING NUMERIC "1000"
// Retrieval info: CONSTANT: SIGNAL_THRESHOLD_SELECT NUMERIC "530"
// Retrieval info: CONSTANT: TX_TERMINATION NUMERIC "2"
// Retrieval info: CONSTANT: USE_8B_10B_MODE STRING "OFF"
// Retrieval info: CONSTANT: USE_AUTO_BIT_SLIP STRING "ON"
// Retrieval info: CONSTANT: USE_CHANNEL_ALIGN STRING "OFF"
// Retrieval info: CONSTANT: USE_DOUBLE_DATA_MODE STRING "ON"
// Retrieval info: CONSTANT: USE_EQUALIZER_CTRL_SIGNAL STRING "OFF"
// Retrieval info: CONSTANT: USE_GENERIC_FIFO STRING "OFF"
// Retrieval info: CONSTANT: USE_PREEMPHASIS_CTRL_SIGNAL STRING "OFF"
// Retrieval info: CONSTANT: USE_RATE_MATCH_FIFO STRING "OFF"
// Retrieval info: CONSTANT: USE_RX_CLKOUT STRING "ON"
// Retrieval info: CONSTANT: USE_RX_CORECLK STRING "OFF"
// Retrieval info: CONSTANT: USE_RX_CRUCLK STRING "ON"
// Retrieval info: CONSTANT: USE_SELF_TEST_MODE STRING "OFF"
// Retrieval info: CONSTANT: USE_SYMBOL_ALIGN STRING "ON"
// Retrieval info: CONSTANT: USE_TX_CORECLK STRING "ON"
// Retrieval info: CONSTANT: USE_VOD_CTRL_SIGNAL STRING "OFF"
// Retrieval info: CONSTANT: VOD_CTRL_SETTING NUMERIC "800"
// Retrieval info: USED_PORT: coreclk_out 0 0 1 0 OUTPUT NODEFVAL "coreclk_out[0..0]"
// Retrieval info: USED_PORT: inclk 0 0 1 0 INPUT GND "inclk[0..0]"
// Retrieval info: USED_PORT: pll_areset 0 0 1 0 INPUT GND "pll_areset[0..0]"
// Retrieval info: USED_PORT: pll_locked 0 0 1 0 OUTPUT NODEFVAL "pll_locked[0..0]"
// Retrieval info: USED_PORT: pllenable 0 0 1 0 INPUT VCC "pllenable[0..0]"
// Retrieval info: USED_PORT: rx_clkout 0 0 4 0 OUTPUT NODEFVAL "rx_clkout[3..0]"
// Retrieval info: USED_PORT: rx_cruclk 0 0 1 0 INPUT GND "rx_cruclk[0..0]"
// Retrieval info: USED_PORT: rx_enacdet 0 0 4 0 INPUT GND "rx_enacdet[3..0]"
// Retrieval info: USED_PORT: rx_freqlocked 0 0 4 0 OUTPUT NODEFVAL "rx_freqlocked[3..0]"
// Retrieval info: USED_PORT: rx_in 0 0 4 0 INPUT GND "rx_in[3..0]"
// Retrieval info: USED_PORT: rx_locked 0 0 4 0 OUTPUT NODEFVAL "rx_locked[3..0]"
// Retrieval info: USED_PORT: rx_out 0 0 80 0 OUTPUT NODEFVAL "rx_out[79..0]"
// Retrieval info: USED_PORT: rx_patterndetect 0 0 8 0 OUTPUT NODEFVAL "rx_patterndetect[7..0]"
// Retrieval info: USED_PORT: rx_syncstatus 0 0 8 0 OUTPUT NODEFVAL "rx_syncstatus[7..0]"
// Retrieval info: USED_PORT: rxanalogreset 0 0 4 0 INPUT GND "rxanalogreset[3..0]"
// Retrieval info: USED_PORT: rxdigitalreset 0 0 4 0 INPUT GND "rxdigitalreset[3..0]"
// Retrieval info: USED_PORT: tx_coreclk 0 0 4 0 INPUT GND "tx_coreclk[3..0]"
// Retrieval info: USED_PORT: tx_in 0 0 80 0 INPUT GND "tx_in[79..0]"
// Retrieval info: USED_PORT: tx_out 0 0 4 0 OUTPUT NODEFVAL "tx_out[3..0]"
// Retrieval info: USED_PORT: txdigitalreset 0 0 4 0 INPUT GND "txdigitalreset[3..0]"
// Retrieval info: CONNECT: rx_patterndetect 0 0 8 0 @rx_patterndetect 0 0 8 0
// Retrieval info: CONNECT: @pllenable 0 0 1 0 pllenable 0 0 1 0
// Retrieval info: CONNECT: rx_locked 0 0 4 0 @rx_locked 0 0 4 0
// Retrieval info: CONNECT: @pll_areset 0 0 1 0 pll_areset 0 0 1 0
// Retrieval info: CONNECT: @txdigitalreset 0 0 4 0 txdigitalreset 0 0 4 0
// Retrieval info: CONNECT: @rx_in 0 0 4 0 rx_in 0 0 4 0
// Retrieval info: CONNECT: coreclk_out 0 0 1 0 @coreclk_out 0 0 1 0
// Retrieval info: CONNECT: @tx_coreclk 0 0 4 0 tx_coreclk 0 0 4 0
// Retrieval info: CONNECT: tx_out 0 0 4 0 @tx_out 0 0 4 0
// Retrieval info: CONNECT: @inclk 0 0 1 0 inclk 0 0 1 0
// Retrieval info: CONNECT: rx_syncstatus 0 0 8 0 @rx_syncstatus 0 0 8 0
// Retrieval info: CONNECT: rx_out 0 0 80 0 @rx_out 0 0 80 0
// Retrieval info: CONNECT: rx_clkout 0 0 4 0 @rx_clkout 0 0 4 0
// Retrieval info: CONNECT: @rxdigitalreset 0 0 4 0 rxdigitalreset 0 0 4 0
// Retrieval info: CONNECT: @rx_cruclk 0 0 1 0 rx_cruclk 0 0 1 0
// Retrieval info: CONNECT: pll_locked 0 0 1 0 @pll_locked 0 0 1 0
// Retrieval info: CONNECT: @rxanalogreset 0 0 4 0 rxanalogreset 0 0 4 0
// Retrieval info: CONNECT: rx_freqlocked 0 0 4 0 @rx_freqlocked 0 0 4 0
// Retrieval info: CONNECT: @rx_enacdet 0 0 4 0 rx_enacdet 0 0 4 0
// Retrieval info: CONNECT: @tx_in 0 0 80 0 tx_in 0 0 80 0
// Retrieval info: GEN_FILE: TYPE_NORMAL altpcie_serdes_1sgx_x4_15625.v TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL altpcie_serdes_1sgx_x4_15625.inc FALSE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL altpcie_serdes_1sgx_x4_15625.cmp FALSE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL altpcie_serdes_1sgx_x4_15625.bsf FALSE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL altpcie_serdes_1sgx_x4_15625_inst.v FALSE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL altpcie_serdes_1sgx_x4_15625_bb.v FALSE FALSE
