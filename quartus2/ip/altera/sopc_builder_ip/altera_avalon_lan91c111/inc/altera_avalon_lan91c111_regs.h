/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2003 Altera Corporation, San Jose, California, USA.           *
* All rights reserved.                                                        *
*                                                                             *
* Permission is hereby granted, free of charge, to any person obtaining a     *
* copy of this software and associated documentation files (the "Software"),  *
* to deal in the Software without restriction, including without limitation   *
* the rights to use, copy, modify, merge, publish, distribute, sublicense,    *
* and/or sell copies of the Software, and to permit persons to whom the       *
* Software is furnished to do so, subject to the following conditions:        *
*                                                                             *
* The above copyright notice and this permission notice shall be included in  *
* all copies or substantial portions of the Software.                         *
*                                                                             *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     *
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         *
* DEALINGS IN THE SOFTWARE.                                                   *
*                                                                             *
* This agreement shall be governed in all respects by the laws of the State   *
* of California and by the laws of the United States of America.              *
*                                                                             *
******************************************************************************/

/*
* Register definitions for the Lan 91C111 ethernet chip used on the Nios 
* development boards
*/

#include <io.h>

#ifndef __ALTERA_AVALON_LAN91C111_REGS_H_
#define __ALTERA_AVALON_LAN91C111_REGS_H_

#define ALTERA_AVALON_LAN91C111_CHIP_ID                   0x3390
#define ALTERA_AVALON_LAN91C111_CHIP_REV                  0x1

/*
* There are four banks of registers, each paged in or out depending upon the
* value written to the Bank Select Register
*/

#define IOADDR_ALTERA_AVALON_LAN91C111_BSR(base)          __IO_CALC_ADDRESS_NATIVE(base, 14)      
#define IORD_ALTERA_AVALON_LAN91C111_BSR(base)            IORD_16DIRECT(base, 14)
#define IOWR_ALTERA_AVALON_LAN91C111_BSR(base,data)       IOWR_16DIRECT(base, 14, data)

/*
* Bank 0 registers
*/ 

/* Transmit Control Register */
#define IOADDR_ALTERA_AVALON_LAN91C111_TCR(base)          __IO_CALC_ADDRESS_NATIVE(base, 0)
#define IORD_ALTERA_AVALON_LAN91C111_TCR(base)            IORD_16DIRECT(base, 0)
#define IOWR_ALTERA_AVALON_LAN91C111_TCR(base,data)       IOWR_16DIRECT(base, 0, data)

#define ALTERA_AVALON_LAN91C111_TCR_TXENA_MSK             0x1        
#define ALTERA_AVALON_LAN91C111_TCR_TXENA_OFST            0
#define ALTERA_AVALON_LAN91C111_TCR_LOOP_MSK              0x2        
#define ALTERA_AVALON_LAN91C111_TCR_LOOP_OFST             1        
#define ALTERA_AVALON_LAN91C111_TCR_FORCOL_MSK            0x4        
#define ALTERA_AVALON_LAN91C111_TCR_FORCOL_OFST           2        
#define ALTERA_AVALON_LAN91C111_TCR_PAD_EN_MSK            0x80        
#define ALTERA_AVALON_LAN91C111_TCR_PAD_EN_OFST           7        
#define ALTERA_AVALON_LAN91C111_TCR_NOCRC_MSK             0x100        
#define ALTERA_AVALON_LAN91C111_TCR_NOCRC_OFST            8        
#define ALTERA_AVALON_LAN91C111_TCR_MON_CSN_MSK           0x400        
#define ALTERA_AVALON_LAN91C111_TCR_MON_CSN_OFST          10        
#define ALTERA_AVALON_LAN91C111_TCR_FDUPLX_MSK            0x800  
#define ALTERA_AVALON_LAN91C111_TCR_FDUPLX_OFST           11  
#define ALTERA_AVALON_LAN91C111_TCR_STP_SQET_MSK          0x1000        
#define ALTERA_AVALON_LAN91C111_TCR_STP_SQET_OFST         12        
#define ALTERA_AVALON_LAN91C111_TCR_EPH_LOOP_MSK          0x2000        
#define ALTERA_AVALON_LAN91C111_TCR_EPH_LOOP_OFST         13        
#define ALTERA_AVALON_LAN91C111_TCR_SWFDUP_MSK            0x8000        
#define ALTERA_AVALON_LAN91C111_TCR_SWFDUP_OFST           15        

/* EPH Status Register */
#define IOADDR_ALTERA_AVALON_LAN91C111_EPHSR(base)        __IO_CALC_ADDRESS_NATIVE(base, 2)
#define IORD_ALTERA_AVALON_LAN91C111_EPHSR(base)          IORD_16DIRECT(base, 2)
#define IOWR_ALTERA_AVALON_LAN91C111_EPHSR(base,data)     IOWR_16DIRECT(base, 2, data)

