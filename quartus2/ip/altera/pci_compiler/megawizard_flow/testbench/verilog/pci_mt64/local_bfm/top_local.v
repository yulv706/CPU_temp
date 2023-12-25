//------------------------------------------------------------------
//  Altera PCI testbench
//  MODULE NAME: top_local

//*****************************************************************************************************
// FUNCTIONAL DESCRIPTION:
// This is the top level file of the local reference design.
// top_local instantiates the following modules 
//     DMA engine
//     Local master (local master instantiates lm_lastn generator)        
//     Local target
//     Prefetch
//     LPM RAM

// This design implements three BASE Address Registers
// 
// Memory Region  Mapping       Block size  Address Offset  Description
// BAR0           Memory Mapped 1 Kbytes    000-3FF         Maps the LPM_RAM function.
// BAR1           I/O Mapped    16 Bytes    0-F             Maps the I/O register.
// BAR2           Memory Mapped 1 Kbyte     000-3FF         Maps the trg_termination register and
//                                                          DMA engine registers. Only the lower 24
//                                                          Bytes of the address space are used.
// Refer to the respective files for more information.
//*****************************************************************************************************

//  REVISION HISTORY:  
//  Revision 1.3 Description: No change.
//  Revision 1.2 Description: No change.
//  Revision 1.1 Description: No change.
//  Revision 1.0 Description: Initial Release.
//
//  Copyright (C) 1991-2004 Altera Corporation, All rights reserved.  
//  Altera products are protected under numerous U.S. and foreign patents, 
//  maskwork rights, copyrights and other intellectual property laws. 
//  This reference design file, and your use thereof, is subject to and 
//  governed by the terms and conditions of the applicable Altera Reference 
//  Design License Agreement (either as signed by you or found at www.altera.com).  
//  By using this reference design file, you indicate your acceptance of such terms 
//  and conditions between you and Altera Corporation.  In the event that you do
//  not agree with such terms and conditions, you may not use the reference design 
//  file and please promptly destroy any copies you have made. 
//  This reference design file is being provided on an �as-is� basis and as an 
//  accommodation and therefore all warranties, representations or guarantees 
//  of any kind (whether express, implied or statutory) including, without limitation, 
//  warranties of merchantability, non-infringement, or fitness for a particular purpose, 
//  are specifically disclaimed.  By making this reference design file available, 
//  Altera expressly does not recommend, suggest or require that this reference design 
//  file be used in combination with any other product not provided by Altera.
//---------------------------------------------------------------------------------------


