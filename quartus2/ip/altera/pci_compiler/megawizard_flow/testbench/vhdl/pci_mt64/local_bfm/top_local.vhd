-- ----------------------------------------------------------------------------------------------------
--   Altera PCI testbench
--   MODULE NAME: top_local

--*****************************************************************************************************
-- FUNCTIONAL DESCRIPTION:
-- This is the top level file of the local reference design.
-- top_local instantiates the following modules 
--     DMA engine
--     Local master (local master instantiates lm_lastn generator)        
--     Local target
--     Prefetch
--     LPM RAM

-- This design implements three BASE Address Registers
-- 
-- Memory Region  Mapping       Block size  Address Offset  Description
-- BAR0           Memory Mapped 1 Kbytes    000-3FF         Maps the LPM_RAM function.
-- BAR1           I/O Mapped    16 Bytes    0-F             Maps the I/O register.
-- BAR2           Memory Mapped 1 Kbyte     000-3FF         Maps the trg_termination register and
--                                                          DMA engine registers. Only the lower 24
--                                                          Bytes of the address space are used.
-- Refer to the respective files for more information.
--*****************************************************************************************************

--   REVISION HISTORY:  
--   Revision 1.3 Description: No change.
--   Revision 1.2 Description: No change.
--   Revision 1.1 Description: No change.
--   Revision 1.0 Description: Initial Release.
-- 
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
-----------------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity top_local is
  port (
    Clk                  : in std_logic;
    Pcialmdr_ack_n_i     : in std_logic;
    Pcihdat_ack_n_i      : in std_logic;
    Pcil_adr_i           : in std_logic_vector (63 downto 0);
    Pcil_ben_i           : in std_logic_vector (7 downto 0);
    Pcil_cmd_i           : in std_logic_vector (3 downto 0);
    Pcil_dat_i           : in std_logic_vector (63 downto 0);
    Pcildat_ack_n_i      : in std_logic;
    Pcilm_ack_n_i        : in std_logic;
    Pcilm_dxfr_n_i       : in std_logic;
    Pcilm_tsr_i          : in std_logic_vector (9 downto 0);
    Pcilt_ack_n_i        : in std_logic;
    Pcilt_dxfr_n_i       : in std_logic;
    Pcilt_frame_n_i      : in std_logic;
    Pcilt_tsr_i          : in std_logic_vector (11 downto 0);
    Rstn                 : in std_logic;
    Pcil_adi_o           : out std_logic_vector (63 downto 0);
    Pcil_cben_o          : out std_logic_vector (7 downto 0);
    Pcilirq_n_o          : out std_logic;
    Pcilm_last_n_o       : out std_logic;
    Pcilm_rdy_n_o        : out std_logic;
    Pcilm_req32_n_o      : out std_logic;
    Pcilm_req64_n_o      : out std_logic;
    Pcilt_abort_n_o      : out std_logic;
    Pcilt_disc_n_o       : out std_logic;
    Pcilt_rdy_n_o        : out std_logic
   );
end top_local;