#define ALTERA_AVALON_LAN91C111_EPHSR_TX_SUC_MSK          0x1       
#define ALTERA_AVALON_LAN91C111_EPHSR_TX_SUC_OFST         0       
#define ALTERA_AVALON_LAN91C111_EPHSR_COL_MSK             0x2       
#define ALTERA_AVALON_LAN91C111_EPHSR_COL_OFST            1       
#define ALTERA_AVALON_LAN91C111_EPHSR_MUL_COL_MSK         0x4       
#define ALTERA_AVALON_LAN91C111_EPHSR_MUL_COL_OFST        2       
#define ALTERA_AVALON_LAN91C111_EPHSRLTX_MULT_MSK         0x8       
#define ALTERA_AVALON_LAN91C111_EPHSRLTX_MULT_OFST        3       
#define ALTERA_AVALON_LAN91C111_EPHSR_16COL_MSK           0x10       
#define ALTERA_AVALON_LAN91C111_EPHSR_16COL_OFST          4       
#define ALTERA_AVALON_LAN91C111_EPHSR_SQET_MSK            0x20       
#define ALTERA_AVALON_LAN91C111_EPHSR_SQET_OFST           5       
#define ALTERA_AVALON_LAN91C111_EPHSR_LTXBRD_MSK          0x40       
#define ALTERA_AVALON_LAN91C111_EPHSR_LTXBRD_OFST         6       
#define ALTERA_AVALON_LAN91C111_EPHSR_TXDEFR_MSK          0x80       
#define ALTERA_AVALON_LAN91C111_EPHSR_TXDEFR_OFST         7       
#define ALTERA_AVALON_LAN91C111_EPHSR_LATCOL_MSK          0x200       
#define ALTERA_AVALON_LAN91C111_EPHSR_LATCOL_OFST         9       
#define ALTERA_AVALON_LAN91C111_EPHSR_LOSTCARR_MSK        0x400       
#define ALTERA_AVALON_LAN91C111_EPHSR_LOSTCARR_OFST       10       
#define ALTERA_AVALON_LAN91C111_EPHSR_EXC_DEF_MSK         0x800       
#define ALTERA_AVALON_LAN91C111_EPHSR_EXC_DEF_OFST        11       
#define ALTERA_AVALON_LAN91C111_EPHSR_CTR_ROL_MSK         0x1000       
#define ALTERA_AVALON_LAN91C111_EPHSR_CTR_ROL_OFST        12
#define ALTERA_AVALON_LAN91C111_EPHSR_LINK_OK_MSK         0x4000       
#define ALTERA_AVALON_LAN91C111_EPHSR_LINK_OK_OFST        14       
#define ALTERA_AVALON_LAN91C111_EPHSR_TXUNRN_MSK          0x8000       
#define ALTERA_AVALON_LAN91C111_EPHSR_TXUNRN_OFST         15       

/* Receive Control Register */  
#define IOADDR_ALTERA_AVALON_LAN91C111_RCR(base)          __IO_CALC_ADDRESS_NATIVE(base, 4)
#define IORD_ALTERA_AVALON_LAN91C111_RCR(base)            IORD_16DIRECT(base, 4)
#define IOWR_ALTERA_AVALON_LAN91C111_RCR(base,data)       IOWR_16DIRECT(base, 4, data)

#define ALTERA_AVALON_LAN91C111_RCR_RX_ABORT_MSK          0x1  
#define ALTERA_AVALON_LAN91C111_RCR_RX_ABORT_OFST         0  
#define ALTERA_AVALON_LAN91C111_RCR_PRMS_MSK              0x2  
#define ALTERA_AVALON_LAN91C111_RCR_PRMS_OFST             1  
#define ALTERA_AVALON_LAN91C111_RCR_ALMUL_MSK             0x4  
#define ALTERA_AVALON_LAN91C111_RCR_ALMUL_OFST            2  
#define ALTERA_AVALON_LAN91C111_RCR_RXEN_MSK              0x100  
#define ALTERA_AVALON_LAN91C111_RCR_RXEN_OFST             8
#define ALTERA_AVALON_LAN91C111_RCR_STRIP_CRC_MSK         0x200  
#define ALTERA_AVALON_LAN91C111_RCR_STRIP_CRC_OFST        9  
#define ALTERA_AVALON_LAN91C111_RCR_ABORT_ENB_MSK         0x2000  
#define ALTERA_AVALON_LAN91C111_RCR_ABORT_ENB_OFST        13  
#define ALTERA_AVALON_LAN91C111_RCR_FILT_CAR_MSK          0x4000  
#define ALTERA_AVALON_LAN91C111_RCR_FILT_CAR_OFST         14  
#define ALTERA_AVALON_LAN91C111_RCR_SOFTRST_MSK           0x8000  
#define ALTERA_AVALON_LAN91C111_RCR_SOFTRST_OFST          15  


/* Counter Register */
#define IOADDR_ALTERA_AVALON_LAN91C111_ECR(base)          __IO_CALC_ADDRESS_NATIVE(base, 6)
#define IORD_ALTERA_AVALON_LAN91C111_ECR(base)            IORD_16DIRECT(base, 6)
#define IOWR_ALTERA_AVALON_LAN91C111_ECR(base,data)       IOWR_16DIRECT(base, 6, data)

/* Memory Information Register */
#define IOADDR_ALTERA_AVALON_LAN91C111_MIR(base)          __IO_CALC_ADDRESS_NATIVE(base, 8)
#define IORD_ALTERA_AVALON_LAN91C111_MIR(base)            IORD_16DIRECT(base, 8)
#define IOWR_ALTERA_AVALON_LAN91C111_MIR(base,data)       IOWR_16DIRECT(base, 8, data)

/* Receive/Phy Control Register */
#define IOADDR_ALTERA_AVALON_LAN91C111_RPCR(base)         __IO_CALC_ADDRESS_NATIVE(base, 10)
#define IORD_ALTERA_AVALON_LAN91C111_RPCR(base)           IORD_16DIRECT(base, 10)
#define IOWR_ALTERA_AVALON_LAN91C111_RPCR(base,data)      IOWR_16DIRECT(base, 10, data)

#define ALTERA_AVALON_LAN91C111_RPCR_LS0B_MSK             0x4
#define ALTERA_AVALON_LAN91C111_RPCR_LS0B_OFST            2
#define ALTERA_AVALON_LAN91C111_RPCR_LS1B_MSK             0x8
#define ALTERA_AVALON_LAN91C111_RPCR_LS1B_OFST            3
#define ALTERA_AVALON_LAN91C111_RPCR_LS2B_MSK             0x10
#define ALTERA_AVALON_LAN91C111_RPCR_LS2B_OFST            4
#define ALTERA_AVALON_LAN91C111_RPCR_LS0A_MSK             0x20
#define ALTERA_AVALON_LAN91C111_RPCR_LS0A_OFST            5
#define ALTERA_AVALON_LAN91C111_RPCR_LS1A_MSK             0x40
#define ALTERA_AVALON_LAN91C111_RPCR_LS1A_OFST            6
#define ALTERA_AVALON_LAN91C111_RPCR_LS2A_MSK             0x80
#define ALTERA_AVALON_LAN91C111_RPCR_LS2A_OFST            7
#define ALTERA_AVALON_LAN91C111_RPCR_ANEG_MSK             0x800
#define ALTERA_AVALON_LAN91C111_RPCR_ANEG_OFST            11
#define ALTERA_AVALON_LAN91C111_RPCR_DPLX_MSK             0x1000  
#define ALTERA_AVALON_LAN91C111_RPCR_DPLX_OFST            12  
#define ALTERA_AVALON_LAN91C111_RPCR_SPEED_MSK            0x2000  
#define ALTERA_AVALON_LAN91C111_RPCR_SPEED_OFST           13  

