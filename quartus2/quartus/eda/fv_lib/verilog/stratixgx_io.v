// Copyright (C) 1991-2009 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.
////////////////////////////////////////////////////////////////////////////////
///////////////////////////////// stratixgx IO atom for FV ///////////////////////
////////////////////////////////////////////////////////////////////////////////


module stratixgx_io (
	ddiodatain,                     // ddio data in
	ddioregout,                     // ddio registered output
	delayctrlin,                    // DQS delay control 
	dqsundelayedout,                // undelayed output
	dff_ddio_data_out,              // internal ddio register output
	dff_data_out,                   // internal register output
	dff_oe,                         // internal output enable register output
	datain,                         // data in
	oe,                             // output enable
	outclk,                         // output register clock
	inclk,                          // input register clock
	outclkena,                      // output register clock enable
	inclkena,                       // input register clock enable
	areset,                         // asynchronous reset/set
	sreset,                         // synchronous reset/set
	combout,                        // combinational output
	regout,                         // registered output
	padio,                           // external pad
	devclrn,
	devpor
);

	parameter open_drain_output = "false";
	parameter bus_hold = "false";

	parameter operation_mode = "unused";

	parameter output_register_mode = "none";
	parameter tie_off_output_clock_enable = "false";
	parameter output_async_reset = "none";
	parameter output_sync_reset = "none";

	parameter oe_register_mode = "none";
	parameter tie_off_oe_clock_enable = "false";
	parameter oe_async_reset = "none";
	parameter oe_sync_reset = "none";

	parameter input_register_mode = "none";
	parameter input_async_reset = "none";
	parameter input_sync_reset = "none";

	parameter input_power_up = "low";
	parameter oe_power_up = "low";
	parameter output_power_up = "low";

	parameter lpm_type = "stratixgx_io";

	parameter ddio_mode = "none";
	parameter extend_oe_disable = "false";

	parameter sim_dll_phase_shift = "unused";
	parameter sim_dqs_input_frequency = "unused";

	input datain;
	input oe;
	input inclk;
	input inclkena;
	input outclk;
	input outclkena;
	input areset;
	input sreset;
	input devclrn, devpor;
	output combout;
	output regout;
	inout padio;
	input ddiodatain;
	output ddioregout;
	input delayctrlin;
	output dqsundelayedout;
	output dff_ddio_data_out;
	output dff_data_out;
	output dff_oe;

	wire oe_delayed,oe_actual;

	wire io_oe_ff_clken,io_in_ff_clken,io_out_ff_clken;                 // clock enables

	wire io_oe_ff_clr,io_in_ff_clr,io_out_ff_clr;                       // i/o/en aclr
	wire io_oe_ff_pre,io_in_ff_pre,io_out_ff_pre;                       // i/o/en apre
	wire io_oe_ff_sclr,io_in_ff_sclr,io_out_ff_sclr;                    // i/o/en sclr
	wire io_oe_ff_spre,io_in_ff_spre,io_out_ff_spre;                    // i/o/en spre

	wire io_in_ff_in,io_out_ff_in,io_oe_ff_in;               // i/o/en(ps) reg inputs

	wire ddio_lat_ff_in, ddio_in_ff_in, ddio_out_ff_in, ddio_oe_ff_in;         // ddio reg inputs
	wire ddio_lat_ff_out, ddio_in_ff_out, ddio_out_ff_out, ddio_oe_ff_out; // ddio reg outputs
	wire ddio_lat_ff_in_syncd, ddio_in_ff_in_syncd, ddio_out_ff_in_syncd, ddio_oe_ff_in_syncd;

	wire  ddio_data;


	wire out_data;
	wire io_in_ff_in_syncd, io_out_ff_in_syncd, io_oe_ff_in_syncd;
	wire ddio_in_ff_clk;

	wire  tristate_in,tristate_out;
	wire io_in_ff_out,io_out_ff_out,io_oe_ff_out;           // i/o/en(ps) reg outputs

	generate
	
	if( open_drain_output == "true" ) begin
		assign tristate_out = ( oe_delayed == 1'b1 ) ?
			( ( tristate_in == 1'b0 ) ? 1'b0 : 1'bz ) : 1'bz;
	end
	else begin
		assign tristate_out = (oe_delayed == 1'b1) ? tristate_in : 1'bz;
	end

	if( output_register_mode == "register" ) begin
		assign out_data = io_out_ff_out;
	end
	else begin
		assign out_data = datain;
	end

	endgenerate


	assign oe_actual  = (operation_mode == "input") ? 1'b0 : oe;

	assign io_in_ff_clr   = (input_async_reset == "clear")   ? areset : 1'b0;
	assign io_in_ff_pre   = (input_async_reset == "preset")  ? areset : 1'b0;
	assign io_out_ff_clr   = (output_async_reset == "clear")  ? areset : 1'b0;
	assign io_out_ff_pre   = (output_async_reset == "preset") ? areset : 1'b0;
	assign io_oe_ff_clr  = (oe_async_reset == "clear")      ? areset : 1'b0;
	assign io_oe_ff_pre  = (oe_async_reset == "preset")     ? areset : 1'b0;

	assign io_in_ff_sclr   = (input_sync_reset == "clear")   ? sreset : 1'b0;
	assign io_in_ff_spre   = (input_sync_reset == "preset")  ? sreset : 1'b0;
	assign io_out_ff_sclr   = (output_sync_reset == "clear")  ? sreset : 1'b0;
	assign io_out_ff_spre   = (output_sync_reset == "preset") ? sreset : 1'b0;
	assign io_oe_ff_sclr  = (oe_sync_reset == "clear")      ? sreset : 1'b0;
	assign io_oe_ff_spre  = (oe_sync_reset == "preset")     ? sreset : 1'b0;

	assign io_oe_ff_clken= (tie_off_oe_clock_enable == "false")     ? outclkena : 1'b1;
	assign io_out_ff_clken = (tie_off_output_clock_enable == "false") ? outclkena : 1'b1;
	assign io_in_ff_clken = inclkena;

	assign combout    = padio;
	assign regout     = (input_register_mode == "register") ? io_in_ff_out : 1'bz;

	assign io_in_ff_in    = padio;
	assign io_out_ff_in  = datain; 
	assign io_oe_ff_in = oe_actual;

	assign padio      = tristate_out; 

	assign dff_oe = io_oe_ff_out;
	assign dff_data_out = io_out_ff_out;

	generate

	if( input_register_mode != "none" ) begin
		assign io_in_ff_in_syncd = io_in_ff_sclr ? 1'b0 :
			( io_in_ff_spre ? 1'b1 : io_in_ff_in );

		// Input register
		dffep io_in_ff (
			.q( io_in_ff_out ),
			.ck( inclk ),
			.en( io_in_ff_clken ),
			.d( io_in_ff_in_syncd ),
			.s( io_in_ff_pre ),
			.r( io_in_ff_clr )
		);
	end
	else begin
		assign io_in_ff_out = io_in_ff_in;
	end

	if( output_register_mode != "none" ) begin
		assign io_out_ff_in_syncd = io_out_ff_sclr ? 1'b0 :
			( io_out_ff_spre ? 1'b1 : io_out_ff_in );

		// Output register
		dffep io_out_ff (
			.q( io_out_ff_out ),
			.ck( outclk ),
			.en( io_out_ff_clken ),
			.d( io_out_ff_in_syncd ),
			.s( io_out_ff_pre ),
			.r( io_out_ff_clr )
		);
	end
	else begin
		assign io_out_ff_out = io_out_ff_in;
	end

	if( oe_register_mode != "none" ) begin
		assign io_oe_ff_in_syncd = io_oe_ff_sclr ? 1'b0 :
			( io_oe_ff_spre ? 1'b1 : io_oe_ff_in );

		// output enable register
		dffep io_oe_ff (
			.q( io_oe_ff_out ),
			.ck( outclk ),
			.en( io_oe_ff_clken ),
			.d( io_oe_ff_in_syncd ),
			.s( io_oe_ff_pre ),
			.r( io_oe_ff_clr )
		);
	end
	else begin
		assign io_oe_ff_out = io_oe_ff_in;
	end

	endgenerate

	assign oe_delayed = (oe_register_mode == "register") ?
		( (extend_oe_disable == "true") ? ddio_oe_ff_out && io_oe_ff_out : io_oe_ff_out )
		: oe_actual;

	assign ddio_data = (outclk == 1'b1) ? io_out_ff_out : ddio_out_ff_out;

	assign ddioregout = ddio_lat_ff_out;
	assign ddio_oe_ff_in = io_oe_ff_out;  
	assign ddio_out_ff_in = ddiodatain;
	assign ddio_lat_ff_in   = ddio_in_ff_out;
	assign ddio_in_ff_in = padio; 
	assign dqsundelayedout = combout;
	assign dff_ddio_data_out = ddio_out_ff_out;
	assign ddio_in_ff_clk = ~inclk;

	generate

	if( ( ddio_mode == "output" ) || ( ddio_mode == "bidir" ) ) begin
		assign tristate_in = ddio_data;
	end
	else begin
		assign tristate_in = out_data;
	end

	if( ( oe_register_mode != "none" ) &&
		( extend_oe_disable == "true" ) ) begin
		assign ddio_oe_ff_in_syncd =
			io_oe_ff_sclr ? 1'b0 : ( io_oe_ff_spre ? 1'b1 : ddio_oe_ff_in );

		// output enable pulse register
		dffep ddio_oe_ff (
			.q( ddio_oe_ff_out ),
			.ck( ~outclk ),
			.en( io_oe_ff_clken ),
			.d( ddio_oe_ff_in_syncd ),
			.s( io_oe_ff_pre ),
			.r( io_oe_ff_clr )
		);
	end
	else begin
		assign ddio_oe_ff_out = ddio_oe_ff_in;
	end

	if( ( ddio_mode == "input" ) || ( ddio_mode == "bidir" ) ) begin
		assign ddio_in_ff_in_syncd = io_in_ff_sclr ? 1'b0 :
			( io_in_ff_spre ? 1'b1 : ddio_in_ff_in );

		// DDIO input register negative edge
		dffep ddio_in_ff (
			.q( ddio_in_ff_out ),
			.ck( ddio_in_ff_clk ),
			.en( io_in_ff_clken ),
			.d( ddio_in_ff_in_syncd ),
			.s( io_in_ff_pre ),
			.r( io_in_ff_clr )
		);
	end
	else begin
		assign ddio_in_ff_out = ddio_in_ff_in;
	end

	if( ( ddio_mode == "input" ) || ( ddio_mode == "bidir" ) ) begin
		assign ddio_lat_ff_in_syncd = io_in_ff_sclr ? 1'b0 :
			( io_in_ff_spre ? 1'b1 : ddio_lat_ff_in );

		// DDIO input register positive edge
		dffep ddio_lat_ff (
			.q( ddio_lat_ff_out ),
			.ck( inclk ),
			.en( io_in_ff_clken ),
			.d( ddio_lat_ff_in_syncd ),
			.s( io_in_ff_pre ),
			.r( io_in_ff_clr )
		);
	end
	else begin
		assign ddio_lat_ff_out = ddio_lat_ff_in;
	end

	if( ( ddio_mode == "output" ) || ( ddio_mode == "bidir" ) ) begin
		assign ddio_out_ff_in_syncd = io_out_ff_sclr ? 1'b0 :
			( io_out_ff_spre ? 1'b1 : ddio_out_ff_in );

		// DDIO output register
		dffep ddio_out_ff (
			.q( ddio_out_ff_out ),
			.ck( outclk ),
			.en( io_out_ff_clken ),
			.d( ddio_out_ff_in_syncd ),
			.s( io_out_ff_pre ),
			.r( io_out_ff_clr )
		);
	end
	else begin
		assign ddio_out_ff_out = ddio_out_ff_in;
	end

	endgenerate

endmodule
