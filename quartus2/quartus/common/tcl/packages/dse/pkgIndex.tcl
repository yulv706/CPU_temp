# Tcl package index file, version 1.1
# This file is generated by the "pkg_mkIndex -lazy" command
# and sourced either when an application starts up or
# by a "package unknown" script.  It invokes the
# "package ifneeded" command to set up package-related
# information so that packages will be loaded automatically
# in response to "package require" commands.  When this
# script is sourced, the variable $dir must contain the
# full path name of this file's directory.

package ifneeded ::quartus::dse::arria 1.0 [list tclPkgSetup $dir ::quartus::dse::arria 1.0 {{dse-arria-lib.tcl source {::quartus::dse::arria::get_description_for_type ::quartus::dse::arria::get_multiplier_for_type ::quartus::dse::arria::get_quick_recipe_for ::quartus::dse::arria::get_valid_types ::quartus::dse::arria::has_quick_recipe_for ::quartus::dse::arria::is_valid_type ::quartus::dse::arria::set_design_space}}}]
package ifneeded ::quartus::dse::ccl 1.0 [list tclPkgSetup $dir ::quartus::dse::ccl 1.0 {{ccl-lib.tcl source {::quartus::dse::ccl::absgain ::quartus::dse::ccl::archive ::quartus::dse::ccl::bputs ::quartus::dse::ccl::dputs ::quartus::dse::ccl::dse_exec ::quartus::dse::ccl::elapsed_time_string ::quartus::dse::ccl::eputs ::quartus::dse::ccl::get_global_option ::quartus::dse::ccl::get_seed_list ::quartus::dse::ccl::init ::quartus::dse::ccl::iputs ::quartus::dse::ccl::pgain ::quartus::dse::ccl::qslave ::quartus::dse::ccl::quartus_fit ::quartus::dse::ccl::quartus_map ::quartus::dse::ccl::quartus_tan ::quartus::dse::ccl::read_state_from_disk ::quartus::dse::ccl::reverseList ::quartus::dse::ccl::save_state_to_disk ::quartus::dse::ccl::stop_tool ::quartus::dse::ccl::time_d ::quartus::dse::ccl::time_h ::quartus::dse::ccl::time_m ::quartus::dse::ccl::time_s ::quartus::dse::ccl::unarchive ::quartus::dse::ccl::wputs}}}]
package ifneeded ::quartus::dse::cyclone 1.0 [list tclPkgSetup $dir ::quartus::dse::cyclone 1.0 {{dse-cyclone-lib.tcl source {::quartus::dse::cyclone::get_description_for_type ::quartus::dse::cyclone::get_quick_recipe_for ::quartus::dse::cyclone::get_valid_types ::quartus::dse::cyclone::has_quick_recipe_for ::quartus::dse::cyclone::is_valid_type ::quartus::dse::cyclone::set_design_space}}}]
package ifneeded ::quartus::dse::cycloneii 1.0 [list tclPkgSetup $dir ::quartus::dse::cycloneii 1.0 {{dse-cycloneii-lib.tcl source {::quartus::dse::cycloneii::get_description_for_type ::quartus::dse::cycloneii::get_multiplier_for_type ::quartus::dse::cycloneii::get_quick_recipe_for ::quartus::dse::cycloneii::get_valid_types ::quartus::dse::cycloneii::has_quick_recipe_for ::quartus::dse::cycloneii::is_valid_type ::quartus::dse::cycloneii::set_design_space}}}]
package ifneeded ::quartus::dse::cycloneiii 1.0 [list tclPkgSetup $dir ::quartus::dse::cycloneiii 1.0 {{dse-cycloneiii-lib.tcl source {::quartus::dse::cycloneiii::get_description_for_type ::quartus::dse::cycloneiii::get_multiplier_for_type ::quartus::dse::cycloneiii::get_quick_recipe_for ::quartus::dse::cycloneiii::get_valid_types ::quartus::dse::cycloneiii::has_quick_recipe_for ::quartus::dse::cycloneiii::is_valid_type ::quartus::dse::cycloneiii::set_design_space}}}]
package ifneeded ::quartus::dse::designspace 1.0 [list source [file join $dir designspace-lib.tcl]]
package ifneeded ::quartus::dse::flex6000 1.0 [list tclPkgSetup $dir ::quartus::dse::flex6000 1.0 {{dse-flex6000-lib.tcl source {::quartus::dse::flex6000::get_description_for_type ::quartus::dse::flex6000::get_quick_recipe_for ::quartus::dse::flex6000::get_valid_types ::quartus::dse::flex6000::has_quick_recipe_for ::quartus::dse::flex6000::is_valid_type ::quartus::dse::flex6000::set_design_space}}}]
package ifneeded ::quartus::dse::flows 1.0 [list tclPkgSetup $dir ::quartus::dse::flows 1.0 {{flow-lib.tcl source {::quartus::dse::flows::init ::quartus::dse::flows::stop_flow}}}]
package ifneeded ::quartus::dse::genericfamily 1.0 [list tclPkgSetup $dir ::quartus::dse::genericfamily 1.0 {{dse-genericfamily-lib.tcl source {::quartus::dse::genericfamily::get_description_for_type ::quartus::dse::genericfamily::get_quick_recipe_for ::quartus::dse::genericfamily::get_valid_types ::quartus::dse::genericfamily::has_quick_recipe_for ::quartus::dse::genericfamily::is_valid_type ::quartus::dse::genericfamily::set_design_space}}}]
package ifneeded ::quartus::dse::gui 1.0 [list tclPkgSetup $dir ::quartus::dse::gui 1.0 {{gui-lib.tcl source {::quartus::dse::gui::main ::quartus::dse::gui::print_msg ::quartus::dse::gui::update_base_result ::quartus::dse::gui::update_best_result ::quartus::dse::gui::update_progress}}}]
package ifneeded ::quartus::dse::hardcopyii 1.0 [list tclPkgSetup $dir ::quartus::dse::hardcopyii 1.0 {{dse-hardcopyii-lib.tcl source {::quartus::dse::hardcopyii::get_description_for_type ::quartus::dse::hardcopyii::get_multiplier_for_type ::quartus::dse::hardcopyii::get_quick_recipe_for ::quartus::dse::hardcopyii::get_valid_types ::quartus::dse::hardcopyii::has_quick_recipe_for ::quartus::dse::hardcopyii::is_valid_type ::quartus::dse::hardcopyii::set_design_space}}}]
package ifneeded ::quartus::dse::logiclock 1.0 [list tclPkgSetup $dir ::quartus::dse::logiclock 1.0 {{dse-logiclock-lib.tcl source ::quartus::dse::logiclock::set_design_space}}]
package ifneeded ::quartus::dse::max7000 1.0 [list tclPkgSetup $dir ::quartus::dse::max7000 1.0 {{dse-max7000-lib.tcl source {::quartus::dse::max7000::get_description_for_type ::quartus::dse::max7000::get_multiplier_for_type ::quartus::dse::max7000::get_quick_recipe_for ::quartus::dse::max7000::get_valid_types ::quartus::dse::max7000::has_quick_recipe_for ::quartus::dse::max7000::is_valid_type ::quartus::dse::max7000::set_design_space}}}]
package ifneeded ::quartus::dse::maxii 1.0 [list tclPkgSetup $dir ::quartus::dse::maxii 1.0 {{dse-maxii-lib.tcl source {::quartus::dse::maxii::get_description_for_type ::quartus::dse::maxii::get_multiplier_for_type ::quartus::dse::maxii::get_quick_recipe_for ::quartus::dse::maxii::get_valid_types ::quartus::dse::maxii::has_quick_recipe_for ::quartus::dse::maxii::is_valid_type ::quartus::dse::maxii::set_design_space}}}]
package ifneeded ::quartus::dse::qof 1.0 [list tclPkgSetup $dir ::quartus::dse::qof 1.0 {{qof-lib.tcl source ::quartus::dse::qof::quality_of_fit}}]
package ifneeded ::quartus::dse::result 1.0 [list source [file join $dir result-lib.tcl]]
package ifneeded ::quartus::dse::seed 1.0 [list tclPkgSetup $dir ::quartus::dse::seed 1.0 {{dse-seed-lib.tcl source ::quartus::dse::seed::set_design_space}}]
package ifneeded ::quartus::dse::stratix 1.0 [list tclPkgSetup $dir ::quartus::dse::stratix 1.0 {{dse-stratix-lib.tcl source {::quartus::dse::stratix::get_description_for_type ::quartus::dse::stratix::get_multiplier_for_type ::quartus::dse::stratix::get_quick_recipe_for ::quartus::dse::stratix::get_valid_types ::quartus::dse::stratix::has_quick_recipe_for ::quartus::dse::stratix::is_valid_type ::quartus::dse::stratix::set_design_space}}}]
package ifneeded ::quartus::dse::stratixii 1.0 [list tclPkgSetup $dir ::quartus::dse::stratixii 1.0 {{dse-stratixii-lib.tcl source {::quartus::dse::stratixii::get_description_for_type ::quartus::dse::stratixii::get_multiplier_for_type ::quartus::dse::stratixii::get_quick_recipe_for ::quartus::dse::stratixii::get_valid_types ::quartus::dse::stratixii::has_quick_recipe_for ::quartus::dse::stratixii::is_valid_type ::quartus::dse::stratixii::set_design_space}}}]
package ifneeded ::quartus::dse::stratixiii 1.0 [list tclPkgSetup $dir ::quartus::dse::stratixiii 1.0 {{dse-stratixiii-lib.tcl source {::quartus::dse::stratixiii::get_description_for_type ::quartus::dse::stratixiii::get_multiplier_for_type ::quartus::dse::stratixiii::get_quick_recipe_for ::quartus::dse::stratixiii::get_valid_types ::quartus::dse::stratixiii::has_quick_recipe_for ::quartus::dse::stratixiii::is_valid_type ::quartus::dse::stratixiii::set_design_space}}}]
package ifneeded ::quartus::dse::stratixiv 1.0 [list tclPkgSetup $dir ::quartus::dse::stratixiv 1.0 {{dse-stratixiv-lib.tcl source {::quartus::dse::stratixiv::get_description_for_type ::quartus::dse::stratixiv::get_multiplier_for_type ::quartus::dse::stratixiv::get_quick_recipe_for ::quartus::dse::stratixiv::get_valid_types ::quartus::dse::stratixiv::has_quick_recipe_for ::quartus::dse::stratixiv::is_valid_type ::quartus::dse::stratixiv::set_design_space}}}]