/* Bank 1 Registers */

/* Configuration Reg */
#define IOADDR_ALTERA_AVALON_LAN91C111_CR(base)           __IO_CALC_ADDRESS_NATIVE(base, 0)
#define IORD_ALTERA_AVALON_LAN91C111_CR(base)             IORD_16DIRECT(base, 0)
#define IOWR_ALTERA_AVALON_LAN91C111_CR(base,data)        IOWR_16DIRECT(base, 0, data)

#define ALTERA_AVALON_LAN91C111_CR_EXT_PHY_MSK            0x200  
#define ALTERA_AVALON_LAN91C111_CR_EXT_PHY_OFST           9  
#define ALTERA_AVALON_LAN91C111_CR_GPCNTRL_MSK            0x400  
#define ALTERA_AVALON_LAN91C111_CR_GPCNTRL_OFST           10  
#define ALTERA_AVALON_LAN91C111_CR_NO_WAIT_MSK            0x1000  
#define ALTERA_AVALON_LAN91C111_CR_NO_WAIT_OFST           12  
#define ALTERA_AVALON_LAN91C111_CR_EPH_POWER_EN_MSK       0x8000 
#define ALTERA_AVALON_LAN91C111_CR_EPH_POWER_EN_OFST      15 

/* Base Address Register */
#define IOADDR_ALTERA_AVALON_LAN91C111_BAR(base)          __IO_CALC_ADDRESS_NATIVE(base, 2)
#define IORD_ALTERA_AVALON_LAN91C111_BAR(base)            IORD_16DIRECT(base, 2)
#define IOWR_ALTERA_AVALON_LAN91C111_BAR(base,data)       IOWR_16DIRECT(base, 2, data)

/* Individual Address Registers */
#define IOADDR_ALTERA_AVALON_LAN91C111_IAR0(base)         __IO_CALC_ADDRESS_NATIVE(base, 4)
#define IORD_ALTERA_AVALON_LAN91C111_IAR0(base)           IORD_8DIRECT(base, 4)
#define IOWR_ALTERA_AVALON_LAN91C111_IAR0(base,data)      IOWR_8DIRECT(base, 4, data)
#define IOADDR_ALTERA_AVALON_LAN91C111_IAR1(base)         __IO_CALC_ADDRESS_NATIVE(base, 5)
#define IORD_ALTERA_AVALON_LAN91C111_IAR1(base)           IORD_8DIRECT(base, 5)
#define IOWR_ALTERA_AVALON_LAN91C111_IAR1(base,data)      IOWR_8DIRECT(base, 5, data)
#define IOADDR_ALTERA_AVALON_LAN91C111_IAR2(base)         __IO_CALC_ADDRESS_NATIVE(base, 6)
#define IORD_ALTERA_AVALON_LAN91C111_IAR2(base)           IORD_8DIRECT(base, 6)
#define IOWR_ALTERA_AVALON_LAN91C111_IAR2(base,data)      IOWR_8DIRECT(base, 6, data)
#define IOADDR_ALTERA_AVALON_LAN91C111_IAR3(base)         __IO_CALC_ADDRESS_NATIVE(base, 7)
#define IORD_ALTERA_AVALON_LAN91C111_IAR3(base)           IORD_8DIRECT(base, 7)
#define IOWR_ALTERA_AVALON_LAN91C111_IAR3(base,data)      IOWR_8DIRECT(base, 7, data)
#define IOADDR_ALTERA_AVALON_LAN91C111_IAR4(base)         __IO_CALC_ADDRESS_NATIVE(base, 8)
#define IORD_ALTERA_AVALON_LAN91C111_IAR4(base)           IORD_8DIRECT(base, 8)
#define IOWR_ALTERA_AVALON_LAN91C111_IAR4(base,data)      IOWR_8DIRECT(base, 8, data)
#define IOADDR_ALTERA_AVALON_LAN91C111_IAR5(base)         __IO_CALC_ADDRESS_NATIVE(base, 9)
#define IORD_ALTERA_AVALON_LAN91C111_IAR5(base)           IORD_8DIRECT(base, 9)
#define IOWR_ALTERA_AVALON_LAN91C111_IAR5(base,data)      IOWR_8DIRECT(base, 9, data)
#define IORD_ALTERA_AVALON_LAN91C111_IAR0_1(base)         IORD_16DIRECT(base, 4)
#define IOWR_ALTERA_AVALON_LAN91C111_IAR0_1(base,data)    IOWR_16DIRECT(base, 4, data)
#define IORD_ALTERA_AVALON_LAN91C111_IAR2_3(base)         IORD_16DIRECT(base, 6)
#define IOWR_ALTERA_AVALON_LAN91C111_IAR2_3(base,data)    IOWR_16DIRECT(base, 6, data)
#define IORD_ALTERA_AVALON_LAN91C111_IAR4_5(base)         IORD_16DIRECT(base, 8)
#define IOWR_ALTERA_AVALON_LAN91C111_IAR4_5(base,data)    IOWR_16DIRECT(base, 8, data)

/* General Purpose Register */
#define IOADDR_ALTERA_AVALON_LAN91C111_GPR(base)          __IO_CALC_ADDRESS_NATIVE(base, 10)
#define IORD_ALTERA_AVALON_LAN91C111_GPR(base)            IORD_16DIRECT(base, 10)
#define IOWR_ALTERA_AVALON_LAN91C111_GPR(base,data)       IOWR_16DIRECT(base, 10, data)

/* Control Register */
#define IOADDR_ALTERA_AVALON_LAN91C111_CTR(base)          __IO_CALC_ADDRESS_NATIVE(base, 12)
#define IORD_ALTERA_AVALON_LAN91C111_CTR(base)            IORD_16DIRECT(base, 12)
#define IOWR_ALTERA_AVALON_LAN91C111_CTR(base,data)       IOWR_16DIRECT(base, 12, data)

