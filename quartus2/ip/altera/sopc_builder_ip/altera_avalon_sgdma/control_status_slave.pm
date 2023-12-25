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

























use strict;
use europa_all;


sub make_chain_control_status_slave {
	my $mod = shift;
  my $WSA = shift;
  

  my $CONTROL_SLAVE_ADDRESS_WIDTH = $WSA->{"control_slave_address_width"};
  my $CONTROL_SLAVE_DATA_WIDTH = $WSA->{"control_slave_data_width"};
	my $HAS_READ_BLOCK = $WSA->{"has_read_block"};
  my $HAS_WRITE_BLOCK = $WSA->{"has_write_block"};
  
  my $read_slave_name = "csr";
  my $prefix = "csr";
  my $IS_STREAM_TO_MEM_MODE = !$HAS_READ_BLOCK && $HAS_WRITE_BLOCK;
  
  &add_chain_control_slave_ports($mod, $CONTROL_SLAVE_DATA_WIDTH, $HAS_READ_BLOCK, $HAS_WRITE_BLOCK);
  &make_chain_control_avalon_slave($mod, $CONTROL_SLAVE_DATA_WIDTH, $CONTROL_SLAVE_ADDRESS_WIDTH, $read_slave_name, $prefix);
  &make_chain_control_status_slave_assignments($mod, $CONTROL_SLAVE_DATA_WIDTH, $CONTROL_SLAVE_ADDRESS_WIDTH);
  &make_chain_control_status_slave_registers($mod, $CONTROL_SLAVE_DATA_WIDTH, $CONTROL_SLAVE_ADDRESS_WIDTH, $IS_STREAM_TO_MEM_MODE, $HAS_READ_BLOCK, $HAS_WRITE_BLOCK);
  
  &make_descriptor_counter($mod);
  &create_interrupt_logic($mod);
  return $mod;
}

sub add_chain_control_slave_ports {
  my $mod = shift;
  my $CONTROL_SLAVE_DATA_WIDTH = shift;
  my $HAS_READ_BLOCK = shift;
  my $HAS_WRITE_BLOCK = shift;
  
  my @ports = (
    [clk=>1=>"input"],
    [reset_n=>1=>"input"],
    [csr_irq=>1=>"output"],
  );
  push (@ports, &get_other_control_slave_ports($CONTROL_SLAVE_DATA_WIDTH, $HAS_READ_BLOCK, $HAS_WRITE_BLOCK));
  push (@ports, &get_fifo_ports());
  $mod->add_contents(
    e_port->news(@ports),
  );
}

sub get_other_control_slave_ports {
  my $CONTROL_SLAVE_DATA_WIDTH = shift;
  my $HAS_READ_BLOCK = shift;
  my $HAS_WRITE_BLOCK = shift;
  my $IS_STREAM_TO_MEM_MODE = !$HAS_READ_BLOCK && $HAS_WRITE_BLOCK;
  
  my @ports = (
    [owned_by_hw=>1=>"input"],
    
    [descriptor_pointer_upper_reg_out=>$CONTROL_SLAVE_DATA_WIDTH=>"output"],
    [descriptor_pointer_lower_reg_out=>$CONTROL_SLAVE_DATA_WIDTH=>"output"],
  

    [sw_reset=>1=>"output"],
    [run=>1=>"output"],
    [park=>1=>"output"],
    

    [descriptor_write_write=>1=>"input"],



    [chain_run=>1=>"input"],
  );
  
  if ($IS_STREAM_TO_MEM_MODE) {
  	push (@ports, [t_eop=>1=>"input"]);
  }
  if ($HAS_WRITE_BLOCK) {
  	push (@ports, [write_go=>1=>"input"]);
  } 
  if ($HAS_READ_BLOCK) {
  	push (@ports, [read_go=>1=>"input"]);
  }
  
  return @ports;
}

sub get_fifo_ports {
  my @ports = (
    [command_fifo_empty=>1=>"input"],
    [desc_address_fifo_empty=>1=>"input"],
    [status_token_fifo_empty=>1=>"input"],
    [status_token_fifo_rdreq=>1=>"input"],
    
  );
  return @ports;
}








