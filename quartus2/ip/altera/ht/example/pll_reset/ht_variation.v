// megafunction wizard: %HT v9.0%

// ============================================================
// Megafunction Name(s):
// 			ht_ec8
// ============================================================
// Generated by HT 1.3.1 [Altera, IP Toolbench v1.2.6 build11]
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
// ************************************************************
// Copyright (C) 1991-2004 Altera Corporation
// Any megafunction design, and related net list (encrypted or decrypted),
// support information, device programming or simulation file, and any other
// associated documentation or information provided by Altera or a partner
// under Altera's Megafunction Partnership Program may be used only to
// program PLD devices (but not masked PLD devices) from Altera.  Any other
// use of such megafunction design, net list, support information, device
// programming or simulation file, or any other related documentation or
// information is prohibited for any other purpose, including, but not
// limited to modification, reverse engineering, de-compiling, or use with
// any other silicon devices, unless such use is explicitly licensed under
// a separate agreement with Altera or a megafunction partner.  Title to
// the intellectual property, including patents, copyrights, trademarks,
// trade secrets, or maskworks, embodied in any such megafunction design,
// net list, support information, device programming or simulation file, or
// any other related documentation or information provided by Altera or a
// megafunction partner, remains with Altera, the megafunction partner, or
// their respective licensors.  No other licenses, including any licenses
// needed under any third party's intellectual property, are provided herein.