#define ALTERA_AVALON_LAN91C111_CTR_STORE_MSK             0x1 
#define ALTERA_AVALON_LAN91C111_CTR_STORE_OFST            0 
#define ALTERA_AVALON_LAN91C111_CTR_RELOAD_MSK            0x2 
#define ALTERA_AVALON_LAN91C111_CTR_RELOAD_OFST           1 
#define ALTERA_AVALON_LAN91C111_CTR_EEPROM_SELECT_MSK     0x4 
#define ALTERA_AVALON_LAN91C111_CTR_EEPROM_SELECT_OFST    2 
#define ALTERA_AVALON_LAN91C111_CTR_TE_ENABLE_MSK         0x20 
#define ALTERA_AVALON_LAN91C111_CTR_TE_ENABLE_OFST        5 
#define ALTERA_AVALON_LAN91C111_CTR_CR_ENABLE_MSK         0x40 
#define ALTERA_AVALON_LAN91C111_CTR_CR_ENABLE_OFST        6 
#define ALTERA_AVALON_LAN91C111_CTR_LE_ENABLE_MSK         0x80 
#define ALTERA_AVALON_LAN91C111_CTR_LE_ENABLE_OFST        7 
#define ALTERA_AVALON_LAN91C111_CTR_AUTO_RELEASE_MSK      0x800 
#define ALTERA_AVALON_LAN91C111_CTR_AUTO_RELEASE_OFST     11 
#define ALTERA_AVALON_LAN91C111_CTR_RCV_BAD_MSK           0x4000 
#define ALTERA_AVALON_LAN91C111_CTR_RCV_BAD_OFST          14 

/* Bank 2 Registers */

/* MMU Command Register */
#define IOADDR_ALTERA_AVALON_LAN91C111_MMUCR(base)        __IO_CALC_ADDRESS_NATIVE(base, 0)
#define IORD_ALTERA_AVALON_LAN91C111_MMUCR(base)          IORD_16DIRECT(base, 0)
#define IOWR_ALTERA_AVALON_LAN91C111_MMUCR(base,data)     IOWR_16DIRECT(base, 0, data)

#define ALTERA_AVALON_LAN91C111_MMUCR_BUSY_MSK            0x1 
#define ALTERA_AVALON_LAN91C111_MMUCR_BUSY_OFST           0
#define ALTERA_AVALON_LAN91C111_MMUCR_CMD_OFST            5
#define ALTERA_AVALON_LAN91C111_MMUCR_NOP_MSK             (0<<ALTERA_AVALON_LAN91C111_MMUCR_CMD_OFST)  
#define ALTERA_AVALON_LAN91C111_MMUCR_ALLOC_MSK           (1<<ALTERA_AVALON_LAN91C111_MMUCR_CMD_OFST)  
#define ALTERA_AVALON_LAN91C111_MMUCR_RESET_MSK           (2<<ALTERA_AVALON_LAN91C111_MMUCR_CMD_OFST)  
#define ALTERA_AVALON_LAN91C111_MMUCR_REMOVE_MSK          (3<<ALTERA_AVALON_LAN91C111_MMUCR_CMD_OFST)  
#define ALTERA_AVALON_LAN91C111_MMUCR_REMOVE_RELEASE_MSK  (4<<ALTERA_AVALON_LAN91C111_MMUCR_CMD_OFST)  
#define ALTERA_AVALON_LAN91C111_MMUCR_RELEASE_MSK         (5<<ALTERA_AVALON_LAN91C111_MMUCR_CMD_OFST)  
#define ALTERA_AVALON_LAN91C111_MMUCR_ENQUEUE_MSK         (6<<ALTERA_AVALON_LAN91C111_MMUCR_CMD_OFST)  
#define ALTERA_AVALON_LAN91C111_MMUCR_RESET_TX_MSK        (7<<ALTERA_AVALON_LAN91C111_MMUCR_CMD_OFST)  

/* Packet Number Register */
#define IOADDR_ALTERA_AVALON_LAN91C111_PNR(base)          __IO_CALC_ADDRESS_NATIVE(base, 2)
#define IORD_ALTERA_AVALON_LAN91C111_PNR(base)            IORD_8DIRECT(base, 2)
#define IOWR_ALTERA_AVALON_LAN91C111_PNR(base,data)       IOWR_8DIRECT(base, 2, data)

/* Allocation Result Register */
#define IOADDR_ALTERA_AVALON_LAN91C111_ARR(base)          __IO_CALC_ADDRESS_NATIVE(base, 3)
#define IORD_ALTERA_AVALON_LAN91C111_ARR(base)            IORD_8DIRECT(base, 3)
#define IOWR_ALTERA_AVALON_LAN91C111_ARR(base,data)       IOWR_8DIRECT(base, 3, data)

#define ALTERA_AVALON_LAN91C111_ARR_FAILED_MSK            0x80    
#define ALTERA_AVALON_LAN91C111_ARR_FAILED_OFST           7    

/* Receive FIFO Ports Register */
#define IOADDR_ALTERA_AVALON_LAN91C111_RX_FIFO(base)      __IO_CALC_ADDRESS_NATIVE(base, 4)
#define IORD_ALTERA_AVALON_LAN91C111_RX_FIFO(base)        IORD_16DIRECT(base, 4)
#define IOWR_ALTERA_AVALON_LAN91C111_RX_FIFO(base,data)   IOWR_16DIRECT(base, 4, data)

#define ALTERA_AVALON_LAN91C111_RX_FIFO_REMPTY_MSK        0x8000  
#define ALTERA_AVALON_LAN91C111_RX_FIFO_REMPTY_OFST       15  

/* Transmit FIFO Ports Register */
#define IOADDR_ALTERA_AVALON_LAN91C111_TX_FIFO(base)      __IO_CALC_ADDRESS_NATIVE(base, 4)
#define IORD_ALTERA_AVALON_LAN91C111_TX_FIFO(base)        IORD_16DIRECT(base, 4)
#define IOWR_ALTERA_AVALON_LAN91C111_TX_FIFO(base,data)   IOWR_16DIRECT(base, 4, data)

#define ALTERA_AVALON_LAN91C111_TX_FIFO_TEMPTY_MSK        0x80    
#define ALTERA_AVALON_LAN91C111_TX_FIFO_TEMPTY_OFST       7    

