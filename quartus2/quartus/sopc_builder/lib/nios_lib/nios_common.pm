#Copyright (C)2001-2008 Altera Corporation
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






















package nios_common;
use Exporter;
@ISA = Exporter;
@EXPORT = qw(
    $addressstall_present
    $perf_cnt_inc_rd_stall
    $perf_cnt_inc_wr_stall
    $shadow_present
    $advanced_exc
    $reset_pc
    $reset_pc_plus_one
    $big_endian
    $big_endian_tilde
    $perf_cnt_present

    $jmp_direct_hi_sz
    $imm16_sex_waddr_sz
    $imm16_sex_datapath_sz
    $byte_en_sz
    $byte_en_all_on
    $max_control_reg_sz
    $max_baddr_width
);

use cpu_utils;
use nios_avalon_masters;
use nios_isa;
use strict;


















































our $addressstall_present;
our $perf_cnt_inc_rd_stall = "1'b0";
our $perf_cnt_inc_wr_stall = "1'b0";
our $shadow_present;
our $advanced_exc;
our $reset_pc;
our $reset_pc_plus_one;
our $big_endian;
our $big_endian_tilde;
our $perf_cnt_present;

our $jmp_direct_hi_sz;
our $imm16_sex_waddr_sz;
our $imm16_sex_datapath_sz;
our $byte_en_sz;
our $byte_en_all_on;
our $max_control_reg_sz;





sub 
initialize_config_constants
{
    my $Opt = shift;







    $addressstall_present = 0;


    $shadow_present = (manditory_int($Opt, "num_shadow_reg_sets") > 0);


    $advanced_exc = manditory_bool($Opt, "advanced_exc");


    $reset_pc = manditory_int($Opt, "reset_addr") >> 2;
    $reset_pc_plus_one = $reset_pc + 1;

    $big_endian = manditory_bool($Opt, "big_endian");
    $big_endian_tilde = $big_endian ? "~" : "";


    $perf_cnt_present = manditory_bool($Opt, "perf_cnt_present");





    if (!defined($pc_sz)) {
        &$error("pc_sz is not defined");
    }

    if (!defined($datapath_sz)) {
        &$error("datapath_sz is not defined");
    }





    $jmp_direct_hi_sz = $pc_sz - 26;


    $imm16_sex_waddr_sz = $pc_sz - 16;    


    $imm16_sex_datapath_sz = $datapath_sz - 16;    


    $byte_en_sz = $datapath_sz / 8;


    $byte_en_all_on = "{${byte_en_sz}\{1'b1}}";


    $max_control_reg_sz = 32;
}

1;