architecture top_local_rtl of top_local is


  component dma
    port (
    Clk                  : in std_logic;
    Mstr_done_i          : in std_logic;
    Pcil_adr_i           : in std_logic_vector (63 downto 0);
    Pcil_cmd_i           : in std_logic_vector (3 downto 0);
    Pcil_dat_i           : in std_logic_vector (63 downto 0);
    Pcilt_ack_n_i        : in std_logic;
    Pcilt_dxfr_n_i       : in std_logic;
    Pcilt_frame_n_i      : in std_logic;
    Pcilt_tsr_i          : in std_logic_vector (11 downto 0);
    Rstn                 : in std_logic;
    Mstr_dma_bc_la_o     : out std_logic_vector (31 downto 0);
    Mstr_dma_sa_o        : out std_logic_vector (31 downto 0);
    Mstr_strt_o          : out std_logic;
    Pcilt_rdy_n_o        : out std_logic
   );
  end component;

  component local_master
    port (
    Clk                  : in std_logic;
    DmaBcLa_i            : in std_logic_vector (31 downto 0);
    DmaSa_i              : in std_logic_vector (31 downto 0);
    DmaStrtMstr_i        : in std_logic;
    IODat_i              : in std_logic_vector (31 downto 0);
    PciAck_n_i           : in std_logic;
    PciAdrAck_n_i        : in std_logic;
    PciData_i            : in std_logic_vector (31 downto 0);
    PciDxfr_n_i          : in std_logic;
    PciHDataAck_n_i      : in std_logic;
    PciLDataAck_n_i      : in std_logic;
    PciLmTsr_i           : in std_logic_vector (9 downto 0);
    PrftchReg_i          : in std_logic_vector (63 downto 0);
    Rstn                 : in std_logic;
    SramHighDw_i         : in std_logic_vector (31 downto 0);
    SramLowDw_i          : in std_logic_vector (31 downto 0);
    DmaMstrDone_o        : out std_logic;
    MstrDataTx_o         : out std_logic;
    MstrIOWren_o         : out std_logic;
    MstrPrftchOn_o       : out std_logic;
    PciAd_o              : out std_logic_vector (63 downto 0);
    PciCben_o            : out std_logic_vector (7 downto 0);
    PciLastTx_n_o        : out std_logic;
    PciRdy_n_o           : out std_logic;
    PciReq32_n_o         : out std_logic;
    PciReq64_n_o         : out std_logic;
    SramAddr_o           : out std_logic_vector (7 downto 0);
    SramHighWrEn_o       : out std_logic;
    SramLowWrEn_o        : out std_logic
   );
  end component;

  component prefetch is
    port (
    Clk                     : IN std_logic;                       
    Rstn                    : IN std_logic;                       
    Prftch_i                : IN std_logic;                       
    Sx_data_tx_i            : IN std_logic;                       
    Mstr_done_i             : IN std_logic;                       
    Trgt_done_i             : IN std_logic;                       
    Sram_data_i             : IN std_logic_vector(63 DOWNTO 0);   
    Trgt64_tx_i             : IN std_logic;                       
    Prftch_o                : OUT std_logic_vector(63 DOWNTO 0)
    ); 
  end component;


  component last_gen is
    port (
    Clk                  : in std_logic;                     
    Rstn                 : in std_logic;                     
    Wr_Rdn_i             : in std_logic;                     
    Req32_i              : in std_logic;                     
    Req64_i              : in std_logic;                     
                                                             
    PciDxfr_n_i          : in std_logic;                     
    PciLmTsr_i           : in std_logic_vector (9 downto 0); 
    PciHDataAck_n_i      : in std_logic;                     
    PciAdrAck_n_i        : in std_logic;                     
    Pcibcr_i             : in std_logic_vector(7 downto 0);  
    PciLastTx_n_o        : out std_logic                     
   );                                     
  end component;   


  component local_target is
   port (
    Clk                  : in std_logic;                            
    Rstn                 : in std_logic;                            
                                                                    
    Pcil_dat_i           : in std_logic_vector (63 downto 0);       
    Pcil_adr_i           : in std_logic_vector (63 downto 0);       
    Pcil_ben_i           : in std_logic_vector (7 downto 0);        
    Pcil_cmd_i           : in std_logic_vector (3 downto 0);        
    Pcildat_ack_n_i      : in std_logic;                            
    Pcihdat_ack_n_i      : in std_logic;                                                                                              
    Pcilt_abort_n_o      : out std_logic;                           
    Pcilt_disc_n_o       : out std_logic;                           
    Pcilt_rdy_n_o        : out std_logic;                           
    Pcilt_frame_n_i      : in std_logic;                            
    Pcilt_ack_n_i        : in std_logic;                            
    Pcilt_dxfr_n_i       : in std_logic;                            
    Pcilt_tsr_i          : in std_logic_vector (11 downto 0);       
    Pcilirq_n_o          : out std_logic;                           
    PciAd_o              : out std_logic_vector (63 downto 0);      
                                                                    
    TrgtDataTx_o         : out std_logic;                           
    TrgtPrftchOn_o       : out std_logic;                            
    PrftchReg_i          : in std_logic_vector (63 downto 0);       
    TrgtDone_o           : out std_logic;                           
    Trgt64_tx_o          : out std_logic;                           
                                                                    
    TrgtIOWren_o         : out std_logic;                           
                                                                    
    SramAddr_o           : out std_logic_vector (7 downto 0);       
    SramHighWrEn_o       : out std_logic;                           
    SramLowWrEn_o        : out std_logic;                           
    SramHighDw_i         : in std_logic_vector (31 downto 0);       
    SramLowDw_i          : in std_logic_vector (31 downto 0);       
                                                                    
    IODat_i              : in std_logic_vector (31 downto 0)            
   );   
  end component;

  component lpm_ram_32 IS
    port
    (
    address     : in std_logic_vector (7 downto 0);
    clock       : in std_logic ;
    data        : in std_logic_vector (31 downto 0);
    wren        : in std_logic ;
    q           : out std_logic_vector (31 downto 0)
    );
   end component;


  signal data_tx              : std_logic;
  signal data_tx_mstr         : std_logic;
  signal data_tx_trgt         : std_logic;
  signal dma_bc_la            : std_logic_vector (31 downto 0);
  signal dma_sa               : std_logic_vector (31 downto 0);
  signal high_dword           : std_logic_vector (31 downto 0);
  signal io_reg               : std_logic_vector (31 downto 0);
  signal iomstrwr_en          : std_logic;
  signal iotrgtwr_en          : std_logic;
  signal l_adi_mstr           : std_logic_vector (63 downto 0);
  signal l_adi_trgt           : std_logic_vector (63 downto 0);
  signal l_cbeni_mstr         : std_logic_vector (7 downto 0);
  signal l_dato_reg           : std_logic_vector (31 downto 0);
  signal mem_addr             : std_logic_vector (7 downto 0);
  signal mem_addr_mstr        : std_logic_vector (7 downto 0);
  signal mem_addr_trgt        : std_logic_vector (7 downto 0);
  signal mstr_actv            : std_logic;
  signal mstr_done            : std_logic;
  signal mstr_rdy             : std_logic;
  signal prftch_on            : std_logic;
  signal prftch_on_mstr       : std_logic;
  signal prftch_on_trgt       : std_logic;
  signal prftch_reg           : std_logic_vector (63 downto 0);
  signal q                    : std_logic_vector (63 downto 0);
  signal q_high               : std_logic_vector (31 downto 0);
  signal q_low                : std_logic_vector (31 downto 0);
  signal trgt64_tx            : std_logic;
  signal trgt_done            : std_logic;
  signal trgt_rdy             : std_logic;
  signal we_high              : std_logic;
  signal we_high_mstr         : std_logic;
  signal we_high_trgt         : std_logic;
  signal we_low               : std_logic;
  signal we_low_mstr          : std_logic;
  signal we_low_trgt          : std_logic;


