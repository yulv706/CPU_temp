#
# altera_avalon_jtag_uart_driver.tcl
#

# Create a new driver
create_driver altera_avalon_jtag_uart_driver

# Associate it with some hardware known as "altera_avalon_jtag_uart"
set_sw_property hw_class_name altera_avalon_jtag_uart

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

# C/C++ source files
add_sw_property c_source HAL/src/altera_avalon_jtag_uart_init.c
add_sw_property c_source HAL/src/altera_avalon_jtag_uart_read.c
add_sw_property c_source HAL/src/altera_avalon_jtag_uart_write.c
add_sw_property c_source HAL/src/altera_avalon_jtag_uart_ioctl.c
add_sw_property c_source HAL/src/altera_avalon_jtag_uart_fd.c

# Include files
add_sw_property include_source HAL/inc/altera_avalon_jtag_uart.h
add_sw_property include_source HAL/inc/altera_avalon_jtag_uart_fd.h
add_sw_property include_source inc/altera_avalon_jtag_uart_regs.h

# This driver supports HAL & UCOSII BSP (OS) types
add_sw_property supported_bsp_type HAL
add_sw_property supported_bsp_type UCOSII

# Add the following per_driver configuration option to the BSP:
#  o Type of setting (boolean_define_only translates to "either
#    emit a #define if true, or don't if false"). Useful for
#    source code with "#ifdef" style build-options.
#  o Generated file to write to (public_mk_define -> public.mk)
#  o Name of setting for use with bsp command line settings tools
#    (enable_small_driver). This name will be combined with the
#    driver class to form a settings hierarchy to assure unique
#    settings names
#  o '#define' in driver code (and therefore string in generated
#     makefile): "ALTERA_AVALON_JTAG_UART_SMALL", which means: "emit
#     CPPFLAGS += ALTERA_AVALON_JTAG_UART_SMALL in generated makefile
#  o Default value (if the user doesn't specify at BSP creation): false
#    (which means: 'do not emit above CPPFLAGS string in generated makefile)
#  o Description text
add_sw_setting boolean_define_only public_mk_define enable_small_driver ALTERA_AVALON_JTAG_UART_SMALL false "Small-footprint (polled mode) driver"

# End of file
