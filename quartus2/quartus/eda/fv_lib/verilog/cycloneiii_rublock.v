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

module cycloneiii_rublock (
		clk,
		shiftnld,
		captnupdt,
		regin,
		rsttimer,
		rconfig,
		regout
);

parameter sim_init_config = "factory";
parameter sim_init_watchdog_value = 0;
parameter sim_init_status = 0;
parameter lpm_type = "cycloneiii_rublock";

input clk; 
input shiftnld	; 
input captnupdt;
input regin;
input rsttimer; 
input rconfig; 
output regout;

endmodule
