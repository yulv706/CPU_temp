# ------------------------------------------------------------------------------
#  This confidential and proprietary software may be used only as authorized by
#  a licensing agreement from Altera Corporation.
#
#  (C) COPYRIGHT 2005 ALTERA CORPORATION
#  ALL RIGHTS RESERVED
#
#  The entire notice above must be reproduced on all authorized copies and any
#  such reproduction must be pursuant to a licensing agreement from Altera.
#
#  Title        : QDRII SRAM Controller Avalon read interface
#  Project      : QDRII SRAM Controller
#
#
#  File         : $RCSfile: write_qdrii_avalon_write_if_ipfs_wrap.pm,v $
#
#  Last modified: $Date: 2009/02/04 $
#  Revision     : $Revision: #1 $
#
#  Abstract:
#
#  Notes:
# ------------------------------------------------------------------------------
#sopc_builder free code
use europa_all;
use europa_utils;
use e_auk_qdrii_avalon_write_if;

sub write_qdrii_avalon_write_if_ipfs_wrap
{
my $mem_type = $gMEM_TYPE;
my $top = e_module->new({name => "auk_qdrii_avalon_write_if_ipfs_wrap"});#, output_file => 'd:/OFadeyi/DATA_PATH/temp_gen/'});
my $project = e_project->new({top => $top, language => $language,__system_directory =>$output_directory,timescale => "1ps / 1ps"});#'temp_gen'});
my $module = $project->top();



my $header_title = "Datapath for the Altera QDRII SDRAM Controller";
my $project_title = "QDRII SDRAM Controller";
my $header_filename = "auk_qdrii_avalon_write_if_ipfs_wrap" . $file_ext;
my $header_revision = "V" . $gWIZARD_VERSION;
my $header_abstract = "This file contains the datapath for the QDRII SDRAM Controller";
my $num_clock_pairs = $gNUM_OUTPUT_CLOCKS;

my $device_clk = "write_clk";
my $family = $gFAMILY;
my $memory_data_width = $gMEMORY_DATA_WIDTH;
my $memory_address_width = $gMEMORY_ADDRESS_WIDTH;
my $local_data_bits = $gLOCAL_DATA_BITS;
my $delay_chain = $gDELAY_CHAIN;
my $burst_mode = $gMEMORY_BURST_LENGTH;
my $avl_data_width_multiply = $gAVL_DATA_WIDTH_MULTIPLY;
my $mem_dq_per_dqs = $gMEM_DQ_PER_DQS;
my $num_pipeline_addr_cmd_stages = $gPIPELINE_ADDRESS_COMMAND;
my $num_pipeline_rdata_stages = $gPIPELINE_READ_DATA;
my $bwsn_width;
my $is_busrt4_narrow = $gIS_BURST4_NARROW;
my $use_dqs_for_read = $gUSE_DQS_FOR_READ;
my $qdrii_pin_prefix = $gQDRII_PIN_PREFIX;
#my $clock_pos_pin_name = $gCLOCK_POS_PIN_NAME;
#my $clock_neg_pin_name = $gCLOCK_NEG_PIN_NAME;
my $clock_pos_pin_name = $qdrii_pin_prefix . "k";
my $clock_neg_pin_name = $qdrii_pin_prefix . "kn";

if($mem_dq_per_dqs <= 18)
{
	$bwsn_width = 2;
}elsif($mem_dq_per_dqs > 18)
{
	$bwsn_width = 4;
}

my $num_chips_wide = $gNUM_CHIPS_WIDE;
my $num_chips_deep = $gNUM_CHIPS_DEEP;
my $deep;
if($num_chips_deep > 1){
	$deep = 1;
}else{
	$deep = 0;
}

######################################################################################################################################################################
	$module->comment
	(
		"------------------------------------------------------------------------------\n
		 This confidential and proprietary software may be used only as authorized by\na licensing agreement from Altera Corporation.\n\n
		 (C) COPYRIGHT 2004 ALTERA CORPORATION\nALL RIGHTS RESERVED\n\nThe entire notice above must be reproduced on all authorized copies and any\n
		 such reproduction must be pursuant to a licensing agreement from Altera.\n\n
		 Title        : $header_title\n
		 Project      : $project_title\n
		 File         : $header_filename\n\n
		 Revision     : $header_revision\n\n
		 Abstract:\n$header_abstract\n\n
		 ----------------------------------------------------------------------------------\n
		 Parameters:\n
		 Device Family                      : $gFAMILY\n
		 ----------------------------------------------------------------------------------\n",
	);
######################################################################################################################################################################
	$module->add_contents
	(
	#####	Ports declaration#	######
		e_port->new({name => "avl_addr_wr",direction => "input" ,width => $memory_address_width + $is_busrt4_narrow + $deep}),
		e_port->new({name => "avl_data_wr",direction => "input" ,width => $local_data_bits}), # ($mem_dq_per_dqs * 2)
		e_port->new({name => "avl_byteen_wr",direction => "input" ,width => $bwsn_width * $avl_data_width_multiply * $num_chips_wide}),
		e_port->new({name => "avl_wait_request_wr",direction => "output"}),
		e_port->new({name => "avl_chipselect_wr",direction => "input"}),
		e_port->new({name => "avl_write",direction => "input"}),
		e_port->new({name => "control_training_finished",direction => "input"}),

		e_port->new({name => "control_addr_comb_wr",direction => "output",width => $memory_address_width + $deep}),
		e_port->new({name => "control_wpsn_comb",direction => "output",width => 1}),
		e_port->new({name => "control_wpsn",direction => "output",width => 1}),
		e_port->new({name => "control_bwsn",direction => "output",width => $bwsn_width * 2 * $num_chips_wide}),
		e_port->new({name => "control_d",direction => "output",width => $memory_data_width * 2}),


		e_port->new({name => "avl_clock",direction => "input"}),
		e_port->new({name => "avl_resetn",direction => "input"}),
	);
	$module->add_contents
	(
		e_comment->new
		({
			comment => "------------------------------------------------------------\n
				   Instance of the Controller Avalon Write Interface\n
				   ------------------------------------------------------------\n"
		}),
		e_auk_qdrii_avalon_write_if->new
		({
			name 		=> "avalon_write_interface",
			module 		=> "auk_qdrii_avalon_write_if",
			port_map 	=>
			{
				avl_addr_wr		=> "avl_addr_wr[".(($memory_address_width + $is_busrt4_narrow + $deep) - 1).":0]",
				avl_data_wr		=> "avl_data_wr",
				avl_clock		=> "avl_clock",
				avl_resetn		=> "avl_resetn",
				avl_write		=> "avl_write",
				avl_chipselect_wr	=> "avl_chipselect_wr",
				avl_byteen_wr		=> "avl_byteen_wr",
				avl_wait_request_wr	=> "avl_wait_request_wr",
				control_addr_comb_wr	=> "control_addr_comb_wr",
				control_d		=> "control_d",
				control_wpsn		=> "control_wpsn",
				control_wpsn_comb	=> "control_wpsn_comb",
				control_bwsn		=> "control_bwsn",
				control_training_finished	=> "control_training_finished",
			},
			parameter_map =>
			{
				gIS_BURST4_NARROW	=> $is_busrt4_narrow,
				gAVL_DATA_WIDTH_MULTIPLY=> $avl_data_width_multiply,
				gBURST_MODE             => $burst_mode,
				gMEMORY_DATA_WIDTH      => $memory_data_width,
				gMEMORY_BYTEEN_WIDTH    => $bwsn_width * $num_chips_wide,
				gMEMORY_ADDRESS_WIDTH   => $memory_address_width + $deep,
			}
		}),
	);
##################################################################################################################################################################
$project->output();
}

1;
#You're done.
