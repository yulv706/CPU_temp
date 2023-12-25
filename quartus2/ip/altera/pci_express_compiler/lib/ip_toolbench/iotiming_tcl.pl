#Copyright (C)2005 Altera Corporation
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



# use europa_all;

my %command_hash;
my $key;
my $value;
foreach my $command (@ARGV)
{
	next unless ($command =~ /\-\-(\w+)\=(.*)/);
	
	$key = $1;
	$value = $2;
	
	$value =~ s/\\|\/$//; # crush directory structures which end with
	print ("Processing argument \"$key=$value\"\n");
	$command_hash{$key} = $value;
};




#command line arguments
my $number_of_lanes = 4;
my $phy_selection = 0;
my $phy_vendor = "";
my $var = "pci_var";
my $pipe_txclk = 0;
my $rmfifo = 1;
my $fast_recovery = 0;
my $family = "Cyclone_II";
my $tlp_clk_freq = 0;
my $hip = 0;
$avclk_name = "clk";

my $temp = $command_hash{"phy"};
if($temp ne "")
{
	$phy_selection = $temp;	
}

my $temp = $command_hash{"vendor"};
if($temp ne "")
{
	$phy_vendor = $temp;	
}


my $temp = $command_hash{"txclk"};
if($temp ne "")
{
	$pipe_txclk = $temp;	
}

my $temp = $command_hash{"lanes"};
if($temp ne "")
{
	$number_of_lanes = $temp;	
}

my $temp = $command_hash{"variation"};
if($temp ne "")
{
	$var = $temp;	
}

my $temp = $command_hash{"refclk"};
if($temp ne "")
{
	$refclk_selection = $temp;	
}

my $temp = $command_hash{"avalon_clock"};
if($temp ne "")
{
	$avclk_name = $temp
}


my $temp = $command_hash{"tl_selection"};
if($temp ne "")
{
    # 0 - PLDA native
    # 1 - Full Avalon interface (CRA,TXS,RXM)
    # 2 - Partial Avalon interface (RXM)
    # 3 - Partial Avalon interface (TXS,RXM)
    # 4 - Partial Avalon interface (CRA,RXM)
    # 5 - Full Avalon interface (CRA,TXS,RXM - reserve for DMA)
    # 6 - HIPCAB
	$tl_selection = $temp;	
}

my $temp = $command_hash{"family"};
if($temp ne "")
{
	$family = $temp;	
}

my $temp = $command_hash{"rmfifo"};
if($temp ne "")
{
	$rmfifo = $temp;	
}

my $temp = $command_hash{"fast_recovery"};
if($temp ne "")
{
	$fast_recovery = $temp;	
}

my $temp = $command_hash{"tlp_clk_freq"};
if($temp ne "")
{
	$tlp_clk_freq = $temp;	
}

my $temp = $command_hash{"hip"};
if($temp ne "")
{
	$hip = $temp;	
}


# turn on physical synthesis in SOPC mode for no SII devices
# remove all quotes (windows do not have quotes, unix has quotes
$family =~ s/\"//g;
$fsyn = 0;
$hc2 = 0;
if (($tl_selection  > 0) & ($tl_selection < 6)){
    if ($family !~ /stratix_i/i) { # turn on physical synthesis for non SII or SIII devices
	$fsyn = 1;
    } elsif ($family =~ /lite/i) {
	$fsyn = 1;
    } elsif ($family =~ /arria/i) {
	$fsyn = 1;
    }

    if ($family =~ /hardcopy/i) {
	$hc2 = 1;
    }
}


# turn off TAN only ACF assignments for newer familys
$sta_only = 0;
if (($family =~ /stratix_iv/i) || ($family =~ /arria_ii/i)) {
    $sta_only = 1;
}
    

##################################################
# Check for Vendor
##################################################

if (($phy_selection == 0) || ($phy_selection == 2) || ($phy_selection == 6)) {
    $vendor = "";
} elsif ($phy_vendor =~ /GL/) {
    if ($phy_selection == 1) {
	$vendor = "GL_SDR";
    } elsif ($phy_selection == 3) {
	$vendor = "GL_DDR";
    } elsif ($phy_selection == 4) {
	$vendor = "GL_S8R";
    }
} elsif (($phy_vendor =~ /TI/) || ($phy_selection == 5)) {
    if ($phy_selection == 1) {
	$vendor = "TI_SDR";
    } else {
	$vendor = "TI_DDR";
    }
} elsif ($phy_vendor =~ /PX/) {
    $vendor = "PX";
} else {
    $vendor = "";
}

