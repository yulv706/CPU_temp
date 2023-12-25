set pvcs_revision(sta_based_conversion) [regsub -nocase -- {\$revision:\s*(\S+)\s*\$} {$Revision: #1 $} {\1}]

# **************************************************************************
#
# File: hcii_sta_based_conversion.tcl
#
# Used by hcii_pt_script.tcl
#
# Description:
#		This file defines hcii_sta_based_conversion namespace that contains
#		all the codes to do Q2P translation, with the aid of TimeQuest process:
#
#               - TimeQuest first process user specified assignments and dump out 2 files
#                 1.<revision>.pt.sdc
#                    This file will represent the actual SDC constriants in the
#                    original user SDC file. The main different between this file and the
#                    original file would be that all collection will be removed and replaced
#                    with variable names.
#                    This file constains both Standard SDC constraints and TimeQuest SDC
#                    extension contraints.
#                 2.<revision>.pt_col.tcl
#                    Contain the necessary information to generate the required flow specific
#                    SDC collections references by <revision>.pt.sdc
#
#		- It then reads timing assignments from the above two TimeQuest dump files
#		and translates them into PrimeTime timing constraints with the aid of
#		the Q2P name map.
#
#               - It also process and convert TimeQuest SDC extension constraints to the
#                 standard SDC constraints
#
#               The format of the file <revision>.pt.sdc is:
#               set_multicycle_path -setup -end -from $_col40 -thru $_col41 -to $_col42 20
#
#               The format of the file <revision>.pt_col.tcl is:
#               set col(_col40) { cell { 344 257 261 265 269 } }
#               set col(_col41) { net { 256 } }
#               set col(_col42) { cell { 264 268 254 260 277 280 } }
#
#
#
# **************************************************************************


# --------------------------------------------------------------------------
#
namespace eval hcii_sta_based_conversion {
#
# Description:	Define the namespace and interal variables.
#
# Warning:	All defined variables are not allowed to be accessed outside
#		this namespace!!!  To access them, use the defined accessors.
#
# --------------------------------------------------------------------------

}


# --------------------------------------------------------------------------
# --------------------------------------------------------------------------
proc hcii_sta_based_conversion::generate_scripts { } {
        # Process TimeQuest dumped out files
        #1. <revision>.pt.sdc
        #2. <revision>.sta_col
# --------------------------------------------------------------------------
# --------------------------------------------------------------------------
       	global quartus
	global pvcs_revision
	global outfile

	# Input files checking.
	set input_constraint_file_name "$::hc_output/${::rev_name}.constraints.sdc"
        if {![file exists $input_constraint_file_name]} {
                   hardcopy_msgs::post E_CANNOT_OPEN_FILE $input_constraint_file_name
                   hardcopy_msgs::post E_RUN_TIMEQUEST
                   qexit -error
        }

        # Creating output files
        # 1. <rev>.pt.tcl
        # 2. <rev>.collection.sdc
	set output_file_name "$::hc_output/${::rev_name}.pt.tcl"
	set outfile [open $output_file_name w]
        set col_output_file_name "$::hc_output/${::rev_name}.collections.sdc"

        # Initialize hcii_name_db databases, which contains all the infomation
	# helping to translate Quartus names to PrimeTime names.
	hcii_name_db::initialize_sta_port_db

	# Translate STA collections to HCII collections.
	l2p::initialize
	# Always call translate_collections.  Don't call reconstruct_collections.
	l2p::translate_collections "hcii"

        # Dump out the physical netlist for debugging purposes
        set ini [get_ini_var -name hcii_dump_physical_netlist]
	if { [string equal -nocase $ini ON] } {
		 test_dump_netlist
	}

        # Since hcii_sta_based_conversion functions may call
	# hcii_qsf_based_conversion functions, we need to load_report.
	load_report
	if ![is_report_loaded] {
		hardcopy_msgs::post E_NO_REPORT_DB
		qexit -error
	}

        hcii_util::post_msgs "info" \
        		"--------------------------------------------------------" \
        		"Generated $col_output_file_name" \
        		"--------------------------------------------------------"

        # Start to generate Top Level PT script (<rev>.pt.tcl)
       	# Output header.
	hcii_util::formatted_write $outfile "
		####################################################################################
		#
		# Generated by [info script] $pvcs_revision(main)
		#   hcii_visitors.tcl : $pvcs_revision(visitors)
		#   Quartus           : $quartus(version)
		#
		# Project:  $quartus(project)
		# Revision: $quartus(settings)
		#
		# Date: [clock format [clock seconds]]
		#
		####################################################################################
         "

         # Set the PLL and DQS pin annotated delay
         hcii_util::formatted_write $outfile "


                 ##############################
                 # Set PLL AND DQS pin delays #
                 ##############################
         "
        generate_pll_delays
        generate_dqs_delays

        hcii_util::formatted_write $outfile "


                 ##############################
                 # Set IO rise&fall delays #
                 ############################## 

         "
        generate_io_delays

        hcii_util::formatted_write $outfile "


                 ######################
                 # Timing Constraints #
                 ######################

         "
        if {[file exists $col_output_file_name]} {
                puts $outfile "source ${::rev_name}.collections.sdc"
                if {[file exists $input_constraint_file_name]} {
                       puts $outfile "source ${::rev_name}.constraints.sdc"
                } else {
                       hardcopy_msgs::post E_CANNOT_OPEN_FILE $input_constraint_file_name
                       hardcopy_msgs::post E_RUN_TIMEQUEST
                       qexit -error
                }
        } else {
                hardcopy_msgs::post E_CANNOT_OPEN_FILE $col_output_file_name
        	qexit -error
        }

        # Get output pin loading and input pin transition times.
	hcii_qsf_based_conversion::generate_output_pin_loadings
	hcii_qsf_based_conversion::generate_input_pin_transitions
        l2p::done

        # Unload all reports
        unload_report

       	close $outfile
       	hcii_util::post_msgs "info" \
		"--------------------------------------------------------" \
		"Generated $output_file_name" \
		"--------------------------------------------------------"
		

}

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
proc hcii_sta_based_conversion::generate_dqs_delays { } {
        # For DQS, set_annotated_delay is used to communicate delay chain
        # settings
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
        global outfile

        foreach_in_collection atom_id [get_atom_nodes -type PIN] {

                set oterms [get_atom_oports -node $atom_id]
                foreach oterm_id $oterms {
                        set oterm_type [get_atom_port_info -node $atom_id -type oport -port_id $oterm_id -key type]
                        if {[string equal -nocase $oterm_type OUT_STAGE4] } {
                                set q_ioc_name [get_atom_node_info -node $atom_id -key name]
                                set p_ioc_name [get_converted_node_name $atom_id -full_name]
                                puts $outfile "# IOC (DQS Mode): $q_ioc_name"
                                set p_pin_name "$p_ioc_name/PIN"
                                set ff_delay [get_atom_node_info -node $atom_id -key INT_DQS_DELAY_VALUE_FOR_BACKEND_FF]
                                set ss_delay [get_atom_node_info -node $atom_id -key INT_DQS_DELAY_VALUE_FOR_BACKEND_SS]
                                # Convert to "ns"
                                set ff_delay [hcii_util::tsm_delay_to_ns $ff_delay]
                                set ss_delay [hcii_util::tsm_delay_to_ns $ss_delay]

                                hcii_util::write_command "set annotated_delay(ffsi) $ff_delay"
                                hcii_util::write_command "set annotated_delay(sssi) $ss_delay"
                                hcii_util::write_command "set_annotated_delay \$annotated_delay(\$delay_type) -incre -to $p_pin_name -net \n"
                        }
                }
        }
}

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
proc hcii_sta_based_conversion::generate_pll_delays { } {
        # Set PLL Annotated Delay
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
        global outfile

        # Use this constant to represent an illegal or unset compensation delay
        variable illegal_pll_compensation
        set illegal_pll_compensation -2147483647

        foreach_in_collection atom_id [get_atom_nodes -type PLL] {

               set q_atom_name [get_atom_node_info -node $atom_id -key name]
               puts $outfile "\n# PLL block name: $q_atom_name"

               # Get iport of PLL
               # Note that a PLL can have at most two input clocks
               set pll_in_list [get_atom_node_info -node $atom_id -key STRING_VEC_PORT_NAME_VEC]

               # Check which real PLL oterms are used
               set oterms [get_atom_oports -node $atom_id]
               foreach oterm_id $oterms {
                       set oterm_fanout [get_atom_port_info -node $atom_id -type oport -port_id $oterm_id -key fanout]
                       if {[llength $oterm_fanout] > 0} {
                            set oterm_type [get_atom_port_info -node $atom_id -type oport -port_id $oterm_id -key type]
                            set oterm_index [get_atom_port_info -node $atom_id -type oport -port_id $oterm_id -key literal_index]
                            set q_oport_name [get_atom_port_info -node $atom_id -type oport -port_id $oterm_id -key name]

                            set max_compensation_delay $illegal_pll_compensation
                            set min_compensation_delay $illegal_pll_compensation

                            switch -glob $oterm_type {
                                   EXTCLKOUT* {
                                        set ext_clock_p2p_delay_list [get_atom_node_info -node $atom_id -key INT_VEC_EXT_CLOCK_P2P_DELAY]
                                        set ext_clock_p2p_delay_fast_list [get_atom_node_info -node $atom_id -key INT_VEC_EXT_CLOCK_P2P_DELAY_FAST]
                                        set max_compensation_delay [lindex $ext_clock_p2p_delay_list $oterm_index]
                                        set min_compensation_delay [lindex $ext_clock_p2p_delay_fast_list $oterm_index]
                                   }
                                   CCLK* {
                                        set clock_out_p2p_delay_list [get_atom_node_info -node $atom_id -key INT_VEC_CLOCK_OUT_P2P_DELAY]
                                        set clock_out_p2p_delay_fast_list [get_atom_node_info -node $atom_id -key INT_VEC_CLOCK_OUT_P2P_DELAY_FAST]
                                        set max_compensation_delay [lindex $clock_out_p2p_delay_list $oterm_index]
                                        set min_compensation_delay [lindex $clock_out_p2p_delay_fast_list $oterm_index]
                                   }
                                   SCLK* {
                                        set sclk_out_p2p_delay_list [get_atom_node_info -node $atom_id -key INT_VEC_SCLK_OUT_P2P_DELAY]
                                        set sclk_out_p2p_delay_fast_list [get_atom_node_info -node $atom_id -key INT_VEC_SCLK_OUT_P2P_DELAY_FAST]
                                        set max_compensation_delay [lindex $sclk_out_p2p_delay_list $oterm_index]
                                        set min_compensation_delay [lindex $sclk_out_p2p_delay_fast_list $oterm_index]
                                   }
                                   default { }
                            }

                            if {($max_compensation_delay != $illegal_pll_compensation) || \
                                    ($min_compensation_delay != $illegal_pll_compensation)} {
                                   # Get corresponding PrimeTime HC name for the PLL block
                                   set p_block_name [get_converted_node_name $atom_id -full_name]
                                   # Create PT HC name of this oterm using the type and index
                                   set p_opin_name "$p_block_name/${oterm_type}${oterm_index}"

                                   # Hard-code delay of the clock net as the compensation delay
                                   # already accounts for it.
                                   puts $::outfile "# --> PLL oport name: $q_oport_name"
                                   hcii_util::write_command "set_annotated_delay -net -from $p_opin_name 0.0"

                                   # For every PLL clock iport/oport pair, set_annotated_delay.
                                   foreach pll_in $pll_in_list {
                                           # There are up to 2 inputs but it is likely only one is used.
                                           if {$pll_in != ""} {
                                                # Remove "[]" from PLL input port name
                                                regsub -all {[]]} $pll_in "" pll_in
                                                regsub -all {[[]} $pll_in "" pll_in
                                                msg_vdebug "==> Found PLL input: $pll_in"
                                                set p_ipin_name "$p_block_name/$pll_in"
                                                if {$min_compensation_delay != $illegal_pll_compensation} {
                                                     set pt_min_delay [hcii_util::tsm_delay_to_ns $min_compensation_delay]
                                                     hcii_util::write_command "set annotated_delay(ffsi) $pt_min_delay"
                                                }
                                                if {$max_compensation_delay != $illegal_pll_compensation} {
                                                     set pt_max_delay [hcii_util::tsm_delay_to_ns $max_compensation_delay]
                                                     hcii_util::write_command "set annotated_delay(sssi) $pt_max_delay"
                                                }
                                                hcii_util::write_command "set_annotated_delay -cell -from $p_ipin_name -to $p_opin_name \$annotated_delay(\$delay_type) \n"
                                           }
                                   }
                            }
                       }

               }

        }
        puts $::outfile ""
}

# --------------------------------------------------------------------------
# --------------------------------------------------------------------------
proc hcii_sta_based_conversion::test_dump_netlist { } {
# --------------------------------------------------------------------------
# --------------------------------------------------------------------------
     set output_file_name "$::hc_output/netlist.txt"
     set output_file [open $output_file_name w]
     post_message -type info "*** Generate Physical Netlist (START TESTING)"
     foreach_in_collection atom_id [get_atom_nodes] {

          set atom_name [get_atom_node_info -key name -node $atom_id]
          set atom_type [get_atom_node_info -key type -node $atom_id]
          set atom_keys [get_legal_info_keys -type all -node $atom_id]
          set atom_enum_type [get_atom_node_info -key ENUM_ATOM_TYPE -node $atom_id]
          set atom_hdb [get_atom_node_info -key HDBID_NAME_ID -node $atom_id]

          puts $output_file "***Atom ID: $atom_id"
          puts $output_file "***Atom Name: $atom_name"
          puts $output_file "***Atom Type: $atom_type"
          puts $output_file "***Atom Enum Type: $atom_enum_type"
          puts $output_file "***Atom HDB ID: $atom_hdb"
          puts $output_file "***PT Name: [get_converted_node_name $atom_id]"
	  puts $output_file "***PT Name (Full): [get_converted_node_name $atom_id -full_name]"

          puts $output_file "***Valid Keys: $atom_keys"

          set oterms [get_atom_oports -node $atom_id]

          foreach oterm_id $oterms {
                set oterm_name [get_atom_port_info -node $atom_id -type oport -port_id $oterm_id -key name]
                set oterm_hdb_id [get_atom_port_info -node $atom_id -type oport -port_id $oterm_id -key name_id]
                set port_type [get_atom_port_info -node $atom_id -type oport -port_id $oterm_id -key type]
                set port_index [get_atom_port_info -node $atom_id -type oport -port_id $oterm_id -key literal_index]

                puts $output_file "Oterm ID: $oterm_id"
                puts $output_file "Oterm Name: $oterm_name"
                puts $output_file "Oterm HDB ID: $oterm_hdb_id"
                puts $output_file "Oterm Type: $port_type"
                puts $output_file "Port Index: $port_index"
                puts $output_file "PT Name: [get_converted_port_name $oterm_id -node_id $atom_id]"
	        puts $output_file "PT Name (Full): [get_converted_port_name $oterm_id -node_id $atom_id -full_name]"
          }
          set iterms [get_atom_iports -node $atom_id]

          foreach iterm_id $iterms {
               # set iterm_name [get_atom_port_info -node $atom_id -type iport -port_id $iterm_id -key name]
               # set iterm_hdb_id [get_atom_port_info -node $atom_id -type iport -port_id $iterm_id -key name_id]
                set port_type [get_atom_port_info -node $atom_id -type iport -port_id $iterm_id -key type]
                set port_index [get_atom_port_info -node $atom_id -type iport -port_id $iterm_id -key literal_index]
                puts $output_file "Iterm ID: $iterm_id"
              #  puts $output_file "Iterm Name: $iterm_name"
              #  puts $output_file "Iterm HDB ID: $iterm_hdb_id"
                puts $output_file "Iterm Type: $port_type"
                puts $output_file "Port Index: $port_index"
              #  puts $output_file "PT Name: [get_converted_port_name $iterm_id -node_id $atom_id]"
	     #	puts $output_file "PT Name (Full): [get_converted_port_name $iterm_id -node_id $atom_id -full_name]"
          }

          puts $output_file ""
     }
     post_message -type info "*** Generate Physical Netlist (END TESTING)"
     close $output_file
}

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
proc hcii_sta_based_conversion::generate_io_delays { } {
        #
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

    #for debugging an io_delays.txt will be generated in hc_output filder.
    if { [string equal -nocase [get_ini_var -name io_delay_msg] "on"] } {
        set output_file_name "$::hc_output/io_delays.txt"
        set output_file [open $output_file_name w]
    }

    if { ![catch {read_atom_netlist -type cmp} msg] } {

        foreach_in_collection atom [get_atom_nodes] {
            set type [get_atom_node_info -key TYPE -node $atom]
            set name [get_atom_node_info -key NAME -node $atom]

            if {[string equal -nocase $type "io_ibuf"] || [string equal -nocase $type "io_obuf"]} {

                set key "INT_VEC_IO_RISING_DELAY"
                set rising_delay [get_atom_node_info -key $key -node $atom]
                #io_rising_delay ff 0c
                set rise_delay(ff) [lindex $rising_delay 0]
                #io_rising_delay ss 0c
                set rise_delay(ss_0) [lindex $rising_delay 1]
                #io_rising_delay ss 85c
                set rise_delay(ss_85) [lindex $rising_delay 2]
                # Convert to "ns"
                set rise_delay(ff) [hcii_util::tsm_delay_to_ns $rise_delay(ff)]
                set rise_delay(ss_0) [hcii_util::tsm_delay_to_ns $rise_delay(ss_0)]
                set rise_delay(ss_85) [hcii_util::tsm_delay_to_ns $rise_delay(ss_85)]

                set key "INT_VEC_IO_FALLING_DELAY"
                set falling_delay [get_atom_node_info -key $key -node $atom]
                #io_falling_delay ff 0c
                set fall_delay(ff) [lindex $falling_delay 0]
                #io_falling_delay ss 0c
                set fall_delay(ss_0) [lindex $falling_delay 1]
                #io_falling_delay ss 85c
                set fall_delay(ss_85) [lindex $falling_delay 2]
                # Convert to "ns"
                set fall_delay(ff) [hcii_util::tsm_delay_to_ns $fall_delay(ff)]
                set fall_delay(ss_0) [hcii_util::tsm_delay_to_ns $fall_delay(ss_0)]
                set fall_delay(ss_85) [hcii_util::tsm_delay_to_ns $fall_delay(ss_85)]

                if { [string equal -nocase [get_ini_var -name io_delay_msg] "on"] } {
                    puts $output_file "\n Name: $name, Type: $type, Atom: $atom"
                    puts $output_file "{"
                    puts $output_file "\t$key: "
                    puts $output_file "\t\t rff_delay_0c:\t$rise_delay(ff) \n\t\t rss_0c_delay:\t$rise_delay(ss_0) \n\t\t rss_85c_delay:\t$rise_delay(ss_85)"
                    puts $output_file "\n\t$key:"
                    puts $output_file "\t\t fff_delay_0c:\t$fall_delay(ff) \n\t\t fss_0c_delay:\t$fall_delay(ss_0) \n\t\t fss_85c_delay:\t$fall_delay(ss_85)"
                    puts $output_file "}"
                }

                set output_name [get_converted_node_name $atom -full_name]


		hcii_util::write_command "set rise_delay(ff) $rise_delay(ff)"
		hcii_util::write_command "set rise_delay(ss_0) $rise_delay(ss_0)"
		hcii_util::write_command "set rise_delay(ss_85) $rise_delay(ss_85)"
		hcii_util::write_command "set fall_delay(ff) $fall_delay(ff)"
		hcii_util::write_command "set fall_delay(ss_0) $fall_delay(ss_0)"
		hcii_util::write_command "set fall_delay(ss_85) $fall_delay(ss_85)\n"

                if { [string equal -nocase $type "io_obuf"] } {
                    hcii_util::write_command "set_annotated_delay -rise -cell \$rise_delay(\$delay_type) -to $output_name"
                    hcii_util::write_command "set_annotated_delay -fall -cell \$fall_delay(\$delay_type) -to $output_name\n"
                }

                if { [string equal -nocase $type "io_ibuf"] } {
                    hcii_util::write_command "set_annotated_delay -rise -cell \$rise_delay(\$delay_type) -from $output_name"
                    hcii_util::write_command "set_annotated_delay -fall -cell \$fall_delay(\$delay_type) -from $output_name\n"
                }
            }
        }
    }
}