/* Pointer Register */
#define IOADDR_ALTERA_AVALON_LAN91C111_PTR(base)          __IO_CALC_ADDRESS_NATIVE(base, 6)
#define IORD_ALTERA_AVALON_LAN91C111_PTR(base)            IORD_16DIRECT(base, 6)
#define IOWR_ALTERA_AVALON_LAN91C111_PTR(base,data)       IOWR_16DIRECT(base, 6, data)

#define ALTERA_AVALON_LAN91C111_PTR_LOW_MSK               0xFF 
#define ALTERA_AVALON_LAN91C111_PTR_LOW_OFST              0 
#define ALTERA_AVALON_LAN91C111_PTR_HIGH_MSK              0x700 
#define ALTERA_AVALON_LAN91C111_PTR_HIGH_OFST             8 
#define ALTERA_AVALON_LAN91C111_PTR_NOT_EMPTY_MSK         0x800 
#define ALTERA_AVALON_LAN91C111_PTR_NOT_EMPTY_OFST        11 
#define ALTERA_AVALON_LAN91C111_PTR_ETEN_MSK              0x1000
#define ALTERA_AVALON_LAN91C111_PTR_ETEN_OFST             12
#define ALTERA_AVALON_LAN91C111_PTR_READ_MSK              0x2000 
#define ALTERA_AVALON_LAN91C111_PTR_READ_OFST             13 
#define ALTERA_AVALON_LAN91C111_PTR_AUTO_INCR_MSK         0x4000 
#define ALTERA_AVALON_LAN91C111_PTR_AUTO_INCR_OFST        14 
#define ALTERA_AVALON_LAN91C111_PTR_RCV_MSK               0x8000 
#define ALTERA_AVALON_LAN91C111_PTR_RCV_OFST              15 

/* Data Register */
#define IOADDR_ALTERA_AVALON_LAN91C111_DATA(base)         __IO_CALC_ADDRESS_NATIVE(base, 8)
#define IORD_ALTERA_AVALON_LAN91C111_DATA_BYTE(base)      IORD_8DIRECT(base, 8)
#define IOWR_ALTERA_AVALON_LAN91C111_DATA_BYTE(base,data) IOWR_8DIRECT(base, 8, data)
#define IORD_ALTERA_AVALON_LAN91C111_DATA_HW(base)        IORD_16DIRECT(base, 8)
#define IOWR_ALTERA_AVALON_LAN91C111_DATA_HW(base,data)   IOWR_16DIRECT(base, 8, data)
#define IORD_ALTERA_AVALON_LAN91C111_DATA_WORD(base)      IORD_32DIRECT(base, 8)
#define IOWR_ALTERA_AVALON_LAN91C111_DATA_WORD(base,data) IOWR_32DIRECT(base, 8, data)
   
/* 
* Interrupt Status Registers
*/

/* Interrupt Status Register */
#define IOADDR_ALTERA_AVALON_LAN91C111_IST(base)          __IO_CALC_ADDRESS_NATIVE(base, 12)
#define IORD_ALTERA_AVALON_LAN91C111_IST(base)            IORD_8DIRECT(base, 12)

/* Interrupt ACK Register */
#define IOWR_ALTERA_AVALON_LAN91C111_ACK(base, data)      IOWR_8DIRECT(base, 12, data)

/* Interrupt Mask Register */
#define IOADDR_ALTERA_AVALON_LAN91C111_MSK(base)          __IO_CALC_ADDRESS_NATIVE(base, 13)
#define IORD_ALTERA_AVALON_LAN91C111_MSK(base)            IORD_8DIRECT(base, 13)
#define IOWR_ALTERA_AVALON_LAN91C111_MSK(base, data)      IOWR_8DIRECT(base, 13, data)

/* The bit definitions are the same for all three registers */
#define ALTERA_AVALON_LAN91C111_INT_RCV_INT_MSK           0x1 
#define ALTERA_AVALON_LAN91C111_INT_RCV_INT_OFST          0 
#define ALTERA_AVALON_LAN91C111_INT_TX_INT_MSK            0x2 
#define ALTERA_AVALON_LAN91C111_INT_TX_INT_OFST           1
#define ALTERA_AVALON_LAN91C111_INT_TX_EMPTY_INT_MSK      0x4 
#define ALTERA_AVALON_LAN91C111_INT_TX_EMPTY_INT_OFST     2 
#define ALTERA_AVALON_LAN91C111_INT_ALLOC_INT_MSK         0x8
#define ALTERA_AVALON_LAN91C111_INT_ALLOC_INT_OFST        3
#define ALTERA_AVALON_LAN91C111_INT_RX_OVRN_INT_MSK       0x10
#define ALTERA_AVALON_LAN91C111_INT_RX_OVRN_INT_OFST      4
#define ALTERA_AVALON_LAN91C111_INT_EPH_INT_MSK           0x20
#define ALTERA_AVALON_LAN91C111_INT_EPH_INT_OFST          5
#define ALTERA_AVALON_LAN91C111_INT_ERCV_INT_MSK          0x40
#define ALTERA_AVALON_LAN91C111_INT_ERCV_INT_OFST         6
#define ALTERA_AVALON_LAN91C111_INT_MDINT_MSK             0x80
#define ALTERA_AVALON_LAN91C111_INT_MDINT_OFST            7

/* Bank 3 Registers */

