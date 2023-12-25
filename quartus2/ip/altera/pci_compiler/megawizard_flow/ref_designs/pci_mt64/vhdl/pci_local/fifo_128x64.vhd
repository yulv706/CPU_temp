-- megafunction wizard: %LPM_FIFO+%
-- GENERATION: STANDARD
-- VERSION: WM1.0
-- MODULE: scfifo 

-- ============================================================
-- File Name: fifo_128x64.vhd
-- Megafunction Name(s):
--                      scfifo
-- ============================================================
-- ************************************************************
-- THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
--
-- 4.0 Internal Build 182 12/16/2003 SJ Full Version
-- ************************************************************


--  Copyright (C) 1991-2004 Altera Corporation, All rights reserved.  
--  Altera products are protected under numerous U.S. and foreign patents, 
--  maskwork rights, copyrights and other intellectual property laws. 
--  This reference design file, and your use thereof, is subject to and 
--  governed by the terms and conditions of the applicable Altera Reference 
--  Design License Agreement (either as signed by you or found at www.altera.com).  
--  By using this reference design file, you indicate your acceptance of such terms 
--  and conditions between you and Altera Corporation.  In the event that you do
--  not agree with such terms and conditions, you may not use the reference design 
--  file and please promptly destroy any copies you have made. 
--  This reference design file is being provided on an �as-is� basis and as an 
--  accommodation and therefore all warranties, representations or guarantees 
--  of any kind (whether express, implied or statutory) including, without limitation, 
--  warranties of merchantability, non-infringement, or fitness for a particular purpose, 
--  are specifically disclaimed.  By making this reference design file available, 
--  Altera expressly does not recommend, suggest or require that this reference design 
--  file be used in combination with any other product not provided by Altera.
-----------------------------------------------------------------------------------




LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY fifo_128x64 IS
        PORT
        (
                data            : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                wrreq           : IN STD_LOGIC ;
                rdreq           : IN STD_LOGIC ;
                clock           : IN STD_LOGIC ;
                aclr            : IN STD_LOGIC ;
                sclr            : IN STD_LOGIC ;
                q               : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                full            : OUT STD_LOGIC ;
                empty           : OUT STD_LOGIC ;
                usedw           : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
        );
END fifo_128x64;


ARCHITECTURE SYN OF fifo_128x64 IS

        SIGNAL sub_wire0        : STD_LOGIC_VECTOR (6 DOWNTO 0);
        SIGNAL sub_wire1        : STD_LOGIC ;
        SIGNAL sub_wire2        : STD_LOGIC_VECTOR (63 DOWNTO 0);
        SIGNAL sub_wire3        : STD_LOGIC ;



        COMPONENT scfifo
        GENERIC (
                intended_device_family          : STRING;
                lpm_width               : NATURAL;
                lpm_numwords            : NATURAL;
                lpm_widthu              : NATURAL;
                lpm_type                : STRING;
                lpm_showahead           : STRING;
                overflow_checking               : STRING;
                underflow_checking              : STRING;
                use_eab         : STRING;
                add_ram_output_register         : STRING;
                lpm_hint                : STRING
        );
        PORT (
                        usedw   : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                        rdreq   : IN STD_LOGIC ;
                        sclr    : IN STD_LOGIC ;
                        empty   : OUT STD_LOGIC ;
                        aclr    : IN STD_LOGIC ;
                        clock   : IN STD_LOGIC ;
                        q       : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
                        wrreq   : IN STD_LOGIC ;
                        data    : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                        full    : OUT STD_LOGIC 
        );
        END COMPONENT;

BEGIN
        usedw    <= sub_wire0(6 DOWNTO 0);
        empty    <= sub_wire1;
        q    <= sub_wire2(63 DOWNTO 0);
        full    <= sub_wire3;

        scfifo_component : scfifo
        GENERIC MAP (
                intended_device_family => "Stratix",
                lpm_width => 64,
                lpm_numwords => 128,
                lpm_widthu => 7,
                lpm_type => "scfifo",
                lpm_showahead => "OFF",
                overflow_checking => "ON",
                underflow_checking => "ON",
                use_eab => "ON",
                add_ram_output_register => "OFF",
                lpm_hint => "RAM_BLOCK_TYPE=AUTO"
        )
        PORT MAP (
                rdreq => rdreq,
                sclr => sclr,
                aclr => aclr,
                clock => clock,
                wrreq => wrreq,
                data => data,
                usedw => sub_wire0,
                empty => sub_wire1,
                q => sub_wire2,
                full => sub_wire3
        );



END SYN;

