
# pkgIndex.tcl - 
#
#    A new manually generated "pkgIndex.tcl" file for tls to
#    replace the original which didn't include the commands from "tls.tcl".
#

package ifneeded tls 1.4 "[list load [file join $dir tls14.dll] ] ; [list source [file join $dir tls.tcl] ]"

