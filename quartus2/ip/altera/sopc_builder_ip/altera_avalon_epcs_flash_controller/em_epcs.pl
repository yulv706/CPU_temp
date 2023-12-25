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
use em_epcs;
use em_spi;




use refdes_check;

use strict;

my $slave_name = get_slave_name();


sub get_contents_file_name
{
  my $project = shift;
  my $extension = shift;
  
  my $top_module = $project->top();
  my $top_level_module_name = $top_module->name();
  


  if ($extension && $extension !~ /^\./)
  {
    $extension = '.' . $extension;
  }
  return "$top_level_module_name\_boot_rom$extension";
}

sub copy_and_convert_contents_file
{
  my $project = shift;
  
  my $top_module = $project->top();
  my $top_level_module_name = $top_module->name();
  my $SBI = $project->SBI($slave_name);
  



  my @master_list = $project->get_my_cpu_masters_through_bridges(
      $top_level_module_name,
      $slave_name
    );
    

  my %master_classes =
    map {
      ($project->system_ptf()->{"MODULE $_"}->{class}, 1)
    } @master_list;


  my $chosen_cpu = "";
  if (keys %master_classes < 1)
  {




    print STDERR (
      "Warning: $top_level_module_name has no mastering CPU,\n" .
      "         so its boot rom will be blank.\n");
  }

  if (keys %master_classes == 1)
  {

    $chosen_cpu = $master_list[0];
  }

  if (keys %master_classes > 1)
  {
    $chosen_cpu = $master_list[0];

    print STDERR (
      "Warning: CPU masters of different classes for component " .
      "$top_level_module_name: ",
      keys %master_classes, "\n"
    );
    print STDERR ("assuming that these different CPU masters are code-compatible, " .
      "or that only one will actually execute code from this component.\n"
    );
    

    for (@master_list)
    {
      if (hex($project->get_cpu_reset_address($_)) ==
        hex($SBI->{Base_Address}))
      {
        $chosen_cpu = $_;
      }
    }
    print STDERR "using contents from master '$chosen_cpu'\n";
  }

  require "format_conversion_utils.pm";


  my $args =
  {
    comments     => "0",
    width        => $SBI->{Data_Width},
    address_low  => 0,
    address_high => get_code_size($project) - 1,
  };




  if($chosen_cpu ne "")
  {






    my $chosen_cpu_class =
      $project->system_ptf()->{"MODULE $chosen_cpu"}->{class};
    my $cpu_wsa = $project->WSA($chosen_cpu);

    my %find_component_dir_context;
    $find_component_dir_context{system_directory} = $project->__system_directory();
    my $boot_copier_dir = find_component_dir(\%find_component_dir_context,'', $chosen_cpu_class);
    my $boot_copier_srec;
    my $device_family =
      uc($project->system_ptf()->{WIZARD_SCRIPT_ARGUMENTS}->{device_family});


  if( ($device_family eq "STRATIXII")   ||
      ($device_family eq "STRATIXIIGX") ||
      ($device_family eq "STRATIXIIGXLITE") ||
      ($device_family eq "STRATIXIII") ||
      ($device_family eq "STRATIXIV") ||
      ($device_family eq "ARRIAII") ||
      ($device_family eq "CYCLONEIII") ||
      ($device_family eq "TARPON"))
    {
      $boot_copier_srec = "$boot_copier_dir/$cpu_wsa->{Boot_Copier_EPCS_SII_SIII_CIII}";
    }
    else
    {
      $boot_copier_srec = "$boot_copier_dir/$cpu_wsa->{Boot_Copier_EPCS}";
    }

    $$args{infile} = $boot_copier_srec;
  }
  

  





  my @contents_file_spec = (
    {
      oformat => 'hex',
      outfile => $project->__system_directory() . "/",
    },
  );
  


  map {
    $_->{outfile} .= get_contents_file_name($project, $_->{oformat})
  } @contents_file_spec;
  
  
  for my $file_spec (@contents_file_spec)
  {
    my %specific_args = %$args;
    for (keys %$file_spec)
    {
      $specific_args{$_} = $file_spec->{$_};
    }
    
    format_conversion_utils::fcu_convert(\%specific_args);
  }
}






