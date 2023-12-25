/*
Your use of Altera Corporation's design tools, logic functions 
and other software and tools, and its AMPP partner logic 
functions, and any output files from any of the foregoing 
(including device programming or simulation files), and any 
associated documentation or information are expressly subject 
to the terms and conditions of the Altera Program License 
Subscription Agreement, Altera MegaCore Function License 
Agreement, or other applicable license agreement, including, 
without limitation, that your use is for the sole purpose of 
programming logic devices manufactured by Altera and sold by 
Altera or its authorized distributors.  Please refer to the 
applicable agreement for further details.
*/

MODEL
MODEL_VERSION "1.0";
DESIGN "arriagx_lvds_receiver";

INPUT clk0, datain, enable0, dpareset, dpahold, dpaswitch;
INPUT  fiforeset, bitslip, bitslipreset, serialfbk;
OUTPUT dataout[9:0];
OUTPUT dpalock, bitslipmax, serialdataout, postdpaserialdataout;

/* clock to out timing arcs */
t_enable0_dataout: DELAY (POSEDGE) enable0 dataout;

t_clk0_bitslipmax: DELAY (POSEDGE) clk0 bitslipmax;


ENDMODEL