if ((($phy_selection == 2) & ($number_of_lanes < 8)) | ($phy_selection < 2)){
    $pipe_width = 16;
} else {
    $pipe_width = 8;
}


%input_max_delay = (
		    "GL_SDR" => 5.6,
		    "GL_DDR" => 1.8,
		    "GL_S8R" => 3.2,
		    "TI_SDR" => 3,
		    "TI_DDR" => 2,
		    "PX" => 2.5,
		    );

%input_min_delay = (
		    "GL_SDR" => 0,
		    "GL_DDR" => 0,
		    "GL_S8R" => 0,
		    "TI_SDR" => 0,
		    "TI_DDR" => 0,
		    "PX" => 1.5,
		    );

%output_min_delay = (
		    "TI_DDR" => -0.1,
		    "TI_SDR" => -0.1,
		    "PX" => -0.5,
		    );


%output_max_delay = (
		    "TI_DDR" => 1.3,
		    "TI_SDR" => 1.3,
		    "PX" => 0.5,
		    );


%refclk_mhz = (
	       0 => 100,
	       1 => 125,
	       2 => 156.25,
	       3 => 250
	       );
	       
%io_standard = (
		"TI" => "1.8 V",
		"PX" => "SSTL-2 CLASS I",		
		"PIPE_REFCLK" => "HCSL",		
		);
$avclk_freq = 100;


@input_sig = ();
$tcl_file = "$var\_example_top.tcl";
$sdc_file = "$var\_example_top.sdc";
open (TCL,">$tcl_file") || die "Error: Cannot open $tcl_file";
open (SDC,">$sdc_file") || die "Error: Cannot open $sdc_file";

print SDC "derive_pll_clocks \n";
print SDC "derive_clock_uncertainty\n";

# set fmax
@refclk_name = ("refclk");
$refclk_freq = $refclk_mhz{$refclk_selection};
if (($phy_selection == 0) || ($phy_selection == 2) || ($phy_selection == 6)) {
} else {
    if ($number_of_lanes == 8) {
	@refclk_name = (@refclk_name,"phy1_pclk");
    }
}

foreach $refclk_tmp (@refclk_name) {

    $refclk_name = $refclk_tmp;
    if (($tl_selection > 0) & ($tl_selection < 6)) { #SOPC mode
	$refclk_name = $refclk_name."_".$var; 
    }
    
    if ($sta_only == 0) {
	print TCL "set_global_assignment -name FMAX_REQUIREMENT \"$refclk_freq MHz\" -section_id $refclk_name\n";
	print TCL "set_instance_assignment -name CLOCK_SETTINGS $refclk_name -to $refclk_name\n";
    }
    print SDC "create_clock -period \"$refclk_freq MHz\" -name {$refclk_name\} {$refclk_name\}\n";
}


# cut clock for elastic buffer in 1SGX
if ($phy_selection == 0) {
    print SDC "set_clock_groups -exclusive -group [get_clocks {$refclk_name\}] -group [get_clocks { *clkout* }]\n";
    print SDC "set_clock_groups -exclusive -group [get_clocks {*pll*clk\[0\]}] -group [get_clocks { *clkout* }]\n";

    # TAN does not take wildcard on clocks
    print TCL "set_instance_assignment -name CUT ON -from \"*elasbuf*rdaddr*\" -to \"*elasbuf*rdaddr*\"\n";
    print TCL "set_instance_assignment -name CUT ON -from \"*elasbuf*wraddr_rr*\" -to \"*elasbuf*wraddr_sync_r*\"\n";
    print TCL "set_instance_assignment -name CUT ON -from \"*phypcs*rx_valin*\" -to \"*phypcs*rx_val_p*\"\n";

}

# 9.0 Cut soft logic reset paths in altgx
if (($hip == 1) & ($phy_selection == 6)) {
    print SDC " set_clock_groups -exclusive -group [get_clocks { *central_clk_div0* }] -group [get_clocks { *_hssi_pcie_hip* }]\n";
}

