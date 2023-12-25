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
* Altera does not recommend, suggest or require that this reference design    *
* file be used in conjunction or combination with any other product.          *
*                                                                             *
* altera_avalon_lan91c111.h - LWIP ethernet interface for the the Lan91C111   *
* on the Nios boards.                                                         *
*                                                                             *
* Author PRR                                                                  *
*                                                                             *
******************************************************************************/

#ifndef __ALTERA_AVALON_LAN91C111_H__
#define __ALTERA_AVALON_LAN91C111_H__

#if defined(ALT_INICHE)

#include "iniche/altera_avalon_lan91c111_iniche.h"

#elif defined(LWIP)

#include "lwip/altera_avalon_lan91c111_lwip.h"

#else

// SPR 189741. This warning directive causes an error in the Nios II IDE console because of an Eclipse bug (2 files same name with #warning)
// So we are removing the warning.  If your SOPC Builder design includes Ethernet hardware and your Nios II IDE project does not include LWIP, 
// you will see errors indicating the LWIP headers cannot be found.
// See the errata notes for more details.
// #warning excluding drivers for the lan91c111 as you do not have the LWIP software component selected

#define ALTERA_AVALON_LAN91C111_INSTANCE(name, dev) extern int alt_no_storage
#define ALTERA_AVALON_LAN91C111_INIT(name, dev) while(0)     

#endif

#endif /* __ALTERA_AVALON_LAN91C111_H__ */