-- ============================================================
-- CNX file retrieval info
-- ============================================================
-- Retrieval info: PRIVATE: Width NUMERIC "64"
-- Retrieval info: PRIVATE: Depth NUMERIC "128"
-- Retrieval info: PRIVATE: Clock NUMERIC "0"
-- Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Stratix"
-- Retrieval info: PRIVATE: CLOCKS_ARE_SYNCHRONIZED NUMERIC "0"
-- Retrieval info: PRIVATE: Full NUMERIC "1"
-- Retrieval info: PRIVATE: Empty NUMERIC "1"
-- Retrieval info: PRIVATE: UsedW NUMERIC "1"
-- Retrieval info: PRIVATE: AlmostFull NUMERIC "0"
-- Retrieval info: PRIVATE: AlmostEmpty NUMERIC "0"
-- Retrieval info: PRIVATE: AlmostFullThr NUMERIC "-1"
-- Retrieval info: PRIVATE: AlmostEmptyThr NUMERIC "-1"
-- Retrieval info: PRIVATE: sc_aclr NUMERIC "1"
-- Retrieval info: PRIVATE: sc_sclr NUMERIC "1"
-- Retrieval info: PRIVATE: rsFull NUMERIC "0"
-- Retrieval info: PRIVATE: rsEmpty NUMERIC "1"
-- Retrieval info: PRIVATE: rsUsedW NUMERIC "0"
-- Retrieval info: PRIVATE: wsFull NUMERIC "1"
-- Retrieval info: PRIVATE: wsEmpty NUMERIC "0"
-- Retrieval info: PRIVATE: wsUsedW NUMERIC "0"
-- Retrieval info: PRIVATE: dc_aclr NUMERIC "0"
-- Retrieval info: PRIVATE: LegacyRREQ NUMERIC "1"
-- Retrieval info: PRIVATE: RAM_BLOCK_TYPE NUMERIC "0"
-- Retrieval info: PRIVATE: LE_BasedFIFO NUMERIC "0"
-- Retrieval info: PRIVATE: Optimize NUMERIC "2"
-- Retrieval info: PRIVATE: OVERFLOW_CHECKING NUMERIC "0"
-- Retrieval info: PRIVATE: UNDERFLOW_CHECKING NUMERIC "0"
-- Retrieval info: PRIVATE: MEGAFN_PORT_INFO_0 STRING "data;wrreq;rdreq;clock;aclr"
-- Retrieval info: PRIVATE: MEGAFN_PORT_INFO_1 STRING "sclr;q;empty;full;almost_full"
-- Retrieval info: PRIVATE: MEGAFN_PORT_INFO_2 STRING "almost_empty;usedw"
-- Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Stratix"
-- Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "64"
-- Retrieval info: CONSTANT: LPM_NUMWORDS NUMERIC "128"
-- Retrieval info: CONSTANT: LPM_WIDTHU NUMERIC "7"
-- Retrieval info: CONSTANT: LPM_TYPE STRING "scfifo"
-- Retrieval info: CONSTANT: LPM_SHOWAHEAD STRING "OFF"
-- Retrieval info: CONSTANT: OVERFLOW_CHECKING STRING "ON"
-- Retrieval info: CONSTANT: UNDERFLOW_CHECKING STRING "ON"
-- Retrieval info: CONSTANT: USE_EAB STRING "ON"
-- Retrieval info: CONSTANT: ADD_RAM_OUTPUT_REGISTER STRING "OFF"
-- Retrieval info: CONSTANT: LPM_HINT STRING "RAM_BLOCK_TYPE=AUTO"
-- Retrieval info: USED_PORT: data 0 0 64 0 INPUT NODEFVAL data[63..0]
-- Retrieval info: USED_PORT: q 0 0 64 0 OUTPUT NODEFVAL q[63..0]
-- Retrieval info: USED_PORT: wrreq 0 0 0 0 INPUT NODEFVAL wrreq
-- Retrieval info: USED_PORT: rdreq 0 0 0 0 INPUT NODEFVAL rdreq
-- Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL clock
-- Retrieval info: USED_PORT: full 0 0 0 0 OUTPUT NODEFVAL full
-- Retrieval info: USED_PORT: empty 0 0 0 0 OUTPUT NODEFVAL empty
-- Retrieval info: USED_PORT: usedw 0 0 7 0 OUTPUT NODEFVAL usedw[6..0]
-- Retrieval info: USED_PORT: aclr 0 0 0 0 INPUT NODEFVAL aclr
-- Retrieval info: USED_PORT: sclr 0 0 0 0 INPUT NODEFVAL sclr
-- Retrieval info: CONNECT: @data 0 0 64 0 data 0 0 64 0
-- Retrieval info: CONNECT: q 0 0 64 0 @q 0 0 64 0
-- Retrieval info: CONNECT: @wrreq 0 0 0 0 wrreq 0 0 0 0
-- Retrieval info: CONNECT: @rdreq 0 0 0 0 rdreq 0 0 0 0
-- Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
-- Retrieval info: CONNECT: full 0 0 0 0 @full 0 0 0 0
-- Retrieval info: CONNECT: empty 0 0 0 0 @empty 0 0 0 0
-- Retrieval info: CONNECT: usedw 0 0 7 0 @usedw 0 0 7 0
-- Retrieval info: CONNECT: @aclr 0 0 0 0 aclr 0 0 0 0
-- Retrieval info: CONNECT: @sclr 0 0 0 0 sclr 0 0 0 0
-- Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
-- Retrieval info: GEN_FILE: TYPE_NORMAL fifo_128x64.vhd TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL fifo_128x64.inc FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL fifo_128x64.cmp TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL fifo_128x64.bsf FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL fifo_128x64_inst.vhd FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL fifo_128x64_waveforms.html FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL fifo_128x64_wave*.jpg FALSE
