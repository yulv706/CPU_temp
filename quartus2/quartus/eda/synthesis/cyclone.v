////clearbox auto-generated components begin
////Dont add any component declarations after this section

//////////////////////////////////////////////////////////////////////////
// cyclone_io parameterized megafunction component declaration
// Generated with 'clearbox' loader - do not edit
//////////////////////////////////////////////////////////////////////////
module	cyclone_io	(
	areset,
	combout,
	datain,
	inclk,
	inclkena,
	oe,
	outclk,
	outclkena,
	padio,
	regout,
	sreset,
	devclrn,
	devoe,
	devpor) /* synthesis syn_black_box */;

	parameter	bus_hold = "false";
	parameter	input_async_reset = "none";
	parameter	input_power_up = "low";
	parameter	input_register_mode = "none";
	parameter	input_sync_reset = "none";
	parameter	oe_async_reset = "none";
	parameter	oe_power_up = "low";
	parameter	oe_register_mode = "none";
	parameter	oe_sync_reset = "none";
	parameter	open_drain_output = "false";
	parameter	operation_mode = "unused";
	parameter	output_async_reset = "none";
	parameter	output_power_up = "low";
	parameter	output_register_mode = "none";
	parameter	output_sync_reset = "none";
	parameter	tie_off_oe_clock_enable = "false";
	parameter	tie_off_output_clock_enable = "false";
	parameter	lpm_type = "cyclone_io";

	input	areset;
	output	combout;
	input	datain;
	input	inclk;
	input	inclkena;
	input	oe;
	input	outclk;
	input	outclkena;
	inout	padio;
	output	regout;
	input	sreset;
	input	devclrn;
	input	devoe;
	input	devpor;

endmodule //cyclone_io

//////////////////////////////////////////////////////////////////////////
// cyclone_ram_block parameterized megafunction component declaration
// Generated with 'clearbox' loader - do not edit
//////////////////////////////////////////////////////////////////////////
module	cyclone_ram_block	(
	clk0,
	clk1,
	clr0,
	clr1,
	ena0,
	ena1,
	portaaddr,
	portabyteenamasks,
	portadatain,
	portadataout,
	portawe,
	portbaddr,
	portbbyteenamasks,
	portbdatain,
	portbdataout,
	portbrewe,
	devclrn,
	devpor) /* synthesis syn_black_box */;

	parameter	connectivity_checking = "OFF";
	parameter	data_interleave_offset_in_bits = 1;
	parameter	data_interleave_width_in_bits = 1;
	parameter	init_file = "UNUSED";
	parameter	init_file_layout = "UNUSED";
	parameter	logical_ram_name = "unused";
	parameter	mem_init0 = 2048'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
	parameter	mem_init1 = 2560'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
	parameter	mixed_port_feed_through_mode = "UNUSED";
	parameter	operation_mode = "unused";
	parameter	port_a_address_clear = "UNUSED";
	parameter	port_a_address_width = 1;
	parameter	port_a_byte_enable_clear = "UNUSED";
	parameter	port_a_byte_enable_mask_width = 1;
	parameter	port_a_data_in_clear = "UNUSED";
	parameter	port_a_data_out_clear = "UNUSED";
	parameter	port_a_data_out_clock = "none";
	parameter	port_a_data_width = 1;
	parameter	port_a_first_address = 1;
	parameter	port_a_first_bit_number = 1;
	parameter	port_a_last_address = 1;
	parameter	port_a_logical_ram_depth = 0;
	parameter	port_a_logical_ram_width = 0;
	parameter	port_a_write_enable_clear = "UNUSED";
	parameter	port_b_address_clear = "UNUSED";
	parameter	port_b_address_clock = "UNUSED";
	parameter	port_b_address_width = 1;
	parameter	port_b_byte_enable_clear = "UNUSED";
	parameter	port_b_byte_enable_clock = "UNUSED";
	parameter	port_b_byte_enable_mask_width = 1;
	parameter	port_b_data_in_clear = "UNUSED";
	parameter	port_b_data_in_clock = "UNUSED";
	parameter	port_b_data_out_clear = "UNUSED";
	parameter	port_b_data_out_clock = "none";
	parameter	port_b_data_width = 1;
	parameter	port_b_first_address = 0;
	parameter	port_b_first_bit_number = 0;
	parameter	port_b_last_address = 0;
	parameter	port_b_logical_ram_depth = 0;
	parameter	port_b_logical_ram_width = 0;
	parameter	port_b_read_enable_write_enable_clear = "UNUSED";
	parameter	port_b_read_enable_write_enable_clock = "UNUSED";
	parameter	power_up_uninitialized = "false";
	parameter	ram_block_type = "unused";
	parameter	lpm_type = "cyclone_ram_block";
	parameter	lpm_hint = "unused";

	input	clk0;
	input	clk1;
	input	clr0;
	input	clr1;
	input	ena0;
	input	ena1;
	input	[port_a_address_width-1:0]	portaaddr;
	input	[port_a_byte_enable_mask_width-1:0]	portabyteenamasks;
	input	[port_a_data_width-1:0]	portadatain;
	output	[port_a_data_width-1:0]	portadataout;
	input	portawe;
	input	[port_b_address_width-1:0]	portbaddr;
	input	[port_b_byte_enable_mask_width-1:0]	portbbyteenamasks;
	input	[port_b_data_width-1:0]	portbdatain;
	output	[port_b_data_width-1:0]	portbdataout;
	input	portbrewe;
	input	devclrn;
	input	devpor;

