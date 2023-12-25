#Copyright (C)1991-2003 Altera Corporation
#Any megafunction design, and related net list (encrypted or decrypted),
#support information, device programming or simulation file, and any other
#associated documentation or information provided by Altera or a partner
#under Altera's Megafunction Partnership Program may be used only to
#program PLD devices (but not masked PLD devices) from Altera.  Any other
#use of such megafunction design, net list, support information, device
#programming or simulation file, or any other related documentation or
#information is prohibited for any other purpose, including, but not
#limited to modification, reverse engineering, de-compiling, or use with
#any other silicon devices, unless such use is explicitly licensed under
#a separate agreement with Altera or a megafunction partner.  Title to
#the intellectual property, including patents, copyrights, trademarks,
#trade secrets, or maskworks, embodied in any such megafunction design,
#net list, support information, device programming or simulation file, or
#any other related documentation or information provided by Altera or a
#megafunction partner, remains with Altera, the megafunction partner, or
#their respective licensors.  No other licenses, including any licenses
#needed under any third party's intellectual property, are provided herein.
#Copying or modifying any file, or portion thereof, to which this notice
#is attached violates this copyright.



use e_ptf_update_to_2_0;
use e_ptf_update_to_2_6;
use e_ptf_update_to_2_8;
use e_ptf_update_to_4_0;
use strict;

# Just a wrapper to call the "main function" in this here module,
# so that you can do it from the command-line:
use wiz_utils;

&PTF_Translate_Old_Version (@ARGV); #translates from 1.0->1.1

my $file = shift or die ("no file"); 
e_ptf_update_to_4_0->new({ptf_file => $file});