module ht_variation (
	Rstn,
	PwrOk,
	RxPllAreset_i,
	TxPllAreset_i,
	RxCAD_i,
	RxCTL_i,
	RxClk_i,
	RxNpEna_i,
	RxPEna_i,
	RxREna_i,
	TxNpDat_i,
	TxNpMty_i,
	TxNpDatEna_i,
	TxNpSop_i,
	TxNpEop_i,
	TxPDat_i,
	TxPMty_i,
	TxPDatEna_i,
	TxPSop_i,
	TxPEop_i,
	TxRDat_i,
	TxRMty_i,
	TxRDatEna_i,
	TxRSop_i,
	TxREop_i,
	RespErr_i,
	SignaledTabrt_i,
	RefClkWrmRst,
	RefClkCldRst,
	RxLnkClkD4,
	RxLnkClkD4Locked_o,
	TxCAD_o,
	TxCTL_o,
	TxClk_o,
	RxNpDat_o,
	RxNpVal_o,
	RxNpDav_o,
	RxNpSop_o,
	RxNpEop_o,
	RxNpMty_o,
	RxNpBarHit_o,
	RxPDat_o,
	RxPVal_o,
	RxPDav_o,
	RxPSop_o,
	RxPEop_o,
	RxPMty_o,
	RxPBarHit_o,
	RxRDat_o,
	RxRVal_o,
	RxRDav_o,
	RxRSop_o,
	RxREop_o,
	RxRMty_o,
	TxNpDav_o,
	TxNpWrRjct_o,
	TxPDav_o,
	TxPWrRjct_o,
	TxRDav_o,
	TxRWrRjct_o,
	CsrCmdReg_o,
	CsrCapCmdReg_o,
	CsrStatReg_o,
	CsrCapLnk0CtrlReg_o,
	CsrCapLnk1CtrlReg_o,
	CsrCapLnk0CfgReg_o,
	CsrCapLnk1CfgReg_o,
	CsrCapFtrReg_o,
	CsrCapLnk0ErrReg_o,
	CsrCapLnk1ErrReg_o,
	CsrCapErrHndlngReg_o,
	Bar0Reg_o,
	Bar1Reg_o,
	Bar2Reg_o,
	Bar3Reg_o,
	Bar4Reg_o,
	Bar5Reg_o,
	ClmdRCmdBufOvrFlwErr_o,
	ClmdPCmdBufOvrFlwErr_o,
	ClmdNPCmdBufOvrFlwErr_o);


	input		Rstn;
	input		PwrOk;
	input		RxPllAreset_i;
	input		TxPllAreset_i;
	input	[7:0]	RxCAD_i;
	input		RxCTL_i;
	input		RxClk_i;
	input		RxNpEna_i;
	input		RxPEna_i;
	input		RxREna_i;
	input	[63:0]	TxNpDat_i;
	input	[2:0]	TxNpMty_i;
	input		TxNpDatEna_i;
	input		TxNpSop_i;
	input		TxNpEop_i;
	input	[63:0]	TxPDat_i;
	input	[2:0]	TxPMty_i;
	input		TxPDatEna_i;
	input		TxPSop_i;
	input		TxPEop_i;
	input	[63:0]	TxRDat_i;
	input	[2:0]	TxRMty_i;
	input		TxRDatEna_i;
	input		TxRSop_i;
	input		TxREop_i;
	input		RespErr_i;
	input		SignaledTabrt_i;
	output		RefClkWrmRst;
	output		RefClkCldRst;
	output		RxLnkClkD4;
	output		RxLnkClkD4Locked_o;
	output	[7:0]	TxCAD_o;
	output		TxCTL_o;
	output		TxClk_o;
	output	[63:0]	RxNpDat_o;
	output		RxNpVal_o;
	output		RxNpDav_o;
	output		RxNpSop_o;
	output		RxNpEop_o;
	output	[2:0]	RxNpMty_o;
	output	[2:0]	RxNpBarHit_o;
	output	[63:0]	RxPDat_o;
	output		RxPVal_o;
	output		RxPDav_o;
	output		RxPSop_o;
	output		RxPEop_o;
	output	[2:0]	RxPMty_o;
	output	[2:0]	RxPBarHit_o;
	output	[63:0]	RxRDat_o;
	output		RxRVal_o;
	output		RxRDav_o;
	output		RxRSop_o;
	output		RxREop_o;
	output	[2:0]	RxRMty_o;
	output		TxNpDav_o;
	output		TxNpWrRjct_o;
	output		TxPDav_o;
	output		TxPWrRjct_o;
	output		TxRDav_o;
	output		TxRWrRjct_o;
	output	[15:0]	CsrCmdReg_o;
	output	[15:0]	CsrCapCmdReg_o;
	output	[15:0]	CsrStatReg_o;
	output	[15:0]	CsrCapLnk0CtrlReg_o;
	output	[15:0]	CsrCapLnk1CtrlReg_o;
	output	[15:0]	CsrCapLnk0CfgReg_o;
	output	[15:0]	CsrCapLnk1CfgReg_o;
	output	[7:0]	CsrCapFtrReg_o;
	output	[3:0]	CsrCapLnk0ErrReg_o;
	output	[3:0]	CsrCapLnk1ErrReg_o;
	output	[15:0]	CsrCapErrHndlngReg_o;
	output	[31:0]	Bar0Reg_o;
	output	[31:0]	Bar1Reg_o;
	output	[31:0]	Bar2Reg_o;
	output	[31:0]	Bar3Reg_o;
	output	[31:0]	Bar4Reg_o;
	output	[31:0]	Bar5Reg_o;
	output		ClmdRCmdBufOvrFlwErr_o;
	output		ClmdPCmdBufOvrFlwErr_o;
	output		ClmdNPCmdBufOvrFlwErr_o;

	wire signal_wire0 = 1'b0;

	ht_ec8	ht_ec8_inst(
		.Rstn(Rstn),
		.PwrOk(PwrOk),
		.RefClk(signal_wire0),
		.RxPllAreset_i(RxPllAreset_i),
		.TxPllAreset_i(TxPllAreset_i),
		.RxCAD_i(RxCAD_i),
		.RxCTL_i(RxCTL_i),
		.RxClk_i(RxClk_i),
		.RxNpEna_i(RxNpEna_i),
		.RxPEna_i(RxPEna_i),
		.RxREna_i(RxREna_i),
		.TxNpDat_i(TxNpDat_i),
		.TxNpMty_i(TxNpMty_i),
		.TxNpDatEna_i(TxNpDatEna_i),
		.TxNpSop_i(TxNpSop_i),
		.TxNpEop_i(TxNpEop_i),
		.TxPDat_i(TxPDat_i),
		.TxPMty_i(TxPMty_i),
		.TxPDatEna_i(TxPDatEna_i),
		.TxPSop_i(TxPSop_i),
		.TxPEop_i(TxPEop_i),
		.TxRDat_i(TxRDat_i),
		.TxRMty_i(TxRMty_i),
		.TxRDatEna_i(TxRDatEna_i),
		.TxRSop_i(TxRSop_i),
		.TxREop_i(TxREop_i),
		.RespErr_i(RespErr_i),
		.SignaledTabrt_i(SignaledTabrt_i),
		.RefClkWrmRst(RefClkWrmRst),
		.RefClkCldRst(RefClkCldRst),
		.RxLnkClkD4(RxLnkClkD4),
		.RxLnkClkD4Locked_o(RxLnkClkD4Locked_o),
		.TxCAD_o(TxCAD_o),
		.TxCTL_o(TxCTL_o),
		.TxClk_o(TxClk_o),
		.RxNpDat_o(RxNpDat_o),
		.RxNpVal_o(RxNpVal_o),
		.RxNpDav_o(RxNpDav_o),
		.RxNpSop_o(RxNpSop_o),
		.RxNpEop_o(RxNpEop_o),
		.RxNpMty_o(RxNpMty_o),
		.RxNpBarHit_o(RxNpBarHit_o),
		.RxPDat_o(RxPDat_o),
		.RxPVal_o(RxPVal_o),
		.RxPDav_o(RxPDav_o),
		.RxPSop_o(RxPSop_o),
		.RxPEop_o(RxPEop_o),
		.RxPMty_o(RxPMty_o),
		.RxPBarHit_o(RxPBarHit_o),
		.RxRDat_o(RxRDat_o),
		.RxRVal_o(RxRVal_o),
		.RxRDav_o(RxRDav_o),
		.RxRSop_o(RxRSop_o),
		.RxREop_o(RxREop_o),
		.RxRMty_o(RxRMty_o),
		.TxNpDav_o(TxNpDav_o),
		.TxNpWrRjct_o(TxNpWrRjct_o),
		.TxPDav_o(TxPDav_o),
		.TxPWrRjct_o(TxPWrRjct_o),
		.TxRDav_o(TxRDav_o),
		.TxRWrRjct_o(TxRWrRjct_o),
		.CsrCmdReg_o(CsrCmdReg_o),
		.CsrCapCmdReg_o(CsrCapCmdReg_o),
		.CsrStatReg_o(CsrStatReg_o),
		.CsrCapLnk0CtrlReg_o(CsrCapLnk0CtrlReg_o),
		.CsrCapLnk1CtrlReg_o(CsrCapLnk1CtrlReg_o),
		.CsrCapLnk0CfgReg_o(CsrCapLnk0CfgReg_o),
		.CsrCapLnk1CfgReg_o(CsrCapLnk1CfgReg_o),
		.CsrCapFtrReg_o(CsrCapFtrReg_o),
		.CsrCapLnk0ErrReg_o(CsrCapLnk0ErrReg_o),
		.CsrCapLnk1ErrReg_o(CsrCapLnk1ErrReg_o),
		.CsrCapErrHndlngReg_o(CsrCapErrHndlngReg_o),
		.Bar0Reg_o(Bar0Reg_o),
		.Bar1Reg_o(Bar1Reg_o),
		.Bar2Reg_o(Bar2Reg_o),
		.Bar3Reg_o(Bar3Reg_o),
		.Bar4Reg_o(Bar4Reg_o),
		.Bar5Reg_o(Bar5Reg_o),
		.ClmdRCmdBufOvrFlwErr_o(ClmdRCmdBufOvrFlwErr_o),
		.ClmdPCmdBufOvrFlwErr_o(ClmdPCmdBufOvrFlwErr_o),
		.ClmdNPCmdBufOvrFlwErr_o(ClmdNPCmdBufOvrFlwErr_o));

	defparam
		ht_ec8_inst.intended_device_family = "Stratix",
		ht_ec8_inst.CLKDMN = 1,
		ht_ec8_inst.HT_TX_CLK_PERIOD = 2500,
		ht_ec8_inst.HT_RX_CLK_PERIOD = 2500,
		ht_ec8_inst.RxRBufNum = 8,
		ht_ec8_inst.RxPBufNum = 8,
		ht_ec8_inst.RxNpBufNum = 8,
		ht_ec8_inst.VendorId = 16'h1172,
		ht_ec8_inst.DeviceId = 16'hCCCC,
		ht_ec8_inst.SubSystemId = 16'h0000,
		ht_ec8_inst.SubSystemVendId = 16'h0000,
		ht_ec8_inst.RevisionId = 8'h00,
		ht_ec8_inst.ClassCode = 24'h050000,
		ht_ec8_inst.BAR0MatchMask = 32'hFFFE0000,
		ht_ec8_inst.BAR0AndMask = 32'hFFFE0000,
		ht_ec8_inst.BAR0OrMask = 32'h00000000,
		ht_ec8_inst.BAR1MatchMask = 32'hFFFE0000,
		ht_ec8_inst.BAR1AndMask = 32'hFFFE0000,
		ht_ec8_inst.BAR1OrMask = 32'h00000000,
		ht_ec8_inst.BAR2MatchMask = 32'hFFFFF000,
		ht_ec8_inst.BAR2AndMask = 32'hFFFFF000,
		ht_ec8_inst.BAR2OrMask = 32'h00000000,
		ht_ec8_inst.BAR3MatchMask = 32'hFFFFF000,
		ht_ec8_inst.BAR3AndMask = 32'hFFFFF000,
		ht_ec8_inst.BAR3OrMask = 32'h00000000,
		ht_ec8_inst.BAR4MatchMask = 32'h00000000,
		ht_ec8_inst.BAR4AndMask = 32'h00000000,
		ht_ec8_inst.BAR4OrMask = 32'h00000000,
		ht_ec8_inst.BAR5MatchMask = 32'h00000000,
		ht_ec8_inst.BAR5AndMask = 32'h00000000,
		ht_ec8_inst.BAR5OrMask = 32'h00000000,
		ht_ec8_inst.TxRDavToSopDelay = 1;