if (($tl_selection > 0) & ($tl_selection < 6)) { # Avalon clk constraint
    if ($sta_only == 0) {
	print TCL "set_global_assignment -name ENABLE_CLOCK_LATENCY ON\n";
	print TCL "set_global_assignment -name ENABLE_RECOVERY_REMOVAL_ANALYSIS ON\n";
    }
    print TCL "set_global_assignment -name SDC_FILE $var\.sdc\n";


    # set fast corner optimization
    print TCL "set_global_assignment -name OPTIMIZE_FAST_CORNER_TIMING ON\n";
# Customer responsible to set Avalon Clock freq
#    print TCL "set_global_assignment -name FMAX_REQUIREMENT \"$avclk_freq MHz\" -section_id $avclk_name\n";
#    print TCL "set_instance_assignment -name CLOCK_SETTINGS $avclk_name -to $avclk_name\n";
#    print SDC "create_clock -period \"$avclk_freq MHz\" -name {$avclk_name\} {$avclk_name\}\n";

    # Cut Avalon clock from PCIe clocks
    if ($avclk_name ne "none") {
	if ($phy_selection == 0) { # 1SGX
	    if ($refclk_selection == 2) {
		# 156.25 Mhz
		print SDC "set_false_path -from [get_clocks {*coreclk*}] -to [get_clocks {$avclk_name\}]\n";
		print SDC "set_false_path -from [get_clocks {$avclk_name\}] -to [get_clocks {*coreclk*}]\n";
	    } elsif ($refclk_selection == 0) {
		# 100 Mhz
		print SDC "set_false_path -from [get_clocks {*pll*clk*}] -to [get_clocks {$avclk_name\}]\n";
		print SDC "set_false_path -from [get_clocks {$avclk_name\}] -to [get_clocks {*pll*clk*}]\n";
	    } elsif ($refclk_selection == 1) {
		# 125 Mhz
		print SDC "set_false_path -from [get_clocks {$refclk_name\}] -to [get_clocks {$avclk_name\}]\n";
		print SDC "set_false_path -from [get_clocks {$avclk_name\}] -to [get_clocks {$refclk_name\}]\n";
	    }

	} elsif ($phy_selection == 2) {
	    if ($number_of_lanes == 1) { # x1s
		$coreclk = "clkout";
	    } elsif ($family =~ /stratix/i) { # SIIGX
		$coreclk = "coreclk";
	    } else { # Arria GX
		$coreclk = "core_clk";
	    }
	    print SDC "set_false_path -from [get_clocks {*$coreclk\*}] -to [get_clocks {$avclk_name\}]\n";
	    print SDC "set_false_path -from [get_clocks {$avclk_name\}] -to [get_clocks {*$coreclk\*}]\n";
	} elsif ($phy_selection == 6) {
	    # S4GX and A2GX
	    if ($hip == 1) { 
		print SDC "set_false_path -from [get_clocks {*coreclk*}] -to [get_clocks {$avclk_name\}]\n";
		print SDC "set_false_path -from [get_clocks {$avclk_name\}] -to [get_clocks {*coreclk*}]\n";
	    } else {
		print SDC "set_false_path -from [get_clocks {*clkout}] -to [get_clocks {$avclk_name\}]\n";
		print SDC "set_false_path -from [get_clocks {$avclk_name\}] -to [get_clocks {*clkout}]\n";
	    }

	} else {
	    print SDC "set_false_path -from [get_clocks {*pll*clk*}] -to [get_clocks {$avclk_name\}]\n";
	    print SDC "set_false_path -from [get_clocks {$avclk_name\}] -to [get_clocks {*pll*clk*}]\n";
	    print SDC "set_false_path -from [get_clocks {$refclk_name\}] -to [get_clocks {$avclk_name\}]\n";
	    print SDC "set_false_path -from [get_clocks {$avclk_name\}] -to [get_clocks {$refclk_name\}]\n";

	}
    }
    

}


# SOPC bridge tag ram need QSF setting to compile in QII
if (($tl_selection > 0) & ($tl_selection < 6)) { #SOPC mode
    print TCL "set_parameter -name CYCLONEII_SAFE_WRITE RESTRUCTURE\n";
    # virtual pin test_out
    print TCL "set_instance_assignment -name VIRTUAL_PIN ON -to test_out_$var\n";
    print TCL "set_instance_assignment -name VIRTUAL_PIN ON -to clk125_out_$var\n";
}

# generate PIPE interface signals
@input_sig = (@input_sig, "phystatus_ext");
@output_sig = (@output_sig, "powerdown_ext[0]","powerdown_ext[1]","txdetectrx_ext");

 
   
if ($pipe_txclk == 1) {
    @output_sig = (@output_sig, "pipe_txclk");
}

