# HK: I must admit that I find it much easier to write a pkgIndex.tcl by
# hand than to tweak my code such that it can be automatically generated. 
# $Revision: #1 $, $Date: 2009/02/04 $

## tclPkgUnknown, when running this script, makes sure that
## $dir is set to the directory of this very file
set VERSION 1.4
set VERDATE 2002-09-21

# Tidied code by Ed Suominen.

# Define the package names and sourced script files
set packageSetupList {
  xmlgen
  {xmlgen.tcl}
  
  htmlgen
  {htmlgen.tcl tab.tcl sidenav.tcl}
}

# Now setup the packages
foreach {pkg files} $packageSetupList {
  set script "package provide $pkg $VERSION\n"
  append script "namespace eval ::$pkg set VERSION $VERSION\n"
  foreach {file} $files {
    append script "source \[file join \"$dir\" $file\]\n"
  }
  package ifneeded $pkg $VERSION $script
}