endmodule //cyclone_ram_block

//////////////////////////////////////////////////////////////////////////
// cyclone_pll parameterized megafunction component declaration
// Generated with 'clearbox' loader - do not edit
//////////////////////////////////////////////////////////////////////////
module	cyclone_pll	(
	activeclock,
	areset,
	clk,
	clkbad,
	clkena,
	clkloss,
	clkswitch,
	comparator,
	ena,
	enable0,
	enable1,
	extclk,
	extclkena,
	fbin,
	inclk,
	locked,
	pfdena,
	scanaclr,
	scanclk,
	scandata,
	scandataout) /* synthesis syn_black_box */;

	parameter	bandwidth = 0;
	parameter	bandwidth_type = "auto";
	parameter	charge_pump_current = 0;
	parameter	clk0_counter = "g0";
	parameter	clk0_divide_by = 1;
	parameter	clk0_duty_cycle = 50;
	parameter	clk0_multiply_by = 1;
	parameter	clk0_phase_shift = "UNUSED";
	parameter	clk0_phase_shift_num = 0;
	parameter	clk0_time_delay = "UNUSED";
	parameter	clk0_use_even_counter_mode = "off";
	parameter	clk0_use_even_counter_value = "off";
	parameter	clk1_counter = "g1";
	parameter	clk1_divide_by = 1;
	parameter	clk1_duty_cycle = 50;
	parameter	clk1_multiply_by = 1;
	parameter	clk1_phase_shift = "UNUSED";
	parameter	clk1_phase_shift_num = 0;
	parameter	clk1_time_delay = "UNUSED";
	parameter	clk1_use_even_counter_mode = "off";
	parameter	clk1_use_even_counter_value = "off";
	parameter	clk2_counter = "g2";
	parameter	clk2_divide_by = 1;
	parameter	clk2_duty_cycle = 50;
	parameter	clk2_multiply_by = 1;
	parameter	clk2_phase_shift = "UNUSED";
	parameter	clk2_phase_shift_num = 0;
	parameter	clk2_time_delay = "UNUSED";
	parameter	clk2_use_even_counter_mode = "off";
	parameter	clk2_use_even_counter_value = "off";
	parameter	clk3_counter = "g3";
	parameter	clk3_divide_by = 1;
	parameter	clk3_duty_cycle = 50;
	parameter	clk3_multiply_by = 1;
	parameter	clk3_phase_shift = "UNUSED";
	parameter	clk3_time_delay = "UNUSED";
	parameter	clk3_use_even_counter_mode = "off";
	parameter	clk3_use_even_counter_value = "off";
	parameter	clk4_counter = "l0";
	parameter	clk4_divide_by = 1;
	parameter	clk4_duty_cycle = 50;
	parameter	clk4_multiply_by = 1;
	parameter	clk4_phase_shift = "UNUSED";
	parameter	clk4_time_delay = "UNUSED";
	parameter	clk4_use_even_counter_mode = "off";
	parameter	clk4_use_even_counter_value = "off";
	parameter	clk5_counter = "l1";
	parameter	clk5_divide_by = 1;
	parameter	clk5_duty_cycle = 50;
	parameter	clk5_multiply_by = 1;
	parameter	clk5_phase_shift = "UNUSED";
	parameter	clk5_time_delay = "UNUSED";
	parameter	clk5_use_even_counter_mode = "off";
	parameter	clk5_use_even_counter_value = "off";
	parameter	common_rx_tx = "off";
	parameter	compensate_clock = "clk0";
	parameter	down_spread = "UNUSED";
	parameter	e0_high = 1;
	parameter	e0_initial = 1;
	parameter	e0_low = 1;
	parameter	e0_mode = "bypass";
	parameter	e0_ph = 0;
	parameter	e0_time_delay = 0;
	parameter	e1_high = 1;
	parameter	e1_initial = 1;
	parameter	e1_low = 1;
	parameter	e1_mode = "bypass";
	parameter	e1_ph = 0;
	parameter	e1_time_delay = 0;
	parameter	e2_high = 1;
	parameter	e2_initial = 1;
	parameter	e2_low = 1;
	parameter	e2_mode = "bypass";
	parameter	e2_ph = 0;
	parameter	e2_time_delay = 0;
	parameter	e3_high = 1;
	parameter	e3_initial = 1;
	parameter	e3_low = 1;
	parameter	e3_mode = "bypass";
	parameter	e3_ph = 0;
	parameter	e3_time_delay = 0;
	parameter	enable0_counter = "l0";
	parameter	enable1_counter = "l0";
	parameter	enable_switch_over_counter = "off";
	parameter	extclk0_counter = "e0";
	parameter	extclk0_divide_by = 1;
	parameter	extclk0_duty_cycle = 50;
	parameter	extclk0_multiply_by = 1;
	parameter	extclk0_phase_shift = "UNUSED";
	parameter	extclk0_time_delay = "UNUSED";
	parameter	extclk0_use_even_counter_mode = "off";
	parameter	extclk0_use_even_counter_value = "off";
	parameter	extclk1_counter = "e1";
	parameter	extclk1_divide_by = 1;
	parameter	extclk1_duty_cycle = 50;
	parameter	extclk1_multiply_by = 1;
	parameter	extclk1_phase_shift = "UNUSED";
	parameter	extclk1_time_delay = "UNUSED";
	parameter	extclk1_use_even_counter_mode = "off";
	parameter	extclk1_use_even_counter_value = "off";
	parameter	extclk2_counter = "e2";
	parameter	extclk2_divide_by = 1;
	parameter	extclk2_duty_cycle = 50;
	parameter	extclk2_multiply_by = 1;
	parameter	extclk2_phase_shift = "UNUSED";
	parameter	extclk2_time_delay = "UNUSED";
	parameter	extclk2_use_even_counter_mode = "off";
	parameter	extclk2_use_even_counter_value = "off";
	parameter	extclk3_counter = "e3";
	parameter	extclk3_divide_by = 1;
	parameter	extclk3_duty_cycle = 50;
	parameter	extclk3_multiply_by = 1;
	parameter	extclk3_phase_shift = "UNUSED";
	parameter	extclk3_time_delay = "UNUSED";
	parameter	extclk3_use_even_counter_mode = "off";
	parameter	extclk3_use_even_counter_value = "off";
	parameter	feedback_source = "extclk0";
	parameter	g0_high = 1;
	parameter	g0_initial = 1;
	parameter	g0_low = 1;
	parameter	g0_mode = "bypass";
	parameter	g0_ph = 0;
	parameter	g0_time_delay = 0;
	parameter	g1_high = 1;
	parameter	g1_initial = 1;
	parameter	g1_low = 1;
	parameter	g1_mode = "bypass";
	parameter	g1_ph = 0;
	parameter	g1_time_delay = 0;
	parameter	g2_high = 1;
	parameter	g2_initial = 1;
	parameter	g2_low = 1;
	parameter	g2_mode = "bypass";
	parameter	g2_ph = 0;
	parameter	g2_time_delay = 0;
	parameter	g3_high = 1;
	parameter	g3_initial = 1;
	parameter	g3_low = 1;
	parameter	g3_mode = "bypass";
	parameter	g3_ph = 0;
	parameter	g3_time_delay = 0;
	parameter	gate_lock_counter = 1;
	parameter	gate_lock_signal = "no";
	parameter	inclk0_input_frequency = 0;
	parameter	inclk1_input_frequency = 0;
	parameter	invalid_lock_multiplier = 5;
	parameter	l0_high = 1;
	parameter	l0_initial = 1;
	parameter	l0_low = 1;
	parameter	l0_mode = "bypass";
	parameter	l0_ph = 0;
	parameter	l0_time_delay = 0;
	parameter	l1_high = 1;
	parameter	l1_initial = 1;
	parameter	l1_low = 1;
	parameter	l1_mode = "bypass";
	parameter	l1_ph = 0;
	parameter	l1_time_delay = 0;
	parameter	loop_filter_c = 1;
	parameter	loop_filter_r = "UNUSED";
	parameter	m = 0;
	parameter	m2 = 1;
	parameter	m_initial = 1;
	parameter	m_ph = 0;
	parameter	m_time_delay = 0;
	parameter	n = 1;
	parameter	n2 = 1;
	parameter	n_time_delay = 0;
	parameter	operation_mode = "normal";
	parameter	pfd_max = 0;
	parameter	pfd_min = 0;
	parameter	pll_compensation_delay = 0;
	parameter	pll_type = "Auto";
	parameter	primary_clock = "inclk0";
	parameter	qualify_conf_done = "OFF";
	parameter	rx_outclock_resource = "auto";
	parameter	scan_chain = "long";
	parameter	simulation_type = "timing";
	parameter	skip_vco = "off";
	parameter	source_is_pll = "off";
	parameter	spread_frequency = 0;
	parameter	ss = 0;
	parameter	switch_over_counter = 1;
	parameter	switch_over_on_gated_lock = "off";
	parameter	switch_over_on_lossclk = "off";
	parameter	use_dc_coupling = "false";
	parameter	use_vco_bypass = "false";
	parameter	valid_lock_multiplier = 5;
	parameter	vco_center = 0;
	parameter	vco_max = 0;
	parameter	vco_min = 0;
	parameter	lpm_type = "cyclone_pll";

	output	activeclock;
	input	areset;
	output	[5:0]	clk;
	output	[1:0]	clkbad;
	input	[5:0]	clkena;
	output	clkloss;
	input	clkswitch;
	input	comparator;
	input	ena;
	output	enable0;
	output	enable1;
	output	[3:0]	extclk;
	input	[3:0]	extclkena;
	input	fbin;
	input	[1:0]	inclk;
	output	locked;
	input	pfdena;
	input	scanaclr;
	input	scanclk;
	input	scandata;
	output	scandataout;

