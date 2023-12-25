// -------------------------------------------------------------------------
// -------------------------------------------------------------------------
//
// Revision Control Information
//
// $RCSfile: testbench_mac8_pcs.v,v $
// $Source: /ipbu/cvs/sio/projects/TriSpeedEthernet/src/testbench/MAC_PCS/verilog/testbench_mac8_pcs.v,v $
//
// $Revision: #1 $
// $Date: 2009/02/04 $
// Check in by : $Author: max $
// Author      : SKNg/TTChong
//
// Project     : Triple Speed Ethernet - 10/100/1000 MAC +  1000 Base-X PCS / SGMII
//
// Description : 
//
// Testbench for 8-Bit Core 10/100/1000 MAC +  1000 Base-X PCS / SGMII
//
// 
// ALTERA Confidential and Proprietary
// Copyright 2007 (c) Altera Corporation
// All rights reserved
//
// -------------------------------------------------------------------------
// -------------------------------------------------------------------------

`timescale 1 ns / 10 ps

module tb ;


//  Core Settings 
//  WARNING: DO NOT MODIFY THESE PARAMETERS
//  -------------------------------
// $<RTL_PARAMETERS>


//  Simulation Settings (Testbench)
//  -------------------------------

//  Multicast addresses 
parameter MCAST_TABLEN = 9; //  number of MAC addresses in the table
parameter MCAST_ADDRESSLIST = {

        48'h 887654332211, 
        48'h 886644352611, 
        48'h ABCDEF012313, 
        48'h 92456545ab15, 
        48'h 432680010217, 
        48'h adb589215439, 
        48'h ffeacfe3434B, 
        48'h ffccddaa3123, 
        48'h adb358415439}; //  rx_err/rx_en/rx_d(7:0)

parameter TB_MAX_LENGTH_TEST    = 1'b0 ;        // Enable Test with Frame Greater than Programmed size
parameter TB_MIN_LENGTH_TEST    = 1'b0 ;        // Enable Test with Frame Lower than Valid size
parameter TB_FORM_TEST          = 1'b0 ;        // Test Preamble Length
parameter TB_VARIABLE_PMBL      = 1'b0 ;        // Frame Reception with Variable Preamble

parameter ETH_MODE = 1000 ; //  Ethernet Operation Mode
parameter HD_ENA = 1'b 0 ; //  Enable Half Duplex Operation
parameter TB_RXFRAMES = 0 ; //  number of frames to send in RX path - If set to 0, generator is diabled and loopbackmode is active
parameter TB_RXIPG = 12 ; //  Inter Packet Gap used by RX generator
parameter TB_TXFRAMES = 5 ; //  number of frames to send in TX path (set to 0 to disable)
parameter TB_PAUSECONTROL = 1'b 1 ; //  react on PAUSE Frames coming from MAC
parameter TB_LENSTART = 100 ; //  length to start (incremented each new frame by TB_LENSTEP)
parameter TB_LENSTEP = 1 ; //  steps the length should increase with each frame
parameter TB_LENMAX = 1500 ; //  max. payload length for generation
parameter TB_ENA_PADDING = 1'b 1 ; //  enable padding of frames coming from RX PHY generator
parameter TB_ENA_VLAN = 0 ; //  enable generation of a VLAN frame every x frames
parameter TB_STOPREAD = 0 ; //  stop reading the RX fifo after x frames
parameter TB_HOLDREAD = 1000 ; //  clock cycles to wait after stopread before continuing to read
parameter TB_TRIGGERXOFF = 0 ; // when to trigger a pause frame using the xoff_gen command
parameter TB_TRIGGERXON = 0 ; // when to trigger a pause frame using the xon_gen command
parameter TB_TRIGGERPAUSE = 0 ; //  when to trigger a pause frame using the pause_gen command
parameter TB_MACLENMAX = 1518 ; //  max. frame length configuration of MAC
parameter TB_MACPAUSEQ = 15 ; //  pause quanta configuration of MAC
parameter TB_MACIGNORE_PAUSE = 1'b 0 ; //  Ignore Pause Frames
parameter TB_MACFWD_PAUSE = 1'b 0 ; //  Forward Pause Frames
parameter TB_MACFWD_CRC = 1'b 0 ; //  Forward CRC
parameter TB_MACINSERT_ADDR = 1'b 0; //  Insert MAC source address
parameter TB_ADDR_SEL = 0 ; // Select MAC source address
parameter TB_MACPADEN = 1'b 1 ; //  Enable Padding
parameter TB_MODPAUSEQ = 16 ; //  pause quanta configuration of MAC
parameter TB_ENA_VAR_IPG = 1'b 0 ; // Enable Variable IPG
parameter TX_FIFO_SECTION_EMPTY  = 16 ; //  Transmit FIFO Section Empty Threshold
parameter TX_FIFO_SECTION_FULL  = 16 ; //  Transmit FIFO Section Full Threshold
parameter RX_FIFO_SECTION_EMPTY  = 0 ; //  Receive FIFO Section Empty Threshold
parameter RX_FIFO_SECTION_FULL  = 16 ; //  Receive FIFO Section Full Threshold
parameter TX_FIFO_AE  = 8 ; //  Transmit FIFO Almost Empty Threshold
parameter TX_FIFO_AF  = 10 ; //  Transmit FIFO Almost Full Threshold
parameter RX_FIFO_AE  = 8 ; //  Receive FIFO Almost Empty Threshold
parameter RX_FIFO_AF  = 8 ; //  Receive FIFO Almost Full Threshold
parameter RX_COL_FRM  = 0 ; //  Colision on Frame Number
parameter RX_COL_GEN = 0 ; //  Colision on Nibble Number
parameter TX_COL_FRM = 0 ; //  Colision on Frame Number
parameter TX_COL_GEN = 0 ; //  Colision on Nibble Number
parameter TX_COL_NUM = 0 ; //  Number of Concecutive Collisions
parameter TX_COL_DELAY = 0 ; //  Delay Between Concecutive Collisions
parameter TB_MDIO_ADDR1 = 1 ; //  MDIO PHY 1 Address
parameter TB_PROMIS_ENA = 1'b1 ; //  Enable Promiscuous Mode
parameter PERIOD_HASHCLK = 15; //  66MHz hash table programming
parameter TB_MDIO_SIMULATION = 1'b 0 ; // Enable MDIO Simulation
parameter TB_PCS_BYPASS = 1'b 1 ; // Bypass PCS
parameter TB_IPG_LENGTH = 12 ; // Enable Inverted Loopback
parameter LOC_HIGH = 4;
parameter LOC_LOW =4;
parameter GMII_HIGH =4; 
parameter GMII_LOW = 4;  
parameter TB_MACRX_ERR_DISC = 1;//  MAC function discards erroneous frames received, only when rx_section_full register = 0

//PCS
//---------------------------------------------------------------
parameter TB_TXIPG = 12 ; //  Inter Packet Gap used by RX generator
parameter TB_PHYERR = 1'b0; //  Generate PHY Error
parameter TB_CHAR_ERR = 0; //  Insert 10b Character Error
parameter TB_CHAR_ERR_NUM = 6; //  Number of Consecutive Character Error
parameter TB_ENA_AUTONEG = 1'b 0 ; //  Enable Auto-Negotiation
parameter TB_PCS_LINK_TIMER = 512 ; //  Link Timer
parameter TB_PARTNER_LINK_TIMER = 128 ; //  Link Timer
parameter TB_TX_ERR = 1'b 0 ; //  Enable GMII Error
parameter TB_PARTNER_PS1 = 1'b 1 ; //  Pause Support Encoding
parameter TB_PARTNER_PS2 = 1'b 0 ; //  Pause Support Encoding
parameter TB_PARTNER_RF1 = 1'b 0 ; //  Remote Fault Encoding
parameter TB_PARTNER_RF2 = 1'b 0 ; //  Remote Fault Encoding
parameter TB_PCS_PS1 = 1'b 1 ; //  Pause Support Encoding
parameter TB_PCS_PS2 = 1'b 0 ; //  Pause Support Encoding
parameter TB_PCS_RF1 = 1'b 0 ; //  Remote Fault Encoding
parameter TB_PCS_RF2 = 1'b 0 ; //  Remote Fault Encoding
parameter TB_ISOLATE = 1'b 0 ; //  Remote Fault Encoding
parameter TB_SGMII_ENA = 1'b 0 ; //  Enable SGMII Interface
parameter TB_SGMII_AUTO_CONF = 1'b 0 ; //  Enable SGMII Auto-Configuration
parameter TB_SGMII_1000 = 1'b 1 ; //  Enable SGMII Gigabit
parameter TB_SGMII_100 = 1'b 0 ; //  Enable SGMII 100Mbps
parameter TB_SGMII_10 = 1'b 0 ; //  Enable SGMII 10Mbps
parameter TB_SGMII_HD = 1'b 0 ; // Enable SGMII Half-Duplex Operation



//DUT interconnects
wire rx_afull_clk;
wire [4:0]  rx_afull_channel;
wire [1:0]  rx_afull_data;
wire    rx_afull_valid;
wire [7:0]  data_tx_data_0;
wire    data_tx_eop_0;
wire    data_tx_error_0;
wire    tx_crc_fwd_0;
wire    data_tx_sop_0;
wire    data_tx_valid_0;
wire    data_rx_ready_0;
wire    tx_clk_0;
wire    rx_clk_0;
wire  tx_control_0;
wire  [3:0] rgmii_out_0;
wire   [3:0] rgmii_in_0;
wire   rx_control_0;
wire [7:0]  gm_rx_d_0;
wire    gm_rx_dv_0;
wire    gm_rx_err_0;
wire [3:0]  m_rx_d_0;
wire    m_rx_en_0;
wire    m_rx_err_0;
wire    set_10_0;
wire    set_1000_0;
wire    xon_gen_0;
wire    xoff_gen_0;
wire    magic_sleep_n_0;
wire    m_rx_col_0;
wire    m_rx_crs_0;
wire [7:0]  data_tx_data_1;
wire    data_tx_eop_1;
wire    data_tx_error_1;
wire    tx_crc_fwd_1;
wire    data_tx_sop_1;
wire    data_tx_valid_1;
wire    data_rx_ready_1;
wire    tx_clk_1;
wire    rx_clk_1;
wire  tx_control_1;
wire  [3:0] rgmii_out_1;
wire   [3:0] rgmii_in_1;
wire   rx_control_1;
wire [7:0]  gm_rx_d_1;
wire    gm_rx_dv_1;
wire    gm_rx_err_1;
wire [3:0]  m_rx_d_1;
wire    m_rx_en_1;
wire    m_rx_err_1;
wire    set_10_1;
wire    set_1000_1;
wire    xon_gen_1;
wire    xoff_gen_1;
wire    magic_sleep_n_1;
wire    m_rx_col_1;
wire    m_rx_crs_1;
wire [7:0]  data_tx_data_2;
wire    data_tx_eop_2;
wire    data_tx_error_2;
wire    tx_crc_fwd_2;
wire    data_tx_sop_2;
wire    data_tx_valid_2;
wire    data_rx_ready_2;
wire    tx_clk_2;
wire    rx_clk_2;
wire  tx_control_2;
wire  [3:0] rgmii_out_2;
wire   [3:0] rgmii_in_2;
wire   rx_control_2;
wire [7:0]  gm_rx_d_2;
wire    gm_rx_dv_2;
wire    gm_rx_err_2;
wire [3:0]  m_rx_d_2;
wire    m_rx_en_2;
wire    m_rx_err_2;
wire    set_10_2;
wire    set_1000_2;
wire    xon_gen_2;
wire    xoff_gen_2;
wire    magic_sleep_n_2;
wire    m_rx_col_2;
wire    m_rx_crs_2;
wire [7:0]  data_tx_data_3;
wire    data_tx_eop_3;
wire    data_tx_error_3;
wire    tx_crc_fwd_3;
wire    data_tx_sop_3;
wire    data_tx_valid_3;
wire    data_rx_ready_3;
wire    tx_clk_3;
wire    rx_clk_3;
wire  tx_control_3;
wire  [3:0] rgmii_out_3;
wire   [3:0] rgmii_in_3;
wire   rx_control_3;
wire [7:0]  gm_rx_d_3;
wire    gm_rx_dv_3;
wire    gm_rx_err_3;
wire [3:0]  m_rx_d_3;
wire    m_rx_en_3;
wire    m_rx_err_3;
wire    set_10_3;
wire    set_1000_3;
wire    xon_gen_3;
wire    xoff_gen_3;
wire    magic_sleep_n_3;
wire    m_rx_col_3;
wire    m_rx_crs_3;
wire [7:0]  data_tx_data_4;
wire    data_tx_eop_4;
wire    data_tx_error_4;
wire    tx_crc_fwd_4;
wire    data_tx_sop_4;
wire    data_tx_valid_4;
wire    data_rx_ready_4;
wire    tx_clk_4;
wire    rx_clk_4;
wire  tx_control_4;
wire  [3:0] rgmii_out_4;
wire   [3:0] rgmii_in_4;
wire   rx_control_4;
wire [7:0]  gm_rx_d_4;
wire    gm_rx_dv_4;
wire    gm_rx_err_4;
wire [3:0]  m_rx_d_4;
wire    m_rx_en_4;
wire    m_rx_err_4;
wire    set_10_4;
wire    set_1000_4;
wire    xon_gen_4;
wire    xoff_gen_4;
wire    magic_sleep_n_4;
wire    m_rx_col_4;
wire    m_rx_crs_4;
wire [7:0]  data_tx_data_5;
wire    data_tx_eop_5;
wire    data_tx_error_5;
wire    tx_crc_fwd_5;
wire    data_tx_sop_5;
wire    data_tx_valid_5;
wire    data_rx_ready_5;
wire    tx_clk_5;
wire    rx_clk_5;
wire  tx_control_5;
wire  [3:0] rgmii_out_5;
wire   [3:0] rgmii_in_5;
wire   rx_control_5;
wire [7:0]  gm_rx_d_5;
wire    gm_rx_dv_5;
wire    gm_rx_err_5;
wire [3:0]  m_rx_d_5;
wire    m_rx_en_5;
wire    m_rx_err_5;
wire    set_10_5;
wire    set_1000_5;
wire    xon_gen_5;
wire    xoff_gen_5;
wire    magic_sleep_n_5;
wire    m_rx_col_5;
wire    m_rx_crs_5;
wire [7:0]  data_tx_data_6;
wire    data_tx_eop_6;
wire    data_tx_error_6;
wire    tx_crc_fwd_6;
wire    data_tx_sop_6;
wire    data_tx_valid_6;
wire    data_rx_ready_6;
wire    tx_clk_6;
wire    rx_clk_6;
wire  tx_control_6;
wire  [3:0] rgmii_out_6;
wire   [3:0] rgmii_in_6;
wire   rx_control_6;
wire [7:0]  gm_rx_d_6;
wire    gm_rx_dv_6;
wire    gm_rx_err_6;
wire [3:0]  m_rx_d_6;
wire    m_rx_en_6;
wire    m_rx_err_6;
wire    set_10_6;
wire    set_1000_6;
wire    xon_gen_6;
wire    xoff_gen_6;
wire    magic_sleep_n_6;
wire    m_rx_col_6;
wire    m_rx_crs_6;
wire [7:0]  data_tx_data_7;
wire    data_tx_eop_7;
wire    data_tx_error_7;
wire    tx_crc_fwd_7;
wire    data_tx_sop_7;
wire    data_tx_valid_7;
wire    data_rx_ready_7;
wire    tx_clk_7;
wire    rx_clk_7;
wire  tx_control_7;
wire  [3:0] rgmii_out_7;
wire   [3:0] rgmii_in_7;
wire   rx_control_7;
wire [7:0]  gm_rx_d_7;
wire    gm_rx_dv_7;
wire    gm_rx_err_7;
wire [3:0]  m_rx_d_7;
wire    m_rx_en_7;
wire    m_rx_err_7;
wire    set_10_7;
wire    set_1000_7;
wire    xon_gen_7;
wire    xoff_gen_7;
wire    magic_sleep_n_7;
wire    m_rx_col_7;
wire    m_rx_crs_7;
wire [7:0]  data_tx_data_8;
wire    data_tx_eop_8;
wire    data_tx_error_8;
wire    tx_crc_fwd_8;
wire    data_tx_sop_8;
wire    data_tx_valid_8;
wire    data_rx_ready_8;
wire    tx_clk_8;
wire    rx_clk_8;
wire  tx_control_8;
wire  [3:0] rgmii_out_8;
wire   [3:0] rgmii_in_8;
wire   rx_control_8;
wire [7:0]  gm_rx_d_8;
wire    gm_rx_dv_8;
wire    gm_rx_err_8;
wire [3:0]  m_rx_d_8;
wire    m_rx_en_8;
wire    m_rx_err_8;
wire    set_10_8;
wire    set_1000_8;
wire    xon_gen_8;
wire    xoff_gen_8;
wire    magic_sleep_n_8;
wire    m_rx_col_8;
wire    m_rx_crs_8;
wire [7:0]  data_tx_data_9;
wire    data_tx_eop_9;
wire    data_tx_error_9;
wire    tx_crc_fwd_9;
wire    data_tx_sop_9;
wire    data_tx_valid_9;
wire    data_rx_ready_9;
wire    tx_clk_9;
wire    rx_clk_9;
wire  tx_control_9;
wire  [3:0] rgmii_out_9;
wire   [3:0] rgmii_in_9;
wire   rx_control_9;
wire [7:0]  gm_rx_d_9;
wire    gm_rx_dv_9;
wire    gm_rx_err_9;
wire [3:0]  m_rx_d_9;
wire    m_rx_en_9;
wire    m_rx_err_9;
wire    set_10_9;
wire    set_1000_9;
wire    xon_gen_9;
wire    xoff_gen_9;
wire    magic_sleep_n_9;
wire    m_rx_col_9;
wire    m_rx_crs_9;
wire [7:0]  data_tx_data_10;
wire    data_tx_eop_10;
wire    data_tx_error_10;
wire    tx_crc_fwd_10;
wire    data_tx_sop_10;
wire    data_tx_valid_10;
wire    data_rx_ready_10;
wire    tx_clk_10;
wire    rx_clk_10;
wire  tx_control_10;
wire  [3:0] rgmii_out_10;
wire   [3:0] rgmii_in_10;
wire   rx_control_10;
wire [7:0]  gm_rx_d_10;
wire    gm_rx_dv_10;
wire    gm_rx_err_10;
wire [3:0]  m_rx_d_10;
wire    m_rx_en_10;
wire    m_rx_err_10;
wire    set_10_10;
wire    set_1000_10;
wire    xon_gen_10;
wire    xoff_gen_10;
wire    magic_sleep_n_10;
wire    m_rx_col_10;
wire    m_rx_crs_10;
wire [7:0]  data_tx_data_11;
wire    data_tx_eop_11;
wire    data_tx_error_11;
wire    tx_crc_fwd_11;
wire    data_tx_sop_11;
wire    data_tx_valid_11;
wire    data_rx_ready_11;
wire    tx_clk_11;
wire    rx_clk_11;
wire  tx_control_11;
wire  [3:0] rgmii_out_11;
wire   [3:0] rgmii_in_11;
wire   rx_control_11;
wire [7:0]  gm_rx_d_11;
wire    gm_rx_dv_11;
wire    gm_rx_err_11;
wire [3:0]  m_rx_d_11;
wire    m_rx_en_11;
wire    m_rx_err_11;
wire    set_10_11;
wire    set_1000_11;
wire    xon_gen_11;
wire    xoff_gen_11;
wire    magic_sleep_n_11;
wire    m_rx_col_11;
wire    m_rx_crs_11;
wire [7:0]  data_tx_data_12;
wire    data_tx_eop_12;
wire    data_tx_error_12;
wire    tx_crc_fwd_12;
wire    data_tx_sop_12;
wire    data_tx_valid_12;
wire    data_rx_ready_12;
wire    tx_clk_12;
wire    rx_clk_12;
wire  tx_control_12;
wire  [3:0] rgmii_out_12;
wire   [3:0] rgmii_in_12;
wire   rx_control_12;
wire [7:0]  gm_rx_d_12;
wire    gm_rx_dv_12;
wire    gm_rx_err_12;
wire [3:0]  m_rx_d_12;
wire    m_rx_en_12;
wire    m_rx_err_12;
wire    set_10_12;
wire    set_1000_12;
wire    xon_gen_12;
wire    xoff_gen_12;
wire    magic_sleep_n_12;
wire    m_rx_col_12;
wire    m_rx_crs_12;
wire [7:0]  data_tx_data_13;
wire    data_tx_eop_13;
wire    data_tx_error_13;
wire    tx_crc_fwd_13;
wire    data_tx_sop_13;
wire    data_tx_valid_13;
wire    data_rx_ready_13;
wire    tx_clk_13;
wire    rx_clk_13;
wire  tx_control_13;
wire  [3:0] rgmii_out_13;
wire   [3:0] rgmii_in_13;
wire   rx_control_13;
wire [7:0]  gm_rx_d_13;
wire    gm_rx_dv_13;
wire    gm_rx_err_13;
wire [3:0]  m_rx_d_13;
wire    m_rx_en_13;
wire    m_rx_err_13;
wire    set_10_13;
wire    set_1000_13;
wire    xon_gen_13;
wire    xoff_gen_13;
wire    magic_sleep_n_13;
wire    m_rx_col_13;
wire    m_rx_crs_13;
wire [7:0]  data_tx_data_14;
wire    data_tx_eop_14;
wire    data_tx_error_14;
wire    tx_crc_fwd_14;
wire    data_tx_sop_14;
wire    data_tx_valid_14;
wire    data_rx_ready_14;
wire    tx_clk_14;
wire    rx_clk_14;
wire  tx_control_14;
wire  [3:0] rgmii_out_14;
wire   [3:0] rgmii_in_14;
wire   rx_control_14;
wire [7:0]  gm_rx_d_14;
wire    gm_rx_dv_14;
wire    gm_rx_err_14;
wire [3:0]  m_rx_d_14;
wire    m_rx_en_14;
wire    m_rx_err_14;
wire    set_10_14;
wire    set_1000_14;
wire    xon_gen_14;
wire    xoff_gen_14;
wire    magic_sleep_n_14;
wire    m_rx_col_14;
wire    m_rx_crs_14;
wire [7:0]  data_tx_data_15;
wire    data_tx_eop_15;
wire    data_tx_error_15;
wire    tx_crc_fwd_15;
wire    data_tx_sop_15;
wire    data_tx_valid_15;
wire    data_rx_ready_15;
wire    tx_clk_15;
wire    rx_clk_15;
wire  tx_control_15;
wire  [3:0] rgmii_out_15;
wire   [3:0] rgmii_in_15;
wire   rx_control_15;
wire [7:0]  gm_rx_d_15;
wire    gm_rx_dv_15;
wire    gm_rx_err_15;
wire [3:0]  m_rx_d_15;
wire    m_rx_en_15;
wire    m_rx_err_15;
wire    set_10_15;
wire    set_1000_15;
wire    xon_gen_15;
wire    xoff_gen_15;
wire    magic_sleep_n_15;
wire    m_rx_col_15;
wire    m_rx_crs_15;
wire [7:0]  data_tx_data_16;
wire    data_tx_eop_16;
wire    data_tx_error_16;
wire    tx_crc_fwd_16;
wire    data_tx_sop_16;
wire    data_tx_valid_16;
wire    data_rx_ready_16;
wire    tx_clk_16;
wire    rx_clk_16;
wire  tx_control_16;
wire  [3:0] rgmii_out_16;
wire   [3:0] rgmii_in_16;
wire   rx_control_16;
wire [7:0]  gm_rx_d_16;
wire    gm_rx_dv_16;
wire    gm_rx_err_16;
wire [3:0]  m_rx_d_16;
wire    m_rx_en_16;
wire    m_rx_err_16;
wire    set_10_16;
wire    set_1000_16;
wire    xon_gen_16;
wire    xoff_gen_16;
wire    magic_sleep_n_16;
wire    m_rx_col_16;
wire    m_rx_crs_16;
wire [7:0]  data_tx_data_17;
wire    data_tx_eop_17;
wire    data_tx_error_17;
wire    tx_crc_fwd_17;
wire    data_tx_sop_17;
wire    data_tx_valid_17;
wire    data_rx_ready_17;
wire    tx_clk_17;
wire    rx_clk_17;
wire  tx_control_17;
wire  [3:0] rgmii_out_17;
wire   [3:0] rgmii_in_17;
wire   rx_control_17;
wire [7:0]  gm_rx_d_17;
wire    gm_rx_dv_17;
wire    gm_rx_err_17;
wire [3:0]  m_rx_d_17;
wire    m_rx_en_17;
wire    m_rx_err_17;
wire    set_10_17;
wire    set_1000_17;
wire    xon_gen_17;
wire    xoff_gen_17;
wire    magic_sleep_n_17;
wire    m_rx_col_17;
wire    m_rx_crs_17;
wire [7:0]  data_tx_data_18;
wire    data_tx_eop_18;
wire    data_tx_error_18;
wire    tx_crc_fwd_18;
wire    data_tx_sop_18;
wire    data_tx_valid_18;
wire    data_rx_ready_18;
wire    tx_clk_18;
wire    rx_clk_18;
wire  tx_control_18;
wire  [3:0] rgmii_out_18;
wire   [3:0] rgmii_in_18;
wire   rx_control_18;
wire [7:0]  gm_rx_d_18;
wire    gm_rx_dv_18;
wire    gm_rx_err_18;
wire [3:0]  m_rx_d_18;
wire    m_rx_en_18;
wire    m_rx_err_18;
wire    set_10_18;
wire    set_1000_18;
wire    xon_gen_18;
wire    xoff_gen_18;
wire    magic_sleep_n_18;
wire    m_rx_col_18;
wire    m_rx_crs_18;
wire [7:0]  data_tx_data_19;
wire    data_tx_eop_19;
wire    data_tx_error_19;
wire    tx_crc_fwd_19;
wire    data_tx_sop_19;
wire    data_tx_valid_19;
wire    data_rx_ready_19;
wire    tx_clk_19;
wire    rx_clk_19;
wire  tx_control_19;
wire  [3:0] rgmii_out_19;
wire   [3:0] rgmii_in_19;
wire   rx_control_19;
wire [7:0]  gm_rx_d_19;
wire    gm_rx_dv_19;
wire    gm_rx_err_19;
wire [3:0]  m_rx_d_19;
wire    m_rx_en_19;
wire    m_rx_err_19;
wire    set_10_19;
wire    set_1000_19;
wire    xon_gen_19;
wire    xoff_gen_19;
wire    magic_sleep_n_19;
wire    m_rx_col_19;
wire    m_rx_crs_19;
wire [7:0]  data_tx_data_20;
wire    data_tx_eop_20;
wire    data_tx_error_20;
wire    tx_crc_fwd_20;
wire    data_tx_sop_20;
wire    data_tx_valid_20;
wire    data_rx_ready_20;
wire    tx_clk_20;
wire    rx_clk_20;
wire  tx_control_20;
wire  [3:0] rgmii_out_20;
wire   [3:0] rgmii_in_20;
wire   rx_control_20;
wire [7:0]  gm_rx_d_20;
wire    gm_rx_dv_20;
wire    gm_rx_err_20;
wire [3:0]  m_rx_d_20;
wire    m_rx_en_20;
wire    m_rx_err_20;
wire    set_10_20;
wire    set_1000_20;
wire    xon_gen_20;
wire    xoff_gen_20;
wire    magic_sleep_n_20;
wire    m_rx_col_20;
wire    m_rx_crs_20;
wire [7:0]  data_tx_data_21;
wire    data_tx_eop_21;
wire    data_tx_error_21;
wire    tx_crc_fwd_21;
wire    data_tx_sop_21;
wire    data_tx_valid_21;
wire    data_rx_ready_21;
wire    tx_clk_21;
wire    rx_clk_21;
wire  tx_control_21;
wire  [3:0] rgmii_out_21;
wire   [3:0] rgmii_in_21;
wire   rx_control_21;
wire [7:0]  gm_rx_d_21;
wire    gm_rx_dv_21;
wire    gm_rx_err_21;
wire [3:0]  m_rx_d_21;
wire    m_rx_en_21;
wire    m_rx_err_21;
wire    set_10_21;
wire    set_1000_21;
wire    xon_gen_21;
wire    xoff_gen_21;
wire    magic_sleep_n_21;
wire    m_rx_col_21;
wire    m_rx_crs_21;
wire [7:0]  data_tx_data_22;
wire    data_tx_eop_22;
wire    data_tx_error_22;
wire    tx_crc_fwd_22;
wire    data_tx_sop_22;
wire    data_tx_valid_22;
wire    data_rx_ready_22;
wire    tx_clk_22;
wire    rx_clk_22;
wire  tx_control_22;
wire  [3:0] rgmii_out_22;
wire   [3:0] rgmii_in_22;
wire   rx_control_22;
wire [7:0]  gm_rx_d_22;
wire    gm_rx_dv_22;
wire    gm_rx_err_22;
wire [3:0]  m_rx_d_22;
wire    m_rx_en_22;
wire    m_rx_err_22;
wire    set_10_22;
wire    set_1000_22;
wire    xon_gen_22;
wire    xoff_gen_22;
wire    magic_sleep_n_22;
wire    m_rx_col_22;
wire    m_rx_crs_22;
wire [7:0]  data_tx_data_23;
wire    data_tx_eop_23;
wire    data_tx_error_23;
wire    tx_crc_fwd_23;
wire    data_tx_sop_23;
wire    data_tx_valid_23;
wire    data_rx_ready_23;
wire    tx_clk_23;
wire    rx_clk_23;
wire  tx_control_23;
wire  [3:0] rgmii_out_23;
wire   [3:0] rgmii_in_23;
wire   rx_control_23;
wire [7:0]  gm_rx_d_23;
wire    gm_rx_dv_23;
wire    gm_rx_err_23;
wire [3:0]  m_rx_d_23;
wire    m_rx_en_23;
wire    m_rx_err_23;
wire    set_10_23;
wire    set_1000_23;
wire    xon_gen_23;
wire    xoff_gen_23;
wire    magic_sleep_n_23;
wire    m_rx_col_23;
wire    m_rx_crs_23;



wire    mdio_out;
wire    mdio_oen;
wire    mdc;
wire    mac_tx_clk_0;
wire    mac_rx_clk_0;
wire    data_tx_ready_0;
wire [7:0]  data_rx_data_0;
wire    data_rx_valid_0;
wire    data_rx_eop_0;
wire    data_rx_sop_0;
wire [4:0]  data_rx_error_0;
wire [4:0]  pkt_class_data_0;
wire    pkt_class_valid_0;
wire [7:0]  gm_tx_d_0;
wire    gm_tx_en_0;
wire    gm_tx_err_0;
wire [3:0]  m_tx_d_0;
wire    m_tx_en_0;
wire    m_tx_err_0;
wire    ena_10_0;
wire    eth_mode_0;
wire    magic_wakeup_0;
wire    mac_tx_clk_1;
wire    mac_rx_clk_1;
wire    data_tx_ready_1;
wire [7:0]  data_rx_data_1;
wire    data_rx_valid_1;
wire    data_rx_eop_1;
wire    data_rx_sop_1;
wire [4:0]  data_rx_error_1;
wire [4:0]  pkt_class_data_1;
wire    pkt_class_valid_1;
wire [7:0]  gm_tx_d_1;
wire    gm_tx_en_1;
wire    gm_tx_err_1;
wire [3:0]  m_tx_d_1;
wire    m_tx_en_1;
wire    m_tx_err_1;
wire    ena_10_1;
wire    eth_mode_1;
wire    magic_wakeup_1;
wire    mac_tx_clk_2;
wire    mac_rx_clk_2;
wire    data_tx_ready_2;
wire [7:0]  data_rx_data_2;
wire    data_rx_valid_2;
wire    data_rx_eop_2;
wire    data_rx_sop_2;
wire [4:0]  data_rx_error_2;
wire [4:0]  pkt_class_data_2;
wire    pkt_class_valid_2;
wire [7:0]  gm_tx_d_2;
wire    gm_tx_en_2;
wire    gm_tx_err_2;
wire [3:0]  m_tx_d_2;
wire    m_tx_en_2;
wire    m_tx_err_2;
wire    ena_10_2;
wire    eth_mode_2;
wire    magic_wakeup_2;
wire    mac_tx_clk_3;
wire    mac_rx_clk_3;
wire    data_tx_ready_3;
wire [7:0]  data_rx_data_3;
wire    data_rx_valid_3;
wire    data_rx_eop_3;
wire    data_rx_sop_3;
wire [4:0]  data_rx_error_3;
wire [4:0]  pkt_class_data_3;
wire    pkt_class_valid_3;
wire [7:0]  gm_tx_d_3;
wire    gm_tx_en_3;
wire    gm_tx_err_3;
wire [3:0]  m_tx_d_3;
wire    m_tx_en_3;
wire    m_tx_err_3;
wire    ena_10_3;
wire    eth_mode_3;
wire    magic_wakeup_3;
wire    mac_tx_clk_4;
wire    mac_rx_clk_4;
wire    data_tx_ready_4;
wire [7:0]  data_rx_data_4;
wire    data_rx_valid_4;
wire    data_rx_eop_4;
wire    data_rx_sop_4;
wire [4:0]  data_rx_error_4;
wire [4:0]  pkt_class_data_4;
wire    pkt_class_valid_4;
wire [7:0]  gm_tx_d_4;
wire    gm_tx_en_4;
wire    gm_tx_err_4;
wire [3:0]  m_tx_d_4;
wire    m_tx_en_4;
wire    m_tx_err_4;
wire    ena_10_4;
wire    eth_mode_4;
wire    magic_wakeup_4;
wire    mac_tx_clk_5;
wire    mac_rx_clk_5;
wire    data_tx_ready_5;
wire [7:0]  data_rx_data_5;
wire    data_rx_valid_5;
wire    data_rx_eop_5;
wire    data_rx_sop_5;
wire [4:0]  data_rx_error_5;
wire [4:0]  pkt_class_data_5;
wire    pkt_class_valid_5;
wire [7:0]  gm_tx_d_5;
wire    gm_tx_en_5;
wire    gm_tx_err_5;
wire [3:0]  m_tx_d_5;
wire    m_tx_en_5;
wire    m_tx_err_5;
wire    ena_10_5;
wire    eth_mode_5;
wire    magic_wakeup_5;
wire    mac_tx_clk_6;
wire    mac_rx_clk_6;
wire    data_tx_ready_6;
wire [7:0]  data_rx_data_6;
wire    data_rx_valid_6;
wire    data_rx_eop_6;
wire    data_rx_sop_6;
wire [4:0]  data_rx_error_6;
wire [4:0]  pkt_class_data_6;
wire    pkt_class_valid_6;
wire [7:0]  gm_tx_d_6;
wire    gm_tx_en_6;
wire    gm_tx_err_6;
wire [3:0]  m_tx_d_6;
wire    m_tx_en_6;
wire    m_tx_err_6;
wire    ena_10_6;
wire    eth_mode_6;
wire    magic_wakeup_6;
wire    mac_tx_clk_7;
wire    mac_rx_clk_7;
wire    data_tx_ready_7;
wire [7:0]  data_rx_data_7;
wire    data_rx_valid_7;
wire    data_rx_eop_7;
wire    data_rx_sop_7;
wire [4:0]  data_rx_error_7;
wire [4:0]  pkt_class_data_7;
wire    pkt_class_valid_7;
wire [7:0]  gm_tx_d_7;
wire    gm_tx_en_7;
wire    gm_tx_err_7;
wire [3:0]  m_tx_d_7;
wire    m_tx_en_7;
wire    m_tx_err_7;
wire    ena_10_7;
wire    eth_mode_7;
wire    magic_wakeup_7;
wire    mac_tx_clk_8;
wire    mac_rx_clk_8;
wire    data_tx_ready_8;
wire [7:0]  data_rx_data_8;
wire    data_rx_valid_8;
wire    data_rx_eop_8;
wire    data_rx_sop_8;
wire [4:0]  data_rx_error_8;
wire [4:0]  pkt_class_data_8;
wire    pkt_class_valid_8;
wire [7:0]  gm_tx_d_8;
wire    gm_tx_en_8;
wire    gm_tx_err_8;
wire [3:0]  m_tx_d_8;
wire    m_tx_en_8;
wire    m_tx_err_8;
wire    ena_10_8;
wire    eth_mode_8;
wire    magic_wakeup_8;
wire    mac_tx_clk_9;
wire    mac_rx_clk_9;
wire    data_tx_ready_9;
wire [7:0]  data_rx_data_9;
wire    data_rx_valid_9;
wire    data_rx_eop_9;
wire    data_rx_sop_9;
wire [4:0]  data_rx_error_9;
wire [4:0]  pkt_class_data_9;
wire    pkt_class_valid_9;
wire [7:0]  gm_tx_d_9;
wire    gm_tx_en_9;
wire    gm_tx_err_9;
wire [3:0]  m_tx_d_9;
wire    m_tx_en_9;
wire    m_tx_err_9;
wire    ena_10_9;
wire    eth_mode_9;
wire    magic_wakeup_9;
wire    mac_tx_clk_10;
wire    mac_rx_clk_10;
wire    data_tx_ready_10;
wire [7:0]  data_rx_data_10;
wire    data_rx_valid_10;
wire    data_rx_eop_10;
wire    data_rx_sop_10;
wire [4:0]  data_rx_error_10;
wire [4:0]  pkt_class_data_10;
wire    pkt_class_valid_10;
wire [7:0]  gm_tx_d_10;
wire    gm_tx_en_10;
wire    gm_tx_err_10;
wire [3:0]  m_tx_d_10;
wire    m_tx_en_10;
wire    m_tx_err_10;
wire    ena_10_10;
wire    eth_mode_10;
wire    magic_wakeup_10;
wire    mac_tx_clk_11;
wire    mac_rx_clk_11;
wire    data_tx_ready_11;
wire [7:0]  data_rx_data_11;
wire    data_rx_valid_11;
wire    data_rx_eop_11;
wire    data_rx_sop_11;
wire [4:0]  data_rx_error_11;
wire [4:0]  pkt_class_data_11;
wire    pkt_class_valid_11;
wire [7:0]  gm_tx_d_11;
wire    gm_tx_en_11;
wire    gm_tx_err_11;
wire [3:0]  m_tx_d_11;
wire    m_tx_en_11;
wire    m_tx_err_11;
wire    ena_11_11;
wire    eth_mode_11;
wire    magic_wakeup_11;
wire    mac_tx_clk_12;
wire    mac_rx_clk_12;
wire    data_tx_ready_12;
wire [7:0]  data_rx_data_12;
wire    data_rx_valid_12;
wire    data_rx_eop_12;
wire    data_rx_sop_12;
wire [4:0]  data_rx_error_12;
wire [4:0]  pkt_class_data_12;
wire    pkt_class_valid_12;
wire [7:0]  gm_tx_d_12;
wire    gm_tx_en_12;
wire    gm_tx_err_12;
wire [3:0]  m_tx_d_12;
wire    m_tx_en_12;
wire    m_tx_err_12;
wire    ena_12_12;
wire    eth_mode_12;
wire    magic_wakeup_12;
wire    mac_tx_clk_13;
wire    mac_rx_clk_13;
wire    data_tx_ready_13;
wire [7:0]  data_rx_data_13;
wire    data_rx_valid_13;
wire    data_rx_eop_13;
wire    data_rx_sop_13;
wire [4:0]  data_rx_error_13;
wire [4:0]  pkt_class_data_13;
wire    pkt_class_valid_13;
wire [7:0]  gm_tx_d_13;
wire    gm_tx_en_13;
wire    gm_tx_err_13;
wire [3:0]  m_tx_d_13;
wire    m_tx_en_13;
wire    m_tx_err_13;
wire    ena_13_13;
wire    eth_mode_13;
wire    magic_wakeup_13;
wire    mac_tx_clk_14;
wire    mac_rx_clk_14;
wire    data_tx_ready_14;
wire [7:0]  data_rx_data_14;
wire    data_rx_valid_14;
wire    data_rx_eop_14;
wire    data_rx_sop_14;
wire [4:0]  data_rx_error_14;
wire [4:0]  pkt_class_data_14;
wire    pkt_class_valid_14;
wire [7:0]  gm_tx_d_14;
wire    gm_tx_en_14;
wire    gm_tx_err_14;
wire [3:0]  m_tx_d_14;
wire    m_tx_en_14;
wire    m_tx_err_14;
wire    ena_14_14;
wire    eth_mode_14;
wire    magic_wakeup_14;
wire    mac_tx_clk_15;
wire    mac_rx_clk_15;
wire    data_tx_ready_15;
wire [7:0]  data_rx_data_15;
wire    data_rx_valid_15;
wire    data_rx_eop_15;
wire    data_rx_sop_15;
wire [4:0]  data_rx_error_15;
wire [4:0]  pkt_class_data_15;
wire    pkt_class_valid_15;
wire [7:0]  gm_tx_d_15;
wire    gm_tx_en_15;
wire    gm_tx_err_15;
wire [3:0]  m_tx_d_15;
wire    m_tx_en_15;
wire    m_tx_err_15;
wire    ena_15_15;
wire    eth_mode_15;
wire    magic_wakeup_15;
wire    mac_tx_clk_16;
wire    mac_rx_clk_16;
wire    data_tx_ready_16;
wire [7:0]  data_rx_data_16;
wire    data_rx_valid_16;
wire    data_rx_eop_16;
wire    data_rx_sop_16;
wire [4:0]  data_rx_error_16;
wire [4:0]  pkt_class_data_16;
wire    pkt_class_valid_16;
wire [7:0]  gm_tx_d_16;
wire    gm_tx_en_16;
wire    gm_tx_err_16;
wire [3:0]  m_tx_d_16;
wire    m_tx_en_16;
wire    m_tx_err_16;
wire    ena_16_16;
wire    eth_mode_16;
wire    magic_wakeup_16;
wire    mac_tx_clk_17;
wire    mac_rx_clk_17;
wire    data_tx_ready_17;
wire [7:0]  data_rx_data_17;
wire    data_rx_valid_17;
wire    data_rx_eop_17;
wire    data_rx_sop_17;
wire [4:0]  data_rx_error_17;
wire [4:0]  pkt_class_data_17;
wire    pkt_class_valid_17;
wire [7:0]  gm_tx_d_17;
wire    gm_tx_en_17;
wire    gm_tx_err_17;
wire [3:0]  m_tx_d_17;
wire    m_tx_en_17;
wire    m_tx_err_17;
wire    ena_17_17;
wire    eth_mode_17;
wire    magic_wakeup_17;
wire    mac_tx_clk_18;
wire    mac_rx_clk_18;
wire    data_tx_ready_18;
wire [7:0]  data_rx_data_18;
wire    data_rx_valid_18;
wire    data_rx_eop_18;
wire    data_rx_sop_18;
wire [4:0]  data_rx_error_18;
wire [4:0]  pkt_class_data_18;
wire    pkt_class_valid_18;
wire [7:0]  gm_tx_d_18;
wire    gm_tx_en_18;
wire    gm_tx_err_18;
wire [3:0]  m_tx_d_18;
wire    m_tx_en_18;
wire    m_tx_err_18;
wire    ena_18_18;
wire    eth_mode_18;
wire    magic_wakeup_18;
wire    mac_tx_clk_19;
wire    mac_rx_clk_19;
wire    data_tx_ready_19;
wire [7:0]  data_rx_data_19;
wire    data_rx_valid_19;
wire    data_rx_eop_19;
wire    data_rx_sop_19;
wire [4:0]  data_rx_error_19;
wire [4:0]  pkt_class_data_19;
wire    pkt_class_valid_19;
wire [7:0]  gm_tx_d_19;
wire    gm_tx_en_19;
wire    gm_tx_err_19;
wire [3:0]  m_tx_d_19;
wire    m_tx_en_19;
wire    m_tx_err_19;
wire    ena_19_19;
wire    eth_mode_19;
wire    magic_wakeup_19;
wire    mac_tx_clk_20;
wire    mac_rx_clk_20;
wire    data_tx_ready_20;
wire [7:0]  data_rx_data_20;
wire    data_rx_valid_20;
wire    data_rx_eop_20;
wire    data_rx_sop_20;
wire [4:0]  data_rx_error_20;
wire [4:0]  pkt_class_data_20;
wire    pkt_class_valid_20;
wire [7:0]  gm_tx_d_20;
wire    gm_tx_en_20;
wire    gm_tx_err_20;
wire [3:0]  m_tx_d_20;
wire    m_tx_en_20;
wire    m_tx_err_20;
wire    ena_20_20;
wire    eth_mode_20;
wire    magic_wakeup_20;
wire    mac_tx_clk_21;
wire    mac_rx_clk_21;
wire    data_tx_ready_21;
wire [7:0]  data_rx_data_21;
wire    data_rx_valid_21;
wire    data_rx_eop_21;
wire    data_rx_sop_21;
wire [4:0]  data_rx_error_21;
wire [4:0]  pkt_class_data_21;
wire    pkt_class_valid_21;
wire [7:0]  gm_tx_d_21;
wire    gm_tx_en_21;
wire    gm_tx_err_21;
wire [3:0]  m_tx_d_21;
wire    m_tx_en_21;
wire    m_tx_err_21;
wire    ena_21_21;
wire    eth_mode_21;
wire    magic_wakeup_21;
wire    mac_tx_clk_22;
wire    mac_rx_clk_22;
wire    data_tx_ready_22;
wire [7:0]  data_rx_data_22;
wire    data_rx_valid_22;
wire    data_rx_eop_22;
wire    data_rx_sop_22;
wire [4:0]  data_rx_error_22;
wire [4:0]  pkt_class_data_22;
wire    pkt_class_valid_22;
wire [7:0]  gm_tx_d_22;
wire    gm_tx_en_22;
wire    gm_tx_err_22;
wire [3:0]  m_tx_d_22;
wire    m_tx_en_22;
wire    m_tx_err_22;
wire    ena_22_22;
wire    eth_mode_22;
wire    magic_wakeup_22;
wire    mac_tx_clk_23;
wire    mac_rx_clk_23;
wire    data_tx_ready_23;
wire [7:0]  data_rx_data_23;
wire    data_rx_valid_23;
wire    data_rx_eop_23;
wire    data_rx_sop_23;
wire [4:0]  data_rx_error_23;
wire [4:0]  pkt_class_data_23;
wire    pkt_class_valid_23;
wire [7:0]  gm_tx_d_23;
wire    gm_tx_en_23;
wire    gm_tx_err_23;
wire [3:0]  m_tx_d_23;
wire    m_tx_en_23;
wire    m_tx_err_23;
wire    ena_23_23;
wire    eth_mode_23;
wire    magic_wakeup_23;

wire   tbi_rx_clk_0;             //  125MHz Recoved Clock
wire   tbi_tx_clk_0;             //  125MHz Transmit Clock
wire   [9:0] tbi_rx_d_0;         //  Non Aligned 10-Bit Characters
wire  [9:0] tbi_tx_d_0;         //  Transmit TBI Interface
wire  sd_loopback_0;            //  SERDES Loopback Enable
wire  powerdown_0;              //  Powerdown Enable
wire  led_crs_0;                //  Carrier Sense
wire  led_link_0;               //  Valid Link 
wire  led_col_0;                //  Collision Indication
wire  led_an_0;                 //  Auto-Negotiation Status
wire  led_char_err_0;           //  Character Error
wire  led_disp_err_0;           //  Disparity Error
//
wire   tbi_rx_clk_1;             //  125MHz Recoved Clock
wire   tbi_tx_clk_1;             //  125MHz Transmit Clock
wire   [9:0] tbi_rx_d_1;         //  Non Aligned 10-Bit Characters
wire  [9:0] tbi_tx_d_1;         //  Transmit TBI Interface
wire  sd_loopback_1;            //  SERDES Loopback Enable
wire  powerdown_1;              //  Powerdown Enable
wire  led_crs_1;                //  Carrier Sense
wire  led_link_1;               //  Valid Link 
wire  led_col_1;                //  Collision Indication
wire  led_an_1;                 //  Auto-Negotiation Status
wire  led_char_err_1;           //  Character Error
wire  led_disp_err_1;           //  Disparity Error
//
wire   tbi_rx_clk_2;             //  125MHz Recoved Clock
wire   tbi_tx_clk_2;             //  125MHz Transmit Clock
wire   [9:0] tbi_rx_d_2;         //  Non Aligned 10-Bit Characters
wire  [9:0] tbi_tx_d_2;         //  Transmit TBI Interface
wire  sd_loopback_2;            //  SERDES Loopback Enable
wire  powerdown_2;              //  Powerdown Enable
wire  led_crs_2;                //  Carrier Sense
wire  led_link_2;               //  Valid Link 
wire  led_col_2;                //  Collision Indication
wire  led_an_2;                 //  Auto-Negotiation Status
wire  led_char_err_2;           //  Character Error
wire  led_disp_err_2;           //  Disparity Error
//
wire   tbi_rx_clk_3;             //  125MHz Recoved Clock
wire   tbi_tx_clk_3;             //  125MHz Transmit Clock
wire   [9:0] tbi_rx_d_3;         //  Non Aligned 10-Bit Characters
wire  [9:0] tbi_tx_d_3;         //  Transmit TBI Interface
wire  sd_loopback_3;            //  SERDES Loopback Enable
wire  powerdown_3;              //  Powerdown Enable
wire  led_crs_3;                //  Carrier Sense
wire  led_link_3;               //  Valid Link 
wire  led_col_3;                //  Collision Indication
wire  led_an_3;                 //  Auto-Negotiation Status
wire  led_char_err_3;           //  Character Error
wire  led_disp_err_3;           //  Disparity Error
//
wire   tbi_rx_clk_4;             //  125MHz Recoved Clock
wire   tbi_tx_clk_4;             //  125MHz Transmit Clock
wire   [9:0] tbi_rx_d_4;         //  Non Aligned 10-Bit Characters
wire  [9:0] tbi_tx_d_4;         //  Transmit TBI Interface
wire  sd_loopback_4;            //  SERDES Loopback Enable
wire  powerdown_4;              //  Powerdown Enable
wire  led_crs_4;                //  Carrier Sense
wire  led_link_4;               //  Valid Link 
wire  led_col_4;                //  Collision Indication
wire  led_an_4;                 //  Auto-Negotiation Status
wire  led_char_err_4;           //  Character Error
wire  led_disp_err_4;           //  Disparity Error
//
wire   tbi_rx_clk_5;             //  125MHz Recoved Clock
wire   tbi_tx_clk_5;             //  125MHz Transmit Clock
wire   [9:0] tbi_rx_d_5;         //  Non Aligned 10-Bit Characters
wire  [9:0] tbi_tx_d_5;         //  Transmit TBI Interface
wire  sd_loopback_5;            //  SERDES Loopback Enable
wire  powerdown_5;              //  Powerdown Enable
wire  led_crs_5;                //  Carrier Sense
wire  led_link_5;               //  Valid Link 
wire  led_col_5;                //  Collision Indication
wire  led_an_5;                 //  Auto-Negotiation Status
wire  led_char_err_5;           //  Character Error
wire  led_disp_err_5;           //  Disparity Error
//
wire   tbi_rx_clk_6;             //  125MHz Recoved Clock
wire   tbi_tx_clk_6;             //  125MHz Transmit Clock
wire   [9:0] tbi_rx_d_6;         //  Non Aligned 10-Bit Characters
wire  [9:0] tbi_tx_d_6;         //  Transmit TBI Interface
wire  sd_loopback_6;            //  SERDES Loopback Enable
wire  powerdown_6;              //  Powerdown Enable
wire  led_crs_6;                //  Carrier Sense
wire  led_link_6;               //  Valid Link 
wire  led_col_6;                //  Collision Indication
wire  led_an_6;                 //  Auto-Negotiation Status
wire  led_char_err_6;           //  Character Error
wire  led_disp_err_6;           //  Disparity Error
//
wire   tbi_rx_clk_7;             //  125MHz Recoved Clock
wire   tbi_tx_clk_7;             //  125MHz Transmit Clock
wire   [9:0] tbi_rx_d_7;         //  Non Aligned 10-Bit Characters
wire  [9:0] tbi_tx_d_7;         //  Transmit TBI Interface
wire  sd_loopback_7;            //  SERDES Loopback Enable
wire  powerdown_7;              //  Powerdown Enable
wire  led_crs_7;                //  Carrier Sense
wire  led_link_7;               //  Valid Link 
wire  led_col_7;                //  Collision Indication
wire  led_an_7;                 //  Auto-Negotiation Status
wire  led_char_err_7;           //  Character Error
wire  led_disp_err_7;           //  Disparity Error
//
wire   tbi_rx_clk_8;             //  125MHz Recoved Clock
wire   tbi_tx_clk_8;             //  125MHz Transmit Clock
wire   [9:0] tbi_rx_d_8;         //  Non Aligned 10-Bit Characters
wire  [9:0] tbi_tx_d_8;         //  Transmit TBI Interface
wire  sd_loopback_8;            //  SERDES Loopback Enable
wire  powerdown_8;              //  Powerdown Enable
wire  led_crs_8;                //  Carrier Sense
wire  led_link_8;               //  Valid Link 
wire  led_col_8;                //  Collision Indication
wire  led_an_8;                 //  Auto-Negotiation Status
wire  led_char_err_8;           //  Character Error
wire  led_disp_err_8;           //  Disparity Error
//
wire   tbi_rx_clk_9;             //  125MHz Recoved Clock
wire   tbi_tx_clk_9;             //  125MHz Transmit Clock
wire   [9:0] tbi_rx_d_9;         //  Non Aligned 10-Bit Characters
wire  [9:0] tbi_tx_d_9;         //  Transmit TBI Interface
wire  sd_loopback_9;            //  SERDES Loopback Enable
wire  powerdown_9;              //  Powerdown Enable
wire  led_crs_9;                //  Carrier Sense
wire  led_link_9;               //  Valid Link 
wire  led_col_9;                //  Collision Indication
wire  led_an_9;                 //  Auto-Negotiation Status
wire  led_char_err_9;           //  Character Error
wire  led_disp_err_9;           //  Disparity Error
//
wire   tbi_rx_clk_10;             //  125MHz Recoved Clock
wire   tbi_tx_clk_10;             //  125MHz Transmit Clock
wire   [9:0] tbi_rx_d_10;         //  Non Aligned 10-Bit Characters
wire  [9:0] tbi_tx_d_10;         //  Transmit TBI Interface
wire  sd_loopback_10;            //  SERDES Loopback Enable
wire  powerdown_10;              //  Powerdown Enable
wire  led_crs_10;                //  Carrier Sense
wire  led_link_10;               //  Valid Link 
wire  led_col_10;                //  Collision Indication
wire  led_an_10;                 //  Auto-Negotiation Status
wire  led_char_err_10;           //  Character Error
wire  led_disp_err_10;           //  Disparity Error

//
wire   tbi_rx_clk_11;             //  125MHz Recoved Clock
wire   tbi_tx_clk_11;             //  125MHz Transmit Clock
wire   [9:0] tbi_rx_d_11;         //  Non Aligned 10-Bit Characters
wire  [9:0] tbi_tx_d_11;         //  Transmit TBI Interface
wire  sd_loopback_11;            //  SERDES Loopback Enable
wire  powerdown_11;              //  Powerdown Enable
wire  led_crs_11;                //  Carrier Sense
wire  led_link_11;               //  Valid Link 
wire  led_col_11;                //  Collision Indication
wire  led_an_11;                 //  Auto-Negotiation Status
wire  led_char_err_11;           //  Character Error
wire  led_disp_err_11;           //  Disparity Error
//
wire   tbi_rx_clk_12;             //  125MHz Recoved Clock
wire   tbi_tx_clk_12;             //  125MHz Transmit Clock
wire   [9:0] tbi_rx_d_12;         //  Non Aligned 10-Bit Characters
wire  [9:0] tbi_tx_d_12;         //  Transmit TBI Interface
wire  sd_loopback_12;            //  SERDES Loopback Enable
wire  powerdown_12;              //  Powerdown Enable
wire  led_crs_12;                //  Carrier Sense
wire  led_link_12;               //  Valid Link 
wire  led_col_12;                //  Collision Indication
wire  led_an_12;                 //  Auto-Negotiation Status
wire  led_char_err_12;           //  Character Error
wire  led_disp_err_12;           //  Disparity Error
//
wire   tbi_rx_clk_13;             //  125MHz Recoved Clock
wire   tbi_tx_clk_13;             //  125MHz Transmit Clock
wire   [9:0] tbi_rx_d_13;         //  Non Aligned 10-Bit Characters
wire  [9:0] tbi_tx_d_13;         //  Transmit TBI Interface
wire  sd_loopback_13;            //  SERDES Loopback Enable
wire  powerdown_13;              //  Powerdown Enable
wire  led_crs_13;                //  Carrier Sense
wire  led_link_13;               //  Valid Link 
wire  led_col_13;                //  Collision Indication
wire  led_an_13;                 //  Auto-Negotiation Status
wire  led_char_err_13;           //  Character Error
wire  led_disp_err_13;           //  Disparity Error
//
wire   tbi_rx_clk_14;             //  125MHz Recoved Clock
wire   tbi_tx_clk_14;             //  125MHz Transmit Clock
wire   [9:0] tbi_rx_d_14;         //  Non Aligned 10-Bit Characters
wire  [9:0] tbi_tx_d_14;         //  Transmit TBI Interface
wire  sd_loopback_14;            //  SERDES Loopback Enable
wire  powerdown_14;              //  Powerdown Enable
wire  led_crs_14;                //  Carrier Sense
wire  led_link_14;               //  Valid Link 
wire  led_col_14;                //  Collision Indication
wire  led_an_14;                 //  Auto-Negotiation Status
wire  led_char_err_14;           //  Character Error
wire  led_disp_err_14;           //  Disparity Error
//
wire   tbi_rx_clk_15;             //  125MHz Recoved Clock
wire   tbi_tx_clk_15;             //  125MHz Transmit Clock
wire   [9:0] tbi_rx_d_15;         //  Non Aligned 10-Bit Characters
wire  [9:0] tbi_tx_d_15;         //  Transmit TBI Interface
wire  sd_loopback_15;            //  SERDES Loopback Enable
wire  powerdown_15;              //  Powerdown Enable
wire  led_crs_15;                //  Carrier Sense
wire  led_link_15;               //  Valid Link 
wire  led_col_15;                //  Collision Indication
wire  led_an_15;                 //  Auto-Negotiation Status
wire  led_char_err_15;           //  Character Error
wire  led_disp_err_15;           //  Disparity Error


//
wire   tbi_rx_clk_16;             //  125MHz Recoved Clock
wire   tbi_tx_clk_16;             //  125MHz Transmit Clock
wire   [9:0] tbi_rx_d_16;         //  Non Aligned 10-Bit Characters
wire  [9:0] tbi_tx_d_16;         //  Transmit TBI Interface
wire  sd_loopback_16;            //  SERDES Loopback Enable
wire  powerdown_16;              //  Powerdown Enable
wire  led_crs_16;                //  Carrier Sense
wire  led_link_16;               //  Valid Link 
wire  led_col_16;                //  Collision Indication
wire  led_an_16;                 //  Auto-Negotiation Status
wire  led_char_err_16;           //  Character Error
wire  led_disp_err_16;           //  Disparity Error
//
wire   tbi_rx_clk_17;             //  125MHz Recoved Clock
wire   tbi_tx_clk_17;             //  125MHz Transmit Clock
wire   [9:0] tbi_rx_d_17;         //  Non Aligned 10-Bit Characters
wire  [9:0] tbi_tx_d_17;         //  Transmit TBI Interface
wire  sd_loopback_17;            //  SERDES Loopback Enable
wire  powerdown_17;              //  Powerdown Enable
wire  led_crs_17;                //  Carrier Sense
wire  led_link_17;               //  Valid Link 
wire  led_col_17;                //  Collision Indication
wire  led_an_17;                 //  Auto-Negotiation Status
wire  led_char_err_17;           //  Character Error
wire  led_disp_err_17;           //  Disparity Error

//
wire   tbi_rx_clk_18;             //  125MHz Recoved Clock
wire   tbi_tx_clk_18;             //  125MHz Transmit Clock
wire   [9:0] tbi_rx_d_18;         //  Non Aligned 10-Bit Characters
wire  [9:0] tbi_tx_d_18;         //  Transmit TBI Interface
wire  sd_loopback_18;            //  SERDES Loopback Enable
wire  powerdown_18;              //  Powerdown Enable
wire  led_crs_18;                //  Carrier Sense
wire  led_link_18;               //  Valid Link 
wire  led_col_18;                //  Collision Indication
wire  led_an_18;                 //  Auto-Negotiation Status
wire  led_char_err_18;           //  Character Error
wire  led_disp_err_18;           //  Disparity Error

//
wire   tbi_rx_clk_19;             //  125MHz Recoved Clock
wire   tbi_tx_clk_19;             //  125MHz Transmit Clock
wire   [9:0] tbi_rx_d_19;         //  Non Aligned 10-Bit Characters
wire  [9:0] tbi_tx_d_19;         //  Transmit TBI Interface
wire  sd_loopback_19;            //  SERDES Loopback Enable
wire  powerdown_19;              //  Powerdown Enable
wire  led_crs_19;                //  Carrier Sense
wire  led_link_19;               //  Valid Link 
wire  led_col_19;                //  Collision Indication
wire  led_an_19;                 //  Auto-Negotiation Status
wire  led_char_err_19;           //  Character Error
wire  led_disp_err_19;           //  Disparity Error

//
wire   tbi_rx_clk_20;             //  125MHz Recoved Clock
wire   tbi_tx_clk_20;             //  125MHz Transmit Clock
wire   [9:0] tbi_rx_d_20;         //  Non Aligned 10-Bit Characters
wire  [9:0] tbi_tx_d_20;         //  Transmit TBI Interface
wire  sd_loopback_20;            //  SERDES Loopback Enable
wire  powerdown_20;              //  Powerdown Enable
wire  led_crs_20;                //  Carrier Sense
wire  led_link_20;               //  Valid Link 
wire  led_col_20;                //  Collision Indication
wire  led_an_20;                 //  Auto-Negotiation Status
wire  led_char_err_20;           //  Character Error
wire  led_disp_err_20;           //  Disparity Error

//
wire   tbi_rx_clk_21;             //  125MHz Recoved Clock
wire   tbi_tx_clk_21;             //  125MHz Transmit Clock
wire   [9:0] tbi_rx_d_21;         //  Non Aligned 10-Bit Characters
wire  [9:0] tbi_tx_d_21;         //  Transmit TBI Interface
wire  sd_loopback_21;            //  SERDES Loopback Enable
wire  powerdown_21;              //  Powerdown Enable
wire  led_crs_21;                //  Carrier Sense
wire  led_link_21;               //  Valid Link 
wire  led_col_21;                //  Collision Indication
wire  led_an_21;                 //  Auto-Negotiation Status
wire  led_char_err_21;           //  Character Error
wire  led_disp_err_21;           //  Disparity Error

//
wire   tbi_rx_clk_22;             //  125MHz Recoved Clock
wire   tbi_tx_clk_22;             //  125MHz Transmit Clock
wire   [9:0] tbi_rx_d_22;         //  Non Aligned 10-Bit Characters
wire  [9:0] tbi_tx_d_22;         //  Transmit TBI Interface
wire  sd_loopback_22;            //  SERDES Loopback Enable
wire  powerdown_22;              //  Powerdown Enable
wire  led_crs_22;                //  Carrier Sense
wire  led_link_22;               //  Valid Link 
wire  led_col_22;                //  Collision Indication
wire  led_an_22;                 //  Auto-Negotiation Status
wire  led_char_err_22;           //  Character Error
wire  led_disp_err_22;           //  Disparity Error

//
wire   tbi_rx_clk_23;             //  125MHz Recoved Clock
wire   tbi_tx_clk_23;             //  125MHz Transmit Clock
wire   [9:0] tbi_rx_d_23;         //  Non Aligned 10-Bit Characters
wire  [9:0] tbi_tx_d_23;         //  Transmit TBI Interface
wire  sd_loopback_23;            //  SERDES Loopback Enable
wire  powerdown_23;              //  Powerdown Enable
wire  led_crs_23;                //  Carrier Sense
wire  led_link_23;               //  Valid Link 
wire  led_col_23;                //  Collision Indication
wire  led_an_23;                 //  Auto-Negotiation Status
wire  led_char_err_23;           //  Character Error
wire  led_disp_err_23;           //  Disparity Error

// DEVICE SPECIFIC SIGNALS
wire   gxb_cal_blk_clk;            //  GXB Calibration Clock
wire   ref_clk;                    //  Reference Clock


wire   rxp_0;                    //  Differential Receive Data 
wire  txp_0;                    //  Differential Receive Data 
wire   gxb_pwrdn_in_0;           //  Powerdown signal to GXB
wire  pcs_pwrdn_out_0;          //  Powerdown Enable from PCS

wire   rxp_1;                    //  Differential Receive Data 
wire  txp_1;                    //  Differential Receive Data 
wire   gxb_pwrdn_in_1;           //  Powerdown signal to GXB
wire  pcs_pwrdn_out_1;          //  Powerdown Enable from PCS

wire   rxp_2;                    //  Differential Receive Data 
wire  txp_2;                    //  Differential Receive Data 
wire   gxb_pwrdn_in_2;           //  Powerdown signal to GXB
wire  pcs_pwrdn_out_2;          //  Powerdown Enable from PCS

wire   rxp_3;                    //  Differential Receive Data 
wire  txp_3;                    //  Differential Receive Data 
wire   gxb_pwrdn_in_3;           //  Powerdown signal to GXB
wire  pcs_pwrdn_out_3;          //  Powerdown Enable from PCS

wire   rxp_4;                    //  Differential Receive Data 
wire  txp_4;                    //  Differential Receive Data 
wire   gxb_pwrdn_in_4;           //  Powerdown signal to GXB
wire  pcs_pwrdn_out_4;          //  Powerdown Enable from PCS

wire   rxp_5;                    //  Differential Receive Data 
wire  txp_5;                    //  Differential Receive Data 
wire   gxb_pwrdn_in_5;           //  Powerdown signal to GXB
wire  pcs_pwrdn_out_5;          //  Powerdown Enable from PCS
wire   rxp_6;                    //  Differential Receive Data 
wire  txp_6;                    //  Differential Receive Data 
wire   gxb_pwrdn_in_6;           //  Powerdown signal to GXB
wire  pcs_pwrdn_out_6;          //  Powerdown Enable from PCS
wire   rxp_7;                    //  Differential Receive Data 
wire  txp_7;                    //  Differential Receive Data 
wire   gxb_pwrdn_in_7;           //  Powerdown signal to GXB
wire  pcs_pwrdn_out_7;          //  Powerdown Enable from PCS
wire   rxp_8;                    //  Differential Receive Data 
wire  txp_8;                    //  Differential Receive Data 
wire   gxb_pwrdn_in_8;           //  Powerdown signal to GXB
wire  pcs_pwrdn_out_8;          //  Powerdown Enable from PCS
wire   rxp_9;                    //  Differential Receive Data 
wire  txp_9;                    //  Differential Receive Data 
wire   gxb_pwrdn_in_9;           //  Powerdown signal to GXB
wire  pcs_pwrdn_out_9;          //  Powerdown Enable from PCS
wire   rxp_10;                    //  Differential Receive Data 
wire  txp_10;                    //  Differential Receive Data 
wire   gxb_pwrdn_in_10;           //  Powerdown signal to GXB
wire  pcs_pwrdn_out_10;          //  Powerdown Enable from PCS
wire   rxp_11;                    //  Differential Receive Data 
wire  txp_11;                    //  Differential Receive Data 
wire   gxb_pwrdn_in_11;           //  Powerdown signal to GXB
wire  pcs_pwrdn_out_11;          //  Powerdown Enable from PCS

wire   rxp_12;                    //  Differential Receive Data 
wire  txp_12;                    //  Differential Receive Data 
wire   gxb_pwrdn_in_12;           //  Powerdown signal to GXB
wire  pcs_pwrdn_out_12;          //  Powerdown Enable from PCS
wire   rxp_13;                    //  Differential Receive Data 
wire  txp_13;                    //  Differential Receive Data 
wire   gxb_pwrdn_in_13;           //  Powerdown signal to GXB
wire  pcs_pwrdn_out_13;          //  Powerdown Enable from PCS
wire   rxp_14;                    //  Differential Receive Data 
wire  txp_14;                    //  Differential Receive Data 
wire   gxb_pwrdn_in_14;           //  Powerdown signal to GXB
wire  pcs_pwrdn_out_14;          //  Powerdown Enable from PCS
wire   rxp_15;                    //  Differential Receive Data 
wire  txp_15;                    //  Differential Receive Data 
wire   gxb_pwrdn_in_15;           //  Powerdown signal to GXB
wire  pcs_pwrdn_out_15;          //  Powerdown Enable from PCS
wire   rxp_16;                    //  Differential Receive Data 
wire  txp_16;                    //  Differential Receive Data 
wire   gxb_pwrdn_in_16;           //  Powerdown signal to GXB
wire  pcs_pwrdn_out_16;          //  Powerdown Enable from PCS
wire   rxp_17;                    //  Differential Receive Data 
wire  txp_17;                    //  Differential Receive Data 
wire   gxb_pwrdn_in_17;           //  Powerdown signal to GXB
wire  pcs_pwrdn_out_17;          //  Powerdown Enable from PCS
wire   rxp_18;                    //  Differential Receive Data 
wire  txp_18;                    //  Differential Receive Data 
wire   gxb_pwrdn_in_18;           //  Powerdown signal to GXB
wire  pcs_pwrdn_out_18;          //  Powerdown Enable from PCS
wire   rxp_19;                    //  Differential Receive Data 
wire  txp_19;                    //  Differential Receive Data 
wire   gxb_pwrdn_in_19;           //  Powerdown signal to GXB
wire  pcs_pwrdn_out_19;          //  Powerdown Enable from PCS
wire   rxp_20;                    //  Differential Receive Data 
wire  txp_20;                    //  Differential Receive Data 
wire   gxb_pwrdn_in_20;           //  Powerdown signal to GXB
wire  pcs_pwrdn_out_20;          //  Powerdown Enable from PCS
wire   rxp_21;                    //  Differential Receive Data 
wire  txp_21;                    //  Differential Receive Data 
wire   gxb_pwrdn_in_21;           //  Powerdown signal to GXB
wire  pcs_pwrdn_out_21;          //  Powerdown Enable from PCS
wire   rxp_22;                    //  Differential Receive Data 
wire  txp_22;                    //  Differential Receive Data 
wire   gxb_pwrdn_in_22;           //  Powerdown signal to GXB
wire  pcs_pwrdn_out_22;          //  Powerdown Enable from PCS
wire   rxp_23;                    //  Differential Receive Data 
wire  txp_23;                    //  Differential Receive Data 
wire   gxb_pwrdn_in_23;           //  Powerdown signal to GXB
wire  pcs_pwrdn_out_23;          //  Powerdown Enable from PCS



//////////////// PCS

//  PCS Status
//  ----------

wire    led_crs;                //  Carrier Sense
wire    led_link;               //  Valid Link
wire    led_col;                //  Collision
wire    led_an;                 //  Auto-Negotiation Status
wire    led_char_err;           //  Character Error
wire    led_disp_err;           //  Disparity Error

//  PCS Control
//  -----------

wire    sd_loopback;            //  SERDES Loopback Enable
wire    powerdown;              //  Powerdown Control                   

//  TBI Interface
//  -------------

wire    [9:0] tbi_rx_d;          //  Non Aligned 10-Bit Characters                       
wire    [9:0] tbi_tx_d;          //  Transmit TBI Interface
wire    [9:0] tbi_rx_d_pcs;      //  Non Aligned 10-Bit Characters                       
wire    [9:0] tbi_tx_d_pcs;      //  Transmit TBI Interface

//  Clocks
//  ------

wire    tbi_rx_clk;             //  TBI Receive Clock
wire    tbi_tx_clk;             //  TBI Transmit Clock 


//////////////// MAC

//  FIFO and Magic Detection Status Signals
//  ---------------------------------------
wire   magic_wakeup;     //magic detection wakeup status
wire   ff_rx_a_full;        //receive fifo almost full
wire   ff_rx_a_empty;       //receive fifo almost empty
wire   ff_tx_a_full;        //transmit fifo almost full
wire   ff_tx_a_empty;       //transmit fifo almost empty

//  Atlantic II Interface
//  --------------
wire   [5:0] rx_err;
wire   [17:0] rx_err_stat;
wire   [3:0] rx_frm_type;

reg    reset; 
reg    reset_model = 1'b0; 
reg    reset_mdio  = 1'b0;

//  MDIO Interface
//  --------------
wire    mdio;
reg     mdio_tmp;                       //  Management Data
wire    [4:0] phy_addr0;                //  PHY 0 Address
wire    [4:0] phy_addr1;                //  PHY 1 Address
wire    mdio0_done;                     //  Slave MDIO 0 Access Done
wire    mdio1_done;                     //  Slave MDIO 1 Access Done

//  Receive GMII Interface
//  ----------------------

reg     rx_clk;                         //  GMII Receive clock       
reg     rx_clk_1000mbps;                    //  GMII Transmit clock       
reg     rx_clk_100mbps;                     //  GMII Transmit clock       
reg     rx_clk_10mbps;                      //  GMII Transmit clock 
reg     [7:0] gm_rx_data;               //  GMII Receive data        
reg     gm_rx_en;                       //  GMII Receive frame enable
reg     gm_rx_err;                      //  GMII Receive frame error
 
//  Transmit GMII Interface
//  -----------------------

reg     tx_clk;                         //  GMII Transmit clock       
reg     tx_clk_1000mbps;                    //  GMII Transmit clock       
reg     tx_clk_100mbps;                     //  GMII Transmit clock       
reg     tx_clk_10mbps;                      //  GMII Transmit clock 
wire    [7:0] gm_tx_data;               //  GMII Transmit data        
wire    gm_tx_en;                       //  GMII Transmit frame enable
wire    gm_tx_err;                      //  GMII Transmit frame error

//  Receive MII Interface
//  ---------------------

reg     [3:0] m_rx_data;                //  MII Receive data        
reg     m_rx_en;                        //  MII Receive frame enable
reg     m_rx_err;                       //  MII Receive frame error 
wire    m_rx_crs;                       //  MII Carrier Sense
wire    m_rx_crs_hd;                    //  MII Carrier Sense
wire    m_rx_crs_fd;                    //  MII Carrier Sense
wire    m_rx_col;                       //  MII Collision
reg     m_rx_col_hd;                    //  MII Collision
wire    m_rx_col_fd;                    //  MII Collision
 
//  Transmit MII Interface
//  ----------------------

wire    [3:0] m_tx_data;                //  MII Transmit data        
wire    [7:0] m_tx_data_tmp;            //  MII Transmit data        
wire    m_tx_en;                        //  MII Transmit frame enable
wire    m_tx_err;                       //  MII Transmit frame error

//  Receive User Interface
//  ----------------------
     
reg     ff_rx_clk_internal;             //  Receive Local Clock    
wire    ff_rx_clk;                      //  Receive Local Clock
wire    [7:0] ff_rx_data;               //  Data
wire    ff_rx_sop;                      //  Start of Packet
wire    ff_rx_eop;                      //  End of Packet
wire    ff_rx_err;                      //  Errored Packet Indication (Parity, POS-PHY Errored or Oversized Packet)
wire    [22:0] ff_rx_err_stat;          //  Errored Packet Status Word
wire    ff_rx_rdy;                      //  PHY Application Ready
wire    ff_rx_dval;                     //  Data Valid Strobe
wire    ff_rx_dsav;                     //  Data Available
wire    ff_rx_ucast;                    //  Unicast Frame Indication
wire    ff_rx_bcast;                    //  Broadcast Frame Indication
wire    ff_rx_mcast;                    //  Multicast Frame Indication
wire    ff_rx_vlan;                     //  VLAN Frame Indication
reg     ff_rx_ucast_reg;                //  Unicast Frame Indication
reg     ff_rx_bcast_reg;                //  Broadcast Frame Indication
reg     ff_rx_mcast_reg;                //  Multicast Frame Indication
reg     ff_rx_vlan_reg;                 //  VLAN Frame Indication
    
//  Transmit User Interface
//  -----------------------
    
reg     ff_tx_clk_internal;             //  Transmit Local Clock    
wire    ff_tx_clk;                      //  Transmit Local Clock    
wire    [7:0] ff_tx_data;               //  Data
wire    ff_tx_sop;                      //  Start of Packet
wire    ff_tx_eop;                      //  End of Packet
wire    ff_tx_err;                      //  Errored Packet
wire    ff_tx_wren;                     //  Write Enable
wire    ff_tx_crc_fwd;                  //  Forward Frame with CRC from Application

wire    ff_tx_rdy;                      //  FIFO Ready          
wire    ff_tx_septy;                    //  FIFO section empty
wire    tx_ff_uflow;                    //  TX FIFO underflow occured (Synchronous with tx_clk)
wire    ff_pause_gen;                   //  TX FIFO pause frame generation

//  Ethernet MAC Configuration
//  --------------------------


reg     xoff_gen;                       //  Xoff Pause frame generate 
reg     xon_gen;                        //  Xon Pause frame generate 
wire    [47:0] mac_addr;                //  Device Ethernet MAC address
wire    [47:0] sup_mac_addr_0;          //  Supplemental Ethernet MAC address
wire    [47:0] sup_mac_addr_1;          //  Supplemental Ethernet MAC address
wire    [47:0] sup_mac_addr_2;          //  Supplemental Ethernet MAC address
wire    [47:0] sup_mac_addr_3;          //  Supplemental Ethernet MAC address
wire    promis_en;                      //  Enable promiscuous mode: accept any frame
wire    [15:0] frm_length_max;          //  Maximium Received Frame length         
reg     ethernet_mode;                  //  Ethernet Mode (1 for Gigabit)

//  Event Triggers
//  --------------

wire    pause_rcv;                      //  Pause Frame Receive Indication
wire    frm_rcv;                        //  Frame Receive Indication
wire    frm_tx;                         //  Frame Transmit Indication
wire    frm_align_err;                  //  Received Frame Aligment Error Indication
wire    frm_type_err;                   //  Received Frame type Error Indication
wire    frm_length_err;                 //  Received Frame length Error Indication
wire    frm_crc_err;                    //  Received Frame CRC_32 Error Indication

//  Ethernet Generator Config (GMII RX)
//  -----------------------------------

wire    [7:0] gm_rxgen_rx_d;            //  gmii receive data
wire    gm_rxgen_rx_en;                 //  gmii receive frame enable  
wire    gm_rxgen_rx_err;                //  gmii receive frame error        
wire    [7:0] m_rxgen_rx_d;             //  mii receive data
wire    m_rxgen_rx_en;                  //  mii receive frame enable  
wire    m_rxgen_rx_err;                 //  mii receive frame error                     
wire    gm_mac_reverse;                 //  1: dst/src are sent MSB first
reg     [47:0] gm_dst;                  //  destination address
wire    [47:0] gm_src;                  //  source address    
wire    [4:0] gm_prmble_len;            //  length of preamble
wire    [15:0] gm_pquant;               //  Pause Quanta value
wire    [15:0] gm_vlan_ctl;             //  VLAN control info
reg     [15:0] gm_len;                  //  Length of payload
wire    [15:0] gm_frmtype;              //  if non-null: type field instead length      
wire    [7:0] gm_cntstart;              //  payload data counter start (first byte of payload)
wire    [7:0] gm_cntstep;               //  payload counter step (2nd byte in paylaod)
wire    gm_payload_err;                 //  generate payload pattern error (last payload byte is wrong)
wire    gm_prmbl_err; 
wire    gm_crc_err; 
wire    gm_pause_gen; 
wire    gm_vlan_en; 
wire    gm_stack_vlan_en;
wire    gm_pad_en; 
wire    gm_phy_err; 
wire    gm_end_err;                     //  keep rx_dv high one cycle after end of frame
wire   [15:0] gm_ipg_len;               //  inter packet gap (delay after CRC) 
reg    [15:0] gm_ipg_cnt;
integer free_ipg_cnt;


//  FIFO Generator Config (user app FIFO TX)
//  ----------------------------------------

wire    ff_mac_reverse;                 //  1: dst/src are sent MSB first
wire    [47:0] ff_dst;                  //  destination address
wire    [47:0] ff_src;                  //  source address    
wire    [3:0] ff_prmble_len;            //  length of preamble
wire    [15:0] ff_pquant;               //  Pause Quanta value
wire    [15:0] ff_vlan_ctl;             //  VLAN control info
reg     [15:0] ff_len;                  //  Length of payload
wire    [15:0] ff_frmtype;              //  if non-null: type field instead length      
wire    [7:0] ff_cntstart;              //  payload data counter start (first byte of payload)
wire    [7:0] ff_cntstep;               //  payload counter step (2nd byte in paylaod)
wire    [15:0] ff_ipg_len;              //  inter packet gap (delay after CRC)         
wire    ff_payload_err;                 //  generate payload pattern error (last payload byte is wrong)
wire    ff_prmbl_err; 
wire    ff_crc_err; 
wire    ff_vlan_en; 
wire    ff_stack_vlan_en; 
wire    ff_pad_en; 
wire    ff_phy_err; 
wire    ff_end_err;                     //  keep rx_dv high one cycle after end of frame

//  Register Interface
//  ------------------

reg     reg_clk;                        //  25MHz Host Interface Clock
reg     reg_rd;                         //  Register Read Strobe
reg     reg_wr;                         //  Register Write Strobe
reg     [13:0] reg_addr;                 //  Register Address
reg     [31:0] reg_data_in;             //  Write Data for Host Bus
wire    [31:0] reg_data_out;            //  Read Data to Host Bus
wire    reg_busy;                       //  Interface Busy
reg     reg_busy_reg;                   //  Interface Busy
wire    magic_sleep_n;                     //  Enable Sleep Mode
wire    reg_wakeup;                     //  Wake Up Request

//  Half Duplex Colision Control
//  ----------------------------

integer rx_nib_cnt;                     //  Nibble Counter
integer tx_nib_cnt;                     //  Nibble Counter
wire    tx_col_reg;                     //  Packet Transmitted with Col                
wire    tx_col_reg_fd;                  //  Packet Transmitted with Col                
reg     tx_col_reg_hd;                  //  Packet Transmitted with Col

//  Ethernet TX Monitor
//  -------------------

wire    [47:0] mgm_dst;                 //  destination address
wire    [47:0] mgm_src;                 //  source address
wire    [13:0] mgm_prmble_len;          //  length of preamble
wire    [15:0] mgm_pquant;              //  Pause Quanta value
wire    [15:0] mgm_vlan_ctl;            //  VLAN control info
wire    [15:0] mgm_len;                 //  Length of payload
wire    [15:0] mgm_frmtype;             //  if non-null: type field instead length
wire    [7:0] mgm_payload; 
wire    mgm_payload_vld; 
wire    mgm_is_vlan; 
wire    mgm_is_stack_vlan; 
wire    mgm_is_pause; 
wire    mgm_crc_err; 
wire    mgm_prmbl_err; 
wire    mgm_pad_err; 
wire    mgm_len_err; 
wire    mgm_payload_err; 
wire    mgm_frame_err; 
wire    mgm_pause_op_err; 
wire    mgm_pause_dst_err; 
wire    mgm_mac_err; 
wire    mgm_end_err; 
wire    mgm_frm_rcvd;
 
//  GMII Monitor
//  -------------

wire    [47:0] gm_mgm_dst;              //  destination address
wire    [47:0] gm_mgm_src;              //  source address
wire    [13:0] gm_mgm_prmble_len;       //  length of preamble
wire    [15:0] gm_mgm_pquant;           //  Pause Quanta value
wire    [15:0] gm_mgm_vlan_ctl;         //  VLAN control info
wire    [15:0] gm_mgm_len;              //  Length of payload
wire    [15:0] gm_mgm_frmtype;          //  if non-null: type field instead length
wire    [7:0] gm_mgm_payload; 
wire    gm_mgm_payload_vld; 
wire    gm_mgm_is_vlan; 
wire    gm_mgm_is_stack_vlan; 
wire    gm_mgm_is_pause; 
wire    gm_mgm_crc_err; 
wire    gm_mgm_prmbl_err; 
wire    gm_mgm_pad_err; 
wire    gm_mgm_len_err; 
wire    gm_mgm_payload_err; 
wire    gm_mgm_frame_err; 
wire    gm_mgm_pause_op_err; 
wire    gm_mgm_pause_dst_err; 
wire    gm_mgm_mac_err; 
wire    gm_mgm_end_err; 
wire    gm_mgm_frm_rcvd;                //  if '1' all signals/indicators are valid
        
//  MII Monitor
//  -----------

wire    [47:0] m_mgm_dst;               //  destination address
wire    [47:0] m_mgm_src;               //  source address
wire    [13:0] m_mgm_prmble_len;        //  length of preamble
wire    [15:0] m_mgm_pquant;            //  Pause Quanta value
wire    [15:0] m_mgm_vlan_ctl;          //  VLAN control info
wire    [15:0] m_mgm_len;               //  Length of payload
wire    [15:0] m_mgm_frmtype;           //  if non-null: type field instead length
wire    [7:0] m_mgm_payload; 
wire    m_mgm_payload_vld; 
wire    m_mgm_is_vlan;
wire    m_mgm_is_stack_vlan;
wire    m_mgm_is_pause; 
wire    m_mgm_crc_err; 
wire    m_mgm_prmbl_err; 
wire    m_mgm_pad_err; 
wire    m_mgm_len_err; 
wire    m_mgm_payload_err; 
wire    m_mgm_frame_err; 
wire    m_mgm_pause_op_err; 
wire    m_mgm_pause_dst_err; 
wire    m_mgm_mac_err; 
wire    m_mgm_end_err; 
wire    m_mgm_frm_rcvd;                 //  if '1' all signals/indicators are valid
         
//  FIFO Monitor RX (user appl) (Checking)
//  --------------------------------------

wire    [47:0] mff_dst;                 //  destination address
reg     [47:0] mff_dst_reg;             //  destination address
wire    [47:0] mff_src;                 //  source address
wire    [13:0] mff_prmble_len;          //  length of preamble
wire    [15:0] mff_pquant;              //  Pause Quanta value
wire    [15:0] mff_vlan_ctl;            //  VLAN control info
wire    [15:0] mff_len;                 //  Length of payload
wire    [15:0] mff_frmtype;             //  if non-null: type field instead length
wire    [7:0] mff_payload; 
wire    mff_payload_vld; 
wire    mff_is_vlan;
wire    mff_is_stack_vlan; 
wire    mff_is_pause; 
wire    mff_crc_err; 
wire    mff_prmbl_err; 
wire    mff_pad_err; 
wire    mff_len_err; 
wire    mff_payload_err; 
reg     mff_payload_err_reg; 
wire    mff_frame_err; 
wire    mff_pause_op_err; 
wire    mff_pause_dst_err; 
wire    mff_mac_err; 
wire    mff_end_err; 
reg     mff_end_err_reg;
wire    mff_frm_rcvd;                   //  if '1' all signals/indicators are valid
integer ff_frmlen;                      //  length of frame as it is coming from the FIFO

//  Simulation Command Signals
//  --------------------------

wire    gm_start_ether_gen;             //  Enable Frame Generation
wire    m_start_ether_gen;              //  Enable Frame Generation
wire    gm_ether_gen_done;              //  Ethernet Generation Completed
wire    gm_gm_ether_gen_done;           //  Ethernet Generation Completed
wire    m_gm_ether_gen_done;            //  Ethernet Generation Completed
wire    ff_start_ether_gen;             //  Enable Frame Generation
wire    ff_ether_gen_done;              //  Ethernet Generation Completed
wire    jumbo_enable;                   //  depending on TB_MACLENMAX 
           
//  Simulation Control
//  ------------------

wire    sim_done;                       //  1 when everything has finished
reg     sim_stop;                       //  when to stop the simulator after simulation is done (delayed after sim_done)
reg     sim_start;                      //  when to start simulation
integer delay_cnt;                      //  wait before start and after done until stop
integer hash_cnt;                       //  Hash table programming counter 
integer multicast_cnt;                  //  counter during setting of a multicast address
reg     multicast_wrong = 0;                //  true if we currently use a multicast address not from the table
wire    promis_en_dly; 
reg     stop_rx_fifo_read;              //  FIFO read should be stopped now
wire    ff_rx_rdy_dly;                  //  delayed rx_rdy for message generation
integer rx_hold_cnt;                    //  timer counting cycles during fifo read stop
integer rx_fifo_cnt;                    //  incremented with each frame read from the FIFO
reg     tx_pause_wait;                  //  Pause frame received. TX should stop
integer tx_pause_cnt;                   //  timer counting pause delay
integer force_xoff_pause_cnt;           //  when to trigger a Xoff pause frame generation
integer force_xon_pause_cnt;            //  when to trigger a Xoff pause frame generation

//  TX PATH simulation
//  ------------------

integer txframe_cnt;                    //  number of frames transmitted/generated
reg     txsim_done;                     //  1 when everything has finished
reg     ff_tx_clk_gen_en;               //  clock enable for TX FIFO generator    
wire    ff_tx_clk_gen;                  //  clock for TX FIFO generator    
wire    ff_tx_wren_gen;                 //  write enable FIFO interface

//  TX: Verification information
//  ----------------------------

integer tx_good_sent;                   //  valid frames sent which should be counted as good on receive
integer tx_good_rcvd;                   //  should be same as good_sent at end of test        
integer tx_pause_rcvd; 
integer tx_pause_err_rcvd;              //  erroneous PAUSE frames
integer tx_align_err_rcvd;              //  should NEVER happen
integer gm_txcnt; 
integer tx_vlan_sent; 
integer tx_stack_vlan_sent;
integer tx_frm_all; 
integer tx_vlan_rcvd;                   //  received by monitor
integer tx_stack_vlan_rcvd;             //  received by monitor
integer tx_vlan_wrong_type_sent; 
integer tx_phy_err_rcvd;                //  GMII tx error signal detected
integer tx_crc_err_rcvd; 
integer tx_payload_err_sent; 
integer tx_payload_err_rcvd; 
integer tx_wrong_src_rcvd;              //  Wrong MAC SOURCE address received by monitor

//  RX PATH simulation
//  ------------------

reg    [31:0] rxframe_cnt;             //  number of frames transmitted/generated
reg     [3:0] last_err_stat;            //  latest FIFO error bits
reg     [15:0] ff_last_length;          //  length part of ff_rx_err_stat
wire    gm_sop;                         //  sop from GMII generator
wire    gm_gm_sop;                      //  sop from GMII generator
wire    m_gm_sop;                       //  sop from MII generator
reg     gm_sop_dly;                     //  delayed by 1
reg     gm_sop_dly2;                    //  delayed by 1
wire    gm_eop;                         //  eop from GMII generator
wire    gm_gm_eop;                      //  eop from GMII generator
wire    m_gm_eop;                       //  eop from MII generator
reg     gm_eop_dly;                     //  dito delayed by 1 clk 

//  RX: Determine when to expect the RX to act 
//  ------------------------------------------

reg     expect1;                        //  set after start of generator
reg     expect2;                        //  set when we expect something, cleared if done

//  RX: Verification information
//  ------------------------

wire    rx_is_good_frame;               //  true if valid frame (payload error is still a valid frame)
wire    rx_is_good_addr;                //  true if valid mac address is given
integer rx_good_sent;                   //  valid frames sent which should be counted as good on receive
integer rx_good_rcvd;                   //  should be same as good_sent at end of test
integer rx_pause_sent; 
integer rx_pause_rcvd; 
integer rx_align_err_sent; 
integer rx_align_err_rcvd; 
integer rx_crc_err_sent; 
integer rx_crc_err_rcvd; 
integer rx_gmii_err_sent; 
integer rx_gmii_err_rcvd; 
integer rx_length_err_rcvd; 
integer rx_length_mismatch_rcvd; 
integer rx_vlan_sent; 
integer rx_vlan_rcvd;
integer rx_stack_vlan_sent; 
integer rx_stack_vlan_rcvd;  
integer rx_vlan_wrong_type_sent; 
integer rx_discard_sent;                //  frame sent that should have been discarded
integer rx_non_discard_rcvd;            //  frames discarded on receive
integer rx_discard_rcvd;                //  frame_cnt - non_discard_rcvd
integer rx_wrong_status_sent;           //  sent frame that will be pushed into FIFO but with error status
integer rx_wrong_status_rcvd; 
integer rx_payload_err_sent; 
integer rx_payload_err_rcvd; 
integer mff_rxcnt; 
integer rx_wrong_mac_sent; 
integer rx_wrong_mac_rcvd; 
integer rx_broadcast_sent; 
integer rx_broadcast_rcvd; 
integer rx_multicast_sent_total; 
integer rx_multicast_sent; 
integer rx_multicast_rcvd; 
integer rx_multicast_denied; 
integer rx_unexpected; 
integer rx_fifo_overflow_rcvd; 
integer rx_col_sent; 
integer tx_col_sent; 
integer rx_col_rcvd; 



//  Control State Machine
//  ---------------------

parameter stm_typ_idle = 0;
parameter stm_typ_read_ver = 1;
parameter stm_typ_wr_scratch = 2;
parameter stm_typ_rd_scratch = 3;
parameter stm_typ_write_mdio1 = 6;
parameter stm_typ_read_mdio1 = 7;
parameter stm_typ_mac_config = 8;
parameter stm_typ_wr_mac1 = 9;
parameter stm_typ_wr_mac2 = 10;
parameter stm_typ_wr_ipg_len = 65;
parameter stm_typ_lut_prog = 11;
parameter stm_typ_lut_prog_inc = 12;
parameter stm_typ_wr_frm_length = 13;
parameter stm_typ_wr_pause_quanta = 14;
parameter stm_typ_wr_mdio_addr1 = 16;
parameter stm_typ_sim = 17;
parameter stm_typ_end_sim_wait = 53;
parameter stm_typ_end_sim = 44;


//  Simulation Control for PCS
//  ------------------

parameter stm_typ_pcs_read_ver = 100;
parameter stm_typ_pcs_wr_scratch = 101;
parameter stm_typ_pcs_rd_scratch = 102;
parameter stm_typ_pcs_read_phy_control = 103;

parameter stm_typ_pcs_write_phy_control = 104;

parameter stm_typ_pcs_read_sync_status = 105;
parameter stm_typ_pcs_prog_ability = 106;
parameter stm_typ_pcs_prog_timer_1 = 107;
parameter stm_typ_pcs_prog_timer_2 = 108;
parameter stm_typ_pcs_autoneg_enable = 109;
parameter stm_typ_pcs_start_autoneg = 110;
parameter stm_typ_pcs_wait_autoneg = 111;
parameter stm_typ_pcs_read_autoneg_expansion = 112;
parameter stm_typ_pcs_read_autoneg_status = 113;
parameter stm_typ_pcs_read_part_ability = 114;
parameter stm_typ_pcs_wait_link = 115;
parameter stm_typ_pcs_stop_tbi = 117;
parameter stm_typ_pcs_start_tbi = 118;
parameter stm_typ_pcs_read_status = 119;
parameter stm_typ_pcs_read_status_2 = 120;
parameter stm_typ_pcs_ena_sw_reset = 121;
parameter stm_typ_pcs_read_sw_reset = 122;
parameter stm_typ_pcs_ena_isolate = 123;
parameter stm_typ_pcs_disable_isolate = 124;
parameter stm_typ_pcs_autoneg_disable = 126;
parameter stm_typ_pcs_if_control = 127;


// Read Statistic Counters
// -----------------------

parameter stm_typ_rd_pause_rx = 18;
parameter stm_typ_rd_pause_tx = 19;
parameter stm_typ_rd_frm_tx = 20;
parameter stm_typ_rd_frm_rx = 21;
parameter stm_typ_rd_crc_err = 22;
parameter stm_typ_rd_tx_octets = 23;
parameter stm_typ_rd_rx_octets = 24;
parameter stm_typ_rd_rx_all_octets = 66;
parameter stm_typ_rd_align_err = 25;
parameter stm_typ_rx_unicast = 26;
parameter stm_typ_rx_mltcast = 27;
parameter stm_typ_rx_brdcast = 28;
parameter stm_typ_tx_frm_discard = 29;
parameter stm_typ_tx_unicast = 30;
parameter stm_typ_tx_mltcast = 31;
parameter stm_typ_tx_brdcast = 32;
parameter stm_typ_rx_frm_err = 33;
parameter stm_typ_tx_frm_err = 34;
parameter stm_typ_rx_frm_drop = 35;
parameter stm_typ_rx_undersz_frm = 36;
parameter stm_typ_rx_oversz_frm = 37;
parameter stm_typ_rx_64_frm = 38;
parameter stm_typ_rx_65_127_frm = 39;
parameter stm_typ_rx_128_255_frm = 40;
parameter stm_typ_rx_256_511_frm = 41;
parameter stm_typ_rx_512_1023_frm = 42;
parameter stm_typ_rx_1024_1518_frm = 43;
parameter stm_typ_rx_1519_X_frm = 67;
parameter stm_typ_rx_jabber = 68;
parameter stm_typ_rx_fragment = 69;
parameter stm_typ_wait_reg_clear = 56;
parameter stm_typ_wr_sup_mac0_0 = 57;
parameter stm_typ_wr_sup_mac0_1 = 58;
parameter stm_typ_wr_sup_mac1_0 = 59;
parameter stm_typ_wr_sup_mac1_1 = 60;
parameter stm_typ_wr_sup_mac2_0 = 61;
parameter stm_typ_wr_sup_mac2_1 = 62;
parameter stm_typ_wr_sup_mac3_0 = 63;
parameter stm_typ_wr_sup_mac3_1 = 64;

// Programming FIFO thresholds
// ---------------------------

parameter stm_typ_wr_rx_ae = 45;
parameter stm_typ_wr_rx_af = 46;
parameter stm_typ_wr_tx_ae = 47;
parameter stm_typ_wr_tx_af = 48;
parameter stm_typ_wr_rx_se = 49;
parameter stm_typ_wr_rx_sf = 50;
parameter stm_typ_wr_tx_se = 51;
parameter stm_typ_wr_tx_sf = 52;
parameter stm_typ_sw_reset = 54;
parameter stm_typ_rd_sw_reset = 55;

reg     [6:0] state; 
reg     [6:0] nextstate; 
integer sim_cnt_end;   
reg     re_read_ena;  

//  Hash Table Program Control
//  --------------------------

reg     [6:0] lut_prog_cnt; 
reg     [5:0] p_hash_hash_code; 
reg     [47:0] p_hash_mcast_addr;   
             
//  global settings
//  ---------------

wire    m_rx_col_wire; 
wire    tx_col_reg_wire; 
integer  process_4_ln; 
integer  process_8_ln; 
integer  process_10_cnt; 
integer  process_12_ln; 
integer  process_15_mdl; 
integer  process_16_maxlen; 
integer  process_16_payloadlen; 
integer  process_16_payloadminlen; 

// register write/read test
//

reg [31:0] readback_scratch;
reg [31:0] readback_MDIO0_addr0;
reg [31:0] readback_MDIO1_addr0;

integer register_test;

reg [31:0] reg_iteration; 

assign jumbo_enable = TB_MACLENMAX > 1522 ? 1'b 1 : 1'b 0; //  enable monitors for long frames

//  Reset Control and start simulation
//  ----------------------------------

   //  Reset Control and start simulation
   //  ----------------------------------
   
        initial
        begin

                $display("\n - ---------------------------------------------------------------------------------------- -") ;
                $display("\n --     Testbench for 8-Bit Core 10/100/1000 MAC +  1000 Base-X PCS / SGMII      --") ;
                $display(" --   (c) ALTERA CORPORATION 2007  --") ;
                $display("\n - ---------------------------------------------------------------------------------------- -\n") ;

                if (TB_RXFRAMES > 0)
                begin
                
                        $display("    Error: 'TB_RXFRAMES' must be set to 0.  Only loopback simulation is supported by this testbench\n") ;
                        $stop ;
                        
                end
                
                if (ETH_MODE==1000 && HD_ENA==1'b1)
                begin
                
                        $display("    Error: Half Duplex must Disabled for Gigabit Operation\n") ;
                        $stop ;
                        
                end
                
                if (TB_MACPADEN==1'b1 & TB_MACFWD_CRC==1'b1)
                begin
                
                        $display("    Warning: Setting Padding Termination and Forward CRC Options may Results in Simulation Errors\n") ;
                                
                end                                        
                
                if (ETH_MODE==1000)
                begin
                
                        ethernet_mode <= 1'b1 ;
                        
                end
                
                else if (ETH_MODE==100)
                begin
                
                        ethernet_mode <= 1'b0 ;
                        
                end
                
                else if (ETH_MODE==10)
                begin
                
                        ethernet_mode <= 1'b0 ;
                        
                end  
      
      
                reset       <=1'b0 ;
                sim_start   <=1'b0 ;
                #(50)
                reset       <=1'b1 ;
                #(2000) ;
                reset       <=1'b0 ;
                #(3000) ;
                sim_start   <=1'b1 ;
   
        end

//  Clocks
//  ------

        always 
        begin
                
                ff_rx_clk_internal <= 1'b 1; 
                # LOC_HIGH; 
                ff_rx_clk_internal <= 1'b 0; 
                # LOC_HIGH; 
        
        end

        always 
        begin
        
                ff_tx_clk_internal <= 1'b 1; 
                # LOC_HIGH; 
                ff_tx_clk_internal <= 1'b 0; 
                # LOC_HIGH; 
        
        end
     
assign ff_tx_crc_fwd = 1'b0 ;
assign magic_sleep_n    = 1'b1 ;

// $<RTL_CORE_INSTANCE>



assign ref_clk = tx_clk_1000mbps;

generate
  if (ENABLE_ENA == 8) //DUT core with internal FIFO
   begin
    assign ff_tx_clk        = ff_tx_clk_internal;
    assign ff_rx_clk        = ff_rx_clk_internal;
    assign ff_rx_err_stat   = { rx_err_stat[17], rx_err[5], rx_err_stat[15:0], rx_err_stat[16], rx_err[4:1]}; 
    assign ff_rx_err        = rx_err [0];
    assign ff_rx_vlan       = rx_frm_type [3];
    assign ff_rx_bcast      = rx_frm_type [2];
    assign ff_rx_mcast      = rx_frm_type [1];
    assign ff_rx_ucast      = rx_frm_type [0];
    assign tbi_rx_clk       = rx_clk_1000mbps;
    assign tbi_tx_clk       = tx_clk_1000mbps;
    assign #(4) tbi_rx_d    = tbi_tx_d;
   end

  if (MAX_CHANNELS == 1)
   begin

    assign led_link = led_link_0;

    //input of DUT
    assign ff_rx_dsav       = 1'b0; 
    assign rx_afull_clk     = rx_clk;
    assign rx_afull_channel = 5'b0;
    assign rx_afull_data    = 2'b0;
    assign rx_afull_valid   = 1'b1 ;
    assign data_tx_data_0   = ff_tx_data;
    assign data_tx_eop_0    = ff_tx_eop;
    assign data_tx_error_0  = ff_tx_err;
    assign data_tx_sop_0    = ff_tx_sop;
    assign data_tx_valid_0  = ff_tx_wren;
    assign tx_crc_fwd_0     = ff_tx_crc_fwd;
    assign data_rx_ready_0  = ff_rx_rdy;
    assign tbi_tx_clk_0     = tx_clk_1000mbps;
    assign tbi_rx_clk_0     = rx_clk_1000mbps;
    assign m_rx_d_0         = m_rx_data;
    assign m_rx_en_0        = m_rx_en;
    assign m_rx_err_0       = m_rx_err;
    assign set_10_0         = 1'b0;
    assign set_1000_0       = 1'b0;
    assign xon_gen_0        = 1'b0;
    assign xoff_gen_0       = 1'b0;
    assign magic_sleep_n_0  = magic_sleep_n;
    assign m_rx_col_0       = m_rx_col;
    assign m_rx_crs_0       = m_rx_crs;
    assign gm_rx_d_0        = gm_rx_data;
    assign gm_rx_dv_0       = gm_rx_en;
    assign gm_rx_err_0      = gm_rx_err;

    assign #(4) tbi_rx_d_0  = tbi_tx_d_0;


    //output of DUT
    assign ff_rx_err_stat   = {pkt_class_valid_0 ? pkt_class_data_0 [0] : 1'b0, data_rx_error_0[4], 15'b0 ,pkt_class_valid_0 ? (pkt_class_data_0[1]|pkt_class_data_0[0]) : 1'b0 ,data_rx_error_0[3:0]};
    assign ff_rx_err        = data_rx_error_0 [0]|data_rx_error_0 [1]|data_rx_error_0 [2]|data_rx_error_0 [3]|data_rx_error_0 [4];
    assign ff_rx_vlan       = pkt_class_valid_0 ? pkt_class_data_0 [1] : 1'b0 ;
    assign ff_rx_bcast      = pkt_class_valid_0 ? pkt_class_data_0 [2] : 1'b0 ;
    assign ff_rx_mcast      = pkt_class_valid_0 ? pkt_class_data_0 [3] : 1'b0 ;
    assign ff_rx_ucast      = pkt_class_valid_0 ? pkt_class_data_0 [4] : 1'b0 ;
    assign ff_tx_clk        = mac_tx_clk_0;
    assign ff_rx_clk        = mac_rx_clk_0;
    assign ff_tx_rdy        = data_tx_ready_0;
    assign ff_rx_data       = data_rx_data_0;
    assign ff_rx_dval       = data_rx_valid_0;
    assign ff_rx_eop        = data_rx_eop_0;
    assign ff_rx_sop        = data_rx_sop_0;
    assign rx_err           = data_rx_error_0;
    assign m_tx_data        = m_tx_d_0;
    assign m_tx_en          = m_tx_en_0;
    assign m_tx_err         = m_tx_err_0;
    assign gm_tx_data       = gm_tx_d_0;
    assign gm_tx_en         = gm_tx_en_0;
    assign gm_tx_err        = gm_tx_err_0;
    assign rgmii_tx_ctnl    = tx_control_0;
    assign rgmii_tx_data    = rgmii_out_0;

   end

  if (MAX_CHANNELS == 4)
  begin

   assign led_link = led_link_0 ;
   //input of DUT
   assign ff_rx_dsav       = 1'b0; 
   assign rx_afull_clk     = rx_clk;
   assign rx_afull_channel = 5'b0;
   assign rx_afull_data    = 2'b0;
   assign rx_afull_valid   = 1'b1;
   assign data_tx_data_0   = ff_tx_data;
   assign data_tx_eop_0    = ff_tx_eop;
   assign data_tx_error_0  = ff_tx_err;
   assign data_tx_sop_0    = ff_tx_sop;
   assign data_tx_valid_0  = ff_tx_wren;
   assign tx_crc_fwd_0     = ff_tx_crc_fwd;
   assign data_rx_ready_3  = ff_rx_rdy;

   assign tbi_tx_clk_0     = tx_clk_1000mbps;
   assign tbi_rx_clk_0     = rx_clk_1000mbps;
   assign tbi_tx_clk_1     = tx_clk_1000mbps;
   assign tbi_rx_clk_1     = rx_clk_1000mbps;
   assign tbi_tx_clk_2     = tx_clk_1000mbps;
   assign tbi_rx_clk_2     = rx_clk_1000mbps;
   assign tbi_tx_clk_3     = tx_clk_1000mbps;
   assign tbi_rx_clk_3     = rx_clk_1000mbps;

   assign set_10_0         = 1'b0;
   assign set_1000_0       = 1'b0;
   assign set_10_1         = 1'b0;
   assign set_1000_1       = 1'b0;
   assign set_10_2         = 1'b0;
   assign set_1000_2       = 1'b0;
   assign set_10_3         = 1'b0;
   assign set_1000_3       = 1'b0;

   assign xon_gen_0        = 1'b0;
   assign xoff_gen_0       = 1'b0;
   assign xon_gen_1        = 1'b0;
   assign xoff_gen_1       = 1'b0;
   assign xon_gen_2        = 1'b0;
   assign xoff_gen_2       = 1'b0;
   assign xon_gen_3        = 1'b0;
   assign xoff_gen_3       = 1'b0;

   assign magic_sleep_n_0  = magic_sleep_n;
   assign magic_sleep_n_1  = magic_sleep_n;
   assign magic_sleep_n_2  = magic_sleep_n;
   assign magic_sleep_n_3  = magic_sleep_n;


   //output of DUT
   assign ff_rx_err_stat   = {pkt_class_valid_3 ? pkt_class_data_3 [0] : 1'b0, data_rx_error_3[4], 15'b0 ,pkt_class_valid_3 ? (pkt_class_data_3[1]|pkt_class_data_3[0]) : 1'b0 ,data_rx_error_3[3:0]};
   assign ff_rx_err        = data_rx_error_3 [0]|data_rx_error_3 [1]|data_rx_error_3 [2]|data_rx_error_3 [3]|data_rx_error_3 [4];
   assign ff_rx_vlan       = pkt_class_valid_3 ? pkt_class_data_3 [1] : 1'b0 ;
   assign ff_rx_bcast      = pkt_class_valid_3 ? pkt_class_data_3 [2] : 1'b0 ;
   assign ff_rx_mcast      = pkt_class_valid_3 ? pkt_class_data_3 [3] : 1'b0 ;
   assign ff_rx_ucast      = pkt_class_valid_3 ? pkt_class_data_3 [4] : 1'b0 ;
   assign ff_tx_clk        = mac_tx_clk_0;
   assign ff_rx_clk        = mac_rx_clk_0;
   assign ff_tx_rdy        = data_tx_ready_0;
   assign ff_rx_data       = data_rx_data_3;
   assign ff_rx_dval       = data_rx_valid_3;
   assign ff_rx_eop        = data_rx_eop_3;
   assign ff_rx_sop        = data_rx_sop_3;
   assign rx_err           = data_rx_error_3;

   //loopback
   assign data_rx_ready_0  = 1'b1;//data_tx_ready_1;
   assign tx_crc_fwd_1     = ff_tx_crc_fwd;


   loopback_adapter u_ch0_2_ch1 (
       
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_0),
     .in_data(data_rx_data_0),
     .in_startofpacket(data_rx_sop_0),
     .in_endofpacket(data_rx_eop_0),
     .in_error(data_rx_error_0),
     // Interface: out
     .out_ready(data_tx_ready_1),
     .out_valid(data_tx_valid_1),
     .out_data(data_tx_data_1),
     .out_startofpacket(data_tx_sop_1),
     .out_endofpacket(data_tx_eop_1),
     .out_error(data_tx_error_1)
   );



   assign data_rx_ready_1  = 1'b1;
   assign tx_crc_fwd_2     = ff_tx_crc_fwd;

   loopback_adapter u_ch1_2_ch2 (
       
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_1),
     .in_data(data_rx_data_1),
     .in_startofpacket(data_rx_sop_1),
     .in_endofpacket(data_rx_eop_1),
     .in_error(data_rx_error_1),
     // Interface: out
     .out_ready(data_tx_ready_2),
     .out_valid(data_tx_valid_2),
     .out_data(data_tx_data_2),
     .out_startofpacket(data_tx_sop_2),
     .out_endofpacket(data_tx_eop_2),
     .out_error(data_tx_error_2)
   );

   assign data_rx_ready_2  = 1'b1;
   assign tx_crc_fwd_3     = ff_tx_crc_fwd;

   loopback_adapter u_ch2_2_ch3 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_2),
     .in_data(data_rx_data_2),
     .in_startofpacket(data_rx_sop_2),
     .in_endofpacket(data_rx_eop_2),
     .in_error(data_rx_error_2),
     // Interface: out
     .out_ready(data_tx_ready_3),
     .out_valid(data_tx_valid_3),
     .out_data(data_tx_data_3),
     .out_startofpacket(data_tx_sop_3),
     .out_endofpacket(data_tx_eop_3),
     .out_error(data_tx_error_3)
   );

   
   //assigning to GMII/MII TX monitoring
   assign gm_tx_data       = gm_tx_d_0;
   assign gm_tx_en         = gm_tx_en_0;
   assign gm_tx_err        = gm_tx_err_0;
   assign m_tx_data        = m_tx_d_0;
   assign m_tx_en          = m_tx_en_0;
   assign m_tx_err         = m_tx_err_0;
   assign rgmii_tx_ctnl    = tx_control_0;
   assign rgmii_tx_data    = rgmii_out_0;

   assign gm_rx_d_0        = gm_tx_d_0;
   assign gm_rx_dv_0       = gm_tx_en_0;
   assign gm_rx_err_0      = gm_tx_err_0;
   assign m_rx_d_0         = m_tx_d_0;
   assign m_rx_en_0        = m_tx_en_0;
   assign m_rx_err_0       = m_tx_err_0;
   assign m_rx_col_0       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_0       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_0     = tx_control_0;
   assign rgmii_in_0       = rgmii_out_0;
   assign #(4) tbi_rx_d_0  = tbi_tx_d_0;

   assign gm_rx_d_1        = gm_tx_d_1;
   assign gm_rx_dv_1       = gm_tx_en_1;
   assign gm_rx_err_1      = gm_tx_err_1;
   assign m_rx_d_1         = m_tx_d_1;
   assign m_rx_en_1        = m_tx_en_1;
   assign m_rx_err_1       = m_tx_err_1;
   assign m_rx_col_1       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_1       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_1     = tx_control_1;
   assign rgmii_in_1       = rgmii_out_1;
   assign #(4) tbi_rx_d_1  = tbi_tx_d_1;

   assign gm_rx_d_2        = gm_tx_d_2;
   assign gm_rx_dv_2       = gm_tx_en_2;
   assign gm_rx_err_2      = gm_tx_err_2;
   assign m_rx_d_2         = m_tx_d_2;
   assign m_rx_en_2        = m_tx_en_2;
   assign m_rx_err_2       = m_tx_err_2;
   assign m_rx_col_2       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_2       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_2     = tx_control_2;
   assign rgmii_in_2       = rgmii_out_2;
   assign #(4) tbi_rx_d_2  = tbi_tx_d_2;

   assign gm_rx_d_3        = gm_tx_d_3;
   assign gm_rx_dv_3       = gm_tx_en_3;
   assign gm_rx_err_3      = gm_tx_err_3;
   assign m_rx_d_3         = m_tx_d_3;
   assign m_rx_en_3        = m_tx_en_3;
   assign m_rx_err_3       = m_tx_err_3;
   assign m_rx_col_3       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_3       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_3     = tx_control_3;
   assign rgmii_in_3       = rgmii_out_3;
   assign #(4) tbi_rx_d_3  = tbi_tx_d_3;


  end

 if (MAX_CHANNELS == 8)
  begin

   assign led_link = led_link_0 ;

   //input of DUT
   assign ff_rx_dsav       = 1'b0; 
   assign rx_afull_clk     = rx_clk;
   assign rx_afull_channel = 5'b0;
   assign rx_afull_data    = 2'b0;
   assign rx_afull_valid   = 1'b1;
   assign data_tx_data_0   = ff_tx_data;
   assign data_tx_eop_0    = ff_tx_eop;
   assign data_tx_error_0  = ff_tx_err;
   assign data_tx_sop_0    = ff_tx_sop;
   assign data_tx_valid_0  = ff_tx_wren;
   assign tx_crc_fwd_0     = ff_tx_crc_fwd;
   assign data_rx_ready_7  = ff_rx_rdy;

   assign tbi_tx_clk_0     = tx_clk_1000mbps;
   assign tbi_rx_clk_0     = rx_clk_1000mbps;
   assign tbi_tx_clk_1     = tx_clk_1000mbps;
   assign tbi_rx_clk_1     = rx_clk_1000mbps;
   assign tbi_tx_clk_2     = tx_clk_1000mbps;
   assign tbi_rx_clk_2     = rx_clk_1000mbps;
   assign tbi_tx_clk_3     = tx_clk_1000mbps;
   assign tbi_rx_clk_3     = rx_clk_1000mbps;
   assign tbi_tx_clk_4     = tx_clk_1000mbps;
   assign tbi_rx_clk_4     = rx_clk_1000mbps;
   assign tbi_tx_clk_5     = tx_clk_1000mbps;
   assign tbi_rx_clk_5     = rx_clk_1000mbps;
   assign tbi_tx_clk_6     = tx_clk_1000mbps;
   assign tbi_rx_clk_6     = rx_clk_1000mbps;
   assign tbi_tx_clk_7     = tx_clk_1000mbps;
   assign tbi_rx_clk_7     = rx_clk_1000mbps;

   assign set_10_0         = 1'b0;
   assign set_1000_0       = 1'b0;
   assign set_10_1         = 1'b0;
   assign set_1000_1       = 1'b0;
   assign set_10_2         = 1'b0;
   assign set_1000_2       = 1'b0;
   assign set_10_3         = 1'b0;
   assign set_1000_3       = 1'b0;
   assign set_10_4         = 1'b0;
   assign set_1000_4       = 1'b0;
   assign set_10_4         = 1'b0;
   assign set_1000_4       = 1'b0;
   assign set_10_5         = 1'b0;
   assign set_1000_5       = 1'b0;
   assign set_10_6         = 1'b0;
   assign set_1000_6       = 1'b0;
   assign set_10_7         = 1'b0;
   assign set_1000_7       = 1'b0;

   assign xon_gen_0        = 1'b0;
   assign xoff_gen_0       = 1'b0;
   assign xon_gen_1        = 1'b0;
   assign xoff_gen_1       = 1'b0;
   assign xon_gen_2        = 1'b0;
   assign xoff_gen_2       = 1'b0;
   assign xon_gen_3        = 1'b0;
   assign xoff_gen_3       = 1'b0;
   assign xon_gen_4        = 1'b0;
   assign xoff_gen_4       = 1'b0;
   assign xon_gen_5        = 1'b0;
   assign xoff_gen_5       = 1'b0;
   assign xon_gen_6        = 1'b0;
   assign xoff_gen_6       = 1'b0;
   assign xon_gen_7        = 1'b0;
   assign xoff_gen_7       = 1'b0;

   assign magic_sleep_n_0  = magic_sleep_n;
   assign magic_sleep_n_1  = magic_sleep_n;
   assign magic_sleep_n_2  = magic_sleep_n;
   assign magic_sleep_n_3  = magic_sleep_n;
   assign magic_sleep_n_4  = magic_sleep_n;
   assign magic_sleep_n_5  = magic_sleep_n;
   assign magic_sleep_n_6  = magic_sleep_n;
   assign magic_sleep_n_7  = magic_sleep_n;


   //output of DUT
   assign ff_rx_err_stat   = {pkt_class_valid_7 ? pkt_class_data_7 [0] : 1'b0, data_rx_error_7[4], 15'b0 ,pkt_class_valid_7 ? (pkt_class_data_7[1]|pkt_class_data_7[0]) : 1'b0 ,data_rx_error_7[3:0]};
   assign ff_rx_err        = data_rx_error_7 [0]|data_rx_error_7 [1]|data_rx_error_7 [2]|data_rx_error_7 [3]|data_rx_error_7 [4];
   assign ff_rx_vlan       = pkt_class_valid_7 ? pkt_class_data_7 [1] : 1'b0 ;
   assign ff_rx_bcast      = pkt_class_valid_7 ? pkt_class_data_7 [2] : 1'b0 ;
   assign ff_rx_mcast      = pkt_class_valid_7 ? pkt_class_data_7 [3] : 1'b0 ;
   assign ff_rx_ucast      = pkt_class_valid_7 ? pkt_class_data_7 [4] : 1'b0 ;
   assign ff_tx_clk        = mac_tx_clk_0;
   assign ff_rx_clk        = mac_rx_clk_0;
   assign ff_tx_rdy        = data_tx_ready_0;
   assign ff_rx_data       = data_rx_data_7;
   assign ff_rx_dval       = data_rx_valid_7;
   assign ff_rx_eop        = data_rx_eop_7;
   assign ff_rx_sop        = data_rx_sop_7;
   assign rx_err           = data_rx_error_7;

   //loopback
   assign data_rx_ready_0  = 1'b1;//data_tx_ready_1;
   assign tx_crc_fwd_1     = ff_tx_crc_fwd;


   loopback_adapter u_ch0_2_ch1 (
       
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_0),
     .in_data(data_rx_data_0),
     .in_startofpacket(data_rx_sop_0),
     .in_endofpacket(data_rx_eop_0),
     .in_error(data_rx_error_0),
     // Interface: out
     .out_ready(data_tx_ready_1),
     .out_valid(data_tx_valid_1),
     .out_data(data_tx_data_1),
     .out_startofpacket(data_tx_sop_1),
     .out_endofpacket(data_tx_eop_1),
     .out_error(data_tx_error_1)
   );

   assign data_rx_ready_1  = 1'b1;
   assign tx_crc_fwd_2     = ff_tx_crc_fwd;

   loopback_adapter u_ch1_2_ch2 (
       
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_1),
     .in_data(data_rx_data_1),
     .in_startofpacket(data_rx_sop_1),
     .in_endofpacket(data_rx_eop_1),
     .in_error(data_rx_error_1),
     // Interface: out
     .out_ready(data_tx_ready_2),
     .out_valid(data_tx_valid_2),
     .out_data(data_tx_data_2),
     .out_startofpacket(data_tx_sop_2),
     .out_endofpacket(data_tx_eop_2),
     .out_error(data_tx_error_2)
   );

   assign data_rx_ready_2  = 1'b1;
   assign tx_crc_fwd_3     = ff_tx_crc_fwd;

   loopback_adapter u_ch2_2_ch3 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_2),
     .in_data(data_rx_data_2),
     .in_startofpacket(data_rx_sop_2),
     .in_endofpacket(data_rx_eop_2),
     .in_error(data_rx_error_2),
     // Interface: out
     .out_ready(data_tx_ready_3),
     .out_valid(data_tx_valid_3),
     .out_data(data_tx_data_3),
     .out_startofpacket(data_tx_sop_3),
     .out_endofpacket(data_tx_eop_3),
     .out_error(data_tx_error_3)
   );

   assign data_rx_ready_3  = 1'b1;
   assign tx_crc_fwd_4     = ff_tx_crc_fwd;

   loopback_adapter u_ch3_2_ch4 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_3),
     .in_data(data_rx_data_3),
     .in_startofpacket(data_rx_sop_3),
     .in_endofpacket(data_rx_eop_3),
     .in_error(data_rx_error_3),
     // Interface: out
     .out_ready(data_tx_ready_4),
     .out_valid(data_tx_valid_4),
     .out_data(data_tx_data_4),
     .out_startofpacket(data_tx_sop_4),
     .out_endofpacket(data_tx_eop_4),
     .out_error(data_tx_error_4)
   );

   assign data_rx_ready_4  = 1'b1;
   assign tx_crc_fwd_5     = ff_tx_crc_fwd;

   loopback_adapter u_ch4_2_ch5 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_4),
     .in_data(data_rx_data_4),
     .in_startofpacket(data_rx_sop_4),
     .in_endofpacket(data_rx_eop_4),
     .in_error(data_rx_error_4),
     // Interface: out
     .out_ready(data_tx_ready_5),
     .out_valid(data_tx_valid_5),
     .out_data(data_tx_data_5),
     .out_startofpacket(data_tx_sop_5),
     .out_endofpacket(data_tx_eop_5),
     .out_error(data_tx_error_5)
   );

   assign data_rx_ready_5  = 1'b1;
   assign tx_crc_fwd_6     = ff_tx_crc_fwd;

   loopback_adapter u_ch5_2_ch6 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_5),
     .in_data(data_rx_data_5),
     .in_startofpacket(data_rx_sop_5),
     .in_endofpacket(data_rx_eop_5),
     .in_error(data_rx_error_5),
     // Interface: out
     .out_ready(data_tx_ready_6),
     .out_valid(data_tx_valid_6),
     .out_data(data_tx_data_6),
     .out_startofpacket(data_tx_sop_6),
     .out_endofpacket(data_tx_eop_6),
     .out_error(data_tx_error_6)
   );

   assign data_rx_ready_6  = 1'b1;
   assign tx_crc_fwd_7     = ff_tx_crc_fwd;

   loopback_adapter u_ch6_2_ch7 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_6),
     .in_data(data_rx_data_6),
     .in_startofpacket(data_rx_sop_6),
     .in_endofpacket(data_rx_eop_6),
     .in_error(data_rx_error_6),
     // Interface: out
     .out_ready(data_tx_ready_7),
     .out_valid(data_tx_valid_7),
     .out_data(data_tx_data_7),
     .out_startofpacket(data_tx_sop_7),
     .out_endofpacket(data_tx_eop_7),
     .out_error(data_tx_error_7)
   );

   
   //assigning to GMII/MII TX monitoring
   assign rgmii_tx_ctnl    = tx_control_0;
   assign rgmii_tx_data    = rgmii_out_0;
   assign gm_tx_data       = gm_tx_d_0;
   assign gm_tx_en         = gm_tx_en_0;
   assign gm_tx_err        = gm_tx_err_0;
   assign m_tx_data        = m_tx_d_0;
   assign m_tx_en          = m_tx_en_0;
   assign m_tx_err         = m_tx_err_0;

   assign gm_rx_d_0        = gm_tx_d_0;
   assign gm_rx_dv_0       = gm_tx_en_0;
   assign gm_rx_err_0      = gm_tx_err_0;
   assign m_rx_d_0         = m_tx_d_0;
   assign m_rx_en_0        = m_tx_en_0;
   assign m_rx_err_0       = m_tx_err_0;
   assign m_rx_col_0       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_0       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_0     = tx_control_0;
   assign rgmii_in_0       = rgmii_out_0;
   assign #(4) tbi_rx_d_0  = tbi_tx_d_0;

   assign gm_rx_d_1        = gm_tx_d_1;
   assign gm_rx_dv_1       = gm_tx_en_1;
   assign gm_rx_err_1      = gm_tx_err_1;
   assign m_rx_d_1         = m_tx_d_1;
   assign m_rx_en_1        = m_tx_en_1;
   assign m_rx_err_1       = m_tx_err_1;
   assign m_rx_col_1       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_1       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_1     = tx_control_1;
   assign rgmii_in_1       = rgmii_out_1;
   assign #(4) tbi_rx_d_1  = tbi_tx_d_1;

   assign gm_rx_d_2        = gm_tx_d_2;
   assign gm_rx_dv_2       = gm_tx_en_2;
   assign gm_rx_err_2      = gm_tx_err_2;
   assign m_rx_d_2         = m_tx_d_2;
   assign m_rx_en_2        = m_tx_en_2;
   assign m_rx_err_2       = m_tx_err_2;
   assign m_rx_col_2       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_2       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_2     = tx_control_2;
   assign rgmii_in_2       = rgmii_out_2;
   assign #(4) tbi_rx_d_2  = tbi_tx_d_2;

   assign gm_rx_d_3        = gm_tx_d_3;
   assign gm_rx_dv_3       = gm_tx_en_3;
   assign gm_rx_err_3      = gm_tx_err_3;
   assign m_rx_d_3         = m_tx_d_3;
   assign m_rx_en_3        = m_tx_en_3;
   assign m_rx_err_3       = m_tx_err_3;
   assign m_rx_col_3       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_3       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_3     = tx_control_3;
   assign rgmii_in_3       = rgmii_out_3;
   assign #(4) tbi_rx_d_3  = tbi_tx_d_3;

   assign gm_rx_d_4        = gm_tx_d_4;
   assign gm_rx_dv_4       = gm_tx_en_4;
   assign gm_rx_err_4      = gm_tx_err_4;
   assign m_rx_d_4         = m_tx_d_4;
   assign m_rx_en_4        = m_tx_en_4;
   assign m_rx_err_4       = m_tx_err_4;
   assign m_rx_col_4       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_4       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_4     = tx_control_4;
   assign rgmii_in_4       = rgmii_out_4;
   assign #(4) tbi_rx_d_4  = tbi_tx_d_4;

   assign gm_rx_d_5        = gm_tx_d_5;
   assign gm_rx_dv_5       = gm_tx_en_5;
   assign gm_rx_err_5      = gm_tx_err_5;
   assign m_rx_d_5         = m_tx_d_5;
   assign m_rx_en_5        = m_tx_en_5;
   assign m_rx_err_5       = m_tx_err_5;
   assign m_rx_col_5       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_5       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_5     = tx_control_5;
   assign rgmii_in_5       = rgmii_out_5;
   assign #(4) tbi_rx_d_5  = tbi_tx_d_5;

   assign gm_rx_d_6        = gm_tx_d_6;
   assign gm_rx_dv_6       = gm_tx_en_6;
   assign gm_rx_err_6      = gm_tx_err_6;
   assign m_rx_d_6         = m_tx_d_6;
   assign m_rx_en_6        = m_tx_en_6;
   assign m_rx_err_6       = m_tx_err_6;
   assign m_rx_col_6       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_6       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_6     = tx_control_6;
   assign rgmii_in_6       = rgmii_out_6;
   assign #(4) tbi_rx_d_6  = tbi_tx_d_6;

   assign gm_rx_d_7        = gm_tx_d_7;
   assign gm_rx_dv_7       = gm_tx_en_7;
   assign gm_rx_err_7      = gm_tx_err_7;
   assign m_rx_d_7         = m_tx_d_7;
   assign m_rx_en_7        = m_tx_en_7;
   assign m_rx_err_7       = m_tx_err_7;
   assign m_rx_col_7       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_7       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_7     = tx_control_7;
   assign rgmii_in_7       = rgmii_out_7;
   assign #(4) tbi_rx_d_7  = tbi_tx_d_7;


  end

 if (MAX_CHANNELS == 12)
  begin
   assign led_link = led_link_0 ;
   //input of DUT
   assign ff_rx_dsav       = 1'b0; 
   assign rx_afull_clk     = rx_clk;
   assign rx_afull_channel = 5'b0;
   assign rx_afull_data    = 2'b0;
   assign rx_afull_valid   = 1'b1;
   assign data_tx_data_0   = ff_tx_data;
   assign data_tx_eop_0    = ff_tx_eop;
   assign data_tx_error_0  = ff_tx_err;
   assign data_tx_sop_0    = ff_tx_sop;
   assign data_tx_valid_0  = ff_tx_wren;
   assign tx_crc_fwd_0     = ff_tx_crc_fwd;
   assign data_rx_ready_11  = ff_rx_rdy;

   assign tbi_tx_clk_0     = tx_clk_1000mbps;
   assign tbi_rx_clk_0     = rx_clk_1000mbps;
   assign tbi_tx_clk_1     = tx_clk_1000mbps;
   assign tbi_rx_clk_1     = rx_clk_1000mbps;
   assign tbi_tx_clk_2     = tx_clk_1000mbps;
   assign tbi_rx_clk_2     = rx_clk_1000mbps;
   assign tbi_tx_clk_3     = tx_clk_1000mbps;
   assign tbi_rx_clk_3     = rx_clk_1000mbps;
   assign tbi_tx_clk_4     = tx_clk_1000mbps;
   assign tbi_rx_clk_4     = rx_clk_1000mbps;
   assign tbi_tx_clk_5     = tx_clk_1000mbps;
   assign tbi_rx_clk_5     = rx_clk_1000mbps;
   assign tbi_tx_clk_6     = tx_clk_1000mbps;
   assign tbi_rx_clk_6     = rx_clk_1000mbps;
   assign tbi_tx_clk_7     = tx_clk_1000mbps;
   assign tbi_rx_clk_7     = rx_clk_1000mbps;
   assign tbi_tx_clk_8     = tx_clk_1000mbps;
   assign tbi_rx_clk_8     = rx_clk_1000mbps;
   assign tbi_tx_clk_9     = tx_clk_1000mbps;
   assign tbi_rx_clk_9     = rx_clk_1000mbps;
   assign tbi_tx_clk_10     = tx_clk_1000mbps;
   assign tbi_rx_clk_10     = rx_clk_1000mbps;
   assign tbi_tx_clk_11     = tx_clk_1000mbps;
   assign tbi_rx_clk_11     = rx_clk_1000mbps;

   assign set_10_0         = 1'b0;
   assign set_1000_0       = 1'b0;
   assign set_10_1         = 1'b0;
   assign set_1000_1       = 1'b0;
   assign set_10_2         = 1'b0;
   assign set_1000_2       = 1'b0;
   assign set_10_3         = 1'b0;
   assign set_1000_3       = 1'b0;
   assign set_10_4         = 1'b0;
   assign set_1000_4       = 1'b0;
   assign set_10_4         = 1'b0;
   assign set_1000_4       = 1'b0;
   assign set_10_5         = 1'b0;
   assign set_1000_5       = 1'b0;
   assign set_10_6         = 1'b0;
   assign set_1000_6       = 1'b0;
   assign set_10_7         = 1'b0;
   assign set_1000_7       = 1'b0;
   assign set_10_8         = 1'b0;
   assign set_1000_8       = 1'b0;
   assign set_10_9         = 1'b0;
   assign set_1000_9       = 1'b0;
   assign set_10_10         = 1'b0;
   assign set_1000_10       = 1'b0;
   assign set_10_11         = 1'b0;
   assign set_1000_11       = 1'b0;

   assign xon_gen_0        = 1'b0;
   assign xoff_gen_0       = 1'b0;
   assign xon_gen_1        = 1'b0;
   assign xoff_gen_1       = 1'b0;
   assign xon_gen_2        = 1'b0;
   assign xoff_gen_2       = 1'b0;
   assign xon_gen_3        = 1'b0;
   assign xoff_gen_3       = 1'b0;
   assign xon_gen_4        = 1'b0;
   assign xoff_gen_4       = 1'b0;
   assign xon_gen_5        = 1'b0;
   assign xoff_gen_5       = 1'b0;
   assign xon_gen_6        = 1'b0;
   assign xoff_gen_6       = 1'b0;
   assign xon_gen_7        = 1'b0;
   assign xoff_gen_7       = 1'b0;
   assign xon_gen_8        = 1'b0;
   assign xoff_gen_8       = 1'b0;
   assign xon_gen_9        = 1'b0;
   assign xoff_gen_9       = 1'b0;
   assign xon_gen_10        = 1'b0;
   assign xoff_gen_10       = 1'b0;
   assign xon_gen_11        = 1'b0;
   assign xoff_gen_11       = 1'b0;

   assign magic_sleep_n_0  = magic_sleep_n;
   assign magic_sleep_n_1  = magic_sleep_n;
   assign magic_sleep_n_2  = magic_sleep_n;
   assign magic_sleep_n_3  = magic_sleep_n;
   assign magic_sleep_n_4  = magic_sleep_n;
   assign magic_sleep_n_5  = magic_sleep_n;
   assign magic_sleep_n_6  = magic_sleep_n;
   assign magic_sleep_n_7  = magic_sleep_n;
   assign magic_sleep_n_8  = magic_sleep_n;
   assign magic_sleep_n_9  = magic_sleep_n;
   assign magic_sleep_n_10  = magic_sleep_n;
   assign magic_sleep_n_11  = magic_sleep_n;


   //output of DUT
   assign ff_rx_err_stat   = {pkt_class_valid_11 ? pkt_class_data_11 [0] : 1'b0, data_rx_error_11[4], 15'b0 ,pkt_class_valid_11 ? (pkt_class_data_11[1]|pkt_class_data_11[0]) : 1'b0 ,data_rx_error_11[3:0]};
   assign ff_rx_err        = data_rx_error_11 [0]|data_rx_error_11 [1]|data_rx_error_11 [2]|data_rx_error_11 [3]|data_rx_error_11 [4];
   assign ff_rx_vlan       = pkt_class_valid_11 ? pkt_class_data_11 [1] : 1'b0 ;
   assign ff_rx_bcast      = pkt_class_valid_11 ? pkt_class_data_11 [2] : 1'b0 ;
   assign ff_rx_mcast      = pkt_class_valid_11 ? pkt_class_data_11 [3] : 1'b0 ;
   assign ff_rx_ucast      = pkt_class_valid_11 ? pkt_class_data_11 [4] : 1'b0 ;
   assign ff_tx_clk        = mac_tx_clk_0;
   assign ff_rx_clk        = mac_rx_clk_0;
   assign ff_tx_rdy        = data_tx_ready_0;
   assign ff_rx_data       = data_rx_data_11;
   assign ff_rx_dval       = data_rx_valid_11;
   assign ff_rx_eop        = data_rx_eop_11;
   assign ff_rx_sop        = data_rx_sop_11;
   assign rx_err           = data_rx_error_11;

   //loopback
   assign data_rx_ready_0  = 1'b1;//data_tx_ready_1;
   assign tx_crc_fwd_1     = ff_tx_crc_fwd;


   loopback_adapter u_ch0_2_ch1 (
       
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_0),
     .in_data(data_rx_data_0),
     .in_startofpacket(data_rx_sop_0),
     .in_endofpacket(data_rx_eop_0),
     .in_error(data_rx_error_0),
     // Interface: out
     .out_ready(data_tx_ready_1),
     .out_valid(data_tx_valid_1),
     .out_data(data_tx_data_1),
     .out_startofpacket(data_tx_sop_1),
     .out_endofpacket(data_tx_eop_1),
     .out_error(data_tx_error_1)
   );

   assign data_rx_ready_1  = 1'b1;
   assign tx_crc_fwd_2     = ff_tx_crc_fwd;

   loopback_adapter u_ch1_2_ch2 (
       
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_1),
     .in_data(data_rx_data_1),
     .in_startofpacket(data_rx_sop_1),
     .in_endofpacket(data_rx_eop_1),
     .in_error(data_rx_error_1),
     // Interface: out
     .out_ready(data_tx_ready_2),
     .out_valid(data_tx_valid_2),
     .out_data(data_tx_data_2),
     .out_startofpacket(data_tx_sop_2),
     .out_endofpacket(data_tx_eop_2),
     .out_error(data_tx_error_2)
   );

   assign data_rx_ready_2  = 1'b1;
   assign tx_crc_fwd_3     = ff_tx_crc_fwd;

   loopback_adapter u_ch2_2_ch3 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_2),
     .in_data(data_rx_data_2),
     .in_startofpacket(data_rx_sop_2),
     .in_endofpacket(data_rx_eop_2),
     .in_error(data_rx_error_2),
     // Interface: out
     .out_ready(data_tx_ready_3),
     .out_valid(data_tx_valid_3),
     .out_data(data_tx_data_3),
     .out_startofpacket(data_tx_sop_3),
     .out_endofpacket(data_tx_eop_3),
     .out_error(data_tx_error_3)
   );

   assign data_rx_ready_3  = 1'b1;
   assign tx_crc_fwd_4     = ff_tx_crc_fwd;

   loopback_adapter u_ch3_2_ch4 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_3),
     .in_data(data_rx_data_3),
     .in_startofpacket(data_rx_sop_3),
     .in_endofpacket(data_rx_eop_3),
     .in_error(data_rx_error_3),
     // Interface: out
     .out_ready(data_tx_ready_4),
     .out_valid(data_tx_valid_4),
     .out_data(data_tx_data_4),
     .out_startofpacket(data_tx_sop_4),
     .out_endofpacket(data_tx_eop_4),
     .out_error(data_tx_error_4)
   );

   assign data_rx_ready_4  = 1'b1;
   assign tx_crc_fwd_5     = ff_tx_crc_fwd;

   loopback_adapter u_ch4_2_ch5 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_4),
     .in_data(data_rx_data_4),
     .in_startofpacket(data_rx_sop_4),
     .in_endofpacket(data_rx_eop_4),
     .in_error(data_rx_error_4),
     // Interface: out
     .out_ready(data_tx_ready_5),
     .out_valid(data_tx_valid_5),
     .out_data(data_tx_data_5),
     .out_startofpacket(data_tx_sop_5),
     .out_endofpacket(data_tx_eop_5),
     .out_error(data_tx_error_5)
   );

   assign data_rx_ready_5  = 1'b1;
   assign tx_crc_fwd_6     = ff_tx_crc_fwd;

   loopback_adapter u_ch5_2_ch6 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_5),
     .in_data(data_rx_data_5),
     .in_startofpacket(data_rx_sop_5),
     .in_endofpacket(data_rx_eop_5),
     .in_error(data_rx_error_5),
     // Interface: out
     .out_ready(data_tx_ready_6),
     .out_valid(data_tx_valid_6),
     .out_data(data_tx_data_6),
     .out_startofpacket(data_tx_sop_6),
     .out_endofpacket(data_tx_eop_6),
     .out_error(data_tx_error_6)
   );

   assign data_rx_ready_6  = 1'b1;
   assign tx_crc_fwd_7     = ff_tx_crc_fwd;

   loopback_adapter u_ch6_2_ch7 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_6),
     .in_data(data_rx_data_6),
     .in_startofpacket(data_rx_sop_6),
     .in_endofpacket(data_rx_eop_6),
     .in_error(data_rx_error_6),
     // Interface: out
     .out_ready(data_tx_ready_7),
     .out_valid(data_tx_valid_7),
     .out_data(data_tx_data_7),
     .out_startofpacket(data_tx_sop_7),
     .out_endofpacket(data_tx_eop_7),
     .out_error(data_tx_error_7)
   );

   assign data_rx_ready_7  = 1'b1;
   assign tx_crc_fwd_8    = ff_tx_crc_fwd;

   loopback_adapter u_ch7_2_ch8 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_7),
     .in_data(data_rx_data_7),
     .in_startofpacket(data_rx_sop_7),
     .in_endofpacket(data_rx_eop_7),
     .in_error(data_rx_error_7),
     // Interface: out
     .out_ready(data_tx_ready_8),
     .out_valid(data_tx_valid_8),
     .out_data(data_tx_data_8),
     .out_startofpacket(data_tx_sop_8),
     .out_endofpacket(data_tx_eop_8),
     .out_error(data_tx_error_8)
   );

   assign data_rx_ready_8  = 1'b1;
   assign tx_crc_fwd_9     = ff_tx_crc_fwd;

   loopback_adapter u_ch8_2_ch9 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_8),
     .in_data(data_rx_data_8),
     .in_startofpacket(data_rx_sop_8),
     .in_endofpacket(data_rx_eop_8),
     .in_error(data_rx_error_8),
     // Interface: out
     .out_ready(data_tx_ready_9),
     .out_valid(data_tx_valid_9),
     .out_data(data_tx_data_9),
     .out_startofpacket(data_tx_sop_9),
     .out_endofpacket(data_tx_eop_9),
     .out_error(data_tx_error_9)
   );

   assign data_rx_ready_9  = 1'b1;
   assign tx_crc_fwd_10     = ff_tx_crc_fwd;

   loopback_adapter u_ch9_2_ch10 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_9),
     .in_data(data_rx_data_9),
     .in_startofpacket(data_rx_sop_9),
     .in_endofpacket(data_rx_eop_9),
     .in_error(data_rx_error_9),
     // Interface: out
     .out_ready(data_tx_ready_10),
     .out_valid(data_tx_valid_10),
     .out_data(data_tx_data_10),
     .out_startofpacket(data_tx_sop_10),
     .out_endofpacket(data_tx_eop_10),
     .out_error(data_tx_error_10)
   );

   assign data_rx_ready_10  = 1'b1;
   assign tx_crc_fwd_11     = ff_tx_crc_fwd;

   loopback_adapter u_ch10_2_ch11 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_10),
     .in_data(data_rx_data_10),
     .in_startofpacket(data_rx_sop_10),
     .in_endofpacket(data_rx_eop_10),
     .in_error(data_rx_error_10),
     // Interface: out
     .out_ready(data_tx_ready_11),
     .out_valid(data_tx_valid_11),
     .out_data(data_tx_data_11),
     .out_startofpacket(data_tx_sop_11),
     .out_endofpacket(data_tx_eop_11),
     .out_error(data_tx_error_11)
   );

   
   //assigning to GMII/MII TX monitoring
   assign rgmii_tx_ctnl    = tx_control_0;
   assign rgmii_tx_data    = rgmii_out_0;
   assign gm_tx_data       = gm_tx_d_0;
   assign gm_tx_en         = gm_tx_en_0;
   assign gm_tx_err        = gm_tx_err_0;
   assign m_tx_data        = m_tx_d_0;
   assign m_tx_en          = m_tx_en_0;
   assign m_tx_err         = m_tx_err_0;

   assign gm_rx_d_0        = gm_tx_d_0;
   assign gm_rx_dv_0       = gm_tx_en_0;
   assign gm_rx_err_0      = gm_tx_err_0;
   assign m_rx_d_0         = m_tx_d_0;
   assign m_rx_en_0        = m_tx_en_0;
   assign m_rx_err_0       = m_tx_err_0;
   assign m_rx_col_0       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_0       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_0     = tx_control_0;
   assign rgmii_in_0       = rgmii_out_0;
   assign #(4) tbi_rx_d_0  = tbi_tx_d_0;

   assign gm_rx_d_1        = gm_tx_d_1;
   assign gm_rx_dv_1       = gm_tx_en_1;
   assign gm_rx_err_1      = gm_tx_err_1;
   assign m_rx_d_1         = m_tx_d_1;
   assign m_rx_en_1        = m_tx_en_1;
   assign m_rx_err_1       = m_tx_err_1;
   assign m_rx_col_1       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_1       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_1     = tx_control_1;
   assign rgmii_in_1       = rgmii_out_1;
   assign #(4) tbi_rx_d_1  = tbi_tx_d_1;

   assign gm_rx_d_2        = gm_tx_d_2;
   assign gm_rx_dv_2       = gm_tx_en_2;
   assign gm_rx_err_2      = gm_tx_err_2;
   assign m_rx_d_2         = m_tx_d_2;
   assign m_rx_en_2        = m_tx_en_2;
   assign m_rx_err_2       = m_tx_err_2;
   assign m_rx_col_2       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_2       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_2     = tx_control_2;
   assign rgmii_in_2       = rgmii_out_2;
   assign #(4) tbi_rx_d_2  = tbi_tx_d_2;

   assign gm_rx_d_3        = gm_tx_d_3;
   assign gm_rx_dv_3       = gm_tx_en_3;
   assign gm_rx_err_3      = gm_tx_err_3;
   assign m_rx_d_3         = m_tx_d_3;
   assign m_rx_en_3        = m_tx_en_3;
   assign m_rx_err_3       = m_tx_err_3;
   assign m_rx_col_3       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_3       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_3     = tx_control_3;
   assign rgmii_in_3       = rgmii_out_3;
   assign #(4) tbi_rx_d_3  = tbi_tx_d_3;

   assign gm_rx_d_4        = gm_tx_d_4;
   assign gm_rx_dv_4       = gm_tx_en_4;
   assign gm_rx_err_4      = gm_tx_err_4;
   assign m_rx_d_4         = m_tx_d_4;
   assign m_rx_en_4        = m_tx_en_4;
   assign m_rx_err_4       = m_tx_err_4;
   assign m_rx_col_4       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_4       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_4     = tx_control_4;
   assign rgmii_in_4       = rgmii_out_4;
   assign #(4) tbi_rx_d_4  = tbi_tx_d_4;

   assign gm_rx_d_5        = gm_tx_d_5;
   assign gm_rx_dv_5       = gm_tx_en_5;
   assign gm_rx_err_5      = gm_tx_err_5;
   assign m_rx_d_5         = m_tx_d_5;
   assign m_rx_en_5        = m_tx_en_5;
   assign m_rx_err_5       = m_tx_err_5;
   assign m_rx_col_5       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_5       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_5     = tx_control_5;
   assign rgmii_in_5       = rgmii_out_5;
   assign #(4) tbi_rx_d_5  = tbi_tx_d_5;

   assign gm_rx_d_6        = gm_tx_d_6;
   assign gm_rx_dv_6       = gm_tx_en_6;
   assign gm_rx_err_6      = gm_tx_err_6;
   assign m_rx_d_6         = m_tx_d_6;
   assign m_rx_en_6        = m_tx_en_6;
   assign m_rx_err_6       = m_tx_err_6;
   assign m_rx_col_6       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_6       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_6     = tx_control_6;
   assign rgmii_in_6       = rgmii_out_6;
   assign #(4) tbi_rx_d_6  = tbi_tx_d_6;

   assign gm_rx_d_7        = gm_tx_d_7;
   assign gm_rx_dv_7       = gm_tx_en_7;
   assign gm_rx_err_7      = gm_tx_err_7;
   assign m_rx_d_7         = m_tx_d_7;
   assign m_rx_en_7        = m_tx_en_7;
   assign m_rx_err_7       = m_tx_err_7;
   assign m_rx_col_7       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_7       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_7     = tx_control_7;
   assign rgmii_in_7       = rgmii_out_7;
   assign #(4) tbi_rx_d_7  = tbi_tx_d_7;

   assign gm_rx_d_8        = gm_tx_d_8;
   assign gm_rx_dv_8       = gm_tx_en_8;
   assign gm_rx_err_8      = gm_tx_err_8;
   assign m_rx_d_8         = m_tx_d_8;
   assign m_rx_en_8        = m_tx_en_8;
   assign m_rx_err_8       = m_tx_err_8;
   assign m_rx_col_8       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_8       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_8     = tx_control_8;
   assign rgmii_in_8       = rgmii_out_8;
   assign #(4) tbi_rx_d_8  = tbi_tx_d_8;

   assign gm_rx_d_9        = gm_tx_d_9;
   assign gm_rx_dv_9       = gm_tx_en_9;
   assign gm_rx_err_9      = gm_tx_err_9;
   assign m_rx_d_9         = m_tx_d_9;
   assign m_rx_en_9        = m_tx_en_9;
   assign m_rx_err_9       = m_tx_err_9;
   assign m_rx_col_9       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_9       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_9     = tx_control_9;
   assign rgmii_in_9       = rgmii_out_9;
   assign #(4) tbi_rx_d_9  = tbi_tx_d_9;

   assign gm_rx_d_10        = gm_tx_d_10;
   assign gm_rx_dv_10       = gm_tx_en_10;
   assign gm_rx_err_10      = gm_tx_err_10;
   assign m_rx_d_10         = m_tx_d_10;
   assign m_rx_en_10        = m_tx_en_10;
   assign m_rx_err_10       = m_tx_err_10;
   assign m_rx_col_10       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_10       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_10     = tx_control_10;
   assign rgmii_in_10       = rgmii_out_10;
   assign #(4) tbi_rx_d_10  = tbi_tx_d_10;

   assign gm_rx_d_11        = gm_tx_d_11;
   assign gm_rx_dv_11       = gm_tx_en_11;
   assign gm_rx_err_11      = gm_tx_err_11;
   assign m_rx_d_11         = m_tx_d_11;
   assign m_rx_en_11        = m_tx_en_11;
   assign m_rx_err_11       = m_tx_err_11;
   assign m_rx_col_11       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_11       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_11     = tx_control_11;
   assign rgmii_in_11       = rgmii_out_11;
   assign #(4) tbi_rx_d_11  = tbi_tx_d_11;


  end

 if (MAX_CHANNELS == 16)
  begin
   assign led_link = led_link_0 ;
   //input of DUT
   assign ff_rx_dsav       = 1'b0; 
   assign rx_afull_clk     = rx_clk;
   assign rx_afull_channel = 5'b0;
   assign rx_afull_data    = 2'b0;
   assign rx_afull_valid   = 1'b1;
   assign data_tx_data_0   = ff_tx_data;
   assign data_tx_eop_0    = ff_tx_eop;
   assign data_tx_error_0  = ff_tx_err;
   assign data_tx_sop_0    = ff_tx_sop;
   assign data_tx_valid_0  = ff_tx_wren;
   assign tx_crc_fwd_0     = ff_tx_crc_fwd;
   assign data_rx_ready_15  = ff_rx_rdy;

   assign tbi_tx_clk_0     = tx_clk_1000mbps;
   assign tbi_rx_clk_0     = rx_clk_1000mbps;
   assign tbi_tx_clk_1     = tx_clk_1000mbps;
   assign tbi_rx_clk_1     = rx_clk_1000mbps;
   assign tbi_tx_clk_2     = tx_clk_1000mbps;
   assign tbi_rx_clk_2     = rx_clk_1000mbps;
   assign tbi_tx_clk_3     = tx_clk_1000mbps;
   assign tbi_rx_clk_3     = rx_clk_1000mbps;
   assign tbi_tx_clk_4     = tx_clk_1000mbps;
   assign tbi_rx_clk_4     = rx_clk_1000mbps;
   assign tbi_tx_clk_5     = tx_clk_1000mbps;
   assign tbi_rx_clk_5     = rx_clk_1000mbps;
   assign tbi_tx_clk_6     = tx_clk_1000mbps;
   assign tbi_rx_clk_6     = rx_clk_1000mbps;
   assign tbi_tx_clk_7     = tx_clk_1000mbps;
   assign tbi_rx_clk_7     = rx_clk_1000mbps;
   assign tbi_tx_clk_8     = tx_clk_1000mbps;
   assign tbi_rx_clk_8     = rx_clk_1000mbps;
   assign tbi_tx_clk_9     = tx_clk_1000mbps;
   assign tbi_rx_clk_9     = rx_clk_1000mbps;
   assign tbi_tx_clk_10     = tx_clk_1000mbps;
   assign tbi_rx_clk_10     = rx_clk_1000mbps;
   assign tbi_tx_clk_11     = tx_clk_1000mbps;
   assign tbi_rx_clk_11     = rx_clk_1000mbps;
   assign tbi_tx_clk_12     = tx_clk_1000mbps;
   assign tbi_rx_clk_12     = rx_clk_1000mbps;
   assign tbi_tx_clk_13     = tx_clk_1000mbps;
   assign tbi_rx_clk_13     = rx_clk_1000mbps;
   assign tbi_tx_clk_14     = tx_clk_1000mbps;
   assign tbi_rx_clk_14     = rx_clk_1000mbps;
   assign tbi_tx_clk_15     = tx_clk_1000mbps;
   assign tbi_rx_clk_15     = rx_clk_1000mbps;

   assign set_10_0         = 1'b0;
   assign set_1000_0       = 1'b0;
   assign set_10_1         = 1'b0;
   assign set_1000_1       = 1'b0;
   assign set_10_2         = 1'b0;
   assign set_1000_2       = 1'b0;
   assign set_10_3         = 1'b0;
   assign set_1000_3       = 1'b0;
   assign set_10_4         = 1'b0;
   assign set_1000_4       = 1'b0;
   assign set_10_4         = 1'b0;
   assign set_1000_4       = 1'b0;
   assign set_10_5         = 1'b0;
   assign set_1000_5       = 1'b0;
   assign set_10_6         = 1'b0;
   assign set_1000_6       = 1'b0;
   assign set_10_7         = 1'b0;
   assign set_1000_7       = 1'b0;
   assign set_10_8         = 1'b0;
   assign set_1000_8       = 1'b0;
   assign set_10_9         = 1'b0;
   assign set_1000_9       = 1'b0;
   assign set_10_10         = 1'b0;
   assign set_1000_10       = 1'b0;
   assign set_10_11         = 1'b0;
   assign set_1000_11       = 1'b0;
   assign set_10_12         = 1'b0;
   assign set_1000_12       = 1'b0;
   assign set_10_13         = 1'b0;
   assign set_1000_13       = 1'b0;
   assign set_10_14         = 1'b0;
   assign set_1000_14       = 1'b0;
   assign set_10_15         = 1'b0;
   assign set_1000_15       = 1'b0;

   assign xon_gen_0        = 1'b0;
   assign xoff_gen_0       = 1'b0;
   assign xon_gen_1        = 1'b0;
   assign xoff_gen_1       = 1'b0;
   assign xon_gen_2        = 1'b0;
   assign xoff_gen_2       = 1'b0;
   assign xon_gen_3        = 1'b0;
   assign xoff_gen_3       = 1'b0;
   assign xon_gen_4        = 1'b0;
   assign xoff_gen_4       = 1'b0;
   assign xon_gen_5        = 1'b0;
   assign xoff_gen_5       = 1'b0;
   assign xon_gen_6        = 1'b0;
   assign xoff_gen_6       = 1'b0;
   assign xon_gen_7        = 1'b0;
   assign xoff_gen_7       = 1'b0;
   assign xon_gen_8        = 1'b0;
   assign xoff_gen_8       = 1'b0;
   assign xon_gen_9        = 1'b0;
   assign xoff_gen_9       = 1'b0;
   assign xon_gen_10        = 1'b0;
   assign xoff_gen_10       = 1'b0;
   assign xon_gen_11        = 1'b0;
   assign xoff_gen_11       = 1'b0;
   assign xon_gen_12        = 1'b0;
   assign xoff_gen_12       = 1'b0;
   assign xon_gen_13        = 1'b0;
   assign xoff_gen_13       = 1'b0;
   assign xon_gen_14        = 1'b0;
   assign xoff_gen_14       = 1'b0;
   assign xon_gen_15        = 1'b0;
   assign xoff_gen_15       = 1'b0;

   assign magic_sleep_n_0  = magic_sleep_n;
   assign magic_sleep_n_1  = magic_sleep_n;
   assign magic_sleep_n_2  = magic_sleep_n;
   assign magic_sleep_n_3  = magic_sleep_n;
   assign magic_sleep_n_4  = magic_sleep_n;
   assign magic_sleep_n_5  = magic_sleep_n;
   assign magic_sleep_n_6  = magic_sleep_n;
   assign magic_sleep_n_7  = magic_sleep_n;
   assign magic_sleep_n_8  = magic_sleep_n;
   assign magic_sleep_n_9  = magic_sleep_n;
   assign magic_sleep_n_10  = magic_sleep_n;
   assign magic_sleep_n_11  = magic_sleep_n;
   assign magic_sleep_n_12  = magic_sleep_n;
   assign magic_sleep_n_13  = magic_sleep_n;
   assign magic_sleep_n_14  = magic_sleep_n;
   assign magic_sleep_n_15  = magic_sleep_n;


   //output of DUT
   assign ff_rx_err_stat   = {pkt_class_valid_15 ? pkt_class_data_15 [0] : 1'b0, data_rx_error_15[4], 15'b0 ,pkt_class_valid_15 ? (pkt_class_data_15[1]|pkt_class_data_15[0]) : 1'b0 ,data_rx_error_15[3:0]};
   assign ff_rx_err        = data_rx_error_15 [0]|data_rx_error_15 [1]|data_rx_error_15 [2]|data_rx_error_15 [3]|data_rx_error_15 [4];
   assign ff_rx_vlan       = pkt_class_valid_15 ? pkt_class_data_15 [1] : 1'b0 ;
   assign ff_rx_bcast      = pkt_class_valid_15 ? pkt_class_data_15 [2] : 1'b0 ;
   assign ff_rx_mcast      = pkt_class_valid_15 ? pkt_class_data_15 [3] : 1'b0 ;
   assign ff_rx_ucast      = pkt_class_valid_15 ? pkt_class_data_15 [4] : 1'b0 ;
   assign ff_tx_clk        = mac_tx_clk_0;
   assign ff_rx_clk        = mac_rx_clk_0;
   assign ff_tx_rdy        = data_tx_ready_0;
   assign ff_rx_data       = data_rx_data_15;
   assign ff_rx_dval       = data_rx_valid_15;
   assign ff_rx_eop        = data_rx_eop_15;
   assign ff_rx_sop        = data_rx_sop_15;
   assign rx_err           = data_rx_error_15;

   //loopback
   assign data_rx_ready_0  = 1'b1;//data_tx_ready_1;
   assign tx_crc_fwd_1     = ff_tx_crc_fwd;


   loopback_adapter u_ch0_2_ch1 (
       
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_0),
     .in_data(data_rx_data_0),
     .in_startofpacket(data_rx_sop_0),
     .in_endofpacket(data_rx_eop_0),
     .in_error(data_rx_error_0),
     // Interface: out
     .out_ready(data_tx_ready_1),
     .out_valid(data_tx_valid_1),
     .out_data(data_tx_data_1),
     .out_startofpacket(data_tx_sop_1),
     .out_endofpacket(data_tx_eop_1),
     .out_error(data_tx_error_1)
   );

   assign data_rx_ready_1  = 1'b1;
   assign tx_crc_fwd_2     = ff_tx_crc_fwd;

   loopback_adapter u_ch1_2_ch2 (
       
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_1),
     .in_data(data_rx_data_1),
     .in_startofpacket(data_rx_sop_1),
     .in_endofpacket(data_rx_eop_1),
     .in_error(data_rx_error_1),
     // Interface: out
     .out_ready(data_tx_ready_2),
     .out_valid(data_tx_valid_2),
     .out_data(data_tx_data_2),
     .out_startofpacket(data_tx_sop_2),
     .out_endofpacket(data_tx_eop_2),
     .out_error(data_tx_error_2)
   );

   assign data_rx_ready_2  = 1'b1;
   assign tx_crc_fwd_3     = ff_tx_crc_fwd;

   loopback_adapter u_ch2_2_ch3 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_2),
     .in_data(data_rx_data_2),
     .in_startofpacket(data_rx_sop_2),
     .in_endofpacket(data_rx_eop_2),
     .in_error(data_rx_error_2),
     // Interface: out
     .out_ready(data_tx_ready_3),
     .out_valid(data_tx_valid_3),
     .out_data(data_tx_data_3),
     .out_startofpacket(data_tx_sop_3),
     .out_endofpacket(data_tx_eop_3),
     .out_error(data_tx_error_3)
   );

   assign data_rx_ready_3  = 1'b1;
   assign tx_crc_fwd_4     = ff_tx_crc_fwd;

   loopback_adapter u_ch3_2_ch4 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_3),
     .in_data(data_rx_data_3),
     .in_startofpacket(data_rx_sop_3),
     .in_endofpacket(data_rx_eop_3),
     .in_error(data_rx_error_3),
     // Interface: out
     .out_ready(data_tx_ready_4),
     .out_valid(data_tx_valid_4),
     .out_data(data_tx_data_4),
     .out_startofpacket(data_tx_sop_4),
     .out_endofpacket(data_tx_eop_4),
     .out_error(data_tx_error_4)
   );

   assign data_rx_ready_4  = 1'b1;
   assign tx_crc_fwd_5     = ff_tx_crc_fwd;

   loopback_adapter u_ch4_2_ch5 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_4),
     .in_data(data_rx_data_4),
     .in_startofpacket(data_rx_sop_4),
     .in_endofpacket(data_rx_eop_4),
     .in_error(data_rx_error_4),
     // Interface: out
     .out_ready(data_tx_ready_5),
     .out_valid(data_tx_valid_5),
     .out_data(data_tx_data_5),
     .out_startofpacket(data_tx_sop_5),
     .out_endofpacket(data_tx_eop_5),
     .out_error(data_tx_error_5)
   );

   assign data_rx_ready_5  = 1'b1;
   assign tx_crc_fwd_6     = ff_tx_crc_fwd;

   loopback_adapter u_ch5_2_ch6 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_5),
     .in_data(data_rx_data_5),
     .in_startofpacket(data_rx_sop_5),
     .in_endofpacket(data_rx_eop_5),
     .in_error(data_rx_error_5),
     // Interface: out
     .out_ready(data_tx_ready_6),
     .out_valid(data_tx_valid_6),
     .out_data(data_tx_data_6),
     .out_startofpacket(data_tx_sop_6),
     .out_endofpacket(data_tx_eop_6),
     .out_error(data_tx_error_6)
   );

   assign data_rx_ready_6  = 1'b1;
   assign tx_crc_fwd_7     = ff_tx_crc_fwd;

   loopback_adapter u_ch6_2_ch7 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_6),
     .in_data(data_rx_data_6),
     .in_startofpacket(data_rx_sop_6),
     .in_endofpacket(data_rx_eop_6),
     .in_error(data_rx_error_6),
     // Interface: out
     .out_ready(data_tx_ready_7),
     .out_valid(data_tx_valid_7),
     .out_data(data_tx_data_7),
     .out_startofpacket(data_tx_sop_7),
     .out_endofpacket(data_tx_eop_7),
     .out_error(data_tx_error_7)
   );

   assign data_rx_ready_7  = 1'b1;
   assign tx_crc_fwd_8    = ff_tx_crc_fwd;

   loopback_adapter u_ch7_2_ch8 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_7),
     .in_data(data_rx_data_7),
     .in_startofpacket(data_rx_sop_7),
     .in_endofpacket(data_rx_eop_7),
     .in_error(data_rx_error_7),
     // Interface: out
     .out_ready(data_tx_ready_8),
     .out_valid(data_tx_valid_8),
     .out_data(data_tx_data_8),
     .out_startofpacket(data_tx_sop_8),
     .out_endofpacket(data_tx_eop_8),
     .out_error(data_tx_error_8)
   );

   assign data_rx_ready_8  = 1'b1;
   assign tx_crc_fwd_9     = ff_tx_crc_fwd;

   loopback_adapter u_ch8_2_ch9 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_8),
     .in_data(data_rx_data_8),
     .in_startofpacket(data_rx_sop_8),
     .in_endofpacket(data_rx_eop_8),
     .in_error(data_rx_error_8),
     // Interface: out
     .out_ready(data_tx_ready_9),
     .out_valid(data_tx_valid_9),
     .out_data(data_tx_data_9),
     .out_startofpacket(data_tx_sop_9),
     .out_endofpacket(data_tx_eop_9),
     .out_error(data_tx_error_9)
   );

   assign data_rx_ready_9  = 1'b1;
   assign tx_crc_fwd_10     = ff_tx_crc_fwd;

   loopback_adapter u_ch9_2_ch10 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_9),
     .in_data(data_rx_data_9),
     .in_startofpacket(data_rx_sop_9),
     .in_endofpacket(data_rx_eop_9),
     .in_error(data_rx_error_9),
     // Interface: out
     .out_ready(data_tx_ready_10),
     .out_valid(data_tx_valid_10),
     .out_data(data_tx_data_10),
     .out_startofpacket(data_tx_sop_10),
     .out_endofpacket(data_tx_eop_10),
     .out_error(data_tx_error_10)
   );

   assign data_rx_ready_10  = 1'b1;
   assign tx_crc_fwd_11     = ff_tx_crc_fwd;

   loopback_adapter u_ch10_2_ch11 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_10),
     .in_data(data_rx_data_10),
     .in_startofpacket(data_rx_sop_10),
     .in_endofpacket(data_rx_eop_10),
     .in_error(data_rx_error_10),
     // Interface: out
     .out_ready(data_tx_ready_11),
     .out_valid(data_tx_valid_11),
     .out_data(data_tx_data_11),
     .out_startofpacket(data_tx_sop_11),
     .out_endofpacket(data_tx_eop_11),
     .out_error(data_tx_error_11)
   );

   assign data_rx_ready_11  = 1'b1;
   assign tx_crc_fwd_12     = ff_tx_crc_fwd;

   loopback_adapter u_ch11_2_ch12 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_11),
     .in_data(data_rx_data_11),
     .in_startofpacket(data_rx_sop_11),
     .in_endofpacket(data_rx_eop_11),
     .in_error(data_rx_error_11),
     // Interface: out
     .out_ready(data_tx_ready_12),
     .out_valid(data_tx_valid_12),
     .out_data(data_tx_data_12),
     .out_startofpacket(data_tx_sop_12),
     .out_endofpacket(data_tx_eop_12),
     .out_error(data_tx_error_12)
   );

   assign data_rx_ready_12  = 1'b1;
   assign tx_crc_fwd_13     = ff_tx_crc_fwd;

   loopback_adapter u_ch12_2_ch13 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_12),
     .in_data(data_rx_data_12),
     .in_startofpacket(data_rx_sop_12),
     .in_endofpacket(data_rx_eop_12),
     .in_error(data_rx_error_12),
     // Interface: out
     .out_ready(data_tx_ready_13),
     .out_valid(data_tx_valid_13),
     .out_data(data_tx_data_13),
     .out_startofpacket(data_tx_sop_13),
     .out_endofpacket(data_tx_eop_13),
     .out_error(data_tx_error_13)
   );

   assign data_rx_ready_13  = 1'b1;
   assign tx_crc_fwd_14     = ff_tx_crc_fwd;

   loopback_adapter u_ch13_2_ch14 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_13),
     .in_data(data_rx_data_13),
     .in_startofpacket(data_rx_sop_13),
     .in_endofpacket(data_rx_eop_13),
     .in_error(data_rx_error_13),
     // Interface: out
     .out_ready(data_tx_ready_14),
     .out_valid(data_tx_valid_14),
     .out_data(data_tx_data_14),
     .out_startofpacket(data_tx_sop_14),
     .out_endofpacket(data_tx_eop_14),
     .out_error(data_tx_error_14)
   );

   assign data_rx_ready_14  = 1'b1;
   assign tx_crc_fwd_15     = ff_tx_crc_fwd;

   loopback_adapter u_ch14_2_ch15 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_14),
     .in_data(data_rx_data_14),
     .in_startofpacket(data_rx_sop_14),
     .in_endofpacket(data_rx_eop_14),
     .in_error(data_rx_error_14),
     // Interface: out
     .out_ready(data_tx_ready_15),
     .out_valid(data_tx_valid_15),
     .out_data(data_tx_data_15),
     .out_startofpacket(data_tx_sop_15),
     .out_endofpacket(data_tx_eop_15),
     .out_error(data_tx_error_15)
   );

   
   //assigning to GMII/MII TX monitoring
   assign rgmii_tx_ctnl    = tx_control_0;
   assign rgmii_tx_data    = rgmii_out_0;
   assign gm_tx_data       = gm_tx_d_0;
   assign gm_tx_en         = gm_tx_en_0;
   assign gm_tx_err        = gm_tx_err_0;
   assign m_tx_data        = m_tx_d_0;
   assign m_tx_en          = m_tx_en_0;
   assign m_tx_err         = m_tx_err_0;

   assign gm_rx_d_0        = gm_tx_d_0;
   assign gm_rx_dv_0       = gm_tx_en_0;
   assign gm_rx_err_0      = gm_tx_err_0;
   assign m_rx_d_0         = m_tx_d_0;
   assign m_rx_en_0        = m_tx_en_0;
   assign m_rx_err_0       = m_tx_err_0;
   assign m_rx_col_0       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_0       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_0     = tx_control_0;
   assign rgmii_in_0       = rgmii_out_0;
   assign #(4) tbi_rx_d_0  = tbi_tx_d_0;

   assign gm_rx_d_1        = gm_tx_d_1;
   assign gm_rx_dv_1       = gm_tx_en_1;
   assign gm_rx_err_1      = gm_tx_err_1;
   assign m_rx_d_1         = m_tx_d_1;
   assign m_rx_en_1        = m_tx_en_1;
   assign m_rx_err_1       = m_tx_err_1;
   assign m_rx_col_1       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_1       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_1     = tx_control_1;
   assign rgmii_in_1       = rgmii_out_1;
   assign #(4) tbi_rx_d_1  = tbi_tx_d_1;

   assign gm_rx_d_2        = gm_tx_d_2;
   assign gm_rx_dv_2       = gm_tx_en_2;
   assign gm_rx_err_2      = gm_tx_err_2;
   assign m_rx_d_2         = m_tx_d_2;
   assign m_rx_en_2        = m_tx_en_2;
   assign m_rx_err_2       = m_tx_err_2;
   assign m_rx_col_2       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_2       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_2     = tx_control_2;
   assign rgmii_in_2       = rgmii_out_2;
   assign #(4) tbi_rx_d_2  = tbi_tx_d_2;

   assign gm_rx_d_3        = gm_tx_d_3;
   assign gm_rx_dv_3       = gm_tx_en_3;
   assign gm_rx_err_3      = gm_tx_err_3;
   assign m_rx_d_3         = m_tx_d_3;
   assign m_rx_en_3        = m_tx_en_3;
   assign m_rx_err_3       = m_tx_err_3;
   assign m_rx_col_3       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_3       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_3     = tx_control_3;
   assign rgmii_in_3       = rgmii_out_3;
   assign #(4) tbi_rx_d_3  = tbi_tx_d_3;

   assign gm_rx_d_4        = gm_tx_d_4;
   assign gm_rx_dv_4       = gm_tx_en_4;
   assign gm_rx_err_4      = gm_tx_err_4;
   assign m_rx_d_4         = m_tx_d_4;
   assign m_rx_en_4        = m_tx_en_4;
   assign m_rx_err_4       = m_tx_err_4;
   assign m_rx_col_4       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_4       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_4     = tx_control_4;
   assign rgmii_in_4       = rgmii_out_4;
   assign #(4) tbi_rx_d_4  = tbi_tx_d_4;

   assign gm_rx_d_5        = gm_tx_d_5;
   assign gm_rx_dv_5       = gm_tx_en_5;
   assign gm_rx_err_5      = gm_tx_err_5;
   assign m_rx_d_5         = m_tx_d_5;
   assign m_rx_en_5        = m_tx_en_5;
   assign m_rx_err_5       = m_tx_err_5;
   assign m_rx_col_5       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_5       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_5     = tx_control_5;
   assign rgmii_in_5       = rgmii_out_5;
   assign #(4) tbi_rx_d_5  = tbi_tx_d_5;

   assign gm_rx_d_6        = gm_tx_d_6;
   assign gm_rx_dv_6       = gm_tx_en_6;
   assign gm_rx_err_6      = gm_tx_err_6;
   assign m_rx_d_6         = m_tx_d_6;
   assign m_rx_en_6        = m_tx_en_6;
   assign m_rx_err_6       = m_tx_err_6;
   assign m_rx_col_6       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_6       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_6     = tx_control_6;
   assign rgmii_in_6       = rgmii_out_6;
   assign #(4) tbi_rx_d_6  = tbi_tx_d_6;

   assign gm_rx_d_7        = gm_tx_d_7;
   assign gm_rx_dv_7       = gm_tx_en_7;
   assign gm_rx_err_7      = gm_tx_err_7;
   assign m_rx_d_7         = m_tx_d_7;
   assign m_rx_en_7        = m_tx_en_7;
   assign m_rx_err_7       = m_tx_err_7;
   assign m_rx_col_7       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_7       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_7     = tx_control_7;
   assign rgmii_in_7       = rgmii_out_7;
   assign #(4) tbi_rx_d_7  = tbi_tx_d_7;

   assign gm_rx_d_8        = gm_tx_d_8;
   assign gm_rx_dv_8       = gm_tx_en_8;
   assign gm_rx_err_8      = gm_tx_err_8;
   assign m_rx_d_8         = m_tx_d_8;
   assign m_rx_en_8        = m_tx_en_8;
   assign m_rx_err_8       = m_tx_err_8;
   assign m_rx_col_8       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_8       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_8     = tx_control_8;
   assign rgmii_in_8       = rgmii_out_8;
   assign #(4) tbi_rx_d_8  = tbi_tx_d_8;

   assign gm_rx_d_9        = gm_tx_d_9;
   assign gm_rx_dv_9       = gm_tx_en_9;
   assign gm_rx_err_9      = gm_tx_err_9;
   assign m_rx_d_9         = m_tx_d_9;
   assign m_rx_en_9        = m_tx_en_9;
   assign m_rx_err_9       = m_tx_err_9;
   assign m_rx_col_9       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_9       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_9     = tx_control_9;
   assign rgmii_in_9       = rgmii_out_9;
   assign #(4) tbi_rx_d_9  = tbi_tx_d_9;

   assign gm_rx_d_10        = gm_tx_d_10;
   assign gm_rx_dv_10       = gm_tx_en_10;
   assign gm_rx_err_10      = gm_tx_err_10;
   assign m_rx_d_10         = m_tx_d_10;
   assign m_rx_en_10        = m_tx_en_10;
   assign m_rx_err_10       = m_tx_err_10;
   assign m_rx_col_10       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_10       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_10     = tx_control_10;
   assign rgmii_in_10       = rgmii_out_10;
   assign #(4) tbi_rx_d_10  = tbi_tx_d_10;

   assign gm_rx_d_11        = gm_tx_d_11;
   assign gm_rx_dv_11       = gm_tx_en_11;
   assign gm_rx_err_11      = gm_tx_err_11;
   assign m_rx_d_11         = m_tx_d_11;
   assign m_rx_en_11        = m_tx_en_11;
   assign m_rx_err_11       = m_tx_err_11;
   assign m_rx_col_11       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_11       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_11     = tx_control_11;
   assign rgmii_in_11       = rgmii_out_11;
   assign #(4) tbi_rx_d_11  = tbi_tx_d_11;

   assign gm_rx_d_12        = gm_tx_d_12;
   assign gm_rx_dv_12       = gm_tx_en_12;
   assign gm_rx_err_12      = gm_tx_err_12;
   assign m_rx_d_12         = m_tx_d_12;
   assign m_rx_en_12        = m_tx_en_12;
   assign m_rx_err_12       = m_tx_err_12;
   assign m_rx_col_12       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_12       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_12     = tx_control_12;
   assign rgmii_in_12       = rgmii_out_12;
   assign #(4) tbi_rx_d_12  = tbi_tx_d_12;

   assign gm_rx_d_13        = gm_tx_d_13;
   assign gm_rx_dv_13       = gm_tx_en_13;
   assign gm_rx_err_13      = gm_tx_err_13;
   assign m_rx_d_13         = m_tx_d_13;
   assign m_rx_en_13        = m_tx_en_13;
   assign m_rx_err_13       = m_tx_err_13;
   assign m_rx_col_13       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_13       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_13     = tx_control_13;
   assign rgmii_in_13       = rgmii_out_13;
   assign #(4) tbi_rx_d_13  = tbi_tx_d_13;

   assign gm_rx_d_14        = gm_tx_d_14;
   assign gm_rx_dv_14       = gm_tx_en_14;
   assign gm_rx_err_14      = gm_tx_err_14;
   assign m_rx_d_14         = m_tx_d_14;
   assign m_rx_en_14        = m_tx_en_14;
   assign m_rx_err_14       = m_tx_err_14;
   assign m_rx_col_14       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_14       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_14     = tx_control_14;
   assign rgmii_in_14       = rgmii_out_14;
   assign #(4) tbi_rx_d_14  = tbi_tx_d_14;

   assign gm_rx_d_15        = gm_tx_d_15;
   assign gm_rx_dv_15       = gm_tx_en_15;
   assign gm_rx_err_15      = gm_tx_err_15;
   assign m_rx_d_15         = m_tx_d_15;
   assign m_rx_en_15        = m_tx_en_15;
   assign m_rx_err_15       = m_tx_err_15;
   assign m_rx_col_15       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_15       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_15     = tx_control_15;
   assign rgmii_in_15       = rgmii_out_15;
   assign #(4) tbi_rx_d_15  = tbi_tx_d_15;
  end

 if (MAX_CHANNELS == 20)
  begin
   assign led_link = led_link_0 ;
   //input of DUT
   assign ff_rx_dsav       = 1'b0; 
   assign rx_afull_clk     = rx_clk;
   assign rx_afull_channel = 5'b0;
   assign rx_afull_data    = 2'b0;
   assign rx_afull_valid   = 1'b1;
   assign data_tx_data_0   = ff_tx_data;
   assign data_tx_eop_0    = ff_tx_eop;
   assign data_tx_error_0  = ff_tx_err;
   assign data_tx_sop_0    = ff_tx_sop;
   assign data_tx_valid_0  = ff_tx_wren;
   assign tx_crc_fwd_0     = ff_tx_crc_fwd;
   assign data_rx_ready_19  = ff_rx_rdy;

   assign tbi_tx_clk_0     = tx_clk_1000mbps;
   assign tbi_rx_clk_0     = rx_clk_1000mbps;
   assign tbi_tx_clk_1     = tx_clk_1000mbps;
   assign tbi_rx_clk_1     = rx_clk_1000mbps;
   assign tbi_tx_clk_2     = tx_clk_1000mbps;
   assign tbi_rx_clk_2     = rx_clk_1000mbps;
   assign tbi_tx_clk_3     = tx_clk_1000mbps;
   assign tbi_rx_clk_3     = rx_clk_1000mbps;
   assign tbi_tx_clk_4     = tx_clk_1000mbps;
   assign tbi_rx_clk_4     = rx_clk_1000mbps;
   assign tbi_tx_clk_5     = tx_clk_1000mbps;
   assign tbi_rx_clk_5     = rx_clk_1000mbps;
   assign tbi_tx_clk_6     = tx_clk_1000mbps;
   assign tbi_rx_clk_6     = rx_clk_1000mbps;
   assign tbi_tx_clk_7     = tx_clk_1000mbps;
   assign tbi_rx_clk_7     = rx_clk_1000mbps;
   assign tbi_tx_clk_8     = tx_clk_1000mbps;
   assign tbi_rx_clk_8     = rx_clk_1000mbps;
   assign tbi_tx_clk_9     = tx_clk_1000mbps;
   assign tbi_rx_clk_9     = rx_clk_1000mbps;
   assign tbi_tx_clk_10     = tx_clk_1000mbps;
   assign tbi_rx_clk_10     = rx_clk_1000mbps;
   assign tbi_tx_clk_11     = tx_clk_1000mbps;
   assign tbi_rx_clk_11     = rx_clk_1000mbps;
   assign tbi_tx_clk_12     = tx_clk_1000mbps;
   assign tbi_rx_clk_12     = rx_clk_1000mbps;
   assign tbi_tx_clk_13     = tx_clk_1000mbps;
   assign tbi_rx_clk_13     = rx_clk_1000mbps;
   assign tbi_tx_clk_14     = tx_clk_1000mbps;
   assign tbi_rx_clk_14     = rx_clk_1000mbps;
   assign tbi_tx_clk_15     = tx_clk_1000mbps;
   assign tbi_rx_clk_15     = rx_clk_1000mbps;
   assign tbi_tx_clk_16     = tx_clk_1000mbps;
   assign tbi_rx_clk_16     = rx_clk_1000mbps;
   assign tbi_tx_clk_17     = tx_clk_1000mbps;
   assign tbi_rx_clk_17     = rx_clk_1000mbps;
   assign tbi_tx_clk_18     = tx_clk_1000mbps;
   assign tbi_rx_clk_18     = rx_clk_1000mbps;
   assign tbi_tx_clk_19     = tx_clk_1000mbps;
   assign tbi_rx_clk_19     = rx_clk_1000mbps;

   assign set_10_0         = 1'b0;
   assign set_1000_0       = 1'b0;
   assign set_10_1         = 1'b0;
   assign set_1000_1       = 1'b0;
   assign set_10_2         = 1'b0;
   assign set_1000_2       = 1'b0;
   assign set_10_3         = 1'b0;
   assign set_1000_3       = 1'b0;
   assign set_10_4         = 1'b0;
   assign set_1000_4       = 1'b0;
   assign set_10_4         = 1'b0;
   assign set_1000_4       = 1'b0;
   assign set_10_5         = 1'b0;
   assign set_1000_5       = 1'b0;
   assign set_10_6         = 1'b0;
   assign set_1000_6       = 1'b0;
   assign set_10_7         = 1'b0;
   assign set_1000_7       = 1'b0;
   assign set_10_8         = 1'b0;
   assign set_1000_8       = 1'b0;
   assign set_10_9         = 1'b0;
   assign set_1000_9       = 1'b0;
   assign set_10_10         = 1'b0;
   assign set_1000_10       = 1'b0;
   assign set_10_11         = 1'b0;
   assign set_1000_11       = 1'b0;
   assign set_10_12         = 1'b0;
   assign set_1000_12       = 1'b0;
   assign set_10_13         = 1'b0;
   assign set_1000_13       = 1'b0;
   assign set_10_14         = 1'b0;
   assign set_1000_14       = 1'b0;
   assign set_10_15         = 1'b0;
   assign set_1000_15       = 1'b0;
   assign set_10_16         = 1'b0;
   assign set_1000_16       = 1'b0;
   assign set_10_17         = 1'b0;
   assign set_1000_17       = 1'b0;
   assign set_10_18         = 1'b0;
   assign set_1000_18       = 1'b0;
   assign set_10_19         = 1'b0;
   assign set_1000_19       = 1'b0;

   assign xon_gen_0        = 1'b0;
   assign xoff_gen_0       = 1'b0;
   assign xon_gen_1        = 1'b0;
   assign xoff_gen_1       = 1'b0;
   assign xon_gen_2        = 1'b0;
   assign xoff_gen_2       = 1'b0;
   assign xon_gen_3        = 1'b0;
   assign xoff_gen_3       = 1'b0;
   assign xon_gen_4        = 1'b0;
   assign xoff_gen_4       = 1'b0;
   assign xon_gen_5        = 1'b0;
   assign xoff_gen_5       = 1'b0;
   assign xon_gen_6        = 1'b0;
   assign xoff_gen_6       = 1'b0;
   assign xon_gen_7        = 1'b0;
   assign xoff_gen_7       = 1'b0;
   assign xon_gen_8        = 1'b0;
   assign xoff_gen_8       = 1'b0;
   assign xon_gen_9        = 1'b0;
   assign xoff_gen_9       = 1'b0;
   assign xon_gen_10        = 1'b0;
   assign xoff_gen_10       = 1'b0;
   assign xon_gen_11        = 1'b0;
   assign xoff_gen_11       = 1'b0;
   assign xon_gen_12        = 1'b0;
   assign xoff_gen_12       = 1'b0;
   assign xon_gen_13        = 1'b0;
   assign xoff_gen_13       = 1'b0;
   assign xon_gen_14        = 1'b0;
   assign xoff_gen_14       = 1'b0;
   assign xon_gen_15        = 1'b0;
   assign xoff_gen_15       = 1'b0;
   assign xon_gen_16        = 1'b0;
   assign xoff_gen_16       = 1'b0;
   assign xon_gen_17        = 1'b0;
   assign xoff_gen_17       = 1'b0;
   assign xon_gen_18        = 1'b0;
   assign xoff_gen_18       = 1'b0;
   assign xon_gen_19        = 1'b0;
   assign xoff_gen_19       = 1'b0;

   assign magic_sleep_n_0  = magic_sleep_n;
   assign magic_sleep_n_1  = magic_sleep_n;
   assign magic_sleep_n_2  = magic_sleep_n;
   assign magic_sleep_n_3  = magic_sleep_n;
   assign magic_sleep_n_4  = magic_sleep_n;
   assign magic_sleep_n_5  = magic_sleep_n;
   assign magic_sleep_n_6  = magic_sleep_n;
   assign magic_sleep_n_7  = magic_sleep_n;
   assign magic_sleep_n_8  = magic_sleep_n;
   assign magic_sleep_n_9  = magic_sleep_n;
   assign magic_sleep_n_10  = magic_sleep_n;
   assign magic_sleep_n_11  = magic_sleep_n;
   assign magic_sleep_n_12  = magic_sleep_n;
   assign magic_sleep_n_13  = magic_sleep_n;
   assign magic_sleep_n_14  = magic_sleep_n;
   assign magic_sleep_n_15  = magic_sleep_n;
   assign magic_sleep_n_16  = magic_sleep_n;
   assign magic_sleep_n_17  = magic_sleep_n;
   assign magic_sleep_n_18  = magic_sleep_n;
   assign magic_sleep_n_19  = magic_sleep_n;


   //output of DUT
   assign ff_rx_err_stat   = {pkt_class_valid_19 ? pkt_class_data_19 [0] : 1'b0, data_rx_error_19[4], 15'b0 ,pkt_class_valid_19 ? (pkt_class_data_19[1]|pkt_class_data_19[0]) : 1'b0 ,data_rx_error_19[3:0]};
   assign ff_rx_err        = data_rx_error_19 [0]|data_rx_error_19 [1]|data_rx_error_19 [2]|data_rx_error_19 [3]|data_rx_error_19 [4];
   assign ff_rx_vlan       = pkt_class_valid_19 ? pkt_class_data_19 [1] : 1'b0 ;
   assign ff_rx_bcast      = pkt_class_valid_19 ? pkt_class_data_19 [2] : 1'b0 ;
   assign ff_rx_mcast      = pkt_class_valid_19 ? pkt_class_data_19 [3] : 1'b0 ;
   assign ff_rx_ucast      = pkt_class_valid_19 ? pkt_class_data_19 [4] : 1'b0 ;
   assign ff_tx_clk        = mac_tx_clk_0;
   assign ff_rx_clk        = mac_rx_clk_0;
   assign ff_tx_rdy        = data_tx_ready_0;
   assign ff_rx_data       = data_rx_data_19;
   assign ff_rx_dval       = data_rx_valid_19;
   assign ff_rx_eop        = data_rx_eop_19;
   assign ff_rx_sop        = data_rx_sop_19;
   assign rx_err           = data_rx_error_19;

   //loopback
   assign data_rx_ready_0  = 1'b1;//data_tx_ready_1;
   assign tx_crc_fwd_1     = ff_tx_crc_fwd;


   loopback_adapter u_ch0_2_ch1 (
       
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_0),
     .in_data(data_rx_data_0),
     .in_startofpacket(data_rx_sop_0),
     .in_endofpacket(data_rx_eop_0),
     .in_error(data_rx_error_0),
     // Interface: out
     .out_ready(data_tx_ready_1),
     .out_valid(data_tx_valid_1),
     .out_data(data_tx_data_1),
     .out_startofpacket(data_tx_sop_1),
     .out_endofpacket(data_tx_eop_1),
     .out_error(data_tx_error_1)
   );

   assign data_rx_ready_1  = 1'b1;
   assign tx_crc_fwd_2     = ff_tx_crc_fwd;

   loopback_adapter u_ch1_2_ch2 (
       
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_1),
     .in_data(data_rx_data_1),
     .in_startofpacket(data_rx_sop_1),
     .in_endofpacket(data_rx_eop_1),
     .in_error(data_rx_error_1),
     // Interface: out
     .out_ready(data_tx_ready_2),
     .out_valid(data_tx_valid_2),
     .out_data(data_tx_data_2),
     .out_startofpacket(data_tx_sop_2),
     .out_endofpacket(data_tx_eop_2),
     .out_error(data_tx_error_2)
   );

   assign data_rx_ready_2  = 1'b1;
   assign tx_crc_fwd_3     = ff_tx_crc_fwd;

   loopback_adapter u_ch2_2_ch3 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_2),
     .in_data(data_rx_data_2),
     .in_startofpacket(data_rx_sop_2),
     .in_endofpacket(data_rx_eop_2),
     .in_error(data_rx_error_2),
     // Interface: out
     .out_ready(data_tx_ready_3),
     .out_valid(data_tx_valid_3),
     .out_data(data_tx_data_3),
     .out_startofpacket(data_tx_sop_3),
     .out_endofpacket(data_tx_eop_3),
     .out_error(data_tx_error_3)
   );

   assign data_rx_ready_3  = 1'b1;
   assign tx_crc_fwd_4     = ff_tx_crc_fwd;

   loopback_adapter u_ch3_2_ch4 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_3),
     .in_data(data_rx_data_3),
     .in_startofpacket(data_rx_sop_3),
     .in_endofpacket(data_rx_eop_3),
     .in_error(data_rx_error_3),
     // Interface: out
     .out_ready(data_tx_ready_4),
     .out_valid(data_tx_valid_4),
     .out_data(data_tx_data_4),
     .out_startofpacket(data_tx_sop_4),
     .out_endofpacket(data_tx_eop_4),
     .out_error(data_tx_error_4)
   );

   assign data_rx_ready_4  = 1'b1;
   assign tx_crc_fwd_5     = ff_tx_crc_fwd;

   loopback_adapter u_ch4_2_ch5 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_4),
     .in_data(data_rx_data_4),
     .in_startofpacket(data_rx_sop_4),
     .in_endofpacket(data_rx_eop_4),
     .in_error(data_rx_error_4),
     // Interface: out
     .out_ready(data_tx_ready_5),
     .out_valid(data_tx_valid_5),
     .out_data(data_tx_data_5),
     .out_startofpacket(data_tx_sop_5),
     .out_endofpacket(data_tx_eop_5),
     .out_error(data_tx_error_5)
   );

   assign data_rx_ready_5  = 1'b1;
   assign tx_crc_fwd_6     = ff_tx_crc_fwd;

   loopback_adapter u_ch5_2_ch6 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_5),
     .in_data(data_rx_data_5),
     .in_startofpacket(data_rx_sop_5),
     .in_endofpacket(data_rx_eop_5),
     .in_error(data_rx_error_5),
     // Interface: out
     .out_ready(data_tx_ready_6),
     .out_valid(data_tx_valid_6),
     .out_data(data_tx_data_6),
     .out_startofpacket(data_tx_sop_6),
     .out_endofpacket(data_tx_eop_6),
     .out_error(data_tx_error_6)
   );

   assign data_rx_ready_6  = 1'b1;
   assign tx_crc_fwd_7     = ff_tx_crc_fwd;

   loopback_adapter u_ch6_2_ch7 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_6),
     .in_data(data_rx_data_6),
     .in_startofpacket(data_rx_sop_6),
     .in_endofpacket(data_rx_eop_6),
     .in_error(data_rx_error_6),
     // Interface: out
     .out_ready(data_tx_ready_7),
     .out_valid(data_tx_valid_7),
     .out_data(data_tx_data_7),
     .out_startofpacket(data_tx_sop_7),
     .out_endofpacket(data_tx_eop_7),
     .out_error(data_tx_error_7)
   );

   assign data_rx_ready_7  = 1'b1;
   assign tx_crc_fwd_8    = ff_tx_crc_fwd;

   loopback_adapter u_ch7_2_ch8 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_7),
     .in_data(data_rx_data_7),
     .in_startofpacket(data_rx_sop_7),
     .in_endofpacket(data_rx_eop_7),
     .in_error(data_rx_error_7),
     // Interface: out
     .out_ready(data_tx_ready_8),
     .out_valid(data_tx_valid_8),
     .out_data(data_tx_data_8),
     .out_startofpacket(data_tx_sop_8),
     .out_endofpacket(data_tx_eop_8),
     .out_error(data_tx_error_8)
   );

   assign data_rx_ready_8  = 1'b1;
   assign tx_crc_fwd_9     = ff_tx_crc_fwd;

   loopback_adapter u_ch8_2_ch9 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_8),
     .in_data(data_rx_data_8),
     .in_startofpacket(data_rx_sop_8),
     .in_endofpacket(data_rx_eop_8),
     .in_error(data_rx_error_8),
     // Interface: out
     .out_ready(data_tx_ready_9),
     .out_valid(data_tx_valid_9),
     .out_data(data_tx_data_9),
     .out_startofpacket(data_tx_sop_9),
     .out_endofpacket(data_tx_eop_9),
     .out_error(data_tx_error_9)
   );

   assign data_rx_ready_9  = 1'b1;
   assign tx_crc_fwd_10     = ff_tx_crc_fwd;

   loopback_adapter u_ch9_2_ch10 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_9),
     .in_data(data_rx_data_9),
     .in_startofpacket(data_rx_sop_9),
     .in_endofpacket(data_rx_eop_9),
     .in_error(data_rx_error_9),
     // Interface: out
     .out_ready(data_tx_ready_10),
     .out_valid(data_tx_valid_10),
     .out_data(data_tx_data_10),
     .out_startofpacket(data_tx_sop_10),
     .out_endofpacket(data_tx_eop_10),
     .out_error(data_tx_error_10)
   );

   assign data_rx_ready_10  = 1'b1;
   assign tx_crc_fwd_11     = ff_tx_crc_fwd;

   loopback_adapter u_ch10_2_ch11 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_10),
     .in_data(data_rx_data_10),
     .in_startofpacket(data_rx_sop_10),
     .in_endofpacket(data_rx_eop_10),
     .in_error(data_rx_error_10),
     // Interface: out
     .out_ready(data_tx_ready_11),
     .out_valid(data_tx_valid_11),
     .out_data(data_tx_data_11),
     .out_startofpacket(data_tx_sop_11),
     .out_endofpacket(data_tx_eop_11),
     .out_error(data_tx_error_11)
   );

   assign data_rx_ready_11  = 1'b1;
   assign tx_crc_fwd_12     = ff_tx_crc_fwd;

   loopback_adapter u_ch11_2_ch12 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_11),
     .in_data(data_rx_data_11),
     .in_startofpacket(data_rx_sop_11),
     .in_endofpacket(data_rx_eop_11),
     .in_error(data_rx_error_11),
     // Interface: out
     .out_ready(data_tx_ready_12),
     .out_valid(data_tx_valid_12),
     .out_data(data_tx_data_12),
     .out_startofpacket(data_tx_sop_12),
     .out_endofpacket(data_tx_eop_12),
     .out_error(data_tx_error_12)
   );

   assign data_rx_ready_12  = 1'b1;
   assign tx_crc_fwd_13     = ff_tx_crc_fwd;

   loopback_adapter u_ch12_2_ch13 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_12),
     .in_data(data_rx_data_12),
     .in_startofpacket(data_rx_sop_12),
     .in_endofpacket(data_rx_eop_12),
     .in_error(data_rx_error_12),
     // Interface: out
     .out_ready(data_tx_ready_13),
     .out_valid(data_tx_valid_13),
     .out_data(data_tx_data_13),
     .out_startofpacket(data_tx_sop_13),
     .out_endofpacket(data_tx_eop_13),
     .out_error(data_tx_error_13)
   );

   assign data_rx_ready_13  = 1'b1;
   assign tx_crc_fwd_14     = ff_tx_crc_fwd;

   loopback_adapter u_ch13_2_ch14 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_13),
     .in_data(data_rx_data_13),
     .in_startofpacket(data_rx_sop_13),
     .in_endofpacket(data_rx_eop_13),
     .in_error(data_rx_error_13),
     // Interface: out
     .out_ready(data_tx_ready_14),
     .out_valid(data_tx_valid_14),
     .out_data(data_tx_data_14),
     .out_startofpacket(data_tx_sop_14),
     .out_endofpacket(data_tx_eop_14),
     .out_error(data_tx_error_14)
   );

   assign data_rx_ready_14  = 1'b1;
   assign tx_crc_fwd_15     = ff_tx_crc_fwd;

   loopback_adapter u_ch14_2_ch15 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_14),
     .in_data(data_rx_data_14),
     .in_startofpacket(data_rx_sop_14),
     .in_endofpacket(data_rx_eop_14),
     .in_error(data_rx_error_14),
     // Interface: out
     .out_ready(data_tx_ready_15),
     .out_valid(data_tx_valid_15),
     .out_data(data_tx_data_15),
     .out_startofpacket(data_tx_sop_15),
     .out_endofpacket(data_tx_eop_15),
     .out_error(data_tx_error_15)
   );

   assign data_rx_ready_15  = 1'b1;
   assign tx_crc_fwd_16     = ff_tx_crc_fwd;

   loopback_adapter u_ch15_2_ch16 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_15),
     .in_data(data_rx_data_15),
     .in_startofpacket(data_rx_sop_15),
     .in_endofpacket(data_rx_eop_15),
     .in_error(data_rx_error_15),
     // Interface: out
     .out_ready(data_tx_ready_16),
     .out_valid(data_tx_valid_16),
     .out_data(data_tx_data_16),
     .out_startofpacket(data_tx_sop_16),
     .out_endofpacket(data_tx_eop_16),
     .out_error(data_tx_error_16)
   );

   assign data_rx_ready_16  = 1'b1;
   assign tx_crc_fwd_17     = ff_tx_crc_fwd;

   loopback_adapter u_ch16_2_ch17 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_16),
     .in_data(data_rx_data_16),
     .in_startofpacket(data_rx_sop_16),
     .in_endofpacket(data_rx_eop_16),
     .in_error(data_rx_error_16),
     // Interface: out
     .out_ready(data_tx_ready_17),
     .out_valid(data_tx_valid_17),
     .out_data(data_tx_data_17),
     .out_startofpacket(data_tx_sop_17),
     .out_endofpacket(data_tx_eop_17),
     .out_error(data_tx_error_17)
   );

   assign data_rx_ready_17  = 1'b1;
   assign tx_crc_fwd_18     = ff_tx_crc_fwd;

   loopback_adapter u_ch17_2_ch18 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_17),
     .in_data(data_rx_data_17),
     .in_startofpacket(data_rx_sop_17),
     .in_endofpacket(data_rx_eop_17),
     .in_error(data_rx_error_17),
     // Interface: out
     .out_ready(data_tx_ready_18),
     .out_valid(data_tx_valid_18),
     .out_data(data_tx_data_18),
     .out_startofpacket(data_tx_sop_18),
     .out_endofpacket(data_tx_eop_18),
     .out_error(data_tx_error_18)
   );

   assign data_rx_ready_18  = 1'b1;
   assign tx_crc_fwd_19     = ff_tx_crc_fwd;

   loopback_adapter u_ch18_2_ch19 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_18),
     .in_data(data_rx_data_18),
     .in_startofpacket(data_rx_sop_18),
     .in_endofpacket(data_rx_eop_18),
     .in_error(data_rx_error_18),
     // Interface: out
     .out_ready(data_tx_ready_19),
     .out_valid(data_tx_valid_19),
     .out_data(data_tx_data_19),
     .out_startofpacket(data_tx_sop_19),
     .out_endofpacket(data_tx_eop_19),
     .out_error(data_tx_error_19)
   );

   
   //assigning to GMII/MII TX monitoring
   assign rgmii_tx_ctnl    = tx_control_0;
   assign rgmii_tx_data    = rgmii_out_0;
   assign gm_tx_data       = gm_tx_d_0;
   assign gm_tx_en         = gm_tx_en_0;
   assign gm_tx_err        = gm_tx_err_0;
   assign m_tx_data        = m_tx_d_0;
   assign m_tx_en          = m_tx_en_0;
   assign m_tx_err         = m_tx_err_0;

   assign gm_rx_d_0        = gm_tx_d_0;
   assign gm_rx_dv_0       = gm_tx_en_0;
   assign gm_rx_err_0      = gm_tx_err_0;
   assign m_rx_d_0         = m_tx_d_0;
   assign m_rx_en_0        = m_tx_en_0;
   assign m_rx_err_0       = m_tx_err_0;
   assign m_rx_col_0       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_0       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_0     = tx_control_0;
   assign rgmii_in_0       = rgmii_out_0;
   assign #(4) tbi_rx_d_0  = tbi_tx_d_0;

   assign gm_rx_d_1        = gm_tx_d_1;
   assign gm_rx_dv_1       = gm_tx_en_1;
   assign gm_rx_err_1      = gm_tx_err_1;
   assign m_rx_d_1         = m_tx_d_1;
   assign m_rx_en_1        = m_tx_en_1;
   assign m_rx_err_1       = m_tx_err_1;
   assign m_rx_col_1       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_1       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_1     = tx_control_1;
   assign rgmii_in_1       = rgmii_out_1;
   assign #(4) tbi_rx_d_1  = tbi_tx_d_1;

   assign gm_rx_d_2        = gm_tx_d_2;
   assign gm_rx_dv_2       = gm_tx_en_2;
   assign gm_rx_err_2      = gm_tx_err_2;
   assign m_rx_d_2         = m_tx_d_2;
   assign m_rx_en_2        = m_tx_en_2;
   assign m_rx_err_2       = m_tx_err_2;
   assign m_rx_col_2       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_2       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_2     = tx_control_2;
   assign rgmii_in_2       = rgmii_out_2;
   assign #(4) tbi_rx_d_2  = tbi_tx_d_2;

   assign gm_rx_d_3        = gm_tx_d_3;
   assign gm_rx_dv_3       = gm_tx_en_3;
   assign gm_rx_err_3      = gm_tx_err_3;
   assign m_rx_d_3         = m_tx_d_3;
   assign m_rx_en_3        = m_tx_en_3;
   assign m_rx_err_3       = m_tx_err_3;
   assign m_rx_col_3       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_3       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_3     = tx_control_3;
   assign rgmii_in_3       = rgmii_out_3;
   assign #(4) tbi_rx_d_3  = tbi_tx_d_3;

   assign gm_rx_d_4        = gm_tx_d_4;
   assign gm_rx_dv_4       = gm_tx_en_4;
   assign gm_rx_err_4      = gm_tx_err_4;
   assign m_rx_d_4         = m_tx_d_4;
   assign m_rx_en_4        = m_tx_en_4;
   assign m_rx_err_4       = m_tx_err_4;
   assign m_rx_col_4       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_4       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_4     = tx_control_4;
   assign rgmii_in_4       = rgmii_out_4;
   assign #(4) tbi_rx_d_4  = tbi_tx_d_4;

   assign gm_rx_d_5        = gm_tx_d_5;
   assign gm_rx_dv_5       = gm_tx_en_5;
   assign gm_rx_err_5      = gm_tx_err_5;
   assign m_rx_d_5         = m_tx_d_5;
   assign m_rx_en_5        = m_tx_en_5;
   assign m_rx_err_5       = m_tx_err_5;
   assign m_rx_col_5       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_5       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_5     = tx_control_5;
   assign rgmii_in_5       = rgmii_out_5;
   assign #(4) tbi_rx_d_5  = tbi_tx_d_5;

   assign gm_rx_d_6        = gm_tx_d_6;
   assign gm_rx_dv_6       = gm_tx_en_6;
   assign gm_rx_err_6      = gm_tx_err_6;
   assign m_rx_d_6         = m_tx_d_6;
   assign m_rx_en_6        = m_tx_en_6;
   assign m_rx_err_6       = m_tx_err_6;
   assign m_rx_col_6       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_6       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_6     = tx_control_6;
   assign rgmii_in_6       = rgmii_out_6;
   assign #(4) tbi_rx_d_6  = tbi_tx_d_6;

   assign gm_rx_d_7        = gm_tx_d_7;
   assign gm_rx_dv_7       = gm_tx_en_7;
   assign gm_rx_err_7      = gm_tx_err_7;
   assign m_rx_d_7         = m_tx_d_7;
   assign m_rx_en_7        = m_tx_en_7;
   assign m_rx_err_7       = m_tx_err_7;
   assign m_rx_col_7       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_7       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_7     = tx_control_7;
   assign rgmii_in_7       = rgmii_out_7;
   assign #(4) tbi_rx_d_7  = tbi_tx_d_7;

   assign gm_rx_d_8        = gm_tx_d_8;
   assign gm_rx_dv_8       = gm_tx_en_8;
   assign gm_rx_err_8      = gm_tx_err_8;
   assign m_rx_d_8         = m_tx_d_8;
   assign m_rx_en_8        = m_tx_en_8;
   assign m_rx_err_8       = m_tx_err_8;
   assign m_rx_col_8       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_8       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_8     = tx_control_8;
   assign rgmii_in_8       = rgmii_out_8;
   assign #(4) tbi_rx_d_8  = tbi_tx_d_8;

   assign gm_rx_d_9        = gm_tx_d_9;
   assign gm_rx_dv_9       = gm_tx_en_9;
   assign gm_rx_err_9      = gm_tx_err_9;
   assign m_rx_d_9         = m_tx_d_9;
   assign m_rx_en_9        = m_tx_en_9;
   assign m_rx_err_9       = m_tx_err_9;
   assign m_rx_col_9       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_9       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_9     = tx_control_9;
   assign rgmii_in_9       = rgmii_out_9;
   assign #(4) tbi_rx_d_9  = tbi_tx_d_9;

   assign gm_rx_d_10        = gm_tx_d_10;
   assign gm_rx_dv_10       = gm_tx_en_10;
   assign gm_rx_err_10      = gm_tx_err_10;
   assign m_rx_d_10         = m_tx_d_10;
   assign m_rx_en_10        = m_tx_en_10;
   assign m_rx_err_10       = m_tx_err_10;
   assign m_rx_col_10       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_10       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_10     = tx_control_10;
   assign rgmii_in_10       = rgmii_out_10;
   assign #(4) tbi_rx_d_10  = tbi_tx_d_10;

   assign gm_rx_d_11        = gm_tx_d_11;
   assign gm_rx_dv_11       = gm_tx_en_11;
   assign gm_rx_err_11      = gm_tx_err_11;
   assign m_rx_d_11         = m_tx_d_11;
   assign m_rx_en_11        = m_tx_en_11;
   assign m_rx_err_11       = m_tx_err_11;
   assign m_rx_col_11       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_11       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_11     = tx_control_11;
   assign rgmii_in_11       = rgmii_out_11;
   assign #(4) tbi_rx_d_11  = tbi_tx_d_11;

   assign gm_rx_d_12        = gm_tx_d_12;
   assign gm_rx_dv_12       = gm_tx_en_12;
   assign gm_rx_err_12      = gm_tx_err_12;
   assign m_rx_d_12         = m_tx_d_12;
   assign m_rx_en_12        = m_tx_en_12;
   assign m_rx_err_12       = m_tx_err_12;
   assign m_rx_col_12       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_12       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_12     = tx_control_12;
   assign rgmii_in_12       = rgmii_out_12;
   assign #(4) tbi_rx_d_12  = tbi_tx_d_12;

   assign gm_rx_d_13        = gm_tx_d_13;
   assign gm_rx_dv_13       = gm_tx_en_13;
   assign gm_rx_err_13      = gm_tx_err_13;
   assign m_rx_d_13         = m_tx_d_13;
   assign m_rx_en_13        = m_tx_en_13;
   assign m_rx_err_13       = m_tx_err_13;
   assign m_rx_col_13       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_13       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_13     = tx_control_13;
   assign rgmii_in_13       = rgmii_out_13;
   assign #(4) tbi_rx_d_13  = tbi_tx_d_13;

   assign gm_rx_d_14        = gm_tx_d_14;
   assign gm_rx_dv_14       = gm_tx_en_14;
   assign gm_rx_err_14      = gm_tx_err_14;
   assign m_rx_d_14         = m_tx_d_14;
   assign m_rx_en_14        = m_tx_en_14;
   assign m_rx_err_14       = m_tx_err_14;
   assign m_rx_col_14       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_14       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_14     = tx_control_14;
   assign rgmii_in_14       = rgmii_out_14;
   assign #(4) tbi_rx_d_14  = tbi_tx_d_14;

   assign gm_rx_d_15        = gm_tx_d_15;
   assign gm_rx_dv_15       = gm_tx_en_15;
   assign gm_rx_err_15      = gm_tx_err_15;
   assign m_rx_d_15         = m_tx_d_15;
   assign m_rx_en_15        = m_tx_en_15;
   assign m_rx_err_15       = m_tx_err_15;
   assign m_rx_col_15       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_15       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_15     = tx_control_15;
   assign rgmii_in_15       = rgmii_out_15;
   assign #(4) tbi_rx_d_15  = tbi_tx_d_15;

   assign gm_rx_d_16        = gm_tx_d_16;
   assign gm_rx_dv_16       = gm_tx_en_16;
   assign gm_rx_err_16      = gm_tx_err_16;
   assign m_rx_d_16         = m_tx_d_16;
   assign m_rx_en_16        = m_tx_en_16;
   assign m_rx_err_16       = m_tx_err_16;
   assign m_rx_col_16       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_16       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_16     = tx_control_16;
   assign rgmii_in_16       = rgmii_out_16;
   assign #(4) tbi_rx_d_16  = tbi_tx_d_16;

   assign gm_rx_d_17        = gm_tx_d_17;
   assign gm_rx_dv_17       = gm_tx_en_17;
   assign gm_rx_err_17      = gm_tx_err_17;
   assign m_rx_d_17         = m_tx_d_17;
   assign m_rx_en_17        = m_tx_en_17;
   assign m_rx_err_17       = m_tx_err_17;
   assign m_rx_col_17       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_17       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_17     = tx_control_17;
   assign rgmii_in_17       = rgmii_out_17;
   assign #(4) tbi_rx_d_17  = tbi_tx_d_17;

   assign gm_rx_d_18        = gm_tx_d_18;
   assign gm_rx_dv_18       = gm_tx_en_18;
   assign gm_rx_err_18      = gm_tx_err_18;
   assign m_rx_d_18         = m_tx_d_18;
   assign m_rx_en_18        = m_tx_en_18;
   assign m_rx_err_18       = m_tx_err_18;
   assign m_rx_col_18       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_18       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_18     = tx_control_18;
   assign rgmii_in_18       = rgmii_out_18;
   assign #(4) tbi_rx_d_18  = tbi_tx_d_18;

   assign gm_rx_d_19        = gm_tx_d_19;
   assign gm_rx_dv_19       = gm_tx_en_19;
   assign gm_rx_err_19      = gm_tx_err_19;
   assign m_rx_d_19         = m_tx_d_19;
   assign m_rx_en_19        = m_tx_en_19;
   assign m_rx_err_19       = m_tx_err_19;
   assign m_rx_col_19       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_19       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_19     = tx_control_19;
   assign rgmii_in_19       = rgmii_out_19;
   assign #(4) tbi_rx_d_19  = tbi_tx_d_19;

  end

 if (MAX_CHANNELS == 24)
  begin
   assign led_link = led_link_0 ;
   //input of DUT
   assign ff_rx_dsav       = 1'b0; 
   assign rx_afull_clk     = rx_clk;
   assign rx_afull_channel = 5'b0;
   assign rx_afull_data    = 2'b0;
   assign rx_afull_valid   = 1'b1;
   assign data_tx_data_0   = ff_tx_data;
   assign data_tx_eop_0    = ff_tx_eop;
   assign data_tx_error_0  = ff_tx_err;
   assign data_tx_sop_0    = ff_tx_sop;
   assign data_tx_valid_0  = ff_tx_wren;
   assign tx_crc_fwd_0     = ff_tx_crc_fwd;
   assign data_rx_ready_23  = ff_rx_rdy;

   assign tbi_tx_clk_0     = tx_clk_1000mbps;
   assign tbi_rx_clk_0     = rx_clk_1000mbps;
   assign tbi_tx_clk_1     = tx_clk_1000mbps;
   assign tbi_rx_clk_1     = rx_clk_1000mbps;
   assign tbi_tx_clk_2     = tx_clk_1000mbps;
   assign tbi_rx_clk_2     = rx_clk_1000mbps;
   assign tbi_tx_clk_3     = tx_clk_1000mbps;
   assign tbi_rx_clk_3     = rx_clk_1000mbps;
   assign tbi_tx_clk_4     = tx_clk_1000mbps;
   assign tbi_rx_clk_4     = rx_clk_1000mbps;
   assign tbi_tx_clk_5     = tx_clk_1000mbps;
   assign tbi_rx_clk_5     = rx_clk_1000mbps;
   assign tbi_tx_clk_6     = tx_clk_1000mbps;
   assign tbi_rx_clk_6     = rx_clk_1000mbps;
   assign tbi_tx_clk_7     = tx_clk_1000mbps;
   assign tbi_rx_clk_7     = rx_clk_1000mbps;
   assign tbi_tx_clk_8     = tx_clk_1000mbps;
   assign tbi_rx_clk_8     = rx_clk_1000mbps;
   assign tbi_tx_clk_9     = tx_clk_1000mbps;
   assign tbi_rx_clk_9     = rx_clk_1000mbps;
   assign tbi_tx_clk_10     = tx_clk_1000mbps;
   assign tbi_rx_clk_10     = rx_clk_1000mbps;
   assign tbi_tx_clk_11     = tx_clk_1000mbps;
   assign tbi_rx_clk_11     = rx_clk_1000mbps;
   assign tbi_tx_clk_12     = tx_clk_1000mbps;
   assign tbi_rx_clk_12     = rx_clk_1000mbps;
   assign tbi_tx_clk_13     = tx_clk_1000mbps;
   assign tbi_rx_clk_13     = rx_clk_1000mbps;
   assign tbi_tx_clk_14     = tx_clk_1000mbps;
   assign tbi_rx_clk_14     = rx_clk_1000mbps;
   assign tbi_tx_clk_15     = tx_clk_1000mbps;
   assign tbi_rx_clk_15     = rx_clk_1000mbps;
   assign tbi_tx_clk_16     = tx_clk_1000mbps;
   assign tbi_rx_clk_16     = rx_clk_1000mbps;
   assign tbi_tx_clk_17     = tx_clk_1000mbps;
   assign tbi_rx_clk_17     = rx_clk_1000mbps;
   assign tbi_tx_clk_18     = tx_clk_1000mbps;
   assign tbi_rx_clk_18     = rx_clk_1000mbps;
   assign tbi_tx_clk_19     = tx_clk_1000mbps;
   assign tbi_rx_clk_19     = rx_clk_1000mbps;
   assign tbi_tx_clk_20     = tx_clk_1000mbps;
   assign tbi_rx_clk_20     = rx_clk_1000mbps;
   assign tbi_tx_clk_21     = tx_clk_1000mbps;
   assign tbi_rx_clk_21     = rx_clk_1000mbps;
   assign tbi_tx_clk_22     = tx_clk_1000mbps;
   assign tbi_rx_clk_22     = rx_clk_1000mbps;
   assign tbi_tx_clk_23     = tx_clk_1000mbps;
   assign tbi_rx_clk_23     = rx_clk_1000mbps;

   assign set_10_0         = 1'b0;
   assign set_1000_0       = 1'b0;
   assign set_10_1         = 1'b0;
   assign set_1000_1       = 1'b0;
   assign set_10_2         = 1'b0;
   assign set_1000_2       = 1'b0;
   assign set_10_3         = 1'b0;
   assign set_1000_3       = 1'b0;
   assign set_10_4         = 1'b0;
   assign set_1000_4       = 1'b0;
   assign set_10_4         = 1'b0;
   assign set_1000_4       = 1'b0;
   assign set_10_5         = 1'b0;
   assign set_1000_5       = 1'b0;
   assign set_10_6         = 1'b0;
   assign set_1000_6       = 1'b0;
   assign set_10_7         = 1'b0;
   assign set_1000_7       = 1'b0;
   assign set_10_8         = 1'b0;
   assign set_1000_8       = 1'b0;
   assign set_10_9         = 1'b0;
   assign set_1000_9       = 1'b0;
   assign set_10_10         = 1'b0;
   assign set_1000_10       = 1'b0;
   assign set_10_11         = 1'b0;
   assign set_1000_11       = 1'b0;
   assign set_10_12         = 1'b0;
   assign set_1000_12       = 1'b0;
   assign set_10_13         = 1'b0;
   assign set_1000_13       = 1'b0;
   assign set_10_14         = 1'b0;
   assign set_1000_14       = 1'b0;
   assign set_10_15         = 1'b0;
   assign set_1000_15       = 1'b0;
   assign set_10_16         = 1'b0;
   assign set_1000_16       = 1'b0;
   assign set_10_17         = 1'b0;
   assign set_1000_17       = 1'b0;
   assign set_10_18         = 1'b0;
   assign set_1000_18       = 1'b0;
   assign set_10_19         = 1'b0;
   assign set_1000_19       = 1'b0;
   assign set_10_20         = 1'b0;
   assign set_1000_20       = 1'b0;
   assign set_10_21         = 1'b0;
   assign set_1000_21       = 1'b0;
   assign set_10_22         = 1'b0;
   assign set_1000_22       = 1'b0;
   assign set_10_23         = 1'b0;
   assign set_1000_23       = 1'b0;

   assign xon_gen_0        = 1'b0;
   assign xoff_gen_0       = 1'b0;
   assign xon_gen_1        = 1'b0;
   assign xoff_gen_1       = 1'b0;
   assign xon_gen_2        = 1'b0;
   assign xoff_gen_2       = 1'b0;
   assign xon_gen_3        = 1'b0;
   assign xoff_gen_3       = 1'b0;
   assign xon_gen_4        = 1'b0;
   assign xoff_gen_4       = 1'b0;
   assign xon_gen_5        = 1'b0;
   assign xoff_gen_5       = 1'b0;
   assign xon_gen_6        = 1'b0;
   assign xoff_gen_6       = 1'b0;
   assign xon_gen_7        = 1'b0;
   assign xoff_gen_7       = 1'b0;
   assign xon_gen_8        = 1'b0;
   assign xoff_gen_8       = 1'b0;
   assign xon_gen_9        = 1'b0;
   assign xoff_gen_9       = 1'b0;
   assign xon_gen_10        = 1'b0;
   assign xoff_gen_10       = 1'b0;
   assign xon_gen_11        = 1'b0;
   assign xoff_gen_11       = 1'b0;
   assign xon_gen_12        = 1'b0;
   assign xoff_gen_12       = 1'b0;
   assign xon_gen_13        = 1'b0;
   assign xoff_gen_13       = 1'b0;
   assign xon_gen_14        = 1'b0;
   assign xoff_gen_14       = 1'b0;
   assign xon_gen_15        = 1'b0;
   assign xoff_gen_15       = 1'b0;
   assign xon_gen_16        = 1'b0;
   assign xoff_gen_16       = 1'b0;
   assign xon_gen_17        = 1'b0;
   assign xoff_gen_17       = 1'b0;
   assign xon_gen_18        = 1'b0;
   assign xoff_gen_18       = 1'b0;
   assign xon_gen_19        = 1'b0;
   assign xoff_gen_19       = 1'b0;
   assign xon_gen_20        = 1'b0;
   assign xoff_gen_20       = 1'b0;
   assign xon_gen_21        = 1'b0;
   assign xoff_gen_21       = 1'b0;
   assign xon_gen_22        = 1'b0;
   assign xoff_gen_22       = 1'b0;
   assign xon_gen_23        = 1'b0;
   assign xoff_gen_23       = 1'b0;

   assign magic_sleep_n_0  = magic_sleep_n;
   assign magic_sleep_n_1  = magic_sleep_n;
   assign magic_sleep_n_2  = magic_sleep_n;
   assign magic_sleep_n_3  = magic_sleep_n;
   assign magic_sleep_n_4  = magic_sleep_n;
   assign magic_sleep_n_5  = magic_sleep_n;
   assign magic_sleep_n_6  = magic_sleep_n;
   assign magic_sleep_n_7  = magic_sleep_n;
   assign magic_sleep_n_8  = magic_sleep_n;
   assign magic_sleep_n_9  = magic_sleep_n;
   assign magic_sleep_n_10  = magic_sleep_n;
   assign magic_sleep_n_11  = magic_sleep_n;
   assign magic_sleep_n_12  = magic_sleep_n;
   assign magic_sleep_n_13  = magic_sleep_n;
   assign magic_sleep_n_14  = magic_sleep_n;
   assign magic_sleep_n_15  = magic_sleep_n;
   assign magic_sleep_n_16  = magic_sleep_n;
   assign magic_sleep_n_17  = magic_sleep_n;
   assign magic_sleep_n_18  = magic_sleep_n;
   assign magic_sleep_n_19  = magic_sleep_n;
   assign magic_sleep_n_20  = magic_sleep_n;
   assign magic_sleep_n_21  = magic_sleep_n;
   assign magic_sleep_n_22  = magic_sleep_n;
   assign magic_sleep_n_23  = magic_sleep_n;


   //output of DUT
   assign ff_rx_err_stat   = {pkt_class_valid_23 ? pkt_class_data_23 [0] : 1'b0, data_rx_error_23[4], 15'b0 ,pkt_class_valid_23 ? (pkt_class_data_23[1]|pkt_class_data_23[0]) : 1'b0 ,data_rx_error_23[3:0]};
   assign ff_rx_err        = data_rx_error_23 [0]|data_rx_error_23 [1]|data_rx_error_23 [2]|data_rx_error_23 [3]|data_rx_error_23 [4];
   assign ff_rx_vlan       = pkt_class_valid_23 ? pkt_class_data_23 [1] : 1'b0 ;
   assign ff_rx_bcast      = pkt_class_valid_23 ? pkt_class_data_23 [2] : 1'b0 ;
   assign ff_rx_mcast      = pkt_class_valid_23 ? pkt_class_data_23 [3] : 1'b0 ;
   assign ff_rx_ucast      = pkt_class_valid_23 ? pkt_class_data_23 [4] : 1'b0 ;
   assign ff_tx_clk        = mac_tx_clk_0;
   assign ff_rx_clk        = mac_rx_clk_0;
   assign ff_tx_rdy        = data_tx_ready_0;
   assign ff_rx_data       = data_rx_data_23;
   assign ff_rx_dval       = data_rx_valid_23;
   assign ff_rx_eop        = data_rx_eop_23;
   assign ff_rx_sop        = data_rx_sop_23;
   assign rx_err           = data_rx_error_23;

   //loopback
   assign data_rx_ready_0  = 1'b1;//data_tx_ready_1;
   assign tx_crc_fwd_1     = ff_tx_crc_fwd;


   loopback_adapter u_ch0_2_ch1 (
       
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_0),
     .in_data(data_rx_data_0),
     .in_startofpacket(data_rx_sop_0),
     .in_endofpacket(data_rx_eop_0),
     .in_error(data_rx_error_0),
     // Interface: out
     .out_ready(data_tx_ready_1),
     .out_valid(data_tx_valid_1),
     .out_data(data_tx_data_1),
     .out_startofpacket(data_tx_sop_1),
     .out_endofpacket(data_tx_eop_1),
     .out_error(data_tx_error_1)
   );

   assign data_rx_ready_1  = 1'b1;
   assign tx_crc_fwd_2     = ff_tx_crc_fwd;

   loopback_adapter u_ch1_2_ch2 (
       
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_1),
     .in_data(data_rx_data_1),
     .in_startofpacket(data_rx_sop_1),
     .in_endofpacket(data_rx_eop_1),
     .in_error(data_rx_error_1),
     // Interface: out
     .out_ready(data_tx_ready_2),
     .out_valid(data_tx_valid_2),
     .out_data(data_tx_data_2),
     .out_startofpacket(data_tx_sop_2),
     .out_endofpacket(data_tx_eop_2),
     .out_error(data_tx_error_2)
   );

   assign data_rx_ready_2  = 1'b1;
   assign tx_crc_fwd_3     = ff_tx_crc_fwd;

   loopback_adapter u_ch2_2_ch3 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_2),
     .in_data(data_rx_data_2),
     .in_startofpacket(data_rx_sop_2),
     .in_endofpacket(data_rx_eop_2),
     .in_error(data_rx_error_2),
     // Interface: out
     .out_ready(data_tx_ready_3),
     .out_valid(data_tx_valid_3),
     .out_data(data_tx_data_3),
     .out_startofpacket(data_tx_sop_3),
     .out_endofpacket(data_tx_eop_3),
     .out_error(data_tx_error_3)
   );

   assign data_rx_ready_3  = 1'b1;
   assign tx_crc_fwd_4     = ff_tx_crc_fwd;

   loopback_adapter u_ch3_2_ch4 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_3),
     .in_data(data_rx_data_3),
     .in_startofpacket(data_rx_sop_3),
     .in_endofpacket(data_rx_eop_3),
     .in_error(data_rx_error_3),
     // Interface: out
     .out_ready(data_tx_ready_4),
     .out_valid(data_tx_valid_4),
     .out_data(data_tx_data_4),
     .out_startofpacket(data_tx_sop_4),
     .out_endofpacket(data_tx_eop_4),
     .out_error(data_tx_error_4)
   );

   assign data_rx_ready_4  = 1'b1;
   assign tx_crc_fwd_5     = ff_tx_crc_fwd;

   loopback_adapter u_ch4_2_ch5 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_4),
     .in_data(data_rx_data_4),
     .in_startofpacket(data_rx_sop_4),
     .in_endofpacket(data_rx_eop_4),
     .in_error(data_rx_error_4),
     // Interface: out
     .out_ready(data_tx_ready_5),
     .out_valid(data_tx_valid_5),
     .out_data(data_tx_data_5),
     .out_startofpacket(data_tx_sop_5),
     .out_endofpacket(data_tx_eop_5),
     .out_error(data_tx_error_5)
   );

   assign data_rx_ready_5  = 1'b1;
   assign tx_crc_fwd_6     = ff_tx_crc_fwd;

   loopback_adapter u_ch5_2_ch6 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_5),
     .in_data(data_rx_data_5),
     .in_startofpacket(data_rx_sop_5),
     .in_endofpacket(data_rx_eop_5),
     .in_error(data_rx_error_5),
     // Interface: out
     .out_ready(data_tx_ready_6),
     .out_valid(data_tx_valid_6),
     .out_data(data_tx_data_6),
     .out_startofpacket(data_tx_sop_6),
     .out_endofpacket(data_tx_eop_6),
     .out_error(data_tx_error_6)
   );

   assign data_rx_ready_6  = 1'b1;
   assign tx_crc_fwd_7     = ff_tx_crc_fwd;

   loopback_adapter u_ch6_2_ch7 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_6),
     .in_data(data_rx_data_6),
     .in_startofpacket(data_rx_sop_6),
     .in_endofpacket(data_rx_eop_6),
     .in_error(data_rx_error_6),
     // Interface: out
     .out_ready(data_tx_ready_7),
     .out_valid(data_tx_valid_7),
     .out_data(data_tx_data_7),
     .out_startofpacket(data_tx_sop_7),
     .out_endofpacket(data_tx_eop_7),
     .out_error(data_tx_error_7)
   );

   assign data_rx_ready_7  = 1'b1;
   assign tx_crc_fwd_8    = ff_tx_crc_fwd;

   loopback_adapter u_ch7_2_ch8 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_7),
     .in_data(data_rx_data_7),
     .in_startofpacket(data_rx_sop_7),
     .in_endofpacket(data_rx_eop_7),
     .in_error(data_rx_error_7),
     // Interface: out
     .out_ready(data_tx_ready_8),
     .out_valid(data_tx_valid_8),
     .out_data(data_tx_data_8),
     .out_startofpacket(data_tx_sop_8),
     .out_endofpacket(data_tx_eop_8),
     .out_error(data_tx_error_8)
   );

   assign data_rx_ready_8  = 1'b1;
   assign tx_crc_fwd_9     = ff_tx_crc_fwd;

   loopback_adapter u_ch8_2_ch9 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_8),
     .in_data(data_rx_data_8),
     .in_startofpacket(data_rx_sop_8),
     .in_endofpacket(data_rx_eop_8),
     .in_error(data_rx_error_8),
     // Interface: out
     .out_ready(data_tx_ready_9),
     .out_valid(data_tx_valid_9),
     .out_data(data_tx_data_9),
     .out_startofpacket(data_tx_sop_9),
     .out_endofpacket(data_tx_eop_9),
     .out_error(data_tx_error_9)
   );

   assign data_rx_ready_9  = 1'b1;
   assign tx_crc_fwd_10     = ff_tx_crc_fwd;

   loopback_adapter u_ch9_2_ch10 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_9),
     .in_data(data_rx_data_9),
     .in_startofpacket(data_rx_sop_9),
     .in_endofpacket(data_rx_eop_9),
     .in_error(data_rx_error_9),
     // Interface: out
     .out_ready(data_tx_ready_10),
     .out_valid(data_tx_valid_10),
     .out_data(data_tx_data_10),
     .out_startofpacket(data_tx_sop_10),
     .out_endofpacket(data_tx_eop_10),
     .out_error(data_tx_error_10)
   );

   assign data_rx_ready_10  = 1'b1;
   assign tx_crc_fwd_11     = ff_tx_crc_fwd;

   loopback_adapter u_ch10_2_ch11 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_10),
     .in_data(data_rx_data_10),
     .in_startofpacket(data_rx_sop_10),
     .in_endofpacket(data_rx_eop_10),
     .in_error(data_rx_error_10),
     // Interface: out
     .out_ready(data_tx_ready_11),
     .out_valid(data_tx_valid_11),
     .out_data(data_tx_data_11),
     .out_startofpacket(data_tx_sop_11),
     .out_endofpacket(data_tx_eop_11),
     .out_error(data_tx_error_11)
   );

   assign data_rx_ready_11  = 1'b1;
   assign tx_crc_fwd_12     = ff_tx_crc_fwd;

   loopback_adapter u_ch11_2_ch12 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_11),
     .in_data(data_rx_data_11),
     .in_startofpacket(data_rx_sop_11),
     .in_endofpacket(data_rx_eop_11),
     .in_error(data_rx_error_11),
     // Interface: out
     .out_ready(data_tx_ready_12),
     .out_valid(data_tx_valid_12),
     .out_data(data_tx_data_12),
     .out_startofpacket(data_tx_sop_12),
     .out_endofpacket(data_tx_eop_12),
     .out_error(data_tx_error_12)
   );

   assign data_rx_ready_12  = 1'b1;
   assign tx_crc_fwd_13     = ff_tx_crc_fwd;

   loopback_adapter u_ch12_2_ch13 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_12),
     .in_data(data_rx_data_12),
     .in_startofpacket(data_rx_sop_12),
     .in_endofpacket(data_rx_eop_12),
     .in_error(data_rx_error_12),
     // Interface: out
     .out_ready(data_tx_ready_13),
     .out_valid(data_tx_valid_13),
     .out_data(data_tx_data_13),
     .out_startofpacket(data_tx_sop_13),
     .out_endofpacket(data_tx_eop_13),
     .out_error(data_tx_error_13)
   );

   assign data_rx_ready_13  = 1'b1;
   assign tx_crc_fwd_14     = ff_tx_crc_fwd;

   loopback_adapter u_ch13_2_ch14 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_13),
     .in_data(data_rx_data_13),
     .in_startofpacket(data_rx_sop_13),
     .in_endofpacket(data_rx_eop_13),
     .in_error(data_rx_error_13),
     // Interface: out
     .out_ready(data_tx_ready_14),
     .out_valid(data_tx_valid_14),
     .out_data(data_tx_data_14),
     .out_startofpacket(data_tx_sop_14),
     .out_endofpacket(data_tx_eop_14),
     .out_error(data_tx_error_14)
   );

   assign data_rx_ready_14  = 1'b1;
   assign tx_crc_fwd_15     = ff_tx_crc_fwd;

   loopback_adapter u_ch14_2_ch15 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_14),
     .in_data(data_rx_data_14),
     .in_startofpacket(data_rx_sop_14),
     .in_endofpacket(data_rx_eop_14),
     .in_error(data_rx_error_14),
     // Interface: out
     .out_ready(data_tx_ready_15),
     .out_valid(data_tx_valid_15),
     .out_data(data_tx_data_15),
     .out_startofpacket(data_tx_sop_15),
     .out_endofpacket(data_tx_eop_15),
     .out_error(data_tx_error_15)
   );

   assign data_rx_ready_15  = 1'b1;
   assign tx_crc_fwd_16     = ff_tx_crc_fwd;

   loopback_adapter u_ch15_2_ch16 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_15),
     .in_data(data_rx_data_15),
     .in_startofpacket(data_rx_sop_15),
     .in_endofpacket(data_rx_eop_15),
     .in_error(data_rx_error_15),
     // Interface: out
     .out_ready(data_tx_ready_16),
     .out_valid(data_tx_valid_16),
     .out_data(data_tx_data_16),
     .out_startofpacket(data_tx_sop_16),
     .out_endofpacket(data_tx_eop_16),
     .out_error(data_tx_error_16)
   );

   assign data_rx_ready_16  = 1'b1;
   assign tx_crc_fwd_17     = ff_tx_crc_fwd;

   loopback_adapter u_ch16_2_ch17 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_16),
     .in_data(data_rx_data_16),
     .in_startofpacket(data_rx_sop_16),
     .in_endofpacket(data_rx_eop_16),
     .in_error(data_rx_error_16),
     // Interface: out
     .out_ready(data_tx_ready_17),
     .out_valid(data_tx_valid_17),
     .out_data(data_tx_data_17),
     .out_startofpacket(data_tx_sop_17),
     .out_endofpacket(data_tx_eop_17),
     .out_error(data_tx_error_17)
   );

   assign data_rx_ready_17  = 1'b1;
   assign tx_crc_fwd_18     = ff_tx_crc_fwd;

   loopback_adapter u_ch17_2_ch18 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_17),
     .in_data(data_rx_data_17),
     .in_startofpacket(data_rx_sop_17),
     .in_endofpacket(data_rx_eop_17),
     .in_error(data_rx_error_17),
     // Interface: out
     .out_ready(data_tx_ready_18),
     .out_valid(data_tx_valid_18),
     .out_data(data_tx_data_18),
     .out_startofpacket(data_tx_sop_18),
     .out_endofpacket(data_tx_eop_18),
     .out_error(data_tx_error_18)
   );

   assign data_rx_ready_18  = 1'b1;
   assign tx_crc_fwd_19     = ff_tx_crc_fwd;

   loopback_adapter u_ch18_2_ch19 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_18),
     .in_data(data_rx_data_18),
     .in_startofpacket(data_rx_sop_18),
     .in_endofpacket(data_rx_eop_18),
     .in_error(data_rx_error_18),
     // Interface: out
     .out_ready(data_tx_ready_19),
     .out_valid(data_tx_valid_19),
     .out_data(data_tx_data_19),
     .out_startofpacket(data_tx_sop_19),
     .out_endofpacket(data_tx_eop_19),
     .out_error(data_tx_error_19)
   );

   assign data_rx_ready_19  = 1'b1;
   assign tx_crc_fwd_20     = ff_tx_crc_fwd;

   loopback_adapter u_ch19_2_ch20 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_19),
     .in_data(data_rx_data_19),
     .in_startofpacket(data_rx_sop_19),
     .in_endofpacket(data_rx_eop_19),
     .in_error(data_rx_error_19),
     // Interface: out
     .out_ready(data_tx_ready_20),
     .out_valid(data_tx_valid_20),
     .out_data(data_tx_data_20),
     .out_startofpacket(data_tx_sop_20),
     .out_endofpacket(data_tx_eop_20),
     .out_error(data_tx_error_20)
   );

   assign data_rx_ready_20  = 1'b1;
   assign tx_crc_fwd_21     = ff_tx_crc_fwd;

   loopback_adapter u_ch20_2_ch21 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_20),
     .in_data(data_rx_data_20),
     .in_startofpacket(data_rx_sop_20),
     .in_endofpacket(data_rx_eop_20),
     .in_error(data_rx_error_20),
     // Interface: out
     .out_ready(data_tx_ready_21),
     .out_valid(data_tx_valid_21),
     .out_data(data_tx_data_21),
     .out_startofpacket(data_tx_sop_21),
     .out_endofpacket(data_tx_eop_21),
     .out_error(data_tx_error_21)
   );

   assign data_rx_ready_21  = 1'b1;
   assign tx_crc_fwd_22     = ff_tx_crc_fwd;

   loopback_adapter u_ch21_2_ch22 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_21),
     .in_data(data_rx_data_21),
     .in_startofpacket(data_rx_sop_21),
     .in_endofpacket(data_rx_eop_21),
     .in_error(data_rx_error_21),
     // Interface: out
     .out_ready(data_tx_ready_22),
     .out_valid(data_tx_valid_22),
     .out_data(data_tx_data_22),
     .out_startofpacket(data_tx_sop_22),
     .out_endofpacket(data_tx_eop_22),
     .out_error(data_tx_error_22)
   );

   assign data_rx_ready_22  = 1'b1;
   assign tx_crc_fwd_23     = ff_tx_crc_fwd;

   loopback_adapter u_ch22_2_ch23 (
     // Interface: clk                     
     .clk(mac_tx_clk_0),
     .reset(reset),
     // Interface: in
     .in_ready(),
     .in_valid(data_rx_valid_22),
     .in_data(data_rx_data_22),
     .in_startofpacket(data_rx_sop_22),
     .in_endofpacket(data_rx_eop_22),
     .in_error(data_rx_error_22),
     // Interface: out
     .out_ready(data_tx_ready_23),
     .out_valid(data_tx_valid_23),
     .out_data(data_tx_data_23),
     .out_startofpacket(data_tx_sop_23),
     .out_endofpacket(data_tx_eop_23),
     .out_error(data_tx_error_23)
   );

   
   //assigning to GMII/MII TX monitoring
   assign rgmii_tx_ctnl    = tx_control_0;
   assign rgmii_tx_data    = rgmii_out_0;
   assign gm_tx_data       = gm_tx_d_0;
   assign gm_tx_en         = gm_tx_en_0;
   assign gm_tx_err        = gm_tx_err_0;
   assign m_tx_data        = m_tx_d_0;
   assign m_tx_en          = m_tx_en_0;
   assign m_tx_err         = m_tx_err_0;

   assign gm_rx_d_0        = gm_tx_d_0;
   assign gm_rx_dv_0       = gm_tx_en_0;
   assign gm_rx_err_0      = gm_tx_err_0;
   assign m_rx_d_0         = m_tx_d_0;
   assign m_rx_en_0        = m_tx_en_0;
   assign m_rx_err_0       = m_tx_err_0;
   assign m_rx_col_0       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_0       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_0     = tx_control_0;
   assign rgmii_in_0       = rgmii_out_0;
   assign #(4) tbi_rx_d_0  = tbi_tx_d_0;

   assign gm_rx_d_1        = gm_tx_d_1;
   assign gm_rx_dv_1       = gm_tx_en_1;
   assign gm_rx_err_1      = gm_tx_err_1;
   assign m_rx_d_1         = m_tx_d_1;
   assign m_rx_en_1        = m_tx_en_1;
   assign m_rx_err_1       = m_tx_err_1;
   assign m_rx_col_1       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_1       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_1     = tx_control_1;
   assign rgmii_in_1       = rgmii_out_1;
   assign #(4) tbi_rx_d_1  = tbi_tx_d_1;

   assign gm_rx_d_2        = gm_tx_d_2;
   assign gm_rx_dv_2       = gm_tx_en_2;
   assign gm_rx_err_2      = gm_tx_err_2;
   assign m_rx_d_2         = m_tx_d_2;
   assign m_rx_en_2        = m_tx_en_2;
   assign m_rx_err_2       = m_tx_err_2;
   assign m_rx_col_2       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_2       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_2     = tx_control_2;
   assign rgmii_in_2       = rgmii_out_2;
   assign #(4) tbi_rx_d_2  = tbi_tx_d_2;

   assign gm_rx_d_3        = gm_tx_d_3;
   assign gm_rx_dv_3       = gm_tx_en_3;
   assign gm_rx_err_3      = gm_tx_err_3;
   assign m_rx_d_3         = m_tx_d_3;
   assign m_rx_en_3        = m_tx_en_3;
   assign m_rx_err_3       = m_tx_err_3;
   assign m_rx_col_3       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_3       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_3     = tx_control_3;
   assign rgmii_in_3       = rgmii_out_3;
   assign #(4) tbi_rx_d_3  = tbi_tx_d_3;

   assign gm_rx_d_4        = gm_tx_d_4;
   assign gm_rx_dv_4       = gm_tx_en_4;
   assign gm_rx_err_4      = gm_tx_err_4;
   assign m_rx_d_4         = m_tx_d_4;
   assign m_rx_en_4        = m_tx_en_4;
   assign m_rx_err_4       = m_tx_err_4;
   assign m_rx_col_4       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_4       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_4     = tx_control_4;
   assign rgmii_in_4       = rgmii_out_4;
   assign #(4) tbi_rx_d_4  = tbi_tx_d_4;

   assign gm_rx_d_5        = gm_tx_d_5;
   assign gm_rx_dv_5       = gm_tx_en_5;
   assign gm_rx_err_5      = gm_tx_err_5;
   assign m_rx_d_5         = m_tx_d_5;
   assign m_rx_en_5        = m_tx_en_5;
   assign m_rx_err_5       = m_tx_err_5;
   assign m_rx_col_5       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_5       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_5     = tx_control_5;
   assign rgmii_in_5       = rgmii_out_5;
   assign #(4) tbi_rx_d_5  = tbi_tx_d_5;

   assign gm_rx_d_6        = gm_tx_d_6;
   assign gm_rx_dv_6       = gm_tx_en_6;
   assign gm_rx_err_6      = gm_tx_err_6;
   assign m_rx_d_6         = m_tx_d_6;
   assign m_rx_en_6        = m_tx_en_6;
   assign m_rx_err_6       = m_tx_err_6;
   assign m_rx_col_6       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_6       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_6     = tx_control_6;
   assign rgmii_in_6       = rgmii_out_6;
   assign #(4) tbi_rx_d_6  = tbi_tx_d_6;

   assign gm_rx_d_7        = gm_tx_d_7;
   assign gm_rx_dv_7       = gm_tx_en_7;
   assign gm_rx_err_7      = gm_tx_err_7;
   assign m_rx_d_7         = m_tx_d_7;
   assign m_rx_en_7        = m_tx_en_7;
   assign m_rx_err_7       = m_tx_err_7;
   assign m_rx_col_7       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_7       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_7     = tx_control_7;
   assign rgmii_in_7       = rgmii_out_7;
   assign #(4) tbi_rx_d_7  = tbi_tx_d_7;

   assign gm_rx_d_8        = gm_tx_d_8;
   assign gm_rx_dv_8       = gm_tx_en_8;
   assign gm_rx_err_8      = gm_tx_err_8;
   assign m_rx_d_8         = m_tx_d_8;
   assign m_rx_en_8        = m_tx_en_8;
   assign m_rx_err_8       = m_tx_err_8;
   assign m_rx_col_8       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_8       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_8     = tx_control_8;
   assign rgmii_in_8       = rgmii_out_8;
   assign #(4) tbi_rx_d_8  = tbi_tx_d_8;

   assign gm_rx_d_9        = gm_tx_d_9;
   assign gm_rx_dv_9       = gm_tx_en_9;
   assign gm_rx_err_9      = gm_tx_err_9;
   assign m_rx_d_9         = m_tx_d_9;
   assign m_rx_en_9        = m_tx_en_9;
   assign m_rx_err_9       = m_tx_err_9;
   assign m_rx_col_9       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_9       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_9     = tx_control_9;
   assign rgmii_in_9       = rgmii_out_9;
   assign #(4) tbi_rx_d_9  = tbi_tx_d_9;

   assign gm_rx_d_10        = gm_tx_d_10;
   assign gm_rx_dv_10       = gm_tx_en_10;
   assign gm_rx_err_10      = gm_tx_err_10;
   assign m_rx_d_10         = m_tx_d_10;
   assign m_rx_en_10        = m_tx_en_10;
   assign m_rx_err_10       = m_tx_err_10;
   assign m_rx_col_10       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_10       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_10     = tx_control_10;
   assign rgmii_in_10       = rgmii_out_10;
   assign #(4) tbi_rx_d_10  = tbi_tx_d_10;

   assign gm_rx_d_11        = gm_tx_d_11;
   assign gm_rx_dv_11       = gm_tx_en_11;
   assign gm_rx_err_11      = gm_tx_err_11;
   assign m_rx_d_11         = m_tx_d_11;
   assign m_rx_en_11        = m_tx_en_11;
   assign m_rx_err_11       = m_tx_err_11;
   assign m_rx_col_11       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_11       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_11     = tx_control_11;
   assign rgmii_in_11       = rgmii_out_11;
   assign #(4) tbi_rx_d_11  = tbi_tx_d_11;

   assign gm_rx_d_12        = gm_tx_d_12;
   assign gm_rx_dv_12       = gm_tx_en_12;
   assign gm_rx_err_12      = gm_tx_err_12;
   assign m_rx_d_12         = m_tx_d_12;
   assign m_rx_en_12        = m_tx_en_12;
   assign m_rx_err_12       = m_tx_err_12;
   assign m_rx_col_12       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_12       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_12     = tx_control_12;
   assign rgmii_in_12       = rgmii_out_12;
   assign #(4) tbi_rx_d_12  = tbi_tx_d_12;

   assign gm_rx_d_13        = gm_tx_d_13;
   assign gm_rx_dv_13       = gm_tx_en_13;
   assign gm_rx_err_13      = gm_tx_err_13;
   assign m_rx_d_13         = m_tx_d_13;
   assign m_rx_en_13        = m_tx_en_13;
   assign m_rx_err_13       = m_tx_err_13;
   assign m_rx_col_13       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_13       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_13     = tx_control_13;
   assign rgmii_in_13       = rgmii_out_13;
   assign #(4) tbi_rx_d_13  = tbi_tx_d_13;

   assign gm_rx_d_14        = gm_tx_d_14;
   assign gm_rx_dv_14       = gm_tx_en_14;
   assign gm_rx_err_14      = gm_tx_err_14;
   assign m_rx_d_14         = m_tx_d_14;
   assign m_rx_en_14        = m_tx_en_14;
   assign m_rx_err_14       = m_tx_err_14;
   assign m_rx_col_14       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_14       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_14     = tx_control_14;
   assign rgmii_in_14       = rgmii_out_14;
   assign #(4) tbi_rx_d_14  = tbi_tx_d_14;

   assign gm_rx_d_15        = gm_tx_d_15;
   assign gm_rx_dv_15       = gm_tx_en_15;
   assign gm_rx_err_15      = gm_tx_err_15;
   assign m_rx_d_15         = m_tx_d_15;
   assign m_rx_en_15        = m_tx_en_15;
   assign m_rx_err_15       = m_tx_err_15;
   assign m_rx_col_15       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_15       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_15     = tx_control_15;
   assign rgmii_in_15       = rgmii_out_15;
   assign #(4) tbi_rx_d_15  = tbi_tx_d_15;

   assign gm_rx_d_16        = gm_tx_d_16;
   assign gm_rx_dv_16       = gm_tx_en_16;
   assign gm_rx_err_16      = gm_tx_err_16;
   assign m_rx_d_16         = m_tx_d_16;
   assign m_rx_en_16        = m_tx_en_16;
   assign m_rx_err_16       = m_tx_err_16;
   assign m_rx_col_16       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_16       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_16     = tx_control_16;
   assign rgmii_in_16       = rgmii_out_16;
   assign #(4) tbi_rx_d_16  = tbi_tx_d_16;

   assign gm_rx_d_17        = gm_tx_d_17;
   assign gm_rx_dv_17       = gm_tx_en_17;
   assign gm_rx_err_17      = gm_tx_err_17;
   assign m_rx_d_17         = m_tx_d_17;
   assign m_rx_en_17        = m_tx_en_17;
   assign m_rx_err_17       = m_tx_err_17;
   assign m_rx_col_17       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_17       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_17     = tx_control_17;
   assign rgmii_in_17       = rgmii_out_17;
   assign #(4) tbi_rx_d_17  = tbi_tx_d_17;

   assign gm_rx_d_18        = gm_tx_d_18;
   assign gm_rx_dv_18       = gm_tx_en_18;
   assign gm_rx_err_18      = gm_tx_err_18;
   assign m_rx_d_18         = m_tx_d_18;
   assign m_rx_en_18        = m_tx_en_18;
   assign m_rx_err_18       = m_tx_err_18;
   assign m_rx_col_18       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_18       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_18     = tx_control_18;
   assign rgmii_in_18       = rgmii_out_18;
   assign #(4) tbi_rx_d_18  = tbi_tx_d_18;

   assign gm_rx_d_19        = gm_tx_d_19;
   assign gm_rx_dv_19       = gm_tx_en_19;
   assign gm_rx_err_19      = gm_tx_err_19;
   assign m_rx_d_19         = m_tx_d_19;
   assign m_rx_en_19        = m_tx_en_19;
   assign m_rx_err_19       = m_tx_err_19;
   assign m_rx_col_19       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_19       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_19     = tx_control_19;
   assign rgmii_in_19       = rgmii_out_19;
   assign #(4) tbi_rx_d_19  = tbi_tx_d_19;

   assign gm_rx_d_20        = gm_tx_d_20;
   assign gm_rx_dv_20       = gm_tx_en_20;
   assign gm_rx_err_20      = gm_tx_err_20;
   assign m_rx_d_20         = m_tx_d_20;
   assign m_rx_en_20        = m_tx_en_20;
   assign m_rx_err_20       = m_tx_err_20;
   assign m_rx_col_20       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_20       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_20     = tx_control_20;
   assign rgmii_in_20       = rgmii_out_20;
   assign #(4) tbi_rx_d_20  = tbi_tx_d_20;

   assign gm_rx_d_21        = gm_tx_d_21;
   assign gm_rx_dv_21       = gm_tx_en_21;
   assign gm_rx_err_21      = gm_tx_err_21;
   assign m_rx_d_21         = m_tx_d_21;
   assign m_rx_en_21        = m_tx_en_21;
   assign m_rx_err_21       = m_tx_err_21;
   assign m_rx_col_21       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_21       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_21     = tx_control_21;
   assign rgmii_in_21       = rgmii_out_21;
   assign #(4) tbi_rx_d_21  = tbi_tx_d_21;

   assign gm_rx_d_22        = gm_tx_d_22;
   assign gm_rx_dv_22       = gm_tx_en_22;
   assign gm_rx_err_22      = gm_tx_err_22;
   assign m_rx_d_22         = m_tx_d_22;
   assign m_rx_en_22        = m_tx_en_22;
   assign m_rx_err_22       = m_tx_err_22;
   assign m_rx_col_22       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_22       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_22     = tx_control_22;
   assign rgmii_in_22       = rgmii_out_22;
   assign #(4) tbi_rx_d_22  = tbi_tx_d_22;

   assign gm_rx_d_23        = gm_tx_d_23;
   assign gm_rx_dv_23       = gm_tx_en_23;
   assign gm_rx_err_23      = gm_tx_err_23;
   assign m_rx_d_23         = m_tx_d_23;
   assign m_rx_en_23        = m_tx_en_23;
   assign m_rx_err_23       = m_tx_err_23;
   assign m_rx_col_23       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign m_rx_crs_23       = 1'b0; //always disable Half Duplex support for multi-port simulation
   assign rx_control_23     = tx_control_23;
   assign rgmii_in_23       = rgmii_out_23;
   assign #(4) tbi_rx_d_23  = tbi_tx_d_23;
  
  end

endgenerate


                
assign mac_addr         = 48'h EE1122334450;
assign sup_mac_addr_0   = 48'h EE2233445560 ;
assign sup_mac_addr_1   = 48'h EE3344556670 ;
assign sup_mac_addr_2   = 48'h EE4455667780 ;           
assign sup_mac_addr_3   = 48'h EE5566778890 ;
assign frm_length_max   = TB_MACLENMAX;

//  MDIO Slave Model
//  ----------------
generate
 if (ENABLE_MDIO == 1'b1)
  begin
assign mdio_in = mdio; 

always@(mdio_oen or mdio_out)
begin

        if (mdio_oen==1'b 1)
        begin
        
                mdio_tmp <= #(2) 1'b Z ;
                
        end
        else
        begin
        
                mdio_tmp <= #(2) mdio_out ;
                
        end
        
end

assign mdio = mdio_tmp ; 

        top_mdio_slave mdio_1 (
        
                .reset(reset),
                .mdc(mdc),
                .mdio(mdio),
                .dev_addr(phy_addr1),
                .conf_done(mdio1_done));
          
assign phy_addr1 = TB_MDIO_ADDR1; 
  end
endgenerate

// Checking FIFO Signals
// ---------------------
   
always@(reset or ff_rx_clk)
begin

        if (reset==1'b1)
        begin
                
                ff_rx_ucast_reg <= 1'b0 ;
                ff_rx_bcast_reg <= 1'b0 ;
                ff_rx_mcast_reg <= 1'b0 ;
                ff_rx_vlan_reg  <= 1'b0 ;
                
        end
        else
        begin
        
                if (ff_rx_sop==1'b1)
                begin
                
                        ff_rx_ucast_reg <= ff_rx_ucast ;
                        ff_rx_bcast_reg <= ff_rx_bcast ;
                        ff_rx_mcast_reg <= ff_rx_mcast ;
                        ff_rx_vlan_reg  <= ff_rx_vlan ;
                        
                end
                
        end
        
end

always@(ff_rx_clk)
begin

        if (ff_rx_clk==1'b1)
        begin

                if (mff_frm_rcvd==1'b1)
                begin
        
                        if (mff_dst_reg==48'hFFFFFFFFFFFF & ff_rx_bcast_reg==1'b0)
                        begin
                        
                                $display("\n - Error: FIFO Broadcast Frame Error") ;
                                                                
                        end
                
                        if (mff_dst_reg!=48'hFFFFFFFFFFFF & mff_dst_reg[0]==1'b1 & ff_rx_mcast_reg==1'b0 & mff_is_pause==1'b0)
                        begin
                        
                                $display("\n - Error: FIFO Multicast Frame Error") ;
                                                        
                        end
                
                        if (mff_dst_reg[0]==1'b0 & ff_rx_ucast_reg==1'b0 & mff_is_pause==1'b0)
                        begin
                        
                                $display("\n - Error: FIFO Unicast Frame Error") ;
                                                        
                        end
                        
                        if (ff_rx_vlan_reg==1'b1 & mff_is_vlan==1'b0)
                        begin
                        
                                $display("\n - Error: FIFO VLAN Frame Error") ;
                                                        
                        end
                
                end
                
        end
        
end      


//  Frame generator feeds TX FIFO (simulate user application) 
//  ---------------------------------------------------------

generate
 if (ENABLE_ENA == 8)
   begin
        ethgenerator #(2) ff_gen (
        
                .reset(reset),
                .rx_clk(ff_tx_clk_gen),
                .enable(ff_tx_rdy),
                .rxd(ff_tx_data),
                .rx_dv(ff_tx_wren_gen),
                .rx_er(ff_tx_err),
                .sop(ff_tx_sop),
                .eop(ff_tx_eop),
                .mac_reverse(ff_mac_reverse),
                .dst(ff_dst),
                .src(ff_src),
                .prmble_len(ff_prmble_len),
                .pquant(ff_pquant),
                .vlan_ctl(ff_vlan_ctl),
                .len(ff_len),
                .frmtype(ff_frmtype),
                .cntstart(ff_cntstart),
                .cntstep(ff_cntstep),
                .ipg_len(ff_ipg_len),
                .payload_err(ff_payload_err),
                .prmbl_err(ff_prmbl_err),
                .crc_err(ff_crc_err),
                .vlan_en(ff_vlan_en),
                .stack_vlan(ff_stack_vlan_en),
                .pause_gen(ff_pause_gen),
                .pad_en(ff_pad_en),
                .phy_err(ff_phy_err),
                .end_err(ff_end_err),
                .data_only(1'b 1),
                .runt_gen(1'b0) ,
                .long_pause(1'b0) ,
                .start(ff_start_ether_gen),
                .done(ff_ether_gen_done));
   end

if (ENABLE_ENA == 0 && MAX_CHANNELS > 0)
   begin
    top_ethgenerator_8 ff_gen (
                .reset(reset),
                .clk(ff_tx_clk_gen),
                .enable(ff_tx_rdy),
                .dout(ff_tx_data),
                .dval(ff_tx_wren_gen),
                .derror(ff_tx_err),
                .sop(ff_tx_sop),
                .eop(ff_tx_eop),
                .mac_reverse(ff_mac_reverse),
                .dst(ff_dst),
                .src(ff_src),
                .prmble_len(ff_prmble_len),
                .pquant(ff_pquant),
                .vlan_ctl(ff_vlan_ctl),
                .len(ff_len),
                .frmtype(ff_frmtype),
                .cntstart(ff_cntstart),
                .cntstep(ff_cntstep),
                .ipg_len(ff_ipg_len),
                .payload_err(ff_payload_err),
                .prmbl_err(ff_prmbl_err),
                .crc_err(ff_crc_err),
                .vlan_en(ff_vlan_en),
                .stack_vlan(ff_stack_vlan_en),
                .pause_gen(1'b 0),
                .pad_en(ff_pad_en),
                .phy_err(ff_phy_err),
                .end_err(ff_end_err),
                .data_only(1'b 1),
                .start(ff_start_ether_gen),
                .done(ff_ether_gen_done));


       defparam ff_gen.ZERO_LATENCY = 1;
       defparam ff_gen.ENABLE_SHIFT16 = ENABLE_SHIFT16;
end

endgenerate
         
//  FIFO Monitor RX (user appl)
//  ---------------------------
 generate
  if (ENABLE_ENA !== 32)
     begin
        ethmonitor ff_mon ( 

                .reset(reset),
                .tx_clk(ff_rx_clk),
                .txd(ff_rx_data),
                .tx_dv(ff_rx_dval),
                .tx_er(1'b 0),
                .tx_sop(ff_rx_sop),
                .tx_eop(ff_rx_eop),
                .dst(mff_dst),
                .src(mff_src),
                .prmble_len(mff_prmble_len),
                .pquant(mff_pquant),
                .vlan_ctl(mff_vlan_ctl),
                .len(mff_len),
                .frmtype(mff_frmtype),
                .payload(mff_payload),
                .payload_vld(mff_payload_vld),
                .is_vlan(mff_is_vlan),
                .is_stack_vlan(mff_is_stack_vlan),
                .is_pause(mff_is_pause),
                .crc_err(mff_crc_err),
                .prmbl_err(mff_prmbl_err),
                .len_err(mff_len_err),
                .payload_err(mff_payload_err),
                .frame_err(mff_frame_err),
                .pause_op_err(mff_pause_op_err),
                .pause_dst_err(mff_pause_dst_err),
                .mac_err(mff_mac_err),
                .end_err(mff_end_err),
                .jumbo_en(jumbo_enable),
                .data_only(1'b 1),
                .frm_rcvd(mff_frm_rcvd));
         defparam ff_mon.ENABLE_SHIFT16 = ENABLE_SHIFT16;
     end
endgenerate


//  FIFO Generator model configuration (user application TX)
//  --------------------------------------------------------

assign ff_mac_reverse = 1'b 0; 
assign ff_dst = 48'h EE1122334450; 
assign ff_src = 48'h AA6655443322; 
assign ff_prmble_len = 5'b 01000; 
assign ff_pquant = TB_MODPAUSEQ ;
assign ff_vlan_ctl = 16'h 1234; 
assign ff_frmtype = 16'h 0000; 
assign ff_cntstart = 1'b 0; 
assign ff_cntstep = 1'b 1; 
assign ff_ipg_len = 16'h4; 
assign ff_payload_err = 1'b 0; 
assign ff_prmbl_err = 1'b 0; 
assign ff_crc_err = 1'b 0; 
assign ff_vlan_en = TB_ENA_VLAN > 0 & txframe_cnt % TB_ENA_VLAN == TB_ENA_VLAN - 1'b 1 ? 1'b 1 : 1'b 0; 
assign ff_stack_vlan_en = TB_ENA_VLAN > 0 & txframe_cnt % (3*TB_ENA_VLAN) == TB_ENA_VLAN - 1'b 1 ? 1'b 1 : 1'b 0; 
assign ff_pad_en = 1'b 0; 
assign ff_phy_err = 1'b 0; 
assign ff_end_err = 1'b 0; 
assign ff_pause_gen = 1'b 0;

//  --------------------------------------------------------------------------------    
//  TX PATH Simulation
//  -------------------------------------------------------------------------------- 
//assign rxframe_cnt = txframe_cnt;
   
assign ff_tx_clk_gen = ff_tx_clk ;//& ff_tx_clk_gen_en; //  hold the generator if FIFO signals full
assign ff_tx_wren = ff_tx_wren_gen ;//& ff_tx_clk_gen_en; //  and stop writing during hold
assign ff_start_ether_gen = state == stm_typ_sim & sim_start == 1'b 1 & txsim_done == 1'b 0 & txframe_cnt < TB_TXFRAMES & HD_ENA == 1'b0 ? 1'b 1 : 
                        state == stm_typ_sim & sim_start == 1'b 1 & txsim_done == 1'b 0 & rxframe_cnt >= TB_RXFRAMES & txframe_cnt < TB_TXFRAMES & HD_ENA == 1'b1 ? 1'b 1 : 
                        1'b 0; //  START Generator
    
        always @(posedge reset or posedge ff_tx_clk)
        begin
   
                if (reset == 1'b 1)
                begin
      
                        txframe_cnt             <= 0;   
                        tx_vlan_sent            <= 0;
                        tx_stack_vlan_sent      <= 0;   
                        tx_payload_err_sent     <= 0;   
                        tx_good_sent            <= 0;   
                        txsim_done              <= 1'b 0;   
                        ff_len                  <= TB_LENSTART; 
                
                end
                
                else
                begin
                      
                   //  FIFO frame generator simulation finished
                   // -----------------------------------------

                        if (txframe_cnt >= TB_TXFRAMES & ff_ether_gen_done == 1'b 1 & rxframe_cnt >= TB_TXFRAMES)
                        begin
         
                                txsim_done <= 1'b 1;    //  STOP after last frame sent
         
                        end
         
                   //  configure generator for every frame
                   // ------------------------------------
       
                        if (ff_tx_sop == 1'b 1 & ff_tx_wren == 1'b 1 & ((ff_tx_rdy == 1'b1 & ENABLE_MACLITE == 1'b1) | ENABLE_MACLITE == 1'b0) & ENABLE_ENA == 8|
                            ff_tx_sop == 1'b 1 & ff_tx_wren == 1'b 1 & ((ff_tx_rdy == 1'b1 & MAX_CHANNELS > 0)))
                        begin
         
                                txframe_cnt <= txframe_cnt + 1'b 1;                         //  TX FRAMEs sent to FIFO

                           //  increment payload length  
                           // --------------------------
      
                                process_4_ln = (ff_len + TB_LENSTEP) % (TB_LENMAX + 1'b 1); //  increment length for next frame
         
                                if (process_4_ln < 0)
                                begin

                                //  incase increment was negative
                                // ------------------------------
      
                                        process_4_ln = TB_LENMAX;   
            
                                end
                        
                                ff_len <= process_4_ln; //  update counters
                        
                                if (ff_vlan_en == 1'b 1 & ff_stack_vlan_en == 1'b 0)
                                begin
            
                                        tx_vlan_sent <= tx_vlan_sent + 1'b 1;   
            
                                end
                                
                                if (ff_vlan_en == 1'b 1 & ff_stack_vlan_en == 1'b 1)
                                begin
            
                                        tx_stack_vlan_sent <= tx_stack_vlan_sent + 1'b 1;   
            
                                end
         
                                if (ff_payload_err == 1'b 1)
                                begin
            
                                        tx_payload_err_sent <= tx_payload_err_sent + 1'b 1; 
                        
                                end
                        
                                if (ff_frmtype == 16'h 0000 & ff_phy_err == 1'b0 & ff_end_err == 1'b0)
                                begin
            
                                        tx_good_sent <= tx_good_sent + 1'b 1;   
            
                                end
         
                        end
                  
                end

        end
   
   always@(posedge reset or negedge ff_tx_clk)
   begin
   
        if (reset==1'b1)
        begin
        
                ff_tx_clk_gen_en <= 1'b1 ;
                
        end
        
        else
        begin
        
                ff_tx_clk_gen_en <= ff_tx_rdy;  //  stop the generator clock if the FIFO signals "full"

        end
        
   end
   
   
//  -----------------------------------------------------------------------------------
//  TX/RX Pause Frame control block
//  -----------------------------------------------------------------------------------

always @(posedge reset or posedge tx_clk)
   begin : process_10
   if (reset == 1'b 1)
      begin
      tx_pause_wait <= 1'b 0;   
      tx_pause_cnt <= 0;    
      end
   else
      begin
      if (tx_pause_cnt != 0)
         begin
         if (gm_ether_gen_done == 1'b 1)
            begin
//  wait for TX to finish current frame
            tx_pause_cnt <= tx_pause_cnt - 1'b 1;   
            end
         end
      else
         begin
         tx_pause_wait <= 1'b 0;    
         end
      if (mgm_frm_rcvd == 1'b 1 & mgm_is_pause == 1'b 1 & 
    mgm_frame_err == 1'b 0 & mgm_crc_err == 1'b 0 & 
    TB_PAUSECONTROL == 1'b1)
         begin
         process_10_cnt = ({1'b 0, mgm_pquant});    
         tx_pause_cnt   <= process_10_cnt*64;   //  set pause counter
         tx_pause_wait  <= 1'b 1;   //  stop TX
         end
      end
   end
   
//  Force Pause Frame Generation
//  ----------------------------
       
always @(posedge reset or posedge tx_clk)
   begin : process_11
   if (reset == 1'b 1)
      begin
      force_xoff_pause_cnt <= 0;    
      force_xon_pause_cnt <= 0;
      xoff_gen <= 1'b 0;
      xon_gen <= 1'b 0; 
      end
   else
      begin
      
     // Xoff Generation
     // ---------------
      
      if (TB_TRIGGERXOFF > 0 & state == stm_typ_sim & 
    HD_ENA == 1'b0)
         begin
         if (force_xoff_pause_cnt < TB_TRIGGERXOFF)
            begin
              force_xoff_pause_cnt <= force_xoff_pause_cnt + 1'b 1; 
            end
         else if (force_xoff_pause_cnt == TB_TRIGGERXOFF && ETH_MODE==1000)
            begin
              force_xoff_pause_cnt <= force_xoff_pause_cnt + 1'b 1;
            end
         else if ((force_xoff_pause_cnt == TB_TRIGGERXOFF||force_xoff_pause_cnt == TB_TRIGGERXOFF-1) && ETH_MODE!=1000)
            begin
              force_xoff_pause_cnt <= force_xoff_pause_cnt + 1'b 1;
            end
                        
         if (force_xoff_pause_cnt == TB_TRIGGERXOFF && ETH_MODE==1000)
            begin
            xoff_gen <= 1'b 1;  
            end
         else if ((force_xoff_pause_cnt == TB_TRIGGERXOFF || force_xoff_pause_cnt == TB_TRIGGERXOFF-1) && (ETH_MODE==100||ETH_MODE==10))
            begin
            xoff_gen <= 1'b 1;  
            end
         else
            begin
            xoff_gen <= 1'b 0;  
            end
         end
         
       // Xon Generation
       // --------------
       
      if (TB_TRIGGERXON > 0 & state == stm_typ_sim & 
    HD_ENA == 1'b0)
         begin
         if (force_xon_pause_cnt < TB_TRIGGERXON)
            begin
              force_xon_pause_cnt <= force_xon_pause_cnt + 1'b 1;   
            end
         else if (force_xon_pause_cnt == TB_TRIGGERXON && ETH_MODE==1000)
            begin
              force_xon_pause_cnt <= force_xon_pause_cnt + 1'b 1;
            end
         else if ((force_xon_pause_cnt == TB_TRIGGERXON||force_xon_pause_cnt == TB_TRIGGERXON-1) && ETH_MODE!=1000)
            begin
              force_xon_pause_cnt <= force_xon_pause_cnt + 1'b 1;
            end
                        
         if (force_xon_pause_cnt == TB_TRIGGERXON && ETH_MODE==1000)
            begin
            xon_gen <= 1'b 1;   
            end
         else if ((force_xon_pause_cnt == TB_TRIGGERXON || force_xon_pause_cnt == TB_TRIGGERXON-1) && (ETH_MODE==100||ETH_MODE==10))
            begin
            xon_gen <= 1'b 1;   
            end
         else
            begin
            xon_gen <= 1'b 0;   
            end
         end       
       
         
      end
   end  
                        
   
//  Total (Including Collision) Frames
//  ----------------------------------
always @(posedge reset or posedge tx_clk)
   begin : process_13
   if (reset == 1'b 1)
      begin
      tx_frm_all <= 0;  
      end
   else
      begin
      if (m_mgm_frm_rcvd == 1'b 1)
         begin
         tx_frm_all <= tx_frm_all + 1'b 1;  
         end
      end
   end
//  Expected signals: decide when we should expect something to happen
//  ------------------------------------------------------------------
always @(posedge rx_clk or posedge reset)
   begin : process_14
   if (reset == 1'b 1)
      begin
      expect1 <= 1'b 0; 
      expect2 <= 1'b 0; 
      end
   else
      begin
      if (gm_sop == 1'b 1 & expect2 == 1'b 0)
         begin
         expect2 <= 1'b 1;  //  immediately expect something
         expect1 <= 1'b 0;  //  and nothing else
         end
      else if (gm_sop == 1'b 1 )
         begin
         expect1 <= 1'b 1;  //  ok, when done later, immediately expect something else coming
         end
//  if a final event happend that indicates that something was received and
//  therefore some expected behaviour occured we can continue to watch
//  for new expected data
      if (pause_rcv == 1'b 1 | frm_type_err == 1'b 1 | 
    frm_align_err == 1'b 1 | ff_rx_eop == 1'b 1)
         begin
//  was: rx_stat_wren
         if (frm_align_err == 1'b 1 & expect1 == 1'b 1)
            begin
//  overlapped frame has an alignment error, but before the last frame
//  has been checked... so we have to do special things here
//  see alignment error checking behaviour.
            expect1 <= 1'b 0;   //  clear it, as it is processed now already
            end
         else
            begin
            expect2 <= 1'b 0;   //  pulse for at least 1 cycle    
            end
         end
//  if a new expectation was already inserted before we were done with the old, 
//  immediately restart it now as we have processed the last expected (2)
      if (expect1 == 1'b 1 & expect2 == 1'b 0)
         begin
//  there is something to expect !
         expect1 <= 1'b 0;  
         expect2 <= 1'b 1;  
         end
      end
   end

//  FIFO INTERFACE receive statistics counters
//  --------------------------------
always @(posedge ff_rx_clk or posedge reset)
   begin : process_17
   if (reset == 1'b 1)
      begin
      rxframe_cnt  <= 0;
      rx_good_rcvd <= 0;    
      rx_payload_err_rcvd <= 0; 
      rx_wrong_status_rcvd <= 0;    
      rx_length_err_rcvd <= 0;  
      rx_crc_err_rcvd <= 0; 
      rx_fifo_overflow_rcvd <= 0;   
      rx_gmii_err_rcvd <= 0;    
      rx_vlan_rcvd <= 0;
      rx_stack_vlan_rcvd <= 0;  
      rx_broadcast_rcvd <= 0;   
      rx_wrong_mac_rcvd <= 0;   
      rx_multicast_rcvd <= 0;   
      rx_non_discard_rcvd <= 0; 
      last_err_stat <= {4{1'b 0}};  
      ff_last_length <= {16{1'b 0}};    
      rx_length_mismatch_rcvd <= 0; 
      ff_frmlen <= 0;
      mff_dst_reg <= {48{1'b 0}} ;
      mff_payload_err_reg <= 1'b 0 ;
      mff_end_err_reg <= 1'b0 ; 
      end
   else
      begin
      
        mff_dst_reg <= mff_dst ;
        mff_payload_err_reg <= mff_payload_err ;
        mff_end_err_reg <= mff_end_err ;

//        if (ff_rx_eop == 1'b1)

        if (ff_rx_eop == 1'b 1 & mff_is_pause == 1'b 0 & ENABLE_ENA == 8|
           ff_rx_eop == 1'b 1 & mff_is_pause == 1'b 0 & ff_rx_dval == 1'b1 & (ff_rx_rdy == 1'b1 & MAX_CHANNELS > 0) )
        rxframe_cnt <= rxframe_cnt + 1;
      
//  count number of bytes received for the frame
      if (ff_rx_sop == 1'b 1)
         begin
         ff_frmlen <= 1;    
         end
      else if (ff_rx_dval == 1'b 1 )
         begin
         ff_frmlen <= ff_frmlen + 1'b 1;    
         end
      if (mff_frm_rcvd == 1'b 1 && mff_end_err_reg==1'b 0 && TB_MACPADEN==1'b1)
         begin
         mff_rxcnt <= mff_rxcnt + 1'b 1;    
         if (mff_payload_err_reg == 1'b 1)
            begin
            rx_payload_err_rcvd <= rx_payload_err_rcvd + 1'b 1; 
            end
          //  verify that the status word length field really matches what we find in
          //  the frame.
         if (mff_len != ff_last_length & mff_is_pause == 1'b 0)
            begin
            rx_length_mismatch_rcvd <= rx_length_mismatch_rcvd + 1'b 1; 
            end
         if (last_err_stat == 4'b 0000)
            begin
            
            
                if(mff_dst_reg==48'hFFFFFFFFFFFF)
                begin
                
                        rx_broadcast_rcvd <= rx_broadcast_rcvd+1;
                        
                end
                
                   if (ENABLE_SUP_ADDR)
                     begin
                        if(mff_dst_reg[0]==1'b0 & mac_addr != mff_dst_reg & sup_mac_addr_0 != mff_dst_reg & 
                           sup_mac_addr_1 != mff_dst_reg & sup_mac_addr_2 != mff_dst_reg & sup_mac_addr_3 != mff_dst_reg)
                        begin
            
                                rx_wrong_mac_rcvd <= rx_wrong_mac_rcvd+1'b1;     
                
                        end
                        else if(mff_dst_reg[0]==1'b1 & mff_is_pause==1'b0 & mff_dst_reg!=48'hFFFFFFFFFFFF)
                        begin
                
                                rx_multicast_rcvd <= rx_multicast_rcvd + 1'b1;
                
                        end
                    end    
                   else
                    begin
                        if (mff_dst_reg[0]==1'b0 & (mac_addr != mff_dst_reg) )
                        begin
            
                                rx_wrong_mac_rcvd <= rx_wrong_mac_rcvd+1'b1;     
                
                        end
                        else if(mff_dst_reg[0]==1'b1 & mff_is_pause==1'b0 & mff_dst_reg!=48'hFFFFFFFFFFFF)
                        begin
                
                                rx_multicast_rcvd <= rx_multicast_rcvd + 1;
                
                        end
                        
                   end
               
            end
         end
       else if (mff_frm_rcvd == 1'b 1 && TB_MACPADEN==1'b0)
         begin
         mff_rxcnt <= mff_rxcnt + 1'b 1;
         

                        if(mff_dst_reg==48'hFFFFFFFFFFFF)
                        begin
                    
                                rx_broadcast_rcvd <= rx_broadcast_rcvd+1'b1;
    
                        end
                                                
                        if (ENABLE_SUP_ADDR)
                         begin   
                                if(mff_dst_reg[0]==1'b0 & (mac_addr != mff_dst_reg))
                                begin
                                            
                                        rx_wrong_mac_rcvd <= rx_wrong_mac_rcvd+1'b1;     
                    
                                end
                                else if(mff_dst_reg[0]==1'b1 & mff_is_pause==1'b0 & mff_dst_reg!=48'hFFFFFFFFFFFF)
                                begin
                
                                        rx_multicast_rcvd <= rx_multicast_rcvd + 1'b1;
                
                                end
                         end       
                        else
                         begin                        
                                if(mff_dst_reg[0]==1'b0 & mac_addr != mff_dst_reg & sup_mac_addr_0 != mff_dst_reg & 
                                   sup_mac_addr_1 != mff_dst_reg & sup_mac_addr_2 != mff_dst_reg & sup_mac_addr_3 != mff_dst_reg)
                                begin
            
                                        rx_wrong_mac_rcvd <= rx_wrong_mac_rcvd+1'b1;     
                    
                                end
                                else if(mff_dst_reg[0]==1'b1 & mff_is_pause==1'b0 & mff_dst_reg!=48'hFFFFFFFFFFFF)
                                begin
                
                                        rx_multicast_rcvd <= rx_multicast_rcvd + 1'b1;
                
                                end
                                
                         end                       
                  
         
         end         
         
//  now check reception of good frames on FIFO interface
//  (we have no Preamble and CRC there, so do not check these errors on the MFF status)
      if (ff_rx_eop == 1'b 1 & mff_is_pause == 1'b 0 & ENABLE_ENA == 8|
           ff_rx_eop == 1'b 1 & mff_is_pause == 1'b 0 & ff_rx_dval == 1'b1 & (ff_rx_rdy == 1'b1 & MAX_CHANNELS > 0) )
         begin
//  good frames should come out
         rx_non_discard_rcvd <= rx_non_discard_rcvd + 1'b 1;    
         end
      if (ff_rx_eop == 1'b 1 & mff_is_pause == 1'b 0 & ENABLE_ENA == 8 |
          ff_rx_eop == 1'b 1 & mff_is_pause == 1'b 0 & ff_rx_dval == 1'b1 & (ff_rx_rdy == 1'b1 & MAX_CHANNELS > 0))
         begin
//  good frames should come out
//  remember the length as it was given from the FIFO
         ff_last_length <= ff_rx_err_stat[20:5];    
         rx_non_discard_rcvd <= rx_non_discard_rcvd + 1'b 1;    
         last_err_stat[3:0] <= ff_rx_err_stat[3:0]; //  save it for the monitor checks
         if (ff_rx_err_stat[3:0] == 0 & mff_is_pause == 1'b 0)
            begin
            rx_good_rcvd <= rx_good_rcvd + 1'b 1;   
            
            if (ff_rx_err_stat[4] == 1'b 1 & ff_rx_err_stat[22]== 1'b0)
               begin
               rx_vlan_rcvd <= rx_vlan_rcvd + 1'b 1;    
               end
            
            
            if (ff_rx_err_stat[4] == 1'b 1 & ff_rx_err_stat[22] == 1'b 1)
               begin
               rx_stack_vlan_rcvd <= rx_stack_vlan_rcvd + 1'b 1;    
               end            
            end
         else if (mff_is_pause == 1'b 0 )
            begin
//  some error occured
            rx_wrong_status_rcvd <= rx_wrong_status_rcvd + 1'b 1;   
            if (ff_rx_err_stat[0] == 1'b 1)
               begin
               rx_length_err_rcvd <= rx_length_err_rcvd + 1'b 1;    
               end
            else if (ff_rx_err_stat[1] == 1'b 1 )
               begin
               rx_crc_err_rcvd <= rx_crc_err_rcvd + 1'b 1;  
               end
            if (ff_rx_err_stat[2] == 1'b 1)
               begin
               rx_fifo_overflow_rcvd <= rx_fifo_overflow_rcvd + 1'b 1;  
               end
            if (ff_rx_err_stat[3] == 1'b 1)
               begin
               rx_gmii_err_rcvd <= rx_gmii_err_rcvd + 1'b 1;    
               end
            end
         end
      end
   end
assign promis_en = TB_PROMIS_ENA ? 1'b 1 : 1'b 0; 

//  Number of Received Pause Frames
//  -------------------------------
always @(posedge reset or posedge reg_clk)
   begin : process_19
   if (reset == 1'b 1)
      begin
      rx_pause_rcvd <= 0;   
      end
   else
      begin
      if (re_read_ena==1'b0 & state == stm_typ_rd_pause_rx & reg_busy == 1'b 0)
         begin
         rx_pause_rcvd <= reg_data_out; 
         end
      end
   end

//  Frames that should be discarded
//  -----------------------------------------------------
always @(posedge rx_clk or posedge reset)
   begin : process_21
   if (reset == 1'b 1)
      begin
      rx_discard_sent <= 0; 
      rx_discard_rcvd <= 0; 
      end
   else
      begin
      if (ff_tx_sop == 1'b 1)
         begin

         if (ff_dst[0] == 1'b 0 & ff_dst != mac_addr & ff_dst!=sup_mac_addr_0 & ff_dst!=sup_mac_addr_1 & 
             ff_dst!=sup_mac_addr_2 & ff_dst!=sup_mac_addr_3 & promis_en == 1'b 0 | 
             ff_dst[0] == 1'b 1 & multicast_wrong & ff_pause_gen == 1'b 0 & promis_en == 1'b 0 & ff_dst != 48'h FFFFFFFFFFFF | 
             ff_prmbl_err == 1'b 1 | 
             ff_pause_gen == 1'b 1) 
begin
            rx_discard_sent <= rx_discard_sent + 1'b 1; 
            end
         end
      rx_discard_rcvd <= rxframe_cnt - rx_non_discard_rcvd; 
      end
   end
//  Block RX FIFO reading
//  ---------------------
assign ff_rx_rdy = stop_rx_fifo_read == 1'b 1 & rx_hold_cnt < TB_HOLDREAD & 
    ff_rx_dval == 1'b 0 ? 1'b 0 : 
    1'b 1; 
always @(posedge ff_rx_clk or posedge reset)
   begin : process_22
   if (reset == 1'b 1)
      begin
      stop_rx_fifo_read <= 1'b 0;   
      rx_hold_cnt <= 0; 
      rx_fifo_cnt <= 0; 
      end
   else
      begin
      if (ff_rx_sop == 1'b 1)
         begin
         rx_fifo_cnt <= rx_fifo_cnt + 1'b 1;    //  count each Frame read from the FIFO
         end
      if (TB_STOPREAD != 0 & TB_STOPREAD < rx_fifo_cnt & 
    stop_rx_fifo_read == 1'b 0)
         begin
         stop_rx_fifo_read <= 1'b 1;    
         end
      if (stop_rx_fifo_read == 1'b 1 & rx_hold_cnt < TB_HOLDREAD)
         begin
         rx_hold_cnt <= rx_hold_cnt + 1'b 1;    
         end
      end
   end
//  END RX 

// ---------------------- //
//  Control State Machine //
//  --------------------- //

always@(posedge reset or posedge reg_clk)
begin

        if (reset==1'b1)
        begin
                
                reg_busy_reg <= 1'b0 ;
                
        end
        else
        
                reg_busy_reg <= reg_busy ;
                
        end
        
always @(posedge reset or posedge reg_clk)
   begin : process_23
   if (reset == 1'b 1)
      begin
      state <= stm_typ_idle;    
      end
   else
      begin
      state <= nextstate;   
      end
   end

//---------------------------------------
always @(state or 
         sim_start or 
         reg_busy or 
         reg_busy_reg or 
         lut_prog_cnt or 
         txsim_done or 
         ff_rx_dsav or 
         gm_tx_en or 
         sim_cnt_end or
         led_link )
//---------------------------------------
begin : process_24
   case (state)
   stm_typ_idle:
      begin
      if (sim_start==1'b1)
      begin
         nextstate <= stm_typ_pcs_read_ver; 
      end
      else
       begin
         nextstate   <= stm_typ_idle ;
         re_read_ena <= 1'b0;
         reg_iteration = 0;
       end
      end 

   // PCS related

   stm_typ_pcs_read_ver:
    begin
    if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
       begin
       nextstate <= stm_typ_pcs_wr_scratch;   
       end
    else
       begin
       nextstate <= stm_typ_pcs_read_ver;   
       end
    end
   stm_typ_pcs_wr_scratch:
    begin
    if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
       begin
       nextstate <= stm_typ_pcs_rd_scratch;   
       end
    else
       begin
       nextstate <= stm_typ_pcs_wr_scratch;   
       end
    end
   stm_typ_pcs_rd_scratch:
    begin
    if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
       begin
       nextstate <= stm_typ_pcs_if_control;   
       end
    else
       begin
       nextstate <= stm_typ_pcs_rd_scratch;   
       end
    end
   stm_typ_pcs_if_control:
    begin
    if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
       begin
       nextstate <= stm_typ_pcs_wait_link; 
       end
    else
       begin
       nextstate <= stm_typ_pcs_if_control;   
       end
    end
   stm_typ_pcs_wait_link:
    begin
    if (led_link == 1'b 1)
       begin
       nextstate <= stm_typ_pcs_read_phy_control;   
       end
    else
       begin
       nextstate <= stm_typ_pcs_wait_link;   
       end
    end
   stm_typ_pcs_read_phy_control:
    begin
    if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
       begin
       nextstate <= stm_typ_pcs_read_sync_status;   
       end
    else
       begin
       nextstate <= stm_typ_pcs_read_phy_control;   
       end
    end
   stm_typ_pcs_read_sync_status:
    begin
    if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
       begin
       if (TB_ENA_AUTONEG)
          begin
          nextstate <= stm_typ_pcs_prog_ability;   
          end
       else
          begin
          nextstate <= stm_typ_pcs_autoneg_disable;   
          end
       end
    else
       begin
       nextstate <= stm_typ_pcs_read_sync_status;   
       end
    end
   stm_typ_pcs_autoneg_disable:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
             if (ENABLE_ENA == 8)
              begin
                nextstate <= stm_typ_read_ver;  
              end
             else
              begin //multi-port fifoless
                 reg_iteration = reg_iteration + 1'b1;
                 if (MAX_CHANNELS == reg_iteration)
                  begin
                   nextstate <= stm_typ_read_ver;
                   reg_iteration = 0;
                  end
                 else
                   nextstate <= stm_typ_pcs_autoneg_disable;
               end
           end
          else
         begin
         nextstate <= stm_typ_pcs_autoneg_disable;   
         end
      end

   // MAC related
   stm_typ_read_ver:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_wr_scratch;   
         end
      else
         begin
         nextstate <= stm_typ_read_ver; 
         end
      end
   stm_typ_wr_scratch:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_rd_scratch;   
         end
      else
         begin
         nextstate <= stm_typ_wr_scratch;   
         end
      end
   stm_typ_rd_scratch:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_mac_config;   
         end
      else
         begin
         nextstate <= stm_typ_rd_scratch;   
         end
      end
   stm_typ_mac_config:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
             if (ENABLE_ENA == 8)
              begin
         nextstate <= stm_typ_wr_mac1;  
         end
      else
              begin //multi-port fifoless
                 reg_iteration = reg_iteration + 1'b1;
                 if (MAX_CHANNELS == reg_iteration)
                  begin
                   nextstate <= stm_typ_sim;
                  end
                 else
                  begin
                   nextstate <= stm_typ_mac_config;
                  end

              end
           end
          else
         begin
         nextstate <= stm_typ_mac_config;   
         end
      end
   stm_typ_wr_mac1:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_wr_mac2;  
         end
      else
         begin
         nextstate <= stm_typ_wr_mac1;  
         end
      end
   stm_typ_wr_mac2:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_wr_ipg_len;   
         end
      else
         begin
         nextstate <= stm_typ_wr_mac2;  
         end
      end
   stm_typ_wr_ipg_len:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_wr_frm_length;    
         end
      else
         begin
         nextstate <= stm_typ_wr_ipg_len;   
         end
      end
   stm_typ_wr_frm_length:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_wr_pause_quanta;  
         end
      else
         begin
         nextstate <= stm_typ_wr_frm_length;    
         end
      end
   stm_typ_wr_pause_quanta:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_wr_rx_se; 
         end
      else
         begin
         nextstate <= stm_typ_wr_pause_quanta;  
         end
      end
   stm_typ_wr_rx_se:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_wr_rx_sf; 
         end
      else
         begin
         nextstate <= stm_typ_wr_rx_se; 
         end
      end
   stm_typ_wr_rx_sf:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_wr_tx_se; 
         end
      else
         begin
         nextstate <= stm_typ_wr_rx_sf; 
         end
      end
   stm_typ_wr_tx_se:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_wr_tx_sf; 
         end
      else
         begin
         nextstate <= stm_typ_wr_tx_se; 
         end
      end
   stm_typ_wr_tx_sf:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_wr_rx_ae; 
         end
      else
         begin
         nextstate <= stm_typ_wr_tx_sf; 
         end
      end
   stm_typ_wr_rx_ae:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_wr_rx_af; 
         end
      else
         begin
         nextstate <= stm_typ_wr_rx_ae; 
         end
      end
   stm_typ_wr_rx_af:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_wr_tx_ae; 
         end
      else
         begin
         nextstate <= stm_typ_wr_rx_af; 
         end
      end
   stm_typ_wr_tx_ae:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_wr_tx_af; 
         end
      else
         begin
         nextstate <= stm_typ_wr_tx_ae; 
         end
      end
   stm_typ_wr_tx_af:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
           if (TB_MDIO_SIMULATION==1'b1 && ENABLE_MDIO==1'b1)
           begin
             nextstate <= stm_typ_wr_mdio_addr1;
           end
           else
           begin
             nextstate <= stm_typ_lut_prog; 
         end
         end
      else
         begin
         nextstate <= stm_typ_wr_tx_af; 
         end
      end
   stm_typ_wr_mdio_addr1:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_write_mdio1;  
         end
      else
         begin
         nextstate <= stm_typ_wr_mdio_addr1;    
         end
      end      
   stm_typ_write_mdio1:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_read_mdio1;   
         end
      else
         begin
         nextstate <= stm_typ_write_mdio1;  
         end
      end
   stm_typ_read_mdio1:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_lut_prog; 
         end
      else
         begin
         nextstate <= stm_typ_read_mdio1;   
         end
      end
   stm_typ_lut_prog_inc:
      begin
      if (lut_prog_cnt == MCAST_TABLEN)
         begin
         
           if (ENABLE_SUP_ADDR)
         
                nextstate <= stm_typ_wr_sup_mac0_0 ;
                
           else        
         
                nextstate <= stm_typ_sim;   
                
           
           
         end
      else
         begin
         nextstate <= stm_typ_lut_prog; 
         end
      end
   stm_typ_lut_prog:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_lut_prog_inc; 
         end
      else
         begin
         nextstate <= stm_typ_lut_prog; 
         end
      end
      
   stm_typ_wr_sup_mac0_0:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_wr_sup_mac0_1;    
         end
      else
         begin
         nextstate <= stm_typ_wr_sup_mac0_0;    
         end
      end      
      
   stm_typ_wr_sup_mac0_1:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_wr_sup_mac1_0;    
         end
      else
         begin
         nextstate <= stm_typ_wr_sup_mac0_1;    
         end
      end   
      
   stm_typ_wr_sup_mac1_0:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_wr_sup_mac1_1;    
         end
      else
         begin
         nextstate <= stm_typ_wr_sup_mac1_0;    
         end
      end  
      
   stm_typ_wr_sup_mac1_1:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_wr_sup_mac2_0;    
         end
      else
         begin
         nextstate <= stm_typ_wr_sup_mac1_1;    
         end
      end 
      
   stm_typ_wr_sup_mac2_0:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_wr_sup_mac2_1;    
         end
      else
         begin
         nextstate <= stm_typ_wr_sup_mac2_0;    
         end
      end
      
   stm_typ_wr_sup_mac2_1:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_wr_sup_mac3_0;    
         end
      else
         begin
         nextstate <= stm_typ_wr_sup_mac2_1;    
         end
      end
      
   stm_typ_wr_sup_mac3_0:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_wr_sup_mac3_1;    
         end
      else
         begin
         nextstate <= stm_typ_wr_sup_mac3_0;    
         end
      end
      
   stm_typ_wr_sup_mac3_1:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_sim;  
         end
      else
         begin
         nextstate <= stm_typ_wr_sup_mac3_1;    
         end
      end
      
   stm_typ_sim:
      begin
      if (txsim_done == 1'b 1 & ff_rx_dsav != 1'b 1 )

         begin
         nextstate <= stm_typ_end_sim_wait; 
         end
      else
         begin
         nextstate <= stm_typ_sim;  
         end
      end
   stm_typ_end_sim_wait:
      begin
      if (sim_cnt_end > 1000)
         begin
            nextstate <= stm_typ_rd_pause_rx;
         end
      else
         begin
            nextstate <= stm_typ_end_sim_wait;
         end
      end
      
// Reading Statistic Registers
// ---------------------------

   stm_typ_rd_pause_rx:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
                if (STAT_CNT_ENA==1'b1)
                begin        
                        nextstate <= stm_typ_rd_frm_tx; 
                end
                else
                begin
                        nextstate <= stm_typ_end_sim;
                        
                end                
         end
      else
         begin
         nextstate <= stm_typ_rd_pause_rx;  
         end
      end             
   stm_typ_rd_frm_tx:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_rd_frm_rx;    
         end
      else
         begin
         nextstate <= stm_typ_rd_frm_tx;    
         end
      end
   stm_typ_rd_frm_rx:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_rd_crc_err;   
         end
      else
         begin
         nextstate <= stm_typ_rd_frm_rx;    
         end
      end      
   stm_typ_rd_crc_err:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_rd_tx_octets; 
         end
      else
         begin
         nextstate <= stm_typ_rd_crc_err;   
         end
      end  
   stm_typ_rd_tx_octets:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_rd_rx_octets; 
         end
      else
         begin
         nextstate <= stm_typ_rd_tx_octets; 
         end
      end              
   stm_typ_rd_rx_octets:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_rd_align_err; 
         end
      else
         begin
         nextstate <= stm_typ_rd_rx_octets; 
         end
      end       
   stm_typ_rd_align_err:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_rd_pause_tx;  
         end
      else
         begin
         nextstate <= stm_typ_rd_align_err; 
         end
      end  
   stm_typ_rd_pause_tx:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_rx_unicast;   
         end
      else
         begin
         nextstate <= stm_typ_rd_pause_tx;  
         end
      end 
   stm_typ_rx_unicast:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_rx_mltcast;   
         end
      else
         begin
         nextstate <= stm_typ_rx_unicast;   
         end
      end 
   stm_typ_rx_mltcast:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_rx_brdcast;   
         end
      else
         begin
         nextstate <= stm_typ_rx_mltcast;   
         end
      end    
   stm_typ_rx_brdcast:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_tx_frm_discard;   
         end
      else
         begin
         nextstate <= stm_typ_rx_brdcast;   
         end
      end 
   stm_typ_tx_frm_discard:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_tx_unicast;   
         end
      else
         begin
         nextstate <= stm_typ_tx_frm_discard;   
         end
      end  
   stm_typ_tx_unicast:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_tx_mltcast;   
         end
      else
         begin
         nextstate <= stm_typ_tx_unicast;   
         end
      end 
   stm_typ_tx_mltcast:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_tx_brdcast;   
         end
      else
         begin
         nextstate <= stm_typ_tx_mltcast;   
         end
      end 
   stm_typ_tx_brdcast:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_rx_frm_err;   
         end
      else
         begin
         nextstate <= stm_typ_tx_brdcast;   
         end
      end 
   stm_typ_rx_frm_err:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_tx_frm_err;   
         end
      else
         begin
         nextstate <= stm_typ_rx_frm_err;   
         end
      end 
   stm_typ_tx_frm_err:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_rx_frm_drop;  
         end
      else
         begin
         nextstate <= stm_typ_tx_frm_err;   
         end
      end 
   stm_typ_rx_frm_drop:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_rx_undersz_frm;   
         end
      else
         begin
         nextstate <= stm_typ_rx_frm_drop;  
         end
      end 
   stm_typ_rx_undersz_frm:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_rx_oversz_frm;    
         end
      else
         begin
         nextstate <= stm_typ_rx_undersz_frm;   
         end
      end 
   stm_typ_rx_oversz_frm:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_rx_64_frm;    
         end
      else
         begin
         nextstate <= stm_typ_rx_oversz_frm;    
         end
      end
   stm_typ_rx_64_frm:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_rx_65_127_frm;    
         end
      else
         begin
         nextstate <= stm_typ_rx_64_frm;    
         end
      end 
   stm_typ_rx_65_127_frm:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_rx_128_255_frm;   
         end
      else
         begin
         nextstate <= stm_typ_rx_65_127_frm;    
         end
      end
   stm_typ_rx_128_255_frm:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_rx_256_511_frm;   
         end
      else
         begin
         nextstate <= stm_typ_rx_128_255_frm;   
         end
      end 
   stm_typ_rx_256_511_frm:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_rx_512_1023_frm;  
         end
      else
         begin
         nextstate <= stm_typ_rx_256_511_frm;   
         end
      end 
   stm_typ_rx_512_1023_frm:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_rx_1024_1518_frm; 
         end
      else
         begin
         nextstate <= stm_typ_rx_512_1023_frm;  
         end
      end  
   stm_typ_rx_1024_1518_frm:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_rx_1519_X_frm;    
         end
      else
         begin
         nextstate <= stm_typ_rx_1024_1518_frm; 
         end
      end  
   stm_typ_rx_1519_X_frm:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_rx_jabber;    
         end
      else
         begin
         nextstate <= stm_typ_rx_1519_X_frm;    
         end
      end  
   stm_typ_rx_jabber:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         nextstate <= stm_typ_rx_fragment;  
         end
      else
         begin
         nextstate <= stm_typ_rx_jabber;    
         end
      end 
   stm_typ_rx_fragment:
      begin
      if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
                
                if (re_read_ena==1'b1)
                begin
                
                        nextstate <= stm_typ_rd_sw_reset ;
                        
                end
                else
                begin
                
                        nextstate   <= stm_typ_sw_reset ;
                        re_read_ena <= 1'b1 ;
                        
                end                         
         end
      else
         begin
         nextstate <= stm_typ_rx_fragment;  
         end
      end  
      
   stm_typ_sw_reset:
   begin
   
        if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         
                nextstate <= stm_typ_wait_reg_clear ; //rd_pause_rx ;
                                        
         end
         else
         begin
         
                nextstate <= stm_typ_sw_reset;  
                
         end
         
   end 
   
   stm_typ_wait_reg_clear:
   begin
   
        if (sim_cnt_end>100)
        begin
        
                nextstate <= stm_typ_rd_pause_rx ;
                
        end
        else
        begin
                
                nextstate <= stm_typ_wait_reg_clear ;
                
        end
        
   end
   
   stm_typ_rd_sw_reset:
   begin
   
        if (reg_busy == 1'b 0 && reg_busy_reg == 1'b1)
         begin
         
                nextstate <= stm_typ_end_sim ;
                                        
         end
         else
         begin
         
                nextstate <= stm_typ_rd_sw_reset;   
                
         end
         
   end               
                       
   stm_typ_end_sim:
      begin
      nextstate <= stm_typ_end_sim; 
      end
   endcase
   end
   
// Delay End of Simulation
// -----------------------

always@(posedge reset or posedge reg_clk)
begin
        if (reset==1'b 1)
        begin
        
                sim_cnt_end <= 0 ;
                
        end
        else
        begin
        
                if (state==stm_typ_end_sim_wait || state==stm_typ_wait_reg_clear || state==stm_typ_end_sim)
                begin
        
                        sim_cnt_end <= sim_cnt_end+1'b1 ;
                        
                end
                else
                begin
                
                        sim_cnt_end <= 0 ;
                        
                end        
                
        end

end
   
//  LUT Table Address and PHY Port Counter
//  --------------------------------------

always @(posedge reset or posedge reg_clk)
   begin : process_25
   if (reset == 1'b 1)
      begin
      lut_prog_cnt     <= 0;
      end
   else
      begin
      if (nextstate == stm_typ_lut_prog_inc)
         begin
         
                lut_prog_cnt <= lut_prog_cnt + 1'b 1;   
         
         end

     end

end  
   
//  Register Interface
//  ------------------

always 
   begin : process_26
   reg_clk <= 1'b 1;    
   #( 10 ); 
   reg_clk <= 1'b 0;    
   #( 10 ); 
   end

always @(posedge reset or posedge reg_clk)
   begin : process_27
   if (reset == 1'b 1)
      begin
      reg_wr <= #(2)1'b 0;  
      reg_rd <= #(2)1'b 0;  
      reg_addr <= #(2) {8{1'b 0}};  
      reg_data_in <= #(2)  {32{1'b 0}}; 
      p_hash_hash_code <= {6{1'b 0}} ;  
      end
   else
      begin
      //PCS  registers programming

      if (nextstate == stm_typ_pcs_read_ver)
         begin
         reg_addr   <= #(2) 145;   
         reg_rd     <= #(2) 1'b 1;   
         reg_wr     <= #(2) 1'b 0;   
         reg_data_in<= #(2) {32{1'b 0}};   
         end
      else if (nextstate == stm_typ_pcs_if_control )
         begin
         reg_addr   <= #(2) 148;   

         reg_rd     <= #(2) 1'b 0;   
         reg_wr     <= #(2) 1'b 1;  
         reg_data_in[31:16]<= #(2) {16{1'b 0}};

          if (TB_SGMII_ENA==1'b1)
          begin
           reg_data_in[0] <= #(2) 1'b1;
          end
          else
          begin
           reg_data_in[0] <= #(2) 1'b0;
          end
          
          if (TB_SGMII_AUTO_CONF==1'b1)
          begin
           reg_data_in[1] <= #(2) 1'b1;
          end
          else
          begin
           reg_data_in[1] <= #(2) 1'b0;
          end
          
          if (TB_SGMII_AUTO_CONF==1'b1)
          begin
           reg_data_in[3:2] <= #(2) 2'b00;
          end         
          else if (TB_SGMII_1000==1'b1)
          begin
           reg_data_in[3:2] <= #(2) 2'b10;
          end
          else if (TB_SGMII_100==1'b1)
          begin
           reg_data_in[3:2] <= #(2) 2'b01;
          end
          else
          begin
           reg_data_in[3:2] <= #(2) 2'b00;
          end
          
          if (TB_SGMII_HD==1'b1)
          begin
           reg_data_in[4] <= #(2) 1'b1;
          end
          else
          begin
           reg_data_in[4] <= #(2) 1'b0;
          end
          
         reg_data_in[15:5]   <= #(2) 0;   
         end
      else if (nextstate == stm_typ_pcs_wr_scratch )
         begin
         reg_addr   <= #(2) 144;   
         reg_rd     <= #(2) 1'b 0;   
         reg_wr     <= #(2) 1'b 1;   
         reg_data_in[31:16]<= #(2) {16{1'b 0}};
         reg_data_in[15:0]<= #(2) 16'h AAAA;   
         end
      else if (nextstate == stm_typ_pcs_rd_scratch )
         begin
         reg_addr   <= #(2) 144;   
         reg_rd     <= #(2) 1'b 1;   
         reg_wr     <= #(2) 1'b 0;   
         reg_data_in<= #(2) {32{1'b 0}};   
         end
      else if (nextstate == stm_typ_pcs_read_sync_status | nextstate == stm_typ_pcs_read_status | 
         nextstate == stm_typ_pcs_read_status_2 )
         begin
         reg_addr   <= #(2) 129;   
         reg_rd     <= #(2) 1'b 1;   
         reg_wr     <= #(2) 1'b 0;   
         reg_data_in<= #(2) {32{1'b 0}};   
         end
      else if (nextstate == stm_typ_pcs_read_phy_control )
         begin
         reg_addr   <= #(2) 128;   
         reg_rd     <= #(2) 1'b 1;   
         reg_wr     <= #(2) 1'b 0;   
         reg_data_in<= #(2) {32{1'b 0}};
         end
      else if (nextstate == stm_typ_pcs_autoneg_disable )
         begin
         reg_addr   <= #(2) 128 + (12'h 100 * reg_iteration);   
         reg_rd     <= #(2) 1'b 0;   
         reg_wr     <= #(2) 1'b 1;   
         reg_data_in[31:16]<= #(2) {16{1'b 0}};
         reg_data_in<= #(2) 16'b 000000000000000;   
         end
      //MAC related
      else if (nextstate == stm_typ_read_ver)         
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 0;    
         reg_data_in <= #(2)  {32{1'b 0}};  
         end
      else if (nextstate == stm_typ_wr_scratch )
         begin
         reg_wr <= #(2)1'b 1;   
         reg_rd <= #(2) 1'b 0;  
         reg_addr <= #(2) 1;    
         reg_data_in <= #(2)  32'h AAAAAAAA;    
         end
      else if (nextstate == stm_typ_rd_scratch )
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 1;    
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_mac_config )
         begin
         reg_wr <= #(2)1'b 1;   
         reg_rd <= #(2) 1'b 0;  
         reg_addr <= #(2) 2 + (12'h 100 * reg_iteration);
         reg_data_in <= #(2)  32'h 00000000;  

         reg_data_in[0] <= #(2) 1'b 1;       // Enable MAC  
         reg_data_in[1] <= #(2) 1'b 1;       // Enable MAC  

//  XON_Gen
//  ---------
         reg_data_in[2] <= #(2) xon_gen;    


//  Speed Selection
//  ---------------
         if (ETH_MODE == 1000)
            begin
            reg_data_in[3] <= #(2) 1'b 1;   
            end
         else
            begin
            reg_data_in[3] <= #(2) 1'b 0;   
            end

//  Unicast Filtering
//  -----------------
         if (TB_PROMIS_ENA == 1'b1)
            begin
            reg_data_in[4] <= #(2) 1'b 1;   
            end
         else
            begin
            reg_data_in[4] <= #(2) 1'b 0;   
            end
//  Enable Padding
//  --------------
         if (TB_MACPADEN == 1'b1)
            begin
            reg_data_in[5] <= #(2) 1'b 1;   
            end
         else
            begin
            reg_data_in[5] <= #(2) 1'b 0;   
            end
//  CRC Forwarding Enable
//  ---------------------
         if (TB_MACFWD_CRC == 1'b1)
            begin
            reg_data_in[6] <= #(2) 1'b 1;   
            end
         else
            begin
            reg_data_in[6] <= #(2) 1'b 0;   
            end
//  Enable Pause Frame Forwarding
//  -----------------------------
         if (TB_MACFWD_PAUSE == 1'b1)
            begin
            reg_data_in[7] <= #(2) 1'b 1;   
            end
         else
            begin
            reg_data_in[7] <= #(2) 1'b 0;   
            end
//  Ignore Pause Frames
//  -------------------
         if (TB_MACIGNORE_PAUSE == 1'b1)
            begin
            reg_data_in[8] <= #(2) 1'b 1;   
            end
         else
            begin
            reg_data_in[8] <= #(2) 1'b 0;   
            end
//  Source MAC Address Insertion
//  ----------------------------
         if (TB_MACINSERT_ADDR == 1'b1 & ENABLE_MAC_TXADDR_SET ==1'b1)
            begin
            reg_data_in[9] <= #(2) 1'b 1;   
            end
         else
            begin
            reg_data_in[9] <= #(2) 1'b 0;   
            end
//  Enable Half Duplex
//  ------------------
                 if (HD_ENA == 1'b 1 && ENABLE_HD_LOGIC ==1'b1)
            begin
            reg_data_in[10] <= #(2) 1'b 1;  
            end
         else
            begin
            reg_data_in[10] <= #(2) 1'b 0;  
            end 
            
// Internal Loopback
// -----------------

   if (ENABLE_GMII_LOOPBACK)
     begin
         if (TB_RXFRAMES==0)
         begin
             
             reg_data_in[15] <= #(5) 1'b1;
             
         end
         else
         begin
        
                reg_data_in[15] <= #(5) 1'b0;  
                
         end      
     end        
   else
             
             
     
             reg_data_in[15] <= #(5) 1'b0;
             

             
     
// Source MAC Address Selection 
// ----------------------------          

 
     if (ENABLE_SUP_ADDR)
             reg_data_in[18:16] <= #(5) TB_ADDR_SEL;
     else
             reg_data_in[18:16] <= #(5) 3'b000;
             
                        
         // Magic Packet Enable
        //  ---------
            if (ENABLE_MAGIC_DETECT==1'b1) 
                reg_data_in[19] <= #(2) 1'b 1; 
            else
                    reg_data_in[19] <= #(2) 1'b 0;



//  XOFF_Gen
//  ---------
         reg_data_in[22] <= #(2) xoff_gen;  
        
        // 10Mbps Speed Selection
        //  ---------
            if (ETH_MODE == 10)
                   reg_data_in[25] <= #(2) 1'b 1;
            else
                   reg_data_in[25] <= #(2) 1'b 0;

    // Discard any errored in received frames
        //  ---------
            if (TB_MACRX_ERR_DISC == 1)
                   reg_data_in[26] <= #(2) 1'b 1;
            else
                   reg_data_in[26] <= #(2) 1'b 0;
    

    end 
         
      else if (nextstate == stm_typ_wr_mac1 )
         begin
         reg_wr <= #(2)1'b 1;   
         reg_rd <= #(2) 1'b 0;  
         reg_addr <= #(2) 3;    
         reg_data_in <= #(2)  mac_addr[31:0];   
         end
      else if (nextstate == stm_typ_wr_mac2 )
         begin
         reg_wr <= #(2)1'b 1;   
         reg_rd <= #(2) 1'b 0;  
         reg_addr <= #(2) 4;    
         reg_data_in[15:0]  <= #(2) mac_addr[47:32];    
         reg_data_in[31:16] <= #(2) {16{1'b 0}};    
         end
         
      else if (nextstate == stm_typ_wr_ipg_len)
         begin
         reg_wr <= #(2)1'b 1;   
         reg_rd <= #(2) 1'b 0;  
         reg_addr <= #(2) 23;   
         reg_data_in <= #(2) TB_IPG_LENGTH; 
         end
         
      else if (nextstate==stm_typ_wr_sup_mac0_0)
      begin
      
         reg_wr      <= #(2)1'b 1;  
         reg_rd      <= #(2) 1'b 0; 
         reg_addr    <= #(2) 192;   
         reg_data_in <= #(2) sup_mac_addr_0[31:0];           
         
      end
      
      else if (nextstate==stm_typ_wr_sup_mac0_1)
      begin
      
         reg_wr             <= #(2)1'b 1;   
         reg_rd             <= #(2) 1'b 0;  
         reg_addr           <= #(2) 193;    
         reg_data_in[15:0]  <= #(2) sup_mac_addr_0[47:32];
         reg_data_in[31:16] <= #(2) {16{1'b 0}};             
         
      end
      
      else if (nextstate==stm_typ_wr_sup_mac1_0)
      begin
      
         reg_wr      <= #(2)1'b 1;  
         reg_rd      <= #(2) 1'b 0; 
         reg_addr    <= #(2) 194;   
         reg_data_in <= #(2) sup_mac_addr_1[31:0];           
         
      end
      
      else if (nextstate==stm_typ_wr_sup_mac1_1)
      begin
      
         reg_wr             <= #(2)1'b 1;   
         reg_rd             <= #(2) 1'b 0;  
         reg_addr           <= #(2) 195;    
         reg_data_in[15:0]  <= #(2) sup_mac_addr_1[47:32];
         reg_data_in[31:16] <= #(2) {16{1'b 0}};             
         
      end
      
      else if (nextstate==stm_typ_wr_sup_mac2_0)
      begin
      
         reg_wr      <= #(2)1'b 1;  
         reg_rd      <= #(2) 1'b 0; 
         reg_addr    <= #(2) 196;   
         reg_data_in <= #(2) sup_mac_addr_2[31:0];           
         
      end
      
      else if (nextstate==stm_typ_wr_sup_mac2_1)
      begin
      
         reg_wr             <= #(2)1'b 1;   
         reg_rd             <= #(2) 1'b 0;  
         reg_addr           <= #(2) 197;    
         reg_data_in[15:0]  <= #(2) sup_mac_addr_2[47:32];
         reg_data_in[31:16] <= #(2) {16{1'b 0}};             
         
      end
      
      else if (nextstate==stm_typ_wr_sup_mac3_0)
      begin
      
         reg_wr      <= #(2)1'b 1;  
         reg_rd      <= #(2) 1'b 0; 
         reg_addr    <= #(2) 198;   
         reg_data_in <= #(2) sup_mac_addr_3[31:0];           
         
      end
      
      else if (nextstate==stm_typ_wr_sup_mac3_1)
      begin
      
         reg_wr             <= #(2)1'b 1;   
         reg_rd             <= #(2) 1'b 0;  
         reg_addr           <= #(2) 199;    
         reg_data_in[15:0]  <= #(2) sup_mac_addr_3[47:32];
         reg_data_in[31:16] <= #(2) {16{1'b 0}};
                  
      end
         
      else if (nextstate == stm_typ_wr_frm_length )
         begin
         reg_wr <= #(2)1'b 1;   
         reg_rd <= #(2) 1'b 0;  
         reg_addr <= #(2) 5;    
         reg_data_in[15:0]  <= #(2) TB_MACLENMAX;   
         reg_data_in[31:16] <= #(2) {16{1'b 0}};    
         end
      else if (nextstate == stm_typ_wr_pause_quanta )
         begin
         reg_wr <= #(2)1'b 1;   
         reg_rd <= #(2) 1'b 0;  
         reg_addr <= #(2) 6;    
         reg_data_in[15:0]  <= #(2) TB_MACPAUSEQ;   
         reg_data_in[31:16] <= #(2) {16{1'b 0}};    
         end
      
      else if (nextstate == stm_typ_wr_rx_se )
         begin
         reg_wr <= #(2)1'b 1;   
         reg_rd <= #(2) 1'b 0;  
         reg_addr <= #(2) 7;    
         reg_data_in[ING_ADDR-1:0] <= #(2) RX_FIFO_SECTION_EMPTY ;   
         reg_data_in[31:ING_ADDR]  <= #(2) 0;
         end
      else if (nextstate == stm_typ_wr_rx_sf )
         begin
         reg_wr <= #(2)1'b 1;   
         reg_rd <= #(2) 1'b 0;  
         reg_addr <= #(2) 8;    
         reg_data_in[ING_ADDR-1:0] <= #(2) RX_FIFO_SECTION_FULL ;    
         reg_data_in[31:ING_ADDR]  <= #(2) 0 ;  
         end
      else if (nextstate == stm_typ_wr_tx_se )
         begin
         reg_wr <= #(2)1'b 1;   
         reg_rd <= #(2) 1'b 0;  
         reg_addr <= #(2) 9;    
         reg_data_in[EG_ADDR-1:0] <= #(2) TX_FIFO_SECTION_EMPTY ;    
         reg_data_in[31:EG_ADDR]  <= #(2) 0 ;   
         end
      else if (nextstate == stm_typ_wr_tx_sf )
         begin
         reg_wr <= #(2)1'b 1;   
         reg_rd <= #(2) 1'b 0;  
         reg_addr <= #(2) 10;   
         reg_data_in[EG_ADDR-1:0] <= #(2) TX_FIFO_SECTION_FULL ; 
         reg_data_in[31:EG_ADDR]  <= #(2) 0 ;   
         end
      else if (nextstate == stm_typ_wr_rx_ae )
         begin
         reg_wr <= #(2)1'b 1;   
         reg_rd <= #(2) 1'b 0;  
         reg_addr <= #(2) 11;   
         reg_data_in[ING_ADDR-1:0] <= #(2) RX_FIFO_AE ;  
         reg_data_in[31:ING_ADDR]  <= #(2) 0 ;  
         end
      else if (nextstate == stm_typ_wr_rx_af )
         begin
         reg_wr <= #(2)1'b 1;   
         reg_rd <= #(2) 1'b 0;  
         reg_addr <= #(2) 12;   
         reg_data_in[ING_ADDR-1:0] <= #(2) RX_FIFO_AF ;  
         reg_data_in[31:ING_ADDR]  <= #(2) 0 ;  
         end
      else if (nextstate == stm_typ_wr_tx_ae )
         begin
         reg_wr <= #(2)1'b 1;   
         reg_rd <= #(2) 1'b 0;  
         reg_addr <= #(2) 13;   
         reg_data_in[EG_ADDR-1:0] <= #(2) TX_FIFO_AE ;   
         reg_data_in[31:EG_ADDR]  <= #(2) 0 ;   
         end
      else if (nextstate == stm_typ_wr_tx_af )
         begin
         reg_wr <= #(2)1'b 1;   
         reg_rd <= #(2) 1'b 0;  
         reg_addr <= #(2) 14;   
         reg_data_in[EG_ADDR-1:0] <= #(2) TX_FIFO_AF ;   
         reg_data_in[31:EG_ADDR]  <= #(2) 0 ;   
         end         
       else if (nextstate == stm_typ_wr_mdio_addr1 )
          begin
          reg_wr <= #(2)1'b 1;   
          reg_rd <= #(2) 1'b 0;  
          reg_addr <= #(2) 16;   
          reg_data_in[4:0]  <= #(2) TB_MDIO_ADDR1;   
          reg_data_in[31:5] <= #(2) {27{1'b 0}}; 
          end         
       else if (nextstate == stm_typ_write_mdio1 )
          begin
          reg_wr <= #(2)1'b 1;   
          reg_rd <= #(2) 1'b 0;  
          reg_addr <= #(2) 160;  
          reg_data_in <= #(2) 32'h 55555555; 
          end
       else if (nextstate == stm_typ_read_mdio1 )
          begin
          reg_wr <= #(2)1'b 0;   
          reg_rd <= #(2) 1'b 1;  
          reg_addr <= #(2) 160;  //PHY identifier
          reg_data_in <= #(2) 32'h 00000000; 
          end
      else if (nextstate == stm_typ_lut_prog )
         begin
         
                case (lut_prog_cnt)
                
                        0:
                                begin
                                p_hash_mcast_addr = MCAST_ADDRESSLIST[47:0];
                                end
                        1:
                                begin
                                p_hash_mcast_addr = MCAST_ADDRESSLIST[48+47:48];
                                end
                        2:
                                begin
                                p_hash_mcast_addr = MCAST_ADDRESSLIST[2*48+47:2*48];
                                end
                        3:
                                begin
                                p_hash_mcast_addr = MCAST_ADDRESSLIST[3*48+47:3*48];
                                end
                        4:
                                begin
                                p_hash_mcast_addr = MCAST_ADDRESSLIST[4*48+47:4*48];
                                end
                        5:
                                begin
                                p_hash_mcast_addr = MCAST_ADDRESSLIST[5*48+47:5*48];
                                end
                        6:
                                begin
                                p_hash_mcast_addr = MCAST_ADDRESSLIST[6*48+47:6*48];
                                end
                        7:
                                begin
                                p_hash_mcast_addr = MCAST_ADDRESSLIST[7*48+47:7*48];
                                end
                        default:
                                begin
                                p_hash_mcast_addr = MCAST_ADDRESSLIST[8*48+47:8*48];
                                end
               endcase
               
                p_hash_hash_code[0] = ^(p_hash_mcast_addr[7:0]);    
                p_hash_hash_code[1] = ^(p_hash_mcast_addr[15:8]);   
                p_hash_hash_code[2] = ^(p_hash_mcast_addr[23:16]);  
                p_hash_hash_code[3] = ^(p_hash_mcast_addr[31:24]);  
                p_hash_hash_code[4] = ^(p_hash_mcast_addr[39:32]);  
                p_hash_hash_code[5] = ^(p_hash_mcast_addr[47:40]);
         
         reg_wr <= #(2)1'b 1;   
         reg_rd <= #(2) 1'b 0;  
         reg_addr[7:6] <= 2'b 01;   
         reg_addr[5:0] <= p_hash_hash_code ;    
         reg_data_in <= #(2)  32'h 00000001;    
         end
      else if (nextstate == stm_typ_rd_pause_rx )
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 33;   
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_rd_pause_tx )
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 32;   
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_rx_unicast )
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 36;   
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_rd_frm_tx )
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 26;   
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_rd_frm_rx )
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 27;   
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_rd_crc_err )
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 28;   
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_rd_align_err )
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 29;   
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_rd_tx_octets )
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 30;   
         reg_data_in <= #(2)  32'h 00000000;    
         end         
      else if (nextstate == stm_typ_rd_rx_octets )
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 31;   
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_rx_mltcast )
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 37;   
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_rx_brdcast )
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 38;   
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_tx_frm_discard )
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 39;   
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_tx_unicast)
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 40;   
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_tx_mltcast)
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 41;   
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_tx_brdcast)
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 42;   
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_rx_frm_err)
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 34;   
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_tx_frm_err)
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 35;   
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_rx_frm_drop)
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 43;   
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_rx_undersz_frm)
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 46 ;  
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_rx_oversz_frm)
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 47 ;  
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_rx_64_frm)
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 48 ;  
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_rx_65_127_frm)
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 49 ;  
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_rx_128_255_frm)
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 50 ;  
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_rx_256_511_frm)
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 51 ;  
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_rx_512_1023_frm)
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 52 ;  
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_rx_1024_1518_frm)
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 53 ;  
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_rx_1519_X_frm)
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 54 ;  
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_rx_jabber)
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 55 ;  
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_rx_fragment)
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 56 ;  
         reg_data_in <= #(2)  32'h 00000000;    
         end
      else if (nextstate == stm_typ_sw_reset)
         begin
         reg_wr <= #(2)1'b 1;   
         reg_rd <= #(2) 1'b 0;  
         reg_addr <= #(2) 2 ;   
         
         reg_data_in[12:0]  <= #(2)  13'b 0000000000011;
         reg_data_in[13]    <= #(2)  1'b1;
         reg_data_in[30:14] <= #(2)  0;
         reg_data_in[31]    <= #(2)  1'b1;
            
         end
      else if (nextstate == stm_typ_rd_sw_reset)
         begin
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 1;  
         reg_addr <= #(2) 2 ;     // fix for SPR 254641       
         reg_data_in <= #(2)  32'h 00000000;            
         end
      else
         begin // fix for SPR 254641
         reg_wr <= #(2)1'b 0;   
         reg_rd <= #(2) 1'b 0;  
         reg_addr <= #(2) {8{1'b 0}};   
         reg_data_in <= #(2)  {32{1'b 0}};  
         end
      end
   end
   
//  Core Registers
//  --------------

   // Statistics
   // ----------
   
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rd_pause_rx && reg_busy==1'b0 )
                begin

                        $display("\n - ---------------------------------------------------------------------------------------- -\n") ;
                        $display(" Core Statistic Counters\n") ;
                        $display("    - Number of Received Pause Frames : %d", reg_data_out) ;
                                                
                end 
                
        end  
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rd_sw_reset && reg_busy==1'b0)
                begin

                        $display("-\n ---------------------------------------------------------------------------------------- -\n") ;
                        
                        if (reg_data_out[13]==1'b0)
                        begin       
                        
                                        
                                $display("   - SW Reset Register Cleared") ;
                                
                        end
                        else
                        begin
                                
                                $display("   - Error: SW Reset Register NOT Cleared") ;
                                        
                        end 

                        if (reg_data_out[0]==1'b0)
                        begin       
                        
                                        
                                $display("   - MAC Transmit Disabled") ;
                                
                        end
                        else
                        begin
                                
                                $display("   - Error: MAC Transmit NOT Disabled") ;
                                        
                        end
                        
                        if (reg_data_out[1]==1'b0)
                        begin       
                        
                                        
                                $display("   - MAC Receive Disabled") ;
                                
                        end
                        else
                        begin
                                
                                $display("   - Error: MAC Receive NOT Disabled") ;
                                        
                        end 
                                                
                end 
                
        end
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rd_pause_tx && reg_busy==1'b0)
                begin

                        $display("    - Number of Transmitted Pause Frames : %d", reg_data_out) ;
                                                
                end 
                
        end
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rd_frm_tx && reg_busy==1'b0)
                begin

                        $display("    - Number of Transmitted Correct Frames - With Pause Frames : %d", reg_data_out) ;
                                                
                end 
                
        end  
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rd_frm_rx && reg_busy==1'b0)
                begin

                        $display("    - Number of Received Correct Frames - With Pause Frames : %d", reg_data_out) ;
                                                
                end 
                
        end 
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rd_crc_err && reg_busy==1'b0)
                begin

                        $display("    - Number of Frames Received with CRC Error : %d", reg_data_out) ;
                                                
                end 
                
        end
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rd_align_err && reg_busy==1'b0)
                begin

                        $display("    - Number of Frames Received with an Alignment Error : %d", reg_data_out) ;
                                                
                end 
                
        end  
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rd_tx_octets && reg_busy==1'b0)
                begin

                        $display("    - Number of Transmitted Octets : %d", reg_data_out) ;
                                                
                end 
                
        end 
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rd_rx_octets && reg_busy==1'b0)
                begin

                        $display("    - Number of Received Octets : %d", reg_data_out) ;
                                                
                end 
                
        end    
        
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rx_unicast && reg_busy==1'b0)
                begin

                        $display("    - Number of Received Unicast Frames : %d", reg_data_out) ;
                                                
                end 
                
        end 
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rx_mltcast && reg_busy==1'b0)
                begin

                        $display("    - Number of Received Multicast Frames : %d", reg_data_out) ;
                                                
                end 
                
        end  
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rx_brdcast && reg_busy==1'b0)
                begin

                        $display("    - Number of Received Broadcast Frames : %d", reg_data_out) ;
                                                
                end 
                
        end  
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_tx_unicast && reg_busy==1'b0)
                begin

                        $display("    - Number of Transmitted Unicast Frames : %d", reg_data_out) ;
                                                
                end 
                
        end 
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_tx_mltcast && reg_busy==1'b0)
                begin

                        $display("    - Number of Transmitted Multicast Frames : %d", reg_data_out) ;
                                                
                end 
                
        end 
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_tx_brdcast && reg_busy==1'b0)
                begin

                        $display("    - Number of Transmitted Broadcast Frames : %d", reg_data_out) ;
                                                
                end 
                
        end 
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rx_frm_err && reg_busy==1'b0)
                begin

                        $display("    - Number of Frames Received with an Error : %d", reg_data_out) ;
                                                
                end 
     
        end 
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_tx_frm_err && reg_busy==1'b0)
                begin

                        $display("    - Number of Frames Transmitted with an Error : %d", reg_data_out) ;
                                                
                end 
     
        end
        
   // RMON Counters
   // -------------
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rx_frm_drop && reg_busy==1'b0)
                begin

                        $display("\n RMON Counters\n") ;
                        $display("    - Number of Frames Dropped Because of FIFO Overflow : %d", reg_data_out) ;
                                                
                end 
     
        end 
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rx_undersz_frm && reg_busy==1'b0)
                begin

                        $display("    - Number of Received Undersized Frames : %d", reg_data_out) ;
                                                
                end 
     
        end 
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rx_oversz_frm && reg_busy==1'b0)
                begin

                        $display("    - Number of Received Oversized Frames : %d", reg_data_out) ;
                                                
                end 
     
        end
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rx_64_frm && reg_busy==1'b0)
                begin

                        $display("    - Number of Received 64-Bytes Frames : %d", reg_data_out) ;
                                                
                end 
     
        end  
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rx_65_127_frm && reg_busy==1'b0)
                begin

                        $display("    - Number of Received Frames with Size Between 65 and 127 Bytes : %d", reg_data_out) ;
                                                
                end 
     
        end 
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rx_128_255_frm && reg_busy==1'b0)
                begin

                        $display("    - Number of Received Frames with Size Between 128 and 255 Bytes : %d", reg_data_out) ;
                                                
                end 
     
        end
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rx_256_511_frm && reg_busy==1'b0)
                begin

                        $display("    - Number of Received Frames with Size Between 256 and 511 Bytes : %d", reg_data_out) ;
                                                
                end 
     
        end 
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rx_512_1023_frm && reg_busy==1'b0)
                begin

                        $display("    - Number of Received Frames with Size Between 512 and 1023 Bytes : %d", reg_data_out) ;
                                                
                end 
     
        end  
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rx_1024_1518_frm && reg_busy==1'b0)
                begin

                        $display("    - Number of Received Frames with Size Between 1024 and 1518 Bytes : %d", reg_data_out) ;
                                                
                end 
     
        end
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rx_1519_X_frm && reg_busy==1'b0)
                begin

                        $display("    - Number of Received Frames with Size Between 1519 and Max Frame Length : %d", reg_data_out) ;
                                                
                end 
     
        end
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rx_jabber && reg_busy==1'b0)
                begin

                        $display("    - Number of Received Jabber Frames (Oversize with Wrong CRC) : %d", reg_data_out) ;
                                                
                end 
     
        end
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rx_fragment && reg_busy==1'b0)
                begin

                        $display("    - Number of Received Fragments (Undersized with Wrong CRC) : %d", reg_data_out) ;
                                                
                end 
     
        end
        
        always@(state)                        
        begin
        
                if (state==stm_typ_sw_reset)
                begin
                
                        $display("\n- ---------------------------------------------------------------------------------------- -\n") ;
                        $display(" - Clearing Statistics") ;
                        
                end
                
        end         

   // Core Version
   // ------------

        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_read_ver && reg_busy==1'b0)
                begin
                
            $display(" - Altera Design Version : %0d.%0d ", reg_data_out[15:8], reg_data_out[7:0] ) ;
                                                
                end 
                
        end
        
   // Scratch Register
   // ----------------
        
        always@(state or nextstate)
        begin
        
                if (state==stm_typ_wr_scratch && nextstate==stm_typ_rd_scratch)
                begin
                
                        $display("\n - Write Scratch : 0xaaaaaaaa") ;
                                                
                end 
                
        end
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_rd_scratch && reg_busy==1'b0)
                begin
                        readback_scratch <= reg_data_out;
                        $display(" - Read Scratch : 0x%h", reg_data_out) ;
                                                
                end 
                
        end     

   // Core Configuration
   // ------------------
   
        always@(state)
        begin
                
                if (state==stm_typ_wr_sup_mac0_0)
                begin
                
                        $display("\n - Setting Supplemental MAC Addresses") ;
                        
                end
                
        end  
   
        always@(state)                        
        begin
        
                if (state==stm_typ_lut_prog && lut_prog_cnt==1)
                begin
                
                        $display(" - Load Hash Table") ;
                        
                end
                
        end 
   
        always@(state)
        begin
        
                if (state==stm_typ_mac_config)
                begin
                
                        $display("\n - MAC Configuration") ;
                                                
                end 
                
        end  
        
        always@(state)
        begin
        
                if (state==stm_typ_wr_mac1)
                begin
                
                        $display("\n - Write MAC Address") ;
                                                
                end 
                
        end 
        
        always@(state)
        begin
        
                if (state==stm_typ_wr_frm_length)
                begin
                
                        $display("\n - Write Maximum Frame Length") ;
                                                
                end 
                
        end 
        
        always@(state)
        begin
        
                if (state==stm_typ_wr_pause_quanta)
                begin
                
                        $display("\n - Write Pause Quanta") ;
                                                
                end 
                
        end  
        
   // MDIO Test
   // ---------
        
        
        always@(state)
        begin
        
                if (state==stm_typ_wr_mdio_addr1)
                begin
                
                        $display(" - Programming MDIO Base Address 1 : 0x%h", TB_MDIO_ADDR1) ;
                                                
                end 
                
        end
        
        
        always@(state)
        begin
        
                if (state==stm_typ_write_mdio1)
                begin
                
                        $display("\n - Writing MDIO Slave 1 Register 0 : 0x00005555") ;
                                                
                end 
                
        end 
        
        always@(state)
        begin
        
                if (state==stm_typ_wr_rx_se)
                begin
                
                        $display("\n - Setting FIFO Thresholds\n") ;
                                                
                end 
                
        end 
        
        
        always@(posedge(reg_clk))
        begin
        
                if (state==stm_typ_read_mdio1 && reg_busy==1'b0 )
                begin
                
                        readback_MDIO1_addr0 <= reg_data_out;
                        $display(" - Reading MDIO Slave 1 Register 0 : 0x%h\n", reg_data_out) ;
                                                
                end 
                
        end   
        
        always@(state)
        begin
        
                if (state==stm_typ_sim)
                begin
                
                        $display("\n - ---------------------------------------------------------------------------------------- -\n") ;
                                                
                end 
                
        end                         
   
//  -----------------------
//  register test status
//  -----------------------


always @(posedge reset or state or nextstate)

   begin

       if (reset == 1'b 1)
          begin
          register_test <= 0;   
          end
       else
          begin
              if (nextstate == stm_typ_end_sim_wait & state == stm_typ_sim)
                begin
                    // expected scratch register readback is 0xaaaaaaaa
                    // expected MDIO slave 1 address 0 register readback is 0x00005555
                    //
                    if (readback_scratch != 32'haaaaaaaa)
                      begin
                         $display("\n      Register test failed on SCRATCH register") ;
                         register_test <= 1;
                      end

                    if (TB_MDIO_SIMULATION == 1'b1 && ENABLE_MDIO == 1'b1)
                       begin
                       if ( (readback_MDIO1_addr0 != 32'h00005555) )
                        begin

                         $display("\n      Register test failed on MDIO Slave 1 register") ;
                         register_test <= 1;

                        end 
    
                       end
    
               end
          end
   end


   
//  Global Simulation STOP
//  ----------------------

always @(posedge reset or posedge rx_clk)
   begin : process_28
   if (reset == 1'b 1)
      begin
      delay_cnt <= 0;   
      sim_stop <= 1'b 0;    
      end
   else
      begin
      if (state == stm_typ_end_sim)
         begin
         delay_cnt <= delay_cnt + 1'b 1;    
         if (delay_cnt > 200)
            begin
            sim_stop <= 1'b 1;  
            end
         end
      end
   end

   // Clock Assignments
   // -----------------
        
        always 
        begin
   
                tx_clk_1000mbps <= 1'b 1;   
                #(4); 
                tx_clk_1000mbps <= 1'b 0;   
                #(4); 
                end

        always 
        begin
   
                rx_clk_1000mbps <= 1'b 0;   
                #(4); 
                rx_clk_1000mbps <= 1'b 1;   
                #(4); 
   
        end
        
        always 
        begin
   
                tx_clk_100mbps <= 1'b 1;    
                #(20); 
                tx_clk_100mbps <= 1'b 0;    
                #(20); 
                end

        always 
        begin
   
                rx_clk_100mbps <= 1'b 0;    
                #(20); 
                rx_clk_100mbps <= 1'b 1;    
                #(20); 
   
        end
        
        always 
        begin
   
                tx_clk_10mbps <= 1'b 1; 
                #(200); 
                tx_clk_10mbps <= 1'b 0; 
                #(200); 
                end

        always 
        begin
   
                rx_clk_10mbps <= 1'b 0; 
                #(200); 
                rx_clk_10mbps <= 1'b 1; 
                #(200); 
   
        end
       
        always@(tx_clk_1000mbps or tx_clk_100mbps or tx_clk_10mbps)
        begin
        
                if (ETH_MODE==1000)
                begin
                
                        tx_clk <= tx_clk_1000mbps ;
                        
                end
                
                else if (ETH_MODE==100)
                begin
                
                        tx_clk <= tx_clk_100mbps ;        
                        
                end
                
                else if (ETH_MODE==10)
                begin 
                
                        tx_clk <= tx_clk_10mbps ;
                        
                end
                
        end
        
        always@(rx_clk_1000mbps or rx_clk_100mbps or rx_clk_10mbps or tx_clk_1000mbps or tx_clk_100mbps or tx_clk_10mbps)                     
        begin
        
                if (TB_RXFRAMES==0)
                begin
                
                        if (ETH_MODE==1000)
                        begin
                
                                rx_clk <= tx_clk_1000mbps ;
                        
                        end
                
                        else if (ETH_MODE==100)
                        begin
                
                                rx_clk <= tx_clk_100mbps ;        
                        
                        end
                
                        else if (ETH_MODE==10)
                        begin 
                
                                rx_clk <= tx_clk_10mbps ;
                        
                        end
                        
                end
                        
                else
                begin      
        
                        if (ETH_MODE==1000)
                        begin
                
                                rx_clk <= rx_clk_1000mbps ;
                        
                        end
                
                        else if (ETH_MODE==100)
                        begin
                
                                rx_clk <= rx_clk_100mbps ;        
                        
                        end
                
                        else if (ETH_MODE==10)
                        begin 
                
                                rx_clk <= rx_clk_10mbps ;
                        
                        end
                        
                end
                
        end 
        
   // GMII Interface
   // --------------
        
        always@(gm_rxgen_rx_d or gm_tx_data)
        begin
        
           if (ENABLE_GMII_LOOPBACK)
             begin
                if (TB_RXFRAMES==0)
                begin
                
                        gm_rx_data <= 8'h0 ;
                        
                end
                
                else
                begin
                
                        gm_rx_data <= gm_rxgen_rx_d ; 
                        
                end
             end
           else
             begin     
                if (TB_RXFRAMES==0)
                begin
                
                        gm_rx_data <= gm_tx_data ;
                        
                end
                
                else
                begin
                
                        gm_rx_data <= gm_rxgen_rx_d ; 
                        
                end
             end                
                
                
        end
        
        always@(gm_rxgen_rx_en or gm_tx_en)
        begin
        
           if (ENABLE_GMII_LOOPBACK)
             begin
                if (TB_RXFRAMES==0)
                begin
                
                        gm_rx_en <= 1'b0 ;
                        
                end
                
                else
                begin
                
                        gm_rx_en <= gm_rxgen_rx_en ; 
                        
                end
             end           
           else
             begin        
                if (TB_RXFRAMES==0)
                begin
                
                        gm_rx_en <= gm_tx_en ;
                        
                end
                
                else
                begin
                
                        gm_rx_en <= gm_rxgen_rx_en ; 
                        
                end
                
             end                        
                
        end
        
        always@(gm_rxgen_rx_err or gm_tx_err)
        begin
        
           if (ENABLE_GMII_LOOPBACK)
             begin
                if (TB_RXFRAMES==0)
                begin
                
                        gm_rx_err <= 1'b0 ;
                        
                end
                
                else
                begin
                
                        gm_rx_err <= gm_rxgen_rx_err ; 
                        
                end
             end            
           else
             begin        
                if (TB_RXFRAMES==0)
                begin
                
                        gm_rx_err <= gm_tx_err ;
                        
                end
                
                else
                begin
                
                        gm_rx_err <= gm_rxgen_rx_err ; 
                        
                end
                
             end           
                
        end 

   // MII Interface
   // -------------
   
        always@(m_rxgen_rx_d or m_tx_data)
        begin
        
           if (ENABLE_GMII_LOOPBACK)
             begin             
                if (TB_RXFRAMES==0)
                begin
                
                        m_rx_data <= 4'h0 ;
                        
                end
                
                else
                begin
                
                        m_rx_data <= m_rxgen_rx_d ; 
                        
                end
             end         
           else
             begin        
                if (TB_RXFRAMES==0)
                begin
                
                        m_rx_data <= m_tx_data ;
                        
                end
                
                else
                begin
                
                        m_rx_data <= m_rxgen_rx_d ; 
                        
                end
                
            end           
                
        end
        
        always@(m_rxgen_rx_en or m_tx_en)
        begin
        
           if (ENABLE_GMII_LOOPBACK)
             begin
                if (TB_RXFRAMES==0)
                begin
                
                        m_rx_en <= 1'b0 ;
                        
                end
                
                else
                begin
                
                        m_rx_en <= m_rxgen_rx_en ; 
                        
                end
             end           
           else
             begin        
                if (TB_RXFRAMES==0)
                begin
                
                        m_rx_en <= m_tx_en ;
                        
                end
                
                else
                begin
                
                        m_rx_en <= m_rxgen_rx_en ; 
                        
                end
                
             end           
                
        end
        
        always@(m_rxgen_rx_err or m_tx_err)
        begin
        
           if (ENABLE_GMII_LOOPBACK)
             begin
                if (TB_RXFRAMES==0)
                begin
                
                        m_rx_err <= 1'b0 ;
                        
                end
                
                else
                begin
                
                        m_rx_err <= m_rxgen_rx_err ; 
                        
                end
             end            
           else 
             begin
                if (TB_RXFRAMES==0)
                begin
                
                        m_rx_err <= m_tx_err ;
                        
                end
                
                else
                begin
                
                        m_rx_err <= m_rxgen_rx_err ; 
                        
                end
                
             end           
                
        end

// Simulation Information
// ----------------------

        always@(ff_rx_rdy)
        begin
        
                if (ff_rx_rdy==1'b0)
                begin
                
                        $display($time, "ns - Pause Rx FIFO Read") ; 
                        
                end
                else if (ff_rx_rdy==1'b1 && $time>1)
                begin
                
                        $display($time, "ns - Re-Start Rx FIFO Read") ; 
                        
                end 
                
        end        

        always@(mff_is_pause)                
        begin
        
                if (mff_is_pause==1'b1)
                begin
                
                        $display($time, "ns - Pause Frame Received on FIFO Interface") ; 
                        
                end       
                                                      
        end 
        
        always@(m_rx_col)                
        begin
        
                if (m_rx_col==1'b1)
                begin
                
                        $display($time, "ns - Collision, Frame Re-Transmitted after Back Off Period") ; 
                        
                end       
                                                      
        end 
        
        always@(posedge rx_clk)
        begin
        
                if (expect2==1'b0 & TB_RXFRAMES>0)
                begin
                
                        if (pause_rcv==1'b1 || frm_align_err==1'b1 || frm_type_err==1'b1 || frm_length_err==1'b1 || frm_crc_err==1'b1)
                        begin
                
                                $display($time, "ns - Warning") ;
                        
                                if (pause_rcv==1'b1)
                                begin
                        
                                        $display("\n      Unexpected RX pause_rcv") ;
                                
                                
                                end
                        
                                if (frm_align_err==1'b1)
                                begin
                        
                                        $display("\n      Unexpected RX frm_align_err") ;
                                
                                end
                        
                                if (frm_type_err==1'b1)
                                begin
                        
                                        $display("\n      Unexpected RX frm_type_err") ;
                                
                                end 
                        
                                if (frm_crc_err==1'b1)
                                begin
                        
                                        $display("\n      Unexpected RX frm_crc_err") ;
                                
                                end
                        
                        end
                        
                end
                
        end               

//  -----------------------
//  Global Simulation STOP
//  -----------------------

always @(posedge reset or posedge rx_clk)
   begin
   if (reset == 1'b 1)
      begin
      delay_cnt <= 0;   
      sim_stop <= 1'b 0;    
      end
   else
      begin
      if (txsim_done == 1'b 1 & ff_rx_dsav != 1'b 1 )

         begin
//  Generators done and FIFO empty
         delay_cnt <= delay_cnt + 1'b 1;    
         if (sim_cnt_end > 500 & state == stm_typ_end_sim)
         begin
            
            sim_stop <= 1'b 1;
            
            $display("\n- ---------------------------------------------------------------------------------------- -") ;
            
            
            if (TB_TXFRAMES > 0)
            begin
            
                $display("\n Statistics MAC Tx Path\n") ;
                $display("     - Frames sent in TX path total: ", txframe_cnt) ;
                $display("     - Tx_good_sent: ", tx_good_sent) ;
                $display("     - Tx_vlan_sent: ", tx_vlan_sent) ;
                $display("     - Tx_stack_vlan_sent: ", tx_stack_vlan_sent) ;
                $display("     - Payload_err_sent: ", tx_payload_err_sent) ;
                
            end
            
            if (TB_RXFRAMES == 0)
            begin
            
                $display("\n Statistics MAC Rx Path - Loopback Test\n") ;
                $display("     - Rx_good_rcvd: ", rx_good_rcvd) ;
                $display("     - Rx_vlan_rcvd: ", rx_vlan_rcvd) ;
                $display("     - Rx_stack_vlan_rcvd: ", rx_stack_vlan_rcvd) ;
                $display("     - Rx_fifo_overflow_rcvd: ", rx_fifo_overflow_rcvd) ;
                $display("     - Rx_payload_err_rcvd: ", rx_payload_err_rcvd) ;
                $display("     - Rx_crc_err_rcvd: ", rx_crc_err_rcvd) ;
                
            end
            
            
            if (TB_RXFRAMES == 0)
            begin
            
                if ((rx_good_rcvd           == tx_good_sent) &
                    (rx_payload_err_rcvd    == tx_payload_err_sent) &
                    (tx_good_sent           == TB_TXFRAMES) &
                    (register_test          == 0)  )
                
                begin
            
                        $display("\n -- Loopback Simulation Ended with no Error") ;
                
                end
                else
                begin
                
                        $display("\n -- Loopback Simulation Ended with Error !") ;
                        
                end
                
                $display("\n- ---------------------------------------------------------------------------------------- -") ;              
                $display("\n End of Simulation - Break \n") ;
                $stop ;
                
            end                       

            $display("\n- ---------------------------------------------------------------------------------------- -") ;  
            
            $display("\n End of Simulation - Break \n") ;
            $stop ;
            end
         end
         
      end
      
      if (promis_en != promis_en_dly)
      begin
      
        if (promis_en==1'b1)
        begin
        
                $display("\n Promiscuous Mode enabled with multicast sent: ", rx_multicast_sent) ;
                $display("      rcvd: ", rx_multicast_rcvd) ;
                $display("      denied:", rx_multicast_denied) ;
                $display("\n") ;
                
        end 
        
      end          
      
   end
   
   always@(posedge xoff_gen)
   begin
   
         if (xoff_gen==1'b1)
         begin
      
                $display($time, "ns - Xoff Pause Frame Generation Requested with Command Pin") ;
        
        end
   
   end
   
   always@(posedge xon_gen)
   begin
   
         if (xon_gen==1'b1)
         begin
      
                $display($time, "ns - Xon Pause Frame Generation Requested with Command Pin") ;
        
        end
   
   end

endmodule // module tb