if (!@ARGV)
{

  make_epcs();
}
else
{









  my $project = make_spi(@ARGV);

  my $error = refdes_check::check($project);
  if ($error)
  {
    print STDERR "\nERROR:\n$error\n";
    ribbit();
  }
    
  my $SBI     = &copy_of_hash($project->SBI($slave_name));

  my $top_module = $project->top();
  


  my $top_level_module_name = $top_module->name();


  $top_module->update();


  my @inner_ports = $top_module->get_object_names("e_port");


  my $new_name = $top_level_module_name . "_sub";
  my $inner_mod = $project->module_hash()->{$top_level_module_name};
  $inner_mod->name($new_name);
  $project->module_hash()->{$new_name} = $inner_mod;
  delete $project->module_hash()->{$top_level_module_name};
  

  my $module = e_module->new({
    name => $top_level_module_name,
    project => $project,
  });

  $module->add_contents(
    e_instance->new({
      module => $new_name,
    }),
  );













  my @port_list = ();
  my %spi_port_names_by_type;

  foreach my $port_name (@inner_ports)
  {
    my $port = $top_module->get_object_by_name($port_name);

    ribbit() if not $port;
    ribbit() if not ref($port) eq "e_port";




    $spi_port_names_by_type{$port->type()} = $port_name;

    next if ($port->type() eq ''          ) || 
            ($port->type() eq 'address'   ) ||
            ($port->type() eq 'chipselect') ||
            ($port->type() eq 'writedata' ) || 
            ($port->type() eq 'readdata'  )  ;

    
    push @port_list, e_port->new({
        name => $port->name(),
        width => $port->width(), 
        direction => $port->direction(),
        type => $port->type(),
      });
  }


  push (@port_list, e_port->news(
    {name      => "address",    
     type      => "address",
     width     => $SBI->{Address_Width},
     direction => "input", 
    },
    {name      => "writedata",    
     type      => "writedata",    
     width     => 32,
     direction => "input", 
    },
    {name      => "readdata",    
     type      => "readdata",    
     width     => 32,
     direction => "output", 
    },
  ));

  $module->add_contents(@port_list);


  my %type_map = ();
  map {$type_map{$_->name()} = $_->type()} @port_list;
  

  $module->add_contents(
    e_avalon_slave->new({
      name => 'epcs_control_port',
      type_map => \%type_map,
    })
  );




  if ($project->module_ptf()->{WIZARD_SCRIPT_ARGUMENTS}->{use_asmi_atom} eq "0") {
    
    $module->add_contents(
      e_port->new(["dclk", 1, "output"]),
      e_port->new(["sce", 1, "output"]),
      e_port->new(["sdo", 1, "output"]),
      e_port->new(["data0", 1, "input"]),

      e_assign->new(["dclk", "SCLK"]),
      e_assign->new(["sce", "SS_n"]),
      e_assign->new(["sdo", "MOSI"]),
      e_assign->new(["MISO", "data0"])
    );

  }
  else {




    my $tspi_name = 'tornado_' . $top_level_module_name . '_atom';
    my $tspi_module = e_module->new({
      name => $tspi_name,
      project => $project,
    });
    $tspi_module->do_black_box(1);
  



  
    $tspi_module->add_contents(
      e_port->new(['dclkin', 1, 'input',]),
      e_port->new(['scein', 1, 'input',]),
      e_port->new(['sdoin', 1, 'input',]),
      e_port->new(['oe', 1, 'input',]),
      e_port->new(['data0out', 1, 'output',]),
      e_blind_instance->new({
        tag => 'synthesis',
        name => 'the_tornado_spiblock',
        module => 'tornado_spiblock',
        in_port_map => {
          dclkin => 'dclkin',
          scein => 'scein',
          sdoin => 'sdoin',
          oe => 'oe',
        },
        out_port_map => {
          data0out => 'data0out',
        },
      }),


      e_assign->new({
        tag => 'simulation',
        lhs => 'data0out',
        rhs => 'sdoin | scein | dclkin | oe',
      }),
    );
  

    $module->add_contents(
      e_instance->new({
        module => $tspi_name,
        port_map => {
          dclkin => 'SCLK',
          scein => 'SS_n',
          sdoin => 'MOSI',





          oe => "1'b0",
          data0out => 'MISO',
        },
      }),
    );
  }


  if ((&Bits_To_Encode(get_code_size($project) - 1) - 2) > ($SBI->{Address_Width} - 1))
  {
     my $addr_bits = $SBI->{Address_Width};
     ribbit ("EPCS Boot copier program (@{[get_code_size($project)]}) too big for  address-range (($addr_bits)");
  }

  my $rom_data_width = $SBI->{Data_Width};
  my $bytes_per_word = $rom_data_width / 8;
  my $rom_address_width = &Bits_To_Encode(get_code_size($project) / $bytes_per_word - 1);
  my $rom_parameter_map = {
    init_file                 => qq("@{[get_contents_file_name($project, 'hex')]}"),
    operation_mode            => qq("ROM"),
    width_a                   => $SBI->{Data_Width},
    widthad_a                 => $rom_address_width,
    numwords_a                => get_code_size($project) / $bytes_per_word,
    lpm_type                  => qq("altsyncram"),
    byte_size                 => 8,
    outdata_reg_a             => qq("UNREGISTERED"),
    read_during_write_mode_mixed_ports => qq("DONT_CARE"),
  };


  my $rom_in_port_map  = { address_a => sprintf("address[%d : 0]", $rom_address_width - 1),
                           clock0    => 'clk'          };
  my $rom_out_port_map = { q_a       => 'rom_readdata' };

  $module->add_contents(
    e_blind_instance->new({                        
      tag           => 'synthesis',
      name          => 'the_boot_copier_rom',
      module        => 'altsyncram',
      in_port_map   => $rom_in_port_map,
      out_port_map  => $rom_out_port_map,
      parameter_map => $rom_parameter_map,
   })
  );









  if ($project->language() eq 'verilog')
  {
    $rom_parameter_map->{init_file} =
      join ("\n",'',
        '`ifdef NO_PLI',
        qq("@{[get_contents_file_name($project, 'dat')]}"),
        '`else',
        qq("@{[get_contents_file_name($project, 'hex')]}"),
        "\`endif\n");
  }
  else
  {
    $rom_parameter_map->{init_file} =
      qq("@{[get_contents_file_name($project, 'hex')]}");
  }
  $module->add_contents(
    e_blind_instance->new({                        
      tag           => 'simulation',
      name          => 'the_boot_copier_rom',
      module        => 'altsyncram',
      in_port_map   => $rom_in_port_map,
      out_port_map  => $rom_out_port_map,
      parameter_map => $rom_parameter_map,
      use_sim_models => 1,
   })
  );

  copy_and_convert_contents_file($project);




  my $address_msb = (&Bits_To_Encode(get_code_size($project) - 1) - 1) + 1;
  $address_msb -= 2;    # Word address --> byte address
  $module->add_contents (
      e_assign->new ({
         lhs => $spi_port_names_by_type {"chipselect"},
         rhs => "chipselect && (address \[ $address_msb \] )",
      }),
      e_assign->new ({
         lhs => $spi_port_names_by_type {"address"},
         rhs => "address",
      }),
      e_assign->new ({
         lhs => $spi_port_names_by_type {"writedata"},
         rhs => "writedata",
      }),
  );



  my $spi_chipselect = $spi_port_names_by_type {"chipselect"};
  my $spi_readdata   = $spi_port_names_by_type {"readdata"  };
  $module->add_contents (
      e_signal->new({name => 'rom_readdata', width => $rom_data_width,}),
      e_assign->new ({
         lhs => "readdata",
         rhs => "$spi_chipselect ? $spi_readdata : rom_readdata",
      })
  );

  $project->add_module($module);  
  $project->top($module);








  $project->system_ptf()->{"MODULE $top_level_module_name"}->
    {WIZARD_SCRIPT_ARGUMENTS}->{register_offset} =
    sprintf("0x%X", get_code_size($project));

  my @targets = ('flashfiles', 'dat', 'hex', 'programflash', 'sym');

  $project->do_makefile_target_ptf_assignments(
    'epcs_control_port',
    \@targets,


    {name => get_contents_file_name($project)},
  );


  $project->output();
}