endmodule //cyclone_pll

//////////////////////////////////////////////////////////////////////////
// cyclone_lcell parameterized megafunction component declaration
// Generated with 'clearbox' loader - do not edit
//////////////////////////////////////////////////////////////////////////
module	cyclone_lcell	(
	aclr,
	aload,
	cin,
	clk,
	combout,
	cout,
	dataa,
	datab,
	datac,
	datad,
	ena,
	inverta,
	regcascin,
	regout,
	sclr,
	sload,
	cin0,
	cin1,
	cout0,
	cout1,
	devclrn,
	devpor) /* synthesis syn_black_box */;

	parameter	cin0_used = "false";
	parameter	cin1_used = "false";
	parameter	cin_used = "false";
	parameter	lut_mask = "unused";
	parameter	operation_mode = "normal";
	parameter	output_mode = "reg_and_comb";
	parameter	power_up = "low";
	parameter	register_cascade_mode = "off";
	parameter	sum_lutc_input = "datac";
	parameter	synch_mode = "off";
	parameter	x_on_violation = "on";
	parameter	lpm_type = "cyclone_lcell";

	input	aclr;
	input	aload;
	input	cin;
	input	clk;
	output	combout;
	output	cout;
	input	dataa;
	input	datab;
	input	datac;
	input	datad;
	input	ena;
	input	inverta;
	input	regcascin;
	output	regout;
	input	sclr;
	input	sload;
	input	cin0;
	input	cin1;
	output	cout0;
	output	cout1;
	input	devclrn;
	input	devpor;