for ($i = 0; $i < $number_of_lanes; $i++) {
    
    @input_sig = (@input_sig, "rxelecidle$i\_ext","rxvalid$i\_ext","rxstatus$i\_ext[0]","rxstatus$i\_ext[1]","rxstatus$i\_ext[2]");
    @output_sig = (@output_sig, "rxpolarity$i\_ext","txcompl$i\_ext","txelecidle0_ext");
    
    for ($j = 0; $j < $pipe_width; $j++) {
	@input_sig = (@input_sig,"rxdata$i\_ext[$j]");
	@output_sig = (@output_sig,"txdata$i\_ext[$j]");
    }
    
    if ($pipe_width > 8) {
	@input_sig = (@input_sig,"rxdatak$i\_ext[0]","rxdatak$i\_ext[1]");
	@output_sig = (@output_sig,"txdatak$i\_ext[0]","txdatak$i\_ext[1]");
    } else {
	@input_sig = (@input_sig,"rxdatak$i\_ext");
	@output_sig = (@output_sig,"txdatak$i\_ext");
    }
    
}

if ($vendor ne "") { # for valid phy vendor
    foreach $input_sig (@input_sig) {

	if ($input_sig =~ /(\d)_/) {
	    $i = $1;
	} else {
	    $i = 0;
	}

	if ($i < 4) {
	    $ref_clk = "refclk";
	} else {
	    $ref_clk = "phy1_pclk";
	}	    

	if (($tl_selection > 0) & ($tl_selection < 6)) { #SOPC mode
	    $input_sig =~ s/_ext/_ext_$var/g;
	    $ref_clk = "refclk_$var";
	}
	print TCL "set_instance_assignment -name INPUT_MAX_DELAY \"$input_max_delay{$vendor} ns\" -from $ref_clk -to $input_sig\n";
	if ($io_standard{$phy_vendor} ne "") {
	    print TCL "set_instance_assignment -name IO_STANDARD \"$io_standard{$phy_vendor}\" -to $input_sig\n";
	}
	print SDC "set_input_delay -add_delay -max $input_max_delay{$vendor} -clock {$ref_clk\} [get_ports {$input_sig\}\]\n";
	print TCL "set_instance_assignment -name INPUT_MIN_DELAY \"$input_min_delay{$vendor} ns\" -from $ref_clk -to $input_sig\n";
	print SDC "set_input_delay -add_delay -min $input_min_delay{$vendor} -clock {$ref_clk\} [get_ports {$input_sig\}\]\n";
	print TCL "set_instance_assignment -name FAST_INPUT_REGISTER ON -to $input_sig\n";

    }


# Generate SDC output clock constraints
    if (($pipe_txclk == 1) & ($vendor ne "")) {
	print SDC "\n###############################\n";
	print SDC "\# Please refer to AN433 pp 14 for details\n";
	print SDC "\# Assume no board skew between clock and data\n";
	print SDC "\# Max output delay = Max data board delay + tsu - min clock board delay =  $output_max_delay{$vendor} ns\n";
	print SDC "\# Min output delay = Min data board delay - thold - max clock board delay = $output_min_delay{$vendor} ns\n";
	print SDC "###############################\n";
	print SDC "\# Generate txclk\n";

	if ($phy_selection == 5) {
	    print SDC "create_generated_clock -edges {2 4 6} -source [get_pins -hierarchical *pll*clk[1]] -name pipe_txclk_div [get_registers -no_duplicates {*pipe_txclk_int}]\n";
	    print SDC "create_generated_clock -source [get_registers -no_duplicates {*pipe_txclk_int}] -name pipe_txclk [get_ports pipe_txclk]\n";
	} elsif (($phy_selection == 1) & ($tlp_clk_freq == 1)) { # SDR with PLL
	    print SDC "create_generated_clock -invert -source [get_pins -hierarchical *pll*clk[1]] -name pipe_txclk [get_ports *pipe_txclk]\n";
	} elsif (($phy_selection == 1) & ($tlp_clk_freq == 0)) { # SDR without PLL
	    print SDC "create_generated_clock -invert -source [get_ports *refclk] -name pipe_txclk [get_ports *pipe_txclk]\n";
	} elsif (($phy_selection == 1) & ($tlp_clk_freq == 0)) { # SDR without PLL
	    print SDC "create_generated_clock -invert -source [get_ports *refclk] -name pipe_txclk [get_ports *pipe_txclk]\n";
	} elsif ($phy_selection == 4) { # 250Mhz SDR
	    print SDC "create_generated_clock -invert -source [get_pins -hierarchical *pll*clk[1]] -name pipe_txclk [get_ports *pipe_txclk]\n";
	}

	print SDC "set max_out_delay $output_max_delay{$vendor}\n";
	print SDC "set min_out_delay $output_min_delay{$vendor}\n";


    }
    



    foreach $output_sig (@output_sig) {

	if (($tl_selection > 0) & ($tl_selection < 6)) { #SOPC mode
	    $output_sig =~ s/_ext/_ext_$var/g;
	}
	print TCL "set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to $output_sig\n";
	if ($io_standard{$phy_vendor} ne "") {
	    print TCL "set_instance_assignment -name IO_STANDARD \"$io_standard{$phy_vendor}\" -to $output_sig\n";

	    if ($phy_vendor =~ /PX/) { # set 12mA driving strength for Philips
		print TCL "set_instance_assignment -name CURRENT_STRENGTH_NEW 12MA -to $output_sig\n";
	    }

	}


	if (($pipe_txclk == 1) & ($vendor ne "")) {
	    if (($phy_selection == 5) | ($phy_selection == 1) | ($phy_selection == 4)) {
		if ($output_sig !~ /txclk/) {
		    print SDC "set_output_delay -max \$max_out_delay -clock {pipe_txclk} [get_ports {$output_sig}]\n";
		    print SDC "set_output_delay -min \$min_out_delay -clock {pipe_txclk} [get_ports {$output_sig}]\n";
		}
	    }
	}
    }

    print TCL "set_global_assignment -name REPORT_IO_PATHS_SEPARATELY ON\n";

} else { # GXs

    @pipe_sig = (@input_sig,@output_sig,"reconfig_clk","reconfig_togxb","reconfig_fromgxb","pipe_mode_$var");

    if (($tl_selection > 0) & ($tl_selection < 6)) { # virtual pin the PIPE interface
	foreach $pipe_sig (@pipe_sig) {
	    $pipe_sig =~ s/_ext/_ext_$var/g;
	    if ($pipe_sig =~ /reconfig/) {
		$pipe_sig .= "_$var";
	    }
	    print TCL "set_instance_assignment -name VIRTUAL_PIN ON -to $pipe_sig\n";
	}
    }

}