/* Multicast Table Registers */
#define IOADDR_ALTERA_AVALON_LAN91C111_MT0(base)          __IO_CALC_ADDRESS_NATIVE(base, 0)
#define IORD_ALTERA_AVALON_LAN91C111_MT0(base)            IORD_8DIRECT(base, 0)
#define IOWR_ALTERA_AVALON_LAN91C111_MT0(base, data)      IOWR_8DIRECT(base, 0, data)
#define IOADDR_ALTERA_AVALON_LAN91C111_MT1(base)          __IO_CALC_ADDRESS_NATIVE(base, 1)
#define IORD_ALTERA_AVALON_LAN91C111_MT1(base)            IORD_8DIRECT(base, 1)
#define IOWR_ALTERA_AVALON_LAN91C111_MT1(base, data)      IOWR_8DIRECT(base, 1, data)
#define IOADDR_ALTERA_AVALON_LAN91C111_MT2(base)          __IO_CALC_ADDRESS_NATIVE(base, 2)
#define IORD_ALTERA_AVALON_LAN91C111_MT2(base)            IORD_8DIRECT(base, 2)
#define IOWR_ALTERA_AVALON_LAN91C111_MT2(base, data)      IOWR_8DIRECT(base, 2, data)
#define IOADDR_ALTERA_AVALON_LAN91C111_MT3(base)          __IO_CALC_ADDRESS_NATIVE(base, 3)
#define IORD_ALTERA_AVALON_LAN91C111_MT3(base)            IORD_8DIRECT(base, 3)
#define IOWR_ALTERA_AVALON_LAN91C111_MT3(base, data)      IOWR_8DIRECT(base, 3, data)
#define IOADDR_ALTERA_AVALON_LAN91C111_MT4(base)          __IO_CALC_ADDRESS_NATIVE(base, 4)
#define IORD_ALTERA_AVALON_LAN91C111_MT4(base)            IORD_8DIRECT(base, 4)
#define IOWR_ALTERA_AVALON_LAN91C111_MT4(base, data)      IOWR_8DIRECT(base, 4, data)
#define IOADDR_ALTERA_AVALON_LAN91C111_MT5(base)          __IO_CALC_ADDRESS_NATIVE(base, 5)
#define IORD_ALTERA_AVALON_LAN91C111_MT5(base)            IORD_8DIRECT(base, 5)
#define IOWR_ALTERA_AVALON_LAN91C111_MT5(base, data)      IOWR_8DIRECT(base, 5, data)
#define IOADDR_ALTERA_AVALON_LAN91C111_MT6(base)          __IO_CALC_ADDRESS_NATIVE(base, 6)
#define IORD_ALTERA_AVALON_LAN91C111_MT6(base)            IORD_8DIRECT(base, 6)
#define IOWR_ALTERA_AVALON_LAN91C111_MT6(base, data)      IOWR_8DIRECT(base, 6, data)
#define IOADDR_ALTERA_AVALON_LAN91C111_MT7(base)          __IO_CALC_ADDRESS_NATIVE(base, 7)
#define IORD_ALTERA_AVALON_LAN91C111_MT7(base)            IORD_8DIRECT(base, 7)
#define IOWR_ALTERA_AVALON_LAN91C111_MT7(base, data)      IOWR_8DIRECT(base, 7, data)

/* Management Interface Register */
#define IOADDR_ALTERA_AVALON_LAN91C111_MGMT(base)         __IO_CALC_ADDRESS_NATIVE(base, 8)
#define IORD_ALTERA_AVALON_LAN91C111_MGMT(base)           IORD_16DIRECT(base, 8)
#define IOWR_ALTERA_AVALON_LAN91C111_MGMT(base, data)     IOWR_16DIRECT(base, 8, data)

#define ALTERA_AVALON_LAN91C111_MGMT_MDO_MSK              0x1 
#define ALTERA_AVALON_LAN91C111_MGMT_MDO_OFST             0 
#define ALTERA_AVALON_LAN91C111_MGMT_MDI_MSK              0x2 
#define ALTERA_AVALON_LAN91C111_MGMT_MDI_OFST             1 
#define ALTERA_AVALON_LAN91C111_MGMT_MCLK_MSK             0x4 
#define ALTERA_AVALON_LAN91C111_MGMT_MCLK_OFST            2 
#define ALTERA_AVALON_LAN91C111_MGMT_MDOE_MSK             0x8 
#define ALTERA_AVALON_LAN91C111_MGMT_MDOE_OFST            3 
#define ALTERA_AVALON_LAN91C111_MGMT_MSK_CRS100_MSK       0x4000 
#define ALTERA_AVALON_LAN91C111_MGMT_MSK_CRS100_OFST      14 

/* Revision Register */
#define IOADDR_ALTERA_AVALON_LAN91C111_REV(base)          __IO_CALC_ADDRESS_NATIVE(base, 10)
#define IORD_ALTERA_AVALON_LAN91C111_REV(base)            IORD_16DIRECT(base, 10)
#define IOWR_ALTERA_AVALON_LAN91C111_REV(base, data)      IOWR_16DIRECT(base, 10, data)

/* Early RCV Register */
#define IOADDR_ALTERA_AVALON_LAN91C111_ERCV(base)         __IO_CALC_ADDRESS_NATIVE(base, 12)
#define IORD_ALTERA_AVALON_LAN91C111_ERCV(base)           IORD_16DIRECT(base, 12)
#define IOWR_ALTERA_AVALON_LAN91C111_ERCV(base, data)     IOWR_16DIRECT(base, 12, data)

#define ALTERA_AVALON_LAN91C111_ERCV_RCV_THRSHLD_MSK      0x1F 
#define ALTERA_AVALON_LAN91C111_ERCV_RCV_THRSHLD_OFST     0 
#define ALTERA_AVALON_LAN91C111_ERCV_RCV_DISCRD_MSK       0x80 
#define ALTERA_AVALON_LAN91C111_ERCV_RCV_DISCRD_OFST      7 

/*
* Receive Frame Status bits
*/
#define ALTERA_AVALON_LAN91C111_RS_MULT_CAST_MSK          0x1
#define ALTERA_AVALON_LAN91C111_RS_MULT_CAST_OFST         0
#define ALTERA_AVALON_LAN91C111_RS_TOO_SHORT_MSK          0x400
#define ALTERA_AVALON_LAN91C111_RS_TOO_SHORT_OFST         10
#define ALTERA_AVALON_LAN91C111_RS_TOO_LONG_MSK           0x800
#define ALTERA_AVALON_LAN91C111_RS_TOO_LONG_OFST          11
#define ALTERA_AVALON_LAN91C111_RS_ODD_FRM_MSK            0x1000  
#define ALTERA_AVALON_LAN91C111_RS_ODD_FRM_OFST           12  
#define ALTERA_AVALON_LAN91C111_RS_BAD_CRC_MSK            0x2000
#define ALTERA_AVALON_LAN91C111_RS_BAD_CRC_OFST           13
#define ALTERA_AVALON_LAN91C111_RS_BROD_CAST_MSK          0x4000
#define ALTERA_AVALON_LAN91C111_RS_BROD_CAST_OFST         14
#define ALTERA_AVALON_LAN91C111_RS_ALGN_ERR_MSK           0x8000
#define ALTERA_AVALON_LAN91C111_RS_ALGN_ERR_OFST          15