endmodule //cyclone_lcell

//////////////////////////////////////////////////////////////////////////
// cyclone_asmiblock parameterized megafunction component declaration
// Generated with 'clearbox' loader - do not edit
//////////////////////////////////////////////////////////////////////////
module	cyclone_asmiblock	(
	data0out,
	dclkin,
	oe,
	scein,
	sdoin) /* synthesis syn_black_box */;

	parameter	lpm_type = "cyclone_asmiblock";

	output	data0out;
	input	dclkin;
	input	oe;
	input	scein;
	input	sdoin;

endmodule //cyclone_asmiblock

//////////////////////////////////////////////////////////////////////////
// cyclone_crcblock parameterized megafunction component declaration
// Generated with 'mega_defn_creator' loader - do not edit
//////////////////////////////////////////////////////////////////////////
module cyclone_crcblock(
	clk,
	crcerror,
	ldsrc,
	regout,
	shiftnld) /* synthesis syn_black_box=1 */;

	parameter	lpm_hint = "UNUSED";
	parameter	lpm_type = "cyclone_crcblock";
	parameter	oscillator_divider = 1;


	input	clk;
	output	crcerror;
	input	ldsrc;
	output	regout;
	input	shiftnld;

endmodule // cyclone_crcblock

//////////////////////////////////////////////////////////////////////////
// cyclone_jtag parameterized megafunction component declaration
// Generated with 'mega_defn_creator' loader - do not edit
//////////////////////////////////////////////////////////////////////////
module cyclone_jtag(
	clkdruser,
	ntrst,
	runidleuser,
	shiftuser,
	tck,
	tckutap,
	tdi,
	tdiutap,
	tdo,
	tdouser,
	tdoutap,
	tms,
	tmsutap,
	updateuser,
	usr1user) /* synthesis syn_black_box=1 */;

	parameter	lpm_hint = "UNUSED";
	parameter	lpm_type = "cyclone_jtag";


	output	clkdruser;
	input	ntrst;
	output	runidleuser;
	output	shiftuser;
	input	tck;
	output	tckutap;
	input	tdi;
	output	tdiutap;
	output	tdo;
	input	tdouser;
	input	tdoutap;
	input	tms;
	output	tmsutap;
	output	updateuser;
	output	usr1user;

endmodule // cyclone_jtag

////clearbox auto-generated components end