sub make_chain_control_status_slave_assignments {
  my $mod = shift;
  my $CONTROL_SLAVE_DATA_WIDTH = shift;
  my $CONTROL_SLAVE_ADDRESS_WIDTH = shift;
  my $PREPEND_WIDTH = $CONTROL_SLAVE_ADDRESS_WIDTH-4;
  
  my $READ_DATA = "(csr_address == $CONTROL_SLAVE_ADDRESS_WIDTH\'b0) ? status_reg : ";
  $READ_DATA .= "(csr_address == {$PREPEND_WIDTH\'b0, 4\'b0100}) ? control_reg : ";
  $READ_DATA .= "(csr_address == {$PREPEND_WIDTH\'b0, 4\'b1100}) ? descriptor_pointer_upper_reg : ";
  $READ_DATA .= "(csr_address == {$PREPEND_WIDTH\'b0, 4\'b1000}) ? descriptor_pointer_lower_reg : $CONTROL_SLAVE_DATA_WIDTH\'b0";
  
  $mod->add_contents(
    e_register->new({out=>"csr_readdata", in=>"$READ_DATA", enable=>"csr_read"}),
    

    e_comment->new({comment=>"register outs"}),
    e_assign->new({lhs=>"descriptor_pointer_upper_reg_out", rhs=>"descriptor_pointer_upper_reg"}),
    e_assign->new({lhs=>"descriptor_pointer_lower_reg_out", rhs=>"descriptor_pointer_lower_reg"}),
    

    e_comment->new({comment=>"control register bits"}),
    e_assign->new({lhs=>"ie_error", rhs=>"control_reg[0]"}),
    e_assign->new({lhs=>"ie_eop_encountered", rhs=>"control_reg[1]"}),
    e_assign->new({lhs=>"ie_descriptor_completed", rhs=>"control_reg[2]"}),
    e_assign->new({lhs=>"ie_chain_completed", rhs=>"control_reg[3]"}),
    e_assign->new({lhs=>"ie_global", rhs=>"control_reg[4]"}),

    e_assign->new({lhs=>"run", rhs=>"control_reg[5] && !(stop_dma_error && error) && !chain_completed"}),
    e_register->new({out=>"delayed_run", in=>"run", enable=>"1"}),
    e_assign->new({lhs=>"stop_dma_error", rhs=>"control_reg[6]"}),
    e_assign->new({lhs=>"ie_max_desc_processed", rhs=>"control_reg[7]"}),
    e_assign->new({lhs=>"max_desc_processed", rhs=>"control_reg[15:8]"}),
    e_signal->new({name=>"max_desc_processed", width=>8}),
    e_assign->new({lhs=>"sw_reset", rhs=>"control_reg[16]"}),
    

    e_assign->new({lhs=>"park", rhs=>"control_reg[17]"}),
    

    e_register->new({out=>"clear_interrupt", in=>"control_reg_en ? csr_writedata[31] : 0", enable=>"1"}),

  );
}

