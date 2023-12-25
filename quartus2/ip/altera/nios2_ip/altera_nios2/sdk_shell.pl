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





$| = 1;         # set flushing on STDOUT


my $in_cmd = shift;
my ($quartus_dir, $sopc_kit_dir, $system_dir, $system_name) = split ',',$in_cmd;




if ($sopc_kit_dir eq "")
{
    $sopc_kit_dir = $ENV{'SOPC_KIT_NIOS2'};
}

if ($^O =~ /win/i) # Windows:
{
my $cmd = $ENV{COMSPEC};
my $bat = "$sopc_kit_dir/Nios II Command Shell.bat";
$bat =~ s/\//\\/g;

$ENV{'WIN32_SDK_SHELL_PROJECT_PATH'} = "$system_dir";
chdir $sopc_kit_dir;

my $result = exec ($cmd, "/C", "start", "\"Launching Nios II Command Shell\"", "\"$bat\"");
}
else # Linux:
{
  exec("xterm -rv -e $sopc_kit_dir/sdk_shell");
}
return 1; # success