begin

  u1 : local_target
    port map(
      Clk        => Clk,
      Rstn       => Rstn,
      Pcil_dat_i => Pcil_dat_i,
      Pcil_adr_i => Pcil_adr_i,
      Pcil_ben_i => Pcil_ben_i,
      Pcil_cmd_i => Pcil_cmd_i,
      Pcildat_ack_n_i => Pcildat_ack_n_i,
      Pcihdat_ack_n_i => Pcihdat_ack_n_i,
      Pcilt_abort_n_o => Pcilt_abort_n_o,
      Pcilt_disc_n_o => Pcilt_disc_n_o,
      Pcilt_rdy_n_o => trgt_rdy,
      Pcilt_frame_n_i => Pcilt_frame_n_i,
      Pcilt_ack_n_i => Pcilt_ack_n_i,
      Pcilt_dxfr_n_i => Pcilt_dxfr_n_i,
      Pcilt_tsr_i => Pcilt_tsr_i,
      Pcilirq_n_o => Pcilirq_n_o,
      PciAd_o    => l_adi_trgt,
      TrgtDataTx_o => data_tx_trgt,
      TrgtPrftchOn_o => prftch_on_trgt,
      PrftchReg_i => prftch_reg,
      TrgtDone_o => trgt_done,
      TrgtIOWren_o => iotrgtwr_en,
      Trgt64_tx_o => trgt64_tx,
      SramAddr_o => mem_addr_trgt,
      SramHighWrEn_o => we_high_trgt,
      SramLowWrEn_o => we_low_trgt,
      SramHighDw_i => q_high,
      SramLowDw_i => q_low,
      IODat_i    => io_reg
      );


  u2 : lpm_ram_32
    port map(
      address    => mem_addr,
      clock      => Clk,
      wren       => we_high,
      data       => high_dword,
      q          => q_high
      );


  u3 : lpm_ram_32
    port map(
      address    => mem_addr,
      clock      => Clk,
      wren       => we_low,
      data       => Pcil_dat_i(31 downto 0),
      q          => q_low
      );


  u4 : dma
    port map(
      Clk        => Clk,
      Rstn       => Rstn,
      Pcil_dat_i => Pcil_dat_i,
      Pcil_adr_i => Pcil_adr_i,
      Pcil_cmd_i => Pcil_cmd_i,
      Pcilt_rdy_n_o => mstr_rdy,
      Pcilt_frame_n_i => Pcilt_frame_n_i,
      Pcilt_ack_n_i => Pcilt_ack_n_i,
      Pcilt_dxfr_n_i => Pcilt_dxfr_n_i,
      Pcilt_tsr_i => Pcilt_tsr_i,
      Mstr_done_i => mstr_done,
      Mstr_strt_o => mstr_actv,
      Mstr_dma_sa_o => dma_sa,
      Mstr_dma_bc_la_o => dma_bc_la
      );


  u5 : local_master
    port map(
      Clk        => Clk,
      Rstn       => Rstn,
      PciAd_o    => l_adi_mstr,
      PciCben_o  => l_cbeni_mstr,
      PciData_i  => Pcil_dat_i(31 downto 0),
      PciLDataAck_n_i => Pcildat_ack_n_i,
      PciHDataAck_n_i => Pcihdat_ack_n_i,
      PciReq32_n_o => Pcilm_req32_n_o,
      PciReq64_n_o => Pcilm_req64_n_o,
      PciLastTx_n_o => Pcilm_last_n_o,
      PciRdy_n_o => Pcilm_rdy_n_o,
      PciAdrAck_n_i => Pcialmdr_ack_n_i,
      PciAck_n_i => Pcilm_ack_n_i,
      PciDxfr_n_i => Pcilm_dxfr_n_i,
      PciLmTsr_i => Pcilm_tsr_i,
      IODat_i    => io_reg,
      DmaSa_i    => dma_sa,
      DmaBcLa_i  => dma_bc_la,
      DmaStrtMstr_i => mstr_actv,
      DmaMstrDone_o => mstr_done,
      MstrDataTx_o => data_tx_mstr,
      MstrPrftchOn_o => prftch_on_mstr,
      PrftchReg_i => prftch_reg,
      MstrIOWren_o => iomstrwr_en,
      SramAddr_o => mem_addr_mstr,
      SramHighWrEn_o => we_high_mstr,
      SramLowWrEn_o => we_low_mstr,
      SramHighDw_i => q_high,
      SramLowDw_i => q_low
      );


  u6 : prefetch
    port map(
      Clk        => Clk,
      Rstn       => Rstn,
      Prftch_i   => prftch_on,
      Sx_data_tx_i => data_tx,
      Sram_data_i => q,
      Trgt64_tx_i => trgt64_tx,
      Prftch_o   => prftch_reg,
      Mstr_done_i => mstr_done,
      Trgt_done_i => trgt_done
      );

 
  -- lt_rdyn signal indicates target is ready to accept or provide data
  -- As such this signal should be driven only by the target controller(local_target)
  -- In this reference design DMA engine of the Master is also driving lt_rdyn because
  -- the DMA registers are configured by the testbench Master transactor(mstr_tranx)   
  Pcilt_rdy_n_o <= trgt_rdy and mstr_rdy ;

  -- l_adi  is driven by Master if mstr_active is active else driven by the target
  Pcil_adi_o  <=  l_adi_mstr  when  (mstr_actv = '1')  else  l_adi_trgt ;
  
  -- Pcil_cben  is driven by Master if mstr_active is active
  Pcil_cben_o  <=  l_cbeni_mstr  when  (mstr_actv = '1')  else  (others => '0');

  
  -- SRAM memory address will be driven if master is active else driven by the target
  mem_addr  <=  mem_addr_mstr  when  (mstr_actv = '1')  else  mem_addr_trgt ;
  

   -- we implement two 32-bit RAM(high and low)
   -- Hence the write enable high and we enable low is driven by Master when master is
   -- active else it is driven by target.
  we_high  <=  we_high_mstr  when  (mstr_actv = '1') else  we_high_trgt ;  
  we_low  <=  we_low_mstr  when  (mstr_actv = '1')  else  we_low_trgt ;
  
   -- Prefetch logic is explained in the Prefetch file
   -- This signal goes active for one clock during target read and
   -- Master write transaction.
  prftch_on <= prftch_on_mstr or prftch_on_trgt ;
  
  
  -- This signal is used by prfetch logic
  -- data_tx indicates successful data transfer
  -- this is realised by assertion of lt_ackn and lt_dxfrn in case of target
  -- and assertion of lm_ackn and lm_dxfrn in case of master.   
  data_tx <= data_tx_mstr or data_tx_trgt ;

  -- This is the output from the SRAM
  -- q_high is the output from the higher 32-bit RAM
  -- q_low is the output from the lower 32-bit RAM
  q(63 downto 32) <= q_high ;
  q(31 downto 0) <= q_low ;
  

   -- This signal is used during 32-bit PCI and 64-bit Local side
   -- The local side is 64 bit that implements two 32-bit RAMs(low and high)
   -- Since PCI transaction is 32-bit the high dword also comes on l_dati(31:0)
   -- This data needs to be steered to the high dword RAM
   -- high dword steers the data to the high dword RAM in case of
   -- target write transaction(use lt_tsr(7)) to check whether the transaction is 32-bit or 64-bit on PCI bus
   -- and during Master Write transaction signified by lm_req32n(DMA configuration of 000 indicates a 32 bit request)
   -- The data presented to the 32-bit RAM is qualified by Write enable
   -- Check the SramWren signal from local_target and local_master.
  
   high_dword(31 downto 0) <= Pcil_dat_i(31 downto 0) when (( dma_bc_la(31 downto 29) = "000" and  mstr_actv = '1' ) or ( Pcilt_frame_n_i = '0' and Pcilt_tsr_i(7) = '0' )) else Pcil_dat_i(63 downto 32);




--********************************************************************************
-- IO Register
-- This is a demo register that simulates IO read and write register functionality
-- As shown this register is enabled when IO target write enable or IO Master
-- Write Enable is active.
--********************************************************************************

  process (Clk,Rstn)
  begin
    if  ( Rstn = '0' ) then
      io_reg <= (others => '0');
    elsif(Clk'event and Clk='1') then  
      
      if  ( iotrgtwr_en = '1' or iomstrwr_en = '1' ) then
        io_reg <= Pcil_dat_i(31 downto 0) ;
      end if;
      
    end if;
  end process;


end top_local_rtl;