endmodule

// =========================================================
// HT Wizard Data
// ===============================
// DO NOT EDIT FOLLOWING DATA
// @Altera, IP Toolbench@
// Warning: If you modify this section, HT Wizard may not be able to reproduce your chosen configuration.
// 
// Retrieval info: <?xml version="1.0"?>
// Retrieval info: <MEGACORE title="HyperTransport MegaCore Function"  version="1.3.1"  iptb_version="v1.2.6 build11"  format_version="120" >
// Retrieval info:  <NETLIST_SECTION active_core="ht_ec8" >
// Retrieval info:   <STATIC_SECTION>
// Retrieval info:    <PRIVATES>
// Retrieval info:     <NAMESPACE name = "parameterization">
// Retrieval info:      <PRIVATE name = "clock_domain" value="1"  type="INTEGER"  enable="1" />
// Retrieval info:      <PRIVATE name = "rx_clk_frequency" value="400"  type="INTEGER"  enable="1" />
// Retrieval info:      <PRIVATE name = "tx_clk_frequency" value="100"  type="INTEGER"  enable="1" />
// Retrieval info:      <PRIVATE name = "vendor_id" value="0x1172"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "device_id" value="0xCCCC"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "class_code" value="0x050000"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "revision_id" value="0x00"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "subsystem_vendor_id" value="0x0000"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "subsystem_id" value="0x0000"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "posted_buffer_size" value="8"  type="INTEGER"  enable="1" />
// Retrieval info:      <PRIVATE name = "nonposted_buffer_size" value="8"  type="INTEGER"  enable="1" />
// Retrieval info:      <PRIVATE name = "response_buffer_size" value="8"  type="INTEGER"  enable="1" />
// Retrieval info:      <PRIVATE name = "implement_64bit_bar10" value="0"  type="BOOLEAN"  enable="1" />
// Retrieval info:      <PRIVATE name = "implement_64bit_bar32" value="0"  type="BOOLEAN"  enable="1" />
// Retrieval info:      <PRIVATE name = "implement_64bit_bar54" value="0"  type="BOOLEAN"  enable="1" />
// Retrieval info:      <PRIVATE name = "bar_1" value="1"  type="BOOLEAN"  enable="1" />
// Retrieval info:      <PRIVATE name = "bar_1_prefetchable_memory" value="0"  type="BOOLEAN"  enable="1" />
// Retrieval info:      <PRIVATE name = "bar_1_mem_range" value="128 KBytes"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "bar_0" value="1"  type="BOOLEAN"  enable="1" />
// Retrieval info:      <PRIVATE name = "bar_0_prefetchable_memory" value="0"  type="BOOLEAN"  enable="1" />
// Retrieval info:      <PRIVATE name = "bar_0_mem_range" value="128 KBytes"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "bar_2" value="1"  type="BOOLEAN"  enable="1" />
// Retrieval info:      <PRIVATE name = "bar_2_prefetchable_memory" value="0"  type="BOOLEAN"  enable="1" />
// Retrieval info:      <PRIVATE name = "bar_2_mem_range" value="4 KBytes"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "bar_3" value="1"  type="BOOLEAN"  enable="1" />
// Retrieval info:      <PRIVATE name = "bar_3_prefetchable_memory" value="0"  type="BOOLEAN"  enable="1" />
// Retrieval info:      <PRIVATE name = "bar_3_mem_range" value="4 KBytes"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "bar_4" value="0"  type="BOOLEAN"  enable="1" />
// Retrieval info:      <PRIVATE name = "bar_4_prefetchable_memory" value="0"  type="BOOLEAN"  enable="1" />
// Retrieval info:      <PRIVATE name = "bar_4_mem_range" value="16 MBytes"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "bar_5" value="0"  type="BOOLEAN"  enable="1" />
// Retrieval info:      <PRIVATE name = "bar_5_prefetchable_memory" value="0"  type="BOOLEAN"  enable="1" />
// Retrieval info:      <PRIVATE name = "bar_5_mem_range" value="16 MBytes"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "TxRDavToSopDelay" value="1"  type="INTEGER"  enable="1" />
// Retrieval info:      <PRIVATE name = "devicefamily" value="Stratix"  type="STRING"  enable="1" />
// Retrieval info:     </NAMESPACE>
// Retrieval info:     <NAMESPACE name = "symbol"/>
// Retrieval info:     <NAMESPACE name = "simgen_enable">
// Retrieval info:      <PRIVATE name = "language" value="Verilog HDL"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "enabled" value="0"  type="BOOLEAN"  enable="1" />
// Retrieval info:     </NAMESPACE>
// Retrieval info:     <NAMESPACE name = "serializer"/>
// Retrieval info:     <NAMESPACE name = "quartus_settings">
// Retrieval info:      <PRIVATE name = "DEVICE" value="EP1S60F1020C6"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "FAMILY" value="Stratix"  type="STRING"  enable="1" />
// Retrieval info:     </NAMESPACE>
// Retrieval info:    </PRIVATES>
// Retrieval info:    <FILES/>
// Retrieval info:    <CONSTANTS>
// Retrieval info:     <CONSTANT name = "intended_device_family" value="Stratix"  type="STRING" />
// Retrieval info:     <CONSTANT name = "CLKDMN" value="1"  type="INTEGER" />
// Retrieval info:     <CONSTANT name = "HT_TX_CLK_PERIOD" value="2500"  type="INTEGER" />
// Retrieval info:     <CONSTANT name = "HT_RX_CLK_PERIOD" value="2500"  type="INTEGER" />
// Retrieval info:     <CONSTANT name = "RxRBufNum" value="8"  type="INTEGER" />
// Retrieval info:     <CONSTANT name = "RxPBufNum" value="8"  type="INTEGER" />
// Retrieval info:     <CONSTANT name = "RxNpBufNum" value="8"  type="INTEGER" />
// Retrieval info:     <CONSTANT name = "VendorId" value="1172"  type="HDL_VECTOR"  radix="HEX"  width="16"  vhdl_type="STD_LOGIC_VECTOR" />
// Retrieval info:     <CONSTANT name = "DeviceId" value="CCCC"  type="HDL_VECTOR"  radix="HEX"  width="16"  vhdl_type="STD_LOGIC_VECTOR" />
// Retrieval info:     <CONSTANT name = "SubSystemId" value="0000"  type="HDL_VECTOR"  radix="HEX"  width="16"  vhdl_type="STD_LOGIC_VECTOR" />
// Retrieval info:     <CONSTANT name = "SubSystemVendId" value="0000"  type="HDL_VECTOR"  radix="HEX"  width="16"  vhdl_type="STD_LOGIC_VECTOR" />
// Retrieval info:     <CONSTANT name = "RevisionId" value="00"  type="HDL_VECTOR"  radix="HEX"  width="8"  vhdl_type="STD_LOGIC_VECTOR" />
// Retrieval info:     <CONSTANT name = "ClassCode" value="050000"  type="HDL_VECTOR"  radix="HEX"  width="24"  vhdl_type="STD_LOGIC_VECTOR" />
// Retrieval info:     <CONSTANT name = "BAR0MatchMask" value="FFFE0000"  type="HDL_VECTOR"  radix="HEX"  width="32"  vhdl_type="STD_LOGIC_VECTOR" />
// Retrieval info:     <CONSTANT name = "BAR0AndMask" value="FFFE0000"  type="HDL_VECTOR"  radix="HEX"  width="32"  vhdl_type="STD_LOGIC_VECTOR" />
// Retrieval info:     <CONSTANT name = "BAR0OrMask" value="00000000"  type="HDL_VECTOR"  radix="HEX"  width="32"  vhdl_type="STD_LOGIC_VECTOR" />
// Retrieval info:     <CONSTANT name = "BAR1MatchMask" value="FFFE0000"  type="HDL_VECTOR"  radix="HEX"  width="32"  vhdl_type="STD_LOGIC_VECTOR" />
// Retrieval info:     <CONSTANT name = "BAR1AndMask" value="FFFE0000"  type="HDL_VECTOR"  radix="HEX"  width="32"  vhdl_type="STD_LOGIC_VECTOR" />
// Retrieval info:     <CONSTANT name = "BAR1OrMask" value="00000000"  type="HDL_VECTOR"  radix="HEX"  width="32"  vhdl_type="STD_LOGIC_VECTOR" />
// Retrieval info:     <CONSTANT name = "BAR2MatchMask" value="FFFFF000"  type="HDL_VECTOR"  radix="HEX"  width="32"  vhdl_type="STD_LOGIC_VECTOR" />
// Retrieval info:     <CONSTANT name = "BAR2AndMask" value="FFFFF000"  type="HDL_VECTOR"  radix="HEX"  width="32"  vhdl_type="STD_LOGIC_VECTOR" />
// Retrieval info:     <CONSTANT name = "BAR2OrMask" value="00000000"  type="HDL_VECTOR"  radix="HEX"  width="32"  vhdl_type="STD_LOGIC_VECTOR" />
// Retrieval info:     <CONSTANT name = "BAR3MatchMask" value="FFFFF000"  type="HDL_VECTOR"  radix="HEX"  width="32"  vhdl_type="STD_LOGIC_VECTOR" />
// Retrieval info:     <CONSTANT name = "BAR3AndMask" value="FFFFF000"  type="HDL_VECTOR"  radix="HEX"  width="32"  vhdl_type="STD_LOGIC_VECTOR" />
// Retrieval info:     <CONSTANT name = "BAR3OrMask" value="00000000"  type="HDL_VECTOR"  radix="HEX"  width="32"  vhdl_type="STD_LOGIC_VECTOR" />
// Retrieval info:     <CONSTANT name = "BAR4MatchMask" value="00000000"  type="HDL_VECTOR"  radix="HEX"  width="32"  vhdl_type="STD_LOGIC_VECTOR" />
// Retrieval info:     <CONSTANT name = "BAR4AndMask" value="00000000"  type="HDL_VECTOR"  radix="HEX"  width="32"  vhdl_type="STD_LOGIC_VECTOR" />
// Retrieval info:     <CONSTANT name = "BAR4OrMask" value="00000000"  type="HDL_VECTOR"  radix="HEX"  width="32"  vhdl_type="STD_LOGIC_VECTOR" />
// Retrieval info:     <CONSTANT name = "BAR5MatchMask" value="00000000"  type="HDL_VECTOR"  radix="HEX"  width="32"  vhdl_type="STD_LOGIC_VECTOR" />
// Retrieval info:     <CONSTANT name = "BAR5AndMask" value="00000000"  type="HDL_VECTOR"  radix="HEX"  width="32"  vhdl_type="STD_LOGIC_VECTOR" />
// Retrieval info:     <CONSTANT name = "BAR5OrMask" value="00000000"  type="HDL_VECTOR"  radix="HEX"  width="32"  vhdl_type="STD_LOGIC_VECTOR" />
// Retrieval info:     <CONSTANT name = "TxRDavToSopDelay" value="1"  type="INTEGER" />
// Retrieval info:    </CONSTANTS>
// Retrieval info:    <PORTS>
// Retrieval info:     <PORT name = "Rstn" direction="INPUT"  connect_to="Rstn"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "PwrOk" direction="INPUT"  connect_to="PwrOk"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "RefClk" direction="INPUT"  connect_to="GND"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "RefClkWrmRst" direction="OUTPUT"  connect_to="RefClkWrmRst"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "RefClkCldRst" direction="OUTPUT"  connect_to="RefClkCldRst"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "RxLnkClkD4" direction="OUTPUT"  connect_to="RxLnkClkD4"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "RxLnkClkD4Locked_o" direction="OUTPUT"  connect_to="RxLnkClkD4Locked_o"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "RxPllAreset_i" direction="INPUT"  connect_to="RxPllAreset_i"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "TxPllAreset_i" direction="INPUT"  connect_to="TxPllAreset_i"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "RxCAD_i" direction="INPUT"  connect_to="RxCAD_i"  default="NODEFVAL"  width="8"  description="" />
// Retrieval info:     <PORT name = "RxCTL_i" direction="INPUT"  connect_to="RxCTL_i"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "RxClk_i" direction="INPUT"  connect_to="RxClk_i"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "TxCAD_o" direction="OUTPUT"  connect_to="TxCAD_o"  default="NODEFVAL"  width="8"  description="" />
// Retrieval info:     <PORT name = "TxCTL_o" direction="OUTPUT"  connect_to="TxCTL_o"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "TxClk_o" direction="OUTPUT"  connect_to="TxClk_o"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "RxNpEna_i" direction="INPUT"  connect_to="RxNpEna_i"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "RxNpDat_o" direction="OUTPUT"  connect_to="RxNpDat_o"  default="NODEFVAL"  width="64"  description="" />
// Retrieval info:     <PORT name = "RxNpVal_o" direction="OUTPUT"  connect_to="RxNpVal_o"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "RxNpDav_o" direction="OUTPUT"  connect_to="RxNpDav_o"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "RxNpSop_o" direction="OUTPUT"  connect_to="RxNpSop_o"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "RxNpEop_o" direction="OUTPUT"  connect_to="RxNpEop_o"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "RxNpMty_o" direction="OUTPUT"  connect_to="RxNpMty_o"  default="NODEFVAL"  width="3"  description="" />
// Retrieval info:     <PORT name = "RxNpBarHit_o" direction="OUTPUT"  connect_to="RxNpBarHit_o"  default="NODEFVAL"  width="3"  description="" />
// Retrieval info:     <PORT name = "RxPEna_i" direction="INPUT"  connect_to="RxPEna_i"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "RxPDat_o" direction="OUTPUT"  connect_to="RxPDat_o"  default="NODEFVAL"  width="64"  description="" />
// Retrieval info:     <PORT name = "RxPVal_o" direction="OUTPUT"  connect_to="RxPVal_o"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "RxPDav_o" direction="OUTPUT"  connect_to="RxPDav_o"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "RxPSop_o" direction="OUTPUT"  connect_to="RxPSop_o"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "RxPEop_o" direction="OUTPUT"  connect_to="RxPEop_o"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "RxPMty_o" direction="OUTPUT"  connect_to="RxPMty_o"  default="NODEFVAL"  width="3"  description="" />
// Retrieval info:     <PORT name = "RxPBarHit_o" direction="OUTPUT"  connect_to="RxPBarHit_o"  default="NODEFVAL"  width="3"  description="" />
// Retrieval info:     <PORT name = "RxREna_i" direction="INPUT"  connect_to="RxREna_i"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "RxRDat_o" direction="OUTPUT"  connect_to="RxRDat_o"  default="NODEFVAL"  width="64"  description="" />
// Retrieval info:     <PORT name = "RxRVal_o" direction="OUTPUT"  connect_to="RxRVal_o"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "RxRDav_o" direction="OUTPUT"  connect_to="RxRDav_o"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "RxRSop_o" direction="OUTPUT"  connect_to="RxRSop_o"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "RxREop_o" direction="OUTPUT"  connect_to="RxREop_o"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "RxRMty_o" direction="OUTPUT"  connect_to="RxRMty_o"  default="NODEFVAL"  width="3"  description="" />
// Retrieval info:     <PORT name = "TxNpDat_i" direction="INPUT"  connect_to="TxNpDat_i"  default="NODEFVAL"  width="64"  description="" />
// Retrieval info:     <PORT name = "TxNpMty_i" direction="INPUT"  connect_to="TxNpMty_i"  default="NODEFVAL"  width="3"  description="" />
// Retrieval info:     <PORT name = "TxNpDatEna_i" direction="INPUT"  connect_to="TxNpDatEna_i"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "TxNpSop_i" direction="INPUT"  connect_to="TxNpSop_i"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "TxNpEop_i" direction="INPUT"  connect_to="TxNpEop_i"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "TxNpDav_o" direction="OUTPUT"  connect_to="TxNpDav_o"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "TxNpWrRjct_o" direction="OUTPUT"  connect_to="TxNpWrRjct_o"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "TxPDat_i" direction="INPUT"  connect_to="TxPDat_i"  default="NODEFVAL"  width="64"  description="" />
// Retrieval info:     <PORT name = "TxPMty_i" direction="INPUT"  connect_to="TxPMty_i"  default="NODEFVAL"  width="3"  description="" />
// Retrieval info:     <PORT name = "TxPDatEna_i" direction="INPUT"  connect_to="TxPDatEna_i"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "TxPSop_i" direction="INPUT"  connect_to="TxPSop_i"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "TxPEop_i" direction="INPUT"  connect_to="TxPEop_i"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "TxPDav_o" direction="OUTPUT"  connect_to="TxPDav_o"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "TxPWrRjct_o" direction="OUTPUT"  connect_to="TxPWrRjct_o"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "TxRDat_i" direction="INPUT"  connect_to="TxRDat_i"  default="NODEFVAL"  width="64"  description="" />
// Retrieval info:     <PORT name = "TxRMty_i" direction="INPUT"  connect_to="TxRMty_i"  default="NODEFVAL"  width="3"  description="" />
// Retrieval info:     <PORT name = "TxRDatEna_i" direction="INPUT"  connect_to="TxRDatEna_i"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "TxRSop_i" direction="INPUT"  connect_to="TxRSop_i"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "TxREop_i" direction="INPUT"  connect_to="TxREop_i"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "TxRDav_o" direction="OUTPUT"  connect_to="TxRDav_o"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "TxRWrRjct_o" direction="OUTPUT"  connect_to="TxRWrRjct_o"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "CsrCmdReg_o" direction="OUTPUT"  connect_to="CsrCmdReg_o"  default="NODEFVAL"  width="16"  description="" />
// Retrieval info:     <PORT name = "CsrCapCmdReg_o" direction="OUTPUT"  connect_to="CsrCapCmdReg_o"  default="NODEFVAL"  width="16"  description="" />
// Retrieval info:     <PORT name = "CsrStatReg_o" direction="OUTPUT"  connect_to="CsrStatReg_o"  default="NODEFVAL"  width="16"  description="" />
// Retrieval info:     <PORT name = "CsrCapLnk0CtrlReg_o" direction="OUTPUT"  connect_to="CsrCapLnk0CtrlReg_o"  default="NODEFVAL"  width="16"  description="" />
// Retrieval info:     <PORT name = "CsrCapLnk1CtrlReg_o" direction="OUTPUT"  connect_to="CsrCapLnk1CtrlReg_o"  default="NODEFVAL"  width="16"  description="" />
// Retrieval info:     <PORT name = "CsrCapLnk0CfgReg_o" direction="OUTPUT"  connect_to="CsrCapLnk0CfgReg_o"  default="NODEFVAL"  width="16"  description="" />
// Retrieval info:     <PORT name = "CsrCapLnk1CfgReg_o" direction="OUTPUT"  connect_to="CsrCapLnk1CfgReg_o"  default="NODEFVAL"  width="16"  description="" />
// Retrieval info:     <PORT name = "CsrCapFtrReg_o" direction="OUTPUT"  connect_to="CsrCapFtrReg_o"  default="NODEFVAL"  width="8"  description="" />
// Retrieval info:     <PORT name = "CsrCapLnk0ErrReg_o" direction="OUTPUT"  connect_to="CsrCapLnk0ErrReg_o"  default="NODEFVAL"  width="4"  description="" />
// Retrieval info:     <PORT name = "CsrCapLnk1ErrReg_o" direction="OUTPUT"  connect_to="CsrCapLnk1ErrReg_o"  default="NODEFVAL"  width="4"  description="" />
// Retrieval info:     <PORT name = "CsrCapErrHndlngReg_o" direction="OUTPUT"  connect_to="CsrCapErrHndlngReg_o"  default="NODEFVAL"  width="16"  description="" />
// Retrieval info:     <PORT name = "Bar0Reg_o" direction="OUTPUT"  connect_to="Bar0Reg_o"  default="NODEFVAL"  width="32"  description="" />
// Retrieval info:     <PORT name = "Bar1Reg_o" direction="OUTPUT"  connect_to="Bar1Reg_o"  default="NODEFVAL"  width="32"  description="" />
// Retrieval info:     <PORT name = "Bar2Reg_o" direction="OUTPUT"  connect_to="Bar2Reg_o"  default="NODEFVAL"  width="32"  description="" />
// Retrieval info:     <PORT name = "Bar3Reg_o" direction="OUTPUT"  connect_to="Bar3Reg_o"  default="NODEFVAL"  width="32"  description="" />
// Retrieval info:     <PORT name = "Bar4Reg_o" direction="OUTPUT"  connect_to="Bar4Reg_o"  default="NODEFVAL"  width="32"  description="" />
// Retrieval info:     <PORT name = "Bar5Reg_o" direction="OUTPUT"  connect_to="Bar5Reg_o"  default="NODEFVAL"  width="32"  description="" />
// Retrieval info:     <PORT name = "ClmdRCmdBufOvrFlwErr_o" direction="OUTPUT"  connect_to="ClmdRCmdBufOvrFlwErr_o"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "ClmdPCmdBufOvrFlwErr_o" direction="OUTPUT"  connect_to="ClmdPCmdBufOvrFlwErr_o"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "ClmdNPCmdBufOvrFlwErr_o" direction="OUTPUT"  connect_to="ClmdNPCmdBufOvrFlwErr_o"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "RespErr_i" direction="INPUT"  connect_to="RespErr_i"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:     <PORT name = "SignaledTabrt_i" direction="INPUT"  connect_to="SignaledTabrt_i"  default="NODEFVAL"  width="1"  description="" />
// Retrieval info:    </PORTS>
// Retrieval info:    <LIBRARIES>
// Retrieval info:     <LIBRARY name = "ht_ec8"/>
// Retrieval info:    </LIBRARIES>
// Retrieval info:   </STATIC_SECTION>
// Retrieval info:  </NETLIST_SECTION>
// Retrieval info: </MEGACORE>
// =========================================================