sub make_chain_control_status_slave_registers {
  my $mod = shift;
  my $CONTROL_SLAVE_DATA_WIDTH = shift;
  my $CONTROL_SLAVE_ADDRESS_WIDTH = shift;
  my $IS_STREAM_TO_MEM_MODE = shift;
  my $HAS_READ_BLOCK = shift;
  my $HAS_WRITE_BLOCK = shift;

  my $PREPEND_WIDTH = $CONTROL_SLAVE_ADDRESS_WIDTH-4;


  my $busy_indicator = "~command_fifo_empty || ~status_token_fifo_empty || ~desc_address_fifo_empty || chain_run || descriptor_write_write || delayed_csr_write || owned_by_hw";
  if ($HAS_WRITE_BLOCK) {
    $busy_indicator .= " || write_go";
  } 
  if ($HAS_READ_BLOCK) {
    $busy_indicator .= " || read_go";
  }
  
  $mod->add_contents(

    e_comment->new({comment=>"control register"}),
    e_assign->new({lhs=>"control_reg_en", 
      rhs=>"(csr_address == {$PREPEND_WIDTH\'b0, 4\'b0100}) && csr_write && csr_chipselect"}),
    e_signal->new({name=>"control_reg", width=>"$CONTROL_SLAVE_DATA_WIDTH"}),


    e_register->new({out=>"control_reg", in=>"{1'b0, csr_writedata[30:0]}", enable=>"control_reg_en"}),
    

    e_comment->new({comment=>"descriptor_pointer_upper_reg"}),
    e_assign->new({lhs=>"descriptor_pointer_upper_reg_en", 
      rhs=>"(csr_address == {$PREPEND_WIDTH\'b0, 4\'b1100}) && csr_write && csr_chipselect"}),
    e_signal->new({name=>"descriptor_pointer_upper_reg", width=>"$CONTROL_SLAVE_DATA_WIDTH"}),
    e_register->new({out=>"descriptor_pointer_upper_reg", in=>"csr_writedata", enable=>"descriptor_pointer_upper_reg_en"}),
    

    e_comment->new({comment=>"descriptor_pointer_lower_reg"}),
    e_assign->new({lhs=>"descriptor_pointer_lower_reg_en", 
      rhs=>"(csr_address == {$PREPEND_WIDTH\'b0, 4\'b1000}) && csr_write && csr_chipselect"}),
    e_signal->new({name=>"descriptor_pointer_lower_reg", width=>"$CONTROL_SLAVE_DATA_WIDTH"}),
    e_register->new({out=>"descriptor_pointer_lower_reg", in=>"csr_writedata", enable=>"descriptor_pointer_lower_reg_en"}),
    


    e_comment->new({comment=>"status register"}),
    e_signal->new({name=>"status_reg", width=>"$CONTROL_SLAVE_DATA_WIDTH"}),
    

		e_assign->new({lhs=>"status_reg", rhs=>"{27'b0, busy, chain_completed, descriptor_completed, eop_encountered, error}"}),
	

		e_register->new({out=>"busy", in=>"$busy_indicator", 
			enable=>"1"}),
		e_register->new({out=>"chain_completed", in=>"clear_chain_completed ? 1'b0 : ~delayed_csr_write", 
			enable=>"(run && ~owned_by_hw && ~busy) || clear_chain_completed"}),
                e_register->new({out=>"delayed_csr_write", in=>"csr_write", enable=>"1"}),
		e_register->new({out=>"descriptor_completed", in=>"~clear_descriptor_completed", 
			enable=>"delayed_descriptor_write_write || clear_descriptor_completed"}),
		e_register->new({out=>"error", in=>"~clear_error", enable=>"atlantic_error || clear_error"}),
		

		e_assign->new({lhs=>"csr_status", rhs=>"csr_write && csr_chipselect && (csr_address == $CONTROL_SLAVE_ADDRESS_WIDTH\'b0)"}),
		e_assign->new({lhs=>"clear_chain_completed", rhs=>"csr_writedata[3] && csr_status"}),
		e_assign->new({lhs=>"clear_descriptor_completed", rhs=>"csr_writedata[2] && csr_status"}),
		e_assign->new({lhs=>"clear_error", rhs=>"csr_writedata[0] && csr_status"}),
	    

    e_register->new({out=>"delayed_eop_encountered", in=>"eop_encountered", enable=>"1"}),
    e_assign->new({lhs=>"eop_encountered_rise", rhs=>"~delayed_eop_encountered && eop_encountered"}),


    e_register->new({out=>"delayed_descriptor_write_write", in=>"descriptor_write_write", enable=>"1"}),
    e_assign->new({lhs=>"descriptor_write_write_rise", rhs=>"~delayed_descriptor_write_write && descriptor_write_write"}),
  );
  
  if ($IS_STREAM_TO_MEM_MODE) {
  	$mod->add_contents(

    	e_comment->new({comment=>"eop_encountered register"}),
    	e_assign->new({lhs=>"clear_eop_encountered", rhs=>"csr_writedata[1] && csr_status"}),
		  e_register->new({out=>"eop_encountered", in=>"~clear_eop_encountered", enable=>"t_eop || clear_eop_encountered"}),
    );
  } else {
  	$mod->add_contents(
    	e_assign->new({lhs=>"eop_encountered", rhs=>"1'b0"}),
    );
  }
  
  $mod->add_contents(

    e_register->new({out=>"delayed_chain_completed", in=>"chain_completed", enable=>"1"}),
    e_assign->new({lhs=>"chain_completed_rise", rhs=>"~delayed_chain_completed && chain_completed"}),

  );

}

