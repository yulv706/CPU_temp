--  pci_mt32 Reference Design
--  MODULE NAME:  datapath_fifo
--  COMPANY:  Altera Coporation.
--            www.altera.com    

--  FUNCTIONAL DESCRIPTION:
--  This module contains the fifos that hold the data during the  
--  memory transaction from/to the SDRAM. This module uses the LPM_FIFOs  

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

library ieee;
library work;
use work.components.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- File name: datapath_fifo.vhd

-- This is the data fifo module that includes the pci2sdram fifo, sdram2pci fifo,
-- byte enable fifo for data write to sdram.
-- All fifos are 128 line deep.




entity datapath_fifo is
    Port (
        clk                     : in std_logic;
        rstn                    : in std_logic;
        p2s_fifoi               : in std_logic_vector(31 downto 0);
        p2s_fifo_wrreq          : in std_logic;
        p2s_fifo_rdreq          : in std_logic;
        p2s_fifo_flush          : in std_logic;
        s2p_fifo_dati           : in std_logic_vector(31 downto 0);
        s2p_fifo_wrreq          : in std_logic;
        s2p_fifo_rdreq          : in std_logic;
        s2p_fifo_flush          : in std_logic;
        p2s_fifo_out            : out std_logic_vector(31 downto 0);
        p2s_fifo_full           : out std_logic;
        p2s_fifo_empty          : out std_logic;
        p2s_fifo_usedw          : out std_logic_vector(6 downto 0);
        s2p_fifo_dato           : out std_logic_vector(31 downto 0);
        s2p_fifo_usedw          : out std_logic_vector(6 downto 0);
        s2p_fifo_full           : out std_logic;
        s2p_fifo_empty          : out std_logic
 
        );
        
end datapath_fifo;

architecture rtl of datapath_fifo is

signal  rst     : std_logic;



begin
        
        rst <= not rstn;

-- instantiation of the pci to sdram fifo (lower 32-bit of the data)
   p2s_fifo  :  fifo_128x32
 
   PORT MAP (
         rdreq => p2s_fifo_rdreq,
         aclr =>   rst,
         sclr => p2s_fifo_flush,
         clock => clk,
         wrreq => p2s_fifo_wrreq,
         data => p2s_fifoi,
         usedw => p2s_fifo_usedw,
         empty => p2s_fifo_empty,
         q => p2s_fifo_out,
         full => p2s_fifo_full
            );

        
-- Instation of the sdram to pci fifo
-- since the local side is 64-bit, this fifo does not need to have separate control
-- of the high and low dword. the core reads the fifo 64-bit at a time and the internal
-- control logic of the core will mux the data to the output registers according to the 
-- 32/64-bit transfer mod
s2p_fifo  : fifo_128x32
   
   PORT MAP (
       rdreq => s2p_fifo_rdreq,
       sclr => s2p_fifo_flush,
       aclr => rst,
       clock => clk,
       wrreq => s2p_fifo_wrreq,
       data => s2p_fifo_dati,
       usedw => s2p_fifo_usedw,
       empty => s2p_fifo_empty,
       q => s2p_fifo_dato,
       full => s2p_fifo_full
             );


end rtl;



