/*
* Control Byte
*/
#define ALTERA_AVALON_LAN91C111_CONTROL_CRC_MSK           0x10
#define ALTERA_AVALON_LAN91C111_CONTROL_CRC_OFST          4
#define ALTERA_AVALON_LAN91C111_CONTROL_ODD_MSK           0x20
#define ALTERA_AVALON_LAN91C111_CONTROL_ODD_OFST          5

/*
* PHY MII Registers
*/
#define ALTERA_AVALON_LAN91C111_PHY_COMPANY_ID            0x16
#define ALTERA_AVALON_LAN91C111_PHY_MFCT_ID               0xF840

/* PHY Control Register */
#define ALTERA_AVALON_LAN91C111_PHY_CONTROL_REG           0

#define ALTERA_AVALON_LAN91C111_PHY_CONTROL_COLTST_MSK    0x80  
#define ALTERA_AVALON_LAN91C111_PHY_CONTROL_COLTST_OFST   7  
#define ALTERA_AVALON_LAN91C111_PHY_CONTROL_DPLX_MSK      0x100  
#define ALTERA_AVALON_LAN91C111_PHY_CONTROL_DPLX_OFST     8  
#define ALTERA_AVALON_LAN91C111_PHY_CONTROL_ANEG_RST_MSK  0x200 
#define ALTERA_AVALON_LAN91C111_PHY_CONTROL_ANEG_RST_OFST 9 
#define ALTERA_AVALON_LAN91C111_PHY_CONTROL_MII_DIS_MSK   0x400 
#define ALTERA_AVALON_LAN91C111_PHY_CONTROL_MII_DIS_OFST  10 
#define ALTERA_AVALON_LAN91C111_PHY_CONTROL_PDN_MSK       0x800 
#define ALTERA_AVALON_LAN91C111_PHY_CONTROL_PDN_OFST      11 
#define ALTERA_AVALON_LAN91C111_PHY_CONTROL_ANEG_EN_MSK   0x1000 
#define ALTERA_AVALON_LAN91C111_PHY_CONTROL_ANEG_EN_OFST  12 
#define ALTERA_AVALON_LAN91C111_PHY_CONTROL_SPEED_MSK     0x2000 
#define ALTERA_AVALON_LAN91C111_PHY_CONTROL_SPEED_OFST    13 
#define ALTERA_AVALON_LAN91C111_PHY_CONTROL_LPBK_MSK      0x4000 
#define ALTERA_AVALON_LAN91C111_PHY_CONTROL_LPBK_OFST     14 
#define ALTERA_AVALON_LAN91C111_PHY_CONTROL_RST_MSK       0x8000 
#define ALTERA_AVALON_LAN91C111_PHY_CONTROL_RST_OFST      15

/* PHY Status Register */
#define ALTERA_AVALON_LAN91C111_PHY_STATUS_REG            1

#define ALTERA_AVALON_LAN91C111_PHY_STATUS_EXREG_MSK      0x1  
#define ALTERA_AVALON_LAN91C111_PHY_STATUS_EXREG_OFST     0  
#define ALTERA_AVALON_LAN91C111_PHY_STATUS_JAB_MSK        0x2  
#define ALTERA_AVALON_LAN91C111_PHY_STATUS_JAB_OFST       1  
#define ALTERA_AVALON_LAN91C111_PHY_STATUS_LINK_MSK       0x4  
#define ALTERA_AVALON_LAN91C111_PHY_STATUS_LINK_OFST      2  
#define ALTERA_AVALON_LAN91C111_PHY_STATUS_CAP_ANEG_MSK   0x8  
#define ALTERA_AVALON_LAN91C111_PHY_STATUS_CAP_ANEG_OFST  3  
#define ALTERA_AVALON_LAN91C111_PHY_STATUS_REM_FLT_MSK    0x10  
#define ALTERA_AVALON_LAN91C111_PHY_STATUS_REM_FLT_OFST   4  
#define ALTERA_AVALON_LAN91C111_PHY_STATUS_ANEG_ACK_MSK   0x20  
#define ALTERA_AVALON_LAN91C111_PHY_STATUS_ANEG_ACK_OFST  5  
#define ALTERA_AVALON_LAN91C111_PHY_STATUS_CAP_SUPR_MSK   0x40  
#define ALTERA_AVALON_LAN91C111_PHY_STATUS_CAP_SUPR_OFST  6  
#define ALTERA_AVALON_LAN91C111_PHY_STATUS_CAP_TH_MSK     0x800  
#define ALTERA_AVALON_LAN91C111_PHY_STATUS_CAP_TH_OFST    11  
#define ALTERA_AVALON_LAN91C111_PHY_STATUS_CAP_TF_MSK     0x1000  
#define ALTERA_AVALON_LAN91C111_PHY_STATUS_CAP_TF_OFST    12  
#define ALTERA_AVALON_LAN91C111_PHY_STATUS_CAP_TXH_MSK    0x2000  
#define ALTERA_AVALON_LAN91C111_PHY_STATUS_CAP_TXH_OFST   13  
#define ALTERA_AVALON_LAN91C111_PHY_STATUS_CAP_TXF_MSK    0x4000  
#define ALTERA_AVALON_LAN91C111_PHY_STATUS_CAP_TXF_OFST   14  
#define ALTERA_AVALON_LAN91C111_PHY_STATUS_CAP_T4_MSK     0x8000  
#define ALTERA_AVALON_LAN91C111_PHY_STATUS_CAP_T4_OFST    15  

/* PHY Identifier Registers */
#define ALTERA_AVALON_LAN91C111_PHY_ID1_REG               2    
#define ALTERA_AVALON_LAN91C111_PHY_ID2_REG               3    

/* PHY Auto Negotiation Advertisement Register */
#define ALTERA_AVALON_LAN91C111_PHY_ADVERT_REG            4

/* PHY Auto Negotiation Remote End Capability Register */
#define ALTERA_AVALON_LAN91C111_PHY_REMOTE_REG            5

