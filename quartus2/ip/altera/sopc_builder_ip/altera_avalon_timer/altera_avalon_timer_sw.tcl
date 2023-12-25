#
# altera_avalon_timer_driver.tcl
#

# Create a new driver
create_driver altera_avalon_timer_driver

# Associate it with some hardware known as "altera_avalon_timer"
set_sw_property hw_class_name altera_avalon_timer

# The version of this driver
set_sw_property version 9.0

# This driver may be incompatible with versions of hardware less
# than specified below. Updates to hardware and device drivers
# rendering the driver incompatible with older versions of
# hardware are noted with this property assignment.
set_sw_property min_compatible_hw_version 8.0

# Initialize the driver in alt_sys_init()
set_sw_property auto_initialize true

# Location in generated BSP that above sources will be copied into
set_sw_property bsp_subdirectory drivers

# Set priority assignment for alt_sys_init()
# If left unspecified, driver priorities default to '1000'. The timer
# must be initialized before certain other drivers (JTAG UART, if
# present). Therefore, set a reasonably high priority to assure
# that the driver will be initialize first. Lower nubmer = higher
# priority.
set_sw_property alt_sys_init_priority 100

#
# Source file listings...
#

# C/C++ source files
add_sw_property c_source HAL/src/altera_avalon_timer_sc.c
add_sw_property c_source HAL/src/altera_avalon_timer_ts.c
add_sw_property c_source HAL/src/altera_avalon_timer_vars.c

# Include files
add_sw_property include_source HAL/inc/altera_avalon_timer.h
add_sw_property include_source inc/altera_avalon_timer_regs.h

# This driver supports HAL & UCOSII BSP (OS) types
add_sw_property supported_bsp_type HAL
add_sw_property supported_bsp_type UCOSII

# End of file