`timescale 1 ns / 1 ns

module top_local (     
                       
                       Clk, 
                       Rstn, 
                       
                       //PCI Master Control Signals
                       Pcilm_req32_n_o, 
                       Pcilm_req64_n_o, 
                       Pcilm_last_n_o, 
                       Pcilm_rdy_n_o, 
                       Pcilm_ack_n_i, 
                       Pcilmdr_ack_n_i, 
                       Pcilm_dxfr_n_i, 
                       Pcilm_tsr_i, 
                       
                       // PCI Data Signals                       
                       Pcil_adi_o, 
                       Pcil_cben_o, 
                       Pcil_dat_i, 
                       Pcil_adr_i, 
                       Pcil_ben_i, 
                       Pcil_cmd_i, 

                       Pcildat_ack_n_i, 
                       Pcihdat_ack_n_i, 

                       //PCI Target Control Signals
                       Pcilt_rdy_n_o, 
                       Pcilt_disc_n_o, 
                       Pcilt_abort_n_o, 
                       Pcilt_frame_n_i, 
                       Pcilt_ack_n_i, 
                       Pcilt_dxfr_n_i, 
                       Pcilt_tsr_i,                                           
                       Pcilirq_n_o);

 
   input            Clk; 
   input            Rstn; 
   input    [63:0]  Pcil_dat_i; 
   input    [63:0]  Pcil_adr_i; 
   input    [7:0]   Pcil_ben_i; 
   input    [3:0]   Pcil_cmd_i; 
   input            Pcildat_ack_n_i; 
   input            Pcihdat_ack_n_i; 
   input            Pcilmdr_ack_n_i; 
   input            Pcilm_ack_n_i; 
   input            Pcilm_dxfr_n_i; 
   input    [9:0]   Pcilm_tsr_i; 
   input            Pcilt_frame_n_i; 
   input            Pcilt_ack_n_i; 
   input            Pcilt_dxfr_n_i; 
   input    [11:0]  Pcilt_tsr_i; 

   
   output   [63:0]  Pcil_adi_o; 
   output   [7:0]   Pcil_cben_o; 
   output           Pcilm_req32_n_o; 
   output           Pcilm_req64_n_o; 
   output           Pcilm_last_n_o;    
   output           Pcilm_rdy_n_o; 
   output           Pcilt_abort_n_o; 
   output           Pcilt_disc_n_o; 
   output           Pcilt_rdy_n_o; 
   output           Pcilirq_n_o; 
               
   
   
   wire             Pcilm_req32_n_o;
   wire             Pcilm_req64_n_o;
   wire             Pcilm_last_n_o;
   wire             Pcilm_rdy_n_o;
   wire             Pcilt_abort_n_o;
   wire             Pcilt_disc_n_o;
   wire             Pcilt_rdy_n_o;
   wire             Pcilirq_n_o;



   wire     [7:0]   mem_addr; 
   wire             we_high; 
   wire             we_low; 
   wire     [31:0]  q_high; 
   wire     [31:0]  q_low; 
   wire             trgt_rdy; 
   wire             mstr_rdy; 
   wire             mstr_done; 
   wire             mstr_actv; 
   wire     [31:0]  dma_sa; 
   wire     [31:0]  dma_bc_la; 
   wire     [63:0]  l_adi_mstr; 
   wire     [63:0]  l_adi_trgt; 
   wire     [7:0]   l_cbeni_mstr; 
   wire     [7:0]   mem_addr_mstr; 
   wire     [7:0]   mem_addr_trgt; 
   wire             we_high_mstr; 
   wire             we_high_trgt; 
   wire             we_low_mstr; 
   wire             we_low_trgt; 
   reg      [31:0]  l_dato_reg; 
   wire             prftch_on; 
   wire             prftch_on_mstr; 
   wire             prftch_on_trgt; 
   wire             data_tx; 
   wire             data_tx_trgt; 
   wire             data_tx_mstr; 
   wire     [63:0]  prftch_reg; 
   wire     [63:0]  q; 
   wire             trgt_done; 
   wire             trgt64_tx;
   wire             iotrgtwr_en;
   reg      [31:0]  io_reg;
   wire             iomstrwr_en;
   wire     [31:0]  high_dword;
   

   local_target u1 (.Clk(Clk), 
                  .Rstn(Rstn), 
                  .Pcil_dat_i(Pcil_dat_i), 
                  .Pcil_adr_i(Pcil_adr_i), 
                  .Pcil_ben_i(Pcil_ben_i), 
                  .Pcil_cmd_i(Pcil_cmd_i), 
                  .Pcildat_ack_n_i(Pcildat_ack_n_i), 
                  .Pcihdat_ack_n_i(Pcihdat_ack_n_i), 
                  .Pcilt_abort_n_o(Pcilt_abort_n_o), 
                  .Pcilt_disc_n_o(Pcilt_disc_n_o), 
                  .Pcilt_rdy_n_o(trgt_rdy), 
                  .Pcilt_frame_n_i(Pcilt_frame_n_i), 
                  .Pcilt_ack_n_i(Pcilt_ack_n_i), 
                  .Pcilt_dxfr_n_i(Pcilt_dxfr_n_i), 
                  .Pcilt_tsr_i(Pcilt_tsr_i), 
                  .Pcilirq_n_o(Pcilirq_n_o), 
                  .PciAd_o(l_adi_trgt), 
                  .TrgtDataTx_o(data_tx_trgt), 
                  .TrgtPrftchOn_o(prftch_on_trgt), 
                  .PrftchReg_i(prftch_reg), 
                  .TrgtDone_o(trgt_done),
                  .TrgtIOWren_o(iotrgtwr_en),
                  .Trgt64_tx_o(trgt64_tx),
                  .SramAddr_o(mem_addr_trgt), 
                  .SramHighWrEn_o(we_high_trgt), 
                  .SramLowWrEn_o(we_low_trgt), 
                  .SramHighDw_i(q_high), 
                  .SramLowDw_i(q_low), 
                  .IODat_i(io_reg)); 
   
   lpm_ram_32 u2 (.address(mem_addr), 
                  .clock(Clk), 
                  .wren(we_high), 
                  .data(high_dword), 
                  .q(q_high)); 
   
   lpm_ram_32 u3 (.address(mem_addr), 
                  .clock(Clk), 
                  .wren(we_low), 
                  .data(Pcil_dat_i[31:0]), 
                  .q(q_low)); 
   
   dma u4      ( .Clk(Clk), 
                 .Rstn(Rstn), 
                 .Pcil_dat_i(Pcil_dat_i), 
                 .Pcil_adr_i(Pcil_adr_i), 
                 .Pcil_cmd_i(Pcil_cmd_i), 
                 .Pcilt_rdy_n_o(mstr_rdy), 
                 .Pcilt_frame_n_i(Pcilt_frame_n_i), 
                 .Pcilt_ack_n_i(Pcilt_ack_n_i), 
                 .Pcilt_dxfr_n_i(Pcilt_dxfr_n_i), 
                 .Pcilt_tsr_i(Pcilt_tsr_i), 
                 .Mstr_done_i(mstr_done), 
                 .Mstr_strt_o(mstr_actv), 
                 .Mstr_dma_sa_o(dma_sa), 
                 .Mstr_dma_bc_la_o(dma_bc_la)); 

          
   local_master u5 (.Clk(Clk), 
                  .Rstn(Rstn), 
                  .PciAd_o(l_adi_mstr), 
                  .PciCben_o(l_cbeni_mstr), 
                  .PciData_i(Pcil_dat_i[31:0]), 
                  .PciLDataAck_n_i(Pcildat_ack_n_i), 
                  .PciHDataAck_n_i(Pcihdat_ack_n_i), 
                  .PciReq32_n_o(Pcilm_req32_n_o), 
                  .PciReq64_n_o(Pcilm_req64_n_o), 
                  .PciLastTx_n_o(Pcilm_last_n_o), 
                  .PciRdy_n_o(Pcilm_rdy_n_o), 
                  .PciAdrAck_n_i(Pcilmdr_ack_n_i), 
                  .PciAck_n_i(Pcilm_ack_n_i), 
                  .PciDxfr_n_i(Pcilm_dxfr_n_i), 
                  .PciLmTsr_i(Pcilm_tsr_i), 
                  .IODat_i(io_reg),
                  .DmaSa_i(dma_sa), 
                  .DmaBcLa_i(dma_bc_la), 
                  .DmaStrtMstr_i(mstr_actv), 
                  .DmaMstrDone_o(mstr_done), 
                  .MstrDataTx_o(data_tx_mstr), 
                  .MstrPrftchOn_o(prftch_on_mstr), 
                  .PrftchReg_i(prftch_reg), 
                  .MstrIOWren_o(iomstrwr_en),
                  .SramAddr_o(mem_addr_mstr), 
                  .SramHighWrEn_o(we_high_mstr), 
                  .SramLowWrEn_o(we_low_mstr), 
                  .SramHighDw_i(q_high), 
                  .SramLowDw_i(q_low)); 
   
   
   
   prefetch u6 (  .Clk(Clk), 
                  .Rstn(Rstn), 
                  .Prftch_i(prftch_on), 
                  .Sx_data_tx_i(data_tx), 
                  .Sram_data_i(q), 
                  .Trgt64_tx_i(trgt64_tx),
                  .Prftch_o(prftch_reg), 
                  .Mstr_done_i(mstr_done), 
                  .Trgt_done_i(trgt_done));
                     
                     

   // lt_rdyn signal indicates target is ready to accept or provide data
   // As such this signal should be driven only by the target controller(local_target)
   // In this reference design DMA engine of the Master is also driving lt_rdyn because
   // the DMA registers are configured by the testbench Master transactor(mstr_tranx)   
   assign Pcilt_rdy_n_o = trgt_rdy & mstr_rdy ;                   
   
   // l_adi  is driven by Master if mstr_active is active else driven by the target
   assign Pcil_adi_o = (mstr_actv) ? l_adi_mstr : l_adi_trgt ; 
   
   // l_adi  is driven by Master if mstr_active is active
   assign Pcil_cben_o = (mstr_actv) ? l_cbeni_mstr : 8'h00 ; 
   
   // SRAM memory address will be driven if master is active else driven by the target
   assign mem_addr = (mstr_actv) ? mem_addr_mstr : mem_addr_trgt ; 
   
   // we implement two 32-bit RAM(high and low)
   // Hence the write enable high and we enable low is driven by Master when master is
   // active else it is driven by target.
   assign we_high = (mstr_actv) ? we_high_mstr : we_high_trgt ; 
   assign we_low = (mstr_actv) ? we_low_mstr : we_low_trgt ; 
   
   
   // Prefetch logic is explained in the Prefetch file
   // This signal goes active for one clock during target read and
   // Master write transaction.
   assign prftch_on = prftch_on_mstr | prftch_on_trgt ; 
   
   // This signal is used by prfetch logic
   // data_tx indicates successful data transfer
   // this is realised by assertion of lt_ackn and lt_dxfrn in case of target
   // and assertion of lm_ackn and lm_dxfrn in case of master.   
   assign data_tx = data_tx_mstr | data_tx_trgt ; 
   
   // This is the output from the SRAM
   // q_high is the output from the higher 32-bit RAM
   // q_low is the output from the lower 32-bit RAM
   assign q[63:32] = q_high ; 
   assign q[31:0] = q_low ; 
   
   // This signal is used during 32-bit PCI and 64-bit Local side
   // The local side is 64 bit that implements two 32-bit RAMs(low and high)
   // Since PCI transaction is 32-bit the high dword also comes on l_dati(31:0)
   // This data needs to be steered to the high dword RAM
   // high dword steers the data to the high dword RAM in case of
   // target write transaction(use lt_tsr(7)) to check whether the transaction is 32-bit or 64-bit on PCI bus
   // and during Master Write transaction signified by lm_req32n(DMA configuration of 000 indicates a 32 bit request)
   // The data presented to the 32-bit RAM is qualified by Write enable
   // Check the SramWren signal from local_target and local_master.
      
   assign high_dword = ((dma_bc_la[31:29] == 3'b000 & mstr_actv) | (!Pcilt_frame_n_i & !(Pcilt_tsr_i[7])))  ? Pcil_dat_i[31:0] : Pcil_dat_i[63:32];
              
   

//********************************************************************************
// IO Register
// This is a demo register that simulates IO read and write register functionality
// As shown this register is enabled when IO target write enable or IO Master
// Write Enable is active.
//**********************************************************************************
always @(posedge Clk or negedge Rstn)
begin   
   if (!Rstn) 
       io_reg <= 32'b0; 
   else 
     begin        
        if ( iotrgtwr_en | iomstrwr_en)   
             io_reg <= Pcil_dat_i[31:0] ; 
     end        
end 


endmodule