/* Bit definitions for the negotiation */
#define ALTERA_AVALON_LAN91C111_PHY_NEGOTIATE_CSMA_MSK    0x1  
#define ALTERA_AVALON_LAN91C111_PHY_NEGOTIATE_CSMA_OFST   0  
#define ALTERA_AVALON_LAN91C111_PHY_NEGOTIATE_10_HDX_MSK  0x20  
#define ALTERA_AVALON_LAN91C111_PHY_NEGOTIATE_10_HDX_OFST 5  
#define ALTERA_AVALON_LAN91C111_PHY_NEGOTIATE_10_FDX_MSK  0x40  
#define ALTERA_AVALON_LAN91C111_PHY_NEGOTIATE_10_FDX_OFST 6  
#define ALTERA_AVALON_LAN91C111_PHY_NEGOTIATE_TX_HDX_MSK  0x80  
#define ALTERA_AVALON_LAN91C111_PHY_NEGOTIATE_TX_HDX_OFST 7  
#define ALTERA_AVALON_LAN91C111_PHY_NEGOTIATE_TX_FDX_MSK  0x100  
#define ALTERA_AVALON_LAN91C111_PHY_NEGOTIATE_TX_FDX_OFST 8  
#define ALTERA_AVALON_LAN91C111_PHY_NEGOTIATE_T4_MSK      0x200  
#define ALTERA_AVALON_LAN91C111_PHY_NEGOTIATE_T4_OFST     9  
#define ALTERA_AVALON_LAN91C111_PHY_NEGOTIATE_RF_MSK      0x2000  
#define ALTERA_AVALON_LAN91C111_PHY_NEGOTIATE_RF_OFST     13  
#define ALTERA_AVALON_LAN91C111_PHY_NEGOTIATE_ACK_MSK     0x4000  
#define ALTERA_AVALON_LAN91C111_PHY_NEGOTIATE_ACK_OFST    14  
#define ALTERA_AVALON_LAN91C111_PHY_NEGOTIATE_NP_MSK      0x8000  
#define ALTERA_AVALON_LAN91C111_PHY_NEGOTIATE_NP_OFST     15  

/* PHY Configuration Register 1 */
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_REG           16

#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_TRF0_MSK      0x1  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_TRF0_OFST     0  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_TRF1_MSK      0x2  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_TRF1_OFST     1  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_TLVL0_MSK     0x4  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_TLVL0_OFST    2  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_TLVL1_MSK     0x8  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_TLVL1_OFST    3 
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_TLVL2_MSK     0x10  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_TLVL2_OFST    4  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_TLVL3_MSK     0x20  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_TLVL3_OFST    5  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_RLVL0_MSK     0x40  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_RLVL0_OFST    6  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_CABLE_MSK     0x80  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_CABLE_OFST    7  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_EQLZR_MSK     0x100  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_EQLZR_OFST    8  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_UNSCDS_MSK    0x200  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_UNSCDS_OFST   9  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_BYPSCR_MSK    0x400  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_BYPSCR_OFST   10  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_XMTPDN_MSK    0x2000  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_XMTPDN_OFST   13  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_XMTDIS_MSK    0x4000  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_XMTDIS_OFST   14
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_LNKDIS_MSK    0x8000  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG1_LNKDIS_OFST   15  

/* PHY Configuration Register 2 */
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG2_REG           17

#define ALTERA_AVALON_LAN91C111_PHY_CONFIG2_INTMDIO_MSK   0x4  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG2_INTMDIO_OFST  2  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG2_MREG_MSK      0x8  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG2_MREG_OFST     3
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG2_JABDIS_MSK    0x10  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG2_JABDIS_OFST   4  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG2_APOLDIS_MSK   0x20  
#define ALTERA_AVALON_LAN91C111_PHY_CONFIG2_APOLDIS_OFST  5  

/* PHY Status Output (and Interrupt status) Register */
#define ALTERA_AVALON_LAN91C111_PHY_INT_STATUS_REG        18    

/* PHY Interrupt/Status Mask Register */
#define ALTERA_AVALON_LAN91C111_PHY_INT_MASK_REG          19

/* Bit definitions for the PHY INT registers */
#define ALTERA_AVALON_LAN91C111_PHY_INT_DPLXDET_MSK       0x40  
#define ALTERA_AVALON_LAN91C111_PHY_INT_DPLXDET_OFST      6  
#define ALTERA_AVALON_LAN91C111_PHY_INT_SPDDET_MSK        0x80  
#define ALTERA_AVALON_LAN91C111_PHY_INT_SPDDET_OFST       7  
#define ALTERA_AVALON_LAN91C111_PHY_INT_JAB_MSK           0x100  
#define ALTERA_AVALON_LAN91C111_PHY_INT_JAB_OFST          8  
#define ALTERA_AVALON_LAN91C111_PHY_INT_RPOL_MSK          0x200  
#define ALTERA_AVALON_LAN91C111_PHY_INT_RPOL_OFST         9  
#define ALTERA_AVALON_LAN91C111_PHY_INT_ESD_MSK           0x400  
#define ALTERA_AVALON_LAN91C111_PHY_INT_ESD_OFST          10  
#define ALTERA_AVALON_LAN91C111_PHY_INT_SSD_MSK           0x800  
#define ALTERA_AVALON_LAN91C111_PHY_INT_SSD_OFST          11  
#define ALTERA_AVALON_LAN91C111_PHY_INT_CWRD_MSK          0x1000  
#define ALTERA_AVALON_LAN91C111_PHY_INT_CWRD_OFST         12  
#define ALTERA_AVALON_LAN91C111_PHY_INT_LOSSSYNC_MSK      0x2000  
#define ALTERA_AVALON_LAN91C111_PHY_INT_LOSSSYNC_OFST     13  
#define ALTERA_AVALON_LAN91C111_PHY_INT_LNKFAIL_MSK       0x4000  
#define ALTERA_AVALON_LAN91C111_PHY_INT_LNKFAIL_OFST      14  
#define ALTERA_AVALON_LAN91C111_PHY_INT_INT_MSK           0x8000  
#define ALTERA_AVALON_LAN91C111_PHY_INT_INT_OFST          15  
 
#endif  /* __ALTERA_AVALON_LAN91C111_REGS_H_ */


