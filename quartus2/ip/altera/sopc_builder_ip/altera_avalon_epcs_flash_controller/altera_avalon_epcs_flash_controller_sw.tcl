#
# altera_avalon_epcs_flash_controller_driver.tcl
#

# Create a new driver
create_driver altera_avalon_epcs_flash_controller_driver

# Associate it with some hardware known as "altera_avalon_epcs_flash_controller"
set_sw_property hw_class_name altera_avalon_epcs_flash_controller

# The version of this driver
set_sw_property version 9.0

# This driver may be incompatible with versions of hardware less
# than specified below. Updates to hardware and device drivers
# rendering the driver incompatible with older versions of
# hardware are noted with this property assignment.
#
# Multiple-Version compatibility was introduced in version 7.1;
# prior versions are therefore excluded.
set_sw_property min_compatible_hw_version 7.1

# Initialize the driver in alt_sys_init()
set_sw_property auto_initialize true

# Location in generated BSP that above sources will be copied into
set_sw_property bsp_subdirectory drivers

#
# Source file listings...
#

# The EPCS controller is a super-set of the SPI component driver. SPI
# drivers are always included when an EPCS is present in the system.
# If an EPCS *and* SPI are present, the SPI sources are merely
# copied into the generated BSP one extra time.

# C/C++ source files
add_sw_property c_source HAL/src/altera_avalon_epcs_flash_controller.c
add_sw_property c_source HAL/src/epcs_commands.c
add_sw_property c_source HAL/src/altera_avalon_spi.c

# Include files
add_sw_property include_source HAL/inc/altera_avalon_epcs_flash_controller.h
add_sw_property include_source HAL/inc/epcs_commands.h
add_sw_property include_source HAL/inc/altera_avalon_spi.h
add_sw_property include_source inc/altera_avalon_spi_regs.h

# This driver supports HAL & UCOSII BSP (OS) types
add_sw_property supported_bsp_type HAL
add_sw_property supported_bsp_type UCOSII

# End of file