sub make_descriptor_counter {
	my $mod = shift;
	
	$mod->add_contents(


		e_signal->new({name=>"descriptor_counter", width=>8}),
		e_register->new({out=>"descriptor_counter", in=>"descriptor_counter + 1'b1", enable=>"status_token_fifo_rdreq"}),
                e_register->new({out=>"delayed_descriptor_counter", in=>"descriptor_counter", enable=>"1"}),
	);
}


sub create_interrupt_logic {
	my $mod = shift;
	
	my $interrupt_condition = "delayed_run && ie_global && ";
	$interrupt_condition .= "((ie_error && error) || (ie_eop_encountered && eop_encountered_rise) || (ie_descriptor_completed && descriptor_write_write_rise) || ";
	$interrupt_condition .= "(ie_chain_completed && chain_completed_rise) || (ie_max_desc_processed && (descriptor_counter == max_desc_processed) && (delayed_descriptor_counter == max_desc_processed - 1) ))";
	
	$mod->add_contents(
		e_register->new({out=>"csr_irq", in=>"csr_irq ? ~clear_interrupt : ($interrupt_condition)", enable=>"1"}),
	);
}
  
sub make_chain_control_avalon_slave {
  my $mod = shift;
  my $CONTROL_SLAVE_DATA_WIDTH = shift;
  my $CONTROL_SLAVE_ADDRESS_WIDTH = shift;
  my $read_slave_name = shift;
  my $prefix = shift;
  
  $mod->add_contents(
    e_avalon_slave->new({
      name => $read_slave_name,
      type_map => {get_read_slave_type_map($prefix)},
    }),
    &get_control_slave_ports($prefix, $CONTROL_SLAVE_DATA_WIDTH, $CONTROL_SLAVE_ADDRESS_WIDTH),
  );
}

sub get_read_slave_type_map {
  my $prefix = shift;
  my @port_types = &get_read_slave_type_list();
  my @port_map = map {($prefix . "_$_" => $_)} @port_types;

  push (@port_map, ("system_reset_n" => "reset_n"));
  return @port_map;
}

sub get_read_slave_type_list {
  return qw(
    address
    readdata
    read
    writedata
    write
    chipselect
    irq

  );
}

sub get_control_slave_ports {
  my $prefix = shift;
  my $CONTROL_SLAVE_DATA_WIDTH = shift;
  my $CONTROL_SLAVE_ADDRESS_WIDTH = shift;
  my @ports;
  
  push @ports, (
    e_port->new({
      name => $prefix . "_address",
      direction => "input",
      width => $CONTROL_SLAVE_ADDRESS_WIDTH,
      type => 'address',
    }),

    e_port->new({
      name => $prefix . "_readdata",
      direction => "output",
      width => $CONTROL_SLAVE_DATA_WIDTH,
      type => 'readdata',
    }),

    e_port->new({
      name => $prefix . "_read",
      direction => "input",
      type => 'read',
    }),

    e_port->new({
      name => $prefix . "_writedata",
      direction => "input",
      width => $CONTROL_SLAVE_DATA_WIDTH,
      type => 'writedata',
    }),

    e_port->new({
      name => $prefix . "_write",
      direction => "input",
      type => 'write',
    }),

    e_port->new({
      name => $prefix . "_chipselect",
      direction => "input",
     type => 'chipselect',
    }),
    
  );
    
  return @ports;
}


1;