if ($sta_only == 0) {
    print TCL "set_global_assignment -name DO_COMBINED_ANALYSIS ON\n";
}
print TCL "set_global_assignment -name OPTIMIZE_HOLD_TIMING \"ALL PATHS\"\n";


# turn on FSYN
if ($fsyn) {
    print TCL "set_global_assignment -name PHYSICAL_SYNTHESIS_COMBO_LOGIC ON\n";
    print TCL "set_global_assignment -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON\n";
    print TCL "set_global_assignment -name PHYSICAL_SYNTHESIS_REGISTER_RETIMING ON\n";
    print TCL "set_global_assignment -name FITTER_EFFORT \"STANDARD FIT\"\n";
    print TCL "set_global_assignment -name PHYSICAL_SYNTHESIS_EFFORT NORMAL\n";
}

# set IO standard for refclk for AGX, A2GX, S2GX, S4GX
if (($phy_selection == 2) || ($phy_selection == 6)) {
    print TCL "set_instance_assignment -name IO_STANDARD \"$io_standard{PIPE_REFCLK}\" -to $refclk_name\n";
    print TCL "set_instance_assignment -name INPUT_TERMINATION \"OCT 100 OHMS\" -to $refclk_name\n";
}


# turn on directive for rate match fifo bypass
$clock_group = int(rand(1000));
if (($rmfifo == 0) & ($phy_selection == 2)) {
    if ($number_of_lanes > 1) {
	print TCL "set_instance_assignment -name GXB_0PPM_CLOCK_GROUP $clock_group -to $var\*\:*altpcie_serdes*alt2gxb_component|channel_rec[*].receive\nset_instance_assignment -name GXB_0PPM_CLOCK_GROUP_DRIVER $clock_group -to $var\*\:*altpcie_serdes*alt2gxb_component|channel_quad[0].clk_div\n";
    } else {
	print TCL "set_instance_assignment -name GXB_0PPM_CLOCK_GROUP $clock_group -to $var\*\:*altpcie_serdes*alt2gxb_component|channel_rec[*].receive\nset_instance_assignment -name GXB_0PPM_CLOCK_GROUP_DRIVER $clock_group -to $var\*\:*altpcie_serdes*alt2gxb_component|channel_tx[0].transmit\n";
    }
}



# copy in virtual pin tcl
$vpin = "vpin.tcl";
open (VPIN,"$vpin") || die "Cannot open Virtual Pin TCL file";
while (<VPIN>) {
    print TCL $_;
}
close (VPIN);
unlink($vpin);


close(TCL);
close(SDC);

	
