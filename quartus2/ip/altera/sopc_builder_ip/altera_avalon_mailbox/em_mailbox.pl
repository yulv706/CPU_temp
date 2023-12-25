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






















use europa_all;
use em_mailbox;

$| = 1;     # Always flush stderr


exit if(not @ARGV);



my $project = e_project->new(@ARGV);
my $module = $project->top();
my $Opt = &copy_of_hash ($project->WSA());

my $data_width = $Opt->{data_width};








my $marker = e_default_module_marker->new($module);




make_em_mailbox($Opt, $project);







my @ports = (
    [clk            => 1,           "in" ],
    [reset_n        => 1,           "in" ],
    [chipselect     => 1,           "in" ],
    [data_from_cpu  => 32,          "in" ],
    [data_to_cpu    => 32,          "out"],
    [read           => 1,           "in" ],
    [write          => 1,           "in" ],
    [address        => 2,           "in" ]
); 




e_port->adds(@ports);




my $s1_type_map = {
    clk             => "clk",
    reset_n         => "reset_n",
    data_from_cpu   => "writedata",
    data_to_cpu     => "readdata",
    read            => "read",
    write           => "write",
    address         => "address",
};




e_avalon_slave->add({
    name     => "s1",
    type_map => $s1_type_map,
}); 




$project->output();
