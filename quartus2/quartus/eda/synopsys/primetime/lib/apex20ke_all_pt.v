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

module  apex20ke_lcell (clk, dataa, datab, datac, datad, aclr,
                      sclr, sload, ena, cin,
                      cascin, modesel, pathsel,
                      combout, regout, cout, cascout) ;

input  clk, dataa, datab, datac, datad, ena ;
input  aclr, sclr, sload, cin, cascin;
input [8:0] modesel;
input [9:0] pathsel;
output cout, cascout, regout, combout ;
wire dffin, qfbk;

apex20ke_asynch_lcell lecomb (.dataa(dataa), .datab(datab), .datac(datac), 
										.datad(datad), .cin(cin), .cascin(cascin),
                              .qfbkin(qfbk), .modesel(modesel), .pathsel(pathsel), .combout(combout),
										 .regin(dffin), .cout(cout), .cascout(cascout));

apex20ke_lcell_register lereg (.clk(clk), .aclr(aclr), .sclr(sclr), .modesel(modesel),
										.sload(sload), .ena(ena), .datain(dffin), 
										.datac(datac), 
										.regout(regout), .qfbko(qfbk));

endmodule


module  apex20ke_io (clk, datain, aclr, preset, ena, oe, 
                   modesel, padio, combout, regout) ;

  inout     padio ;
  input     datain, clk, aclr, preset, ena, oe;
  input     [11:0] modesel;
  output    regout, combout;

  wire aclr_inv, preset_inv;


apex20ke_asynch_io asynch_inst (.datain(datain), .oe(oe), .padio(padio), .dffeD(dffeD), .dffeQ(dffeQ), .combout(combout), .regout(regout), .modesel(modesel));

INV inv_1(.Y(aclr_inv), .IN1(aclr));
INV inv_2(.Y(preset_inv), .IN1(preset));

dffe io_reg (.Q(dffeQ), .CLK(clk), .ENA(ena), .D(dffeD), .CLRN(aclr_inv), .PRN(preset_inv));

endmodule

module apex20ke_ram_slice (datain, clk0, clk1, clr0, clr1, ena0, ena1, 
            we, re, raddr, waddr,  modesel, dataout);
input  datain, clk0, clk1, clr0, clr1, ena0, ena1, we, re;
input  [15:0] raddr, waddr;
input [17:0] modesel;
output dataout;

     wire  datain_reg, we_reg, re_reg, dataout_reg;
     wire  [15:0] raddr_reg, waddr_reg;
     wire  datain_int, we_int, re_int, dataout_int;
     wire  [15:0] raddr_int;
     wire  [15:0] waddr_int;
     wire  reen, raddren, dataouten;
     wire  datain_clr;
     wire  re_clk, re_clr, raddr_clk, raddr_clr;
     wire  dataout_clk, dataout_clr;
     wire  datain_reg_sel, write_reg_sel, raddr_reg_sel;
     wire  re_reg_sel, dataout_reg_sel, re_clk_sel, re_en_sel;
     wire  re_clr_sel, raddr_clk_sel, raddr_clr_sel, raddr_en_sel;
     wire  dataout_clk_sel, dataout_clr_sel, dataout_en_sel;
     wire  datain_reg_clr, write_reg_clr, raddr_reg_clr;
     wire  re_reg_clr, dataout_reg_clr;
     wire  datain_reg_clr_sel, write_reg_clr_sel, raddr_reg_clr_sel;
     wire  re_reg_clr_sel, dataout_reg_clr_sel, NC;
     wire  clk0_inv1, clk0_delayed, we_reg2, we_reg2_delayed;
	 wire iena0;
	 wire iena1;

     assign datain_reg_sel          = modesel[0];
     assign datain_reg_clr_sel      = modesel[1];
     assign write_reg_sel           = modesel[2];
     assign write_reg_clr_sel       = modesel[3];
     assign raddr_reg_sel           = modesel[4];
     assign raddr_reg_clr_sel       = modesel[5];
     assign re_reg_sel              = modesel[6];
     assign re_reg_clr_sel          = modesel[7];
     assign dataout_reg_sel         = modesel[8];
     assign dataout_reg_clr_sel     = modesel[9];
     assign re_clk_sel              = modesel[10];
     assign re_en_sel               = modesel[10];
     assign re_clr_sel              = modesel[11];
     assign raddr_clk_sel           = modesel[12];
     assign raddr_en_sel            = modesel[12];
     assign raddr_clr_sel           = modesel[13];
     assign dataout_clk_sel         = modesel[14];
     assign dataout_en_sel          = modesel[14];
     assign dataout_clr_sel         = modesel[15];

	 assign iena0 = ena0;
	 assign iena1 = ena1;

     assign NC = 1'b0;

mux21 	datainsel (.MO(datain_int), .A(datain), .B(datain_reg), .S(datain_reg_sel));

nmux21 	datainregclr (.MO(datain_reg_clr), .A(NC), .B(clr0), .S(datain_reg_clr_sel));

bmux21 	waddrsel (.MO(waddr_int), .A(waddr), .B(waddr_reg), .S(write_reg_sel));

nmux21 	writeregclr (.MO(write_reg_clr), .A(NC), .B(clr0), .S(write_reg_clr_sel));

mux21   wesel2 (.MO(we_int), .A(we_reg2_delayed), .B(we_pulse), .S(write_reg_sel));

mux21   wesel1 (.MO(we_reg2), .A(we), .B(we_reg), .S(write_reg_sel));

bmux21  raddrsel (.MO(raddr_int), .A(raddr), .B(raddr_reg), .S(raddr_reg_sel));

nmux21 	raddrregclr (.MO(raddr_reg_clr), .A(NC), .B(raddr_clr), .S(raddr_reg_clr_sel));

mux21 	resel (.MO(re_int), .A(re), .B(re_reg), .S(re_reg_sel));

mux21 	dataoutsel (.MO(dataout), .A(dataout_int), .B(dataout_reg), .S(dataout_reg_sel));

nmux21	dataoutregclr (.MO(dataout_reg_clr), .A(NC), .B(dataout_clr), .S(dataout_reg_clr_sel));

mux21   raddrclksel (.MO(raddr_clk), .A(clk0), .B(clk1), .S(raddr_clk_sel));

mux21   raddrensel (.MO(raddren), .A(iena0), .B(iena1), .S(raddr_en_sel));

nmux21  raddrclrsel (.MO(raddr_clr), .A(clr0), .B(clr1), .S(raddr_clr_sel));

mux21 	reclksel (.MO(re_clk), .A(clk0), .B(clk1), .S(re_clk_sel));

mux21   reensel (.MO(reen), .A(iena0), .B(iena1), .S(re_en_sel));

nmux21	reclrsel (.MO(re_clr), .A(clr0), .B(clr1), .S(re_clr_sel));

nmux21   reregclr (.MO(re_reg_clr), .A(NC), .B(re_clr), .S(re_reg_clr_sel));

mux21   dataoutclksel (.MO(dataout_clk), .A(clk0), .B(clk1), .S(dataout_clk_sel));

mux21   dataoutensel (.MO(dataouten), .A(iena0), .B(iena1), .S(dataout_en_sel));

nmux21  dataoutclrsel (.MO(dataout_clr), .A(clr0), .B(clr1), .S(dataout_clr_sel));

dffe	dinreg (.Q(datain_reg), .CLK(clk0), .ENA(iena0), .D(datain), .CLRN(datain_reg_clr), .PRN(1'b1));

dffe	wereg (.Q(we_reg), .CLK(clk0), .ENA(iena0), .D(we), .CLRN(write_reg_clr), .PRN(1'b1));

INV    pt_inv_1 (.Y(clk0_inv1), .IN1(clk0_delayed));

AND1    clk0weregdelaybuf (.Y(clk0_delayed), .IN1(clk0));

AND2    pt_and2_1 (.Y(we_pulse), .IN1(clk0_inv1), .IN2(we_reg2_delayed));

AND1    wedelaybuf (.Y(we_reg2_delayed), .IN1(we_reg2));

dffe    rereg (.Q(re_reg), .CLK(re_clk), .ENA(reen), .D(re), .CLRN(re_reg_clr), .PRN(1'b1));

dffe    dataoutreg (.Q(dataout_reg), .CLK(dataout_clk), .ENA(dataouten), .D(dataout_int), .CLRN(dataout_reg_clr), .PRN(1'b1));

dffe    waddrreg_0 (.Q(waddr_reg[0]), .CLK(clk0), .ENA(iena0), .D(waddr[0]), .CLRN(write_reg_clr), .PRN(1'b1));

dffe    waddrreg_1 (.Q(waddr_reg[1]), .CLK(clk0), .ENA(iena0), .D(waddr[1]), .CLRN(write_reg_clr), .PRN(1'b1));

dffe    waddrreg_2 (.Q(waddr_reg[2]), .CLK(clk0), .ENA(iena0), .D(waddr[2]), .CLRN(write_reg_clr), .PRN(1'b1));

dffe    waddrreg_3 (.Q(waddr_reg[3]), .CLK(clk0), .ENA(iena0), .D(waddr[3]), .CLRN(write_reg_clr), .PRN(1'b1));

dffe    waddrreg_4 (.Q(waddr_reg[4]), .CLK(clk0), .ENA(iena0), .D(waddr[4]), .CLRN(write_reg_clr), .PRN(1'b1));

dffe    waddrreg_5 (.Q(waddr_reg[5]), .CLK(clk0), .ENA(iena0), .D(waddr[5]), .CLRN(write_reg_clr), .PRN(1'b1));

dffe    waddrreg_6 (.Q(waddr_reg[6]), .CLK(clk0), .ENA(iena0), .D(waddr[6]), .CLRN(write_reg_clr), .PRN(1'b1));

dffe    waddrreg_7 (.Q(waddr_reg[7]), .CLK(clk0), .ENA(iena0), .D(waddr[7]), .CLRN(write_reg_clr), .PRN(1'b1));

dffe    waddrreg_8 (.Q(waddr_reg[8]), .CLK(clk0), .ENA(iena0), .D(waddr[8]), .CLRN(write_reg_clr), .PRN(1'b1));

dffe    waddrreg_9 (.Q(waddr_reg[9]), .CLK(clk0), .ENA(iena0), .D(waddr[9]), .CLRN(write_reg_clr), .PRN(1'b1));

dffe    waddrreg_10 (.Q(waddr_reg[10]), .CLK(clk0), .ENA(iena0), .D(waddr[10]), .CLRN(write_reg_clr), .PRN(1'b1));

dffe    waddrreg_11 (.Q(waddr_reg[11]), .CLK(clk0), .ENA(iena0), .D(waddr[11]), .CLRN(write_reg_clr), .PRN(1'b1));

dffe    waddrreg_12 (.Q(waddr_reg[12]), .CLK(clk0), .ENA(iena0), .D(waddr[12]), .CLRN(write_reg_clr), .PRN(1'b1));

dffe    waddrreg_13 (.Q(waddr_reg[13]), .CLK(clk0), .ENA(iena0), .D(waddr[13]), .CLRN(write_reg_clr), .PRN(1'b1));

dffe    waddrreg_14 (.Q(waddr_reg[14]), .CLK(clk0), .ENA(iena0), .D(waddr[14]), .CLRN(write_reg_clr), .PRN(1'b1));

dffe    waddrreg_15 (.Q(waddr_reg[15]), .CLK(clk0), .ENA(iena0), .D(waddr[15]), .CLRN(write_reg_clr), .PRN(1'b1));

dffe    raddrreg_0 (.Q(raddr_reg[0]), .CLK(raddr_clk), .ENA(raddren), .D(raddr[0]), .CLRN(raddr_reg_clr), .PRN(1'b1));

dffe    raddrreg_1 (.Q(raddr_reg[1]), .CLK(raddr_clk), .ENA(raddren), .D(raddr[1]), .CLRN(raddr_reg_clr), .PRN(1'b1));

dffe    raddrreg_2 (.Q(raddr_reg[2]), .CLK(raddr_clk), .ENA(raddren), .D(raddr[2]), .CLRN(raddr_reg_clr), .PRN(1'b1));

dffe    raddrreg_3 (.Q(raddr_reg[3]), .CLK(raddr_clk), .ENA(raddren), .D(raddr[3]), .CLRN(raddr_reg_clr), .PRN(1'b1));

dffe    raddrreg_4 (.Q(raddr_reg[4]), .CLK(raddr_clk), .ENA(raddren), .D(raddr[4]), .CLRN(raddr_reg_clr), .PRN(1'b1));

dffe    raddrreg_5 (.Q(raddr_reg[5]), .CLK(raddr_clk), .ENA(raddren), .D(raddr[5]), .CLRN(raddr_reg_clr), .PRN(1'b1));

dffe    raddrreg_6 (.Q(raddr_reg[6]), .CLK(raddr_clk), .ENA(raddren), .D(raddr[6]), .CLRN(raddr_reg_clr), .PRN(1'b1));

dffe    raddrreg_7 (.Q(raddr_reg[7]), .CLK(raddr_clk), .ENA(raddren), .D(raddr[7]), .CLRN(raddr_reg_clr), .PRN(1'b1));

dffe    raddrreg_8 (.Q(raddr_reg[8]), .CLK(raddr_clk), .ENA(raddren), .D(raddr[8]), .CLRN(raddr_reg_clr), .PRN(1'b1));

dffe    raddrreg_9 (.Q(raddr_reg[9]), .CLK(raddr_clk), .ENA(raddren), .D(raddr[9]), .CLRN(raddr_reg_clr), .PRN(1'b1));

dffe    raddrreg_10 (.Q(raddr_reg[10]), .CLK(raddr_clk), .ENA(raddren), .D(raddr[10]), .CLRN(raddr_reg_clr), .PRN(1'b1));

dffe    raddrreg_11 (.Q(raddr_reg[11]), .CLK(raddr_clk), .ENA(raddren), .D(raddr[11]), .CLRN(raddr_reg_clr), .PRN(1'b1));

dffe    raddrreg_12 (.Q(raddr_reg[12]), .CLK(raddr_clk), .ENA(raddren), .D(raddr[12]), .CLRN(raddr_reg_clr), .PRN(1'b1));

dffe    raddrreg_13 (.Q(raddr_reg[13]), .CLK(raddr_clk), .ENA(raddren), .D(raddr[13]), .CLRN(raddr_reg_clr), .PRN(1'b1));

dffe    raddrreg_14 (.Q(raddr_reg[14]), .CLK(raddr_clk), .ENA(raddren), .D(raddr[14]), .CLRN(raddr_reg_clr), .PRN(1'b1));

dffe    raddrreg_15 (.Q(raddr_reg[15]), .CLK(raddr_clk), .ENA(raddren), .D(raddr[15]), .CLRN(raddr_reg_clr), .PRN(1'b1));


apex20ke_asynch_mem apexmem (.datain(datain_int), .we(we_int), .re(re_int), .dataout(dataout_int), .modesel({modesel[17], modesel[16]}), .raddr(raddr_int), .waddr(waddr_int)
                            );

endmodule


module apex20ke_cam_slice (lit, clk0, clk1, clr0, clr1, ena0, ena1,
        outputselect, we, wrinvert, datain, waddr, matchout, matchfound,
        modesel);
input  clk0, clk1, clr0, clr1, ena0, ena1, we, datain, wrinvert;
input outputselect;
input  [4:0] waddr;
input  [31:0] lit;
input [9:0] modesel;
output [15:0] matchout;
output matchfound;

     wire iena0;
     wire iena1;

     wire wdatain_reg, we_reg;
     wire [4:0] waddr_reg;
     wire [15:0] matchout_reg, matchout_int;
     wire matchfound_reg, matchfound_int, matchfound_tmp;

     wire we_clr_sel, waddr_clr_sel, write_logic_clr_sel;
     wire write_logic_sel;
     wire output_reg_sel, output_clk_sel;
     wire output_clr_sel, output_reg_clr_sel;
     wire we_pulse, clk0_delayed, clk0_delayed_inv;

     assign iena0 = ena0;
     assign iena1 = ena1;

     assign waddr_clr_sel = modesel[0];
     assign write_logic_sel = modesel[1];
     assign write_logic_clr_sel = modesel[2];
     assign we_clr_sel = modesel[3];
     assign output_reg_sel = modesel[4];
     assign output_clk_sel = modesel[5];
     assign output_clr_sel = modesel[6];
     assign output_reg_clr_sel = modesel[7];

mux21   outputclksel (
	.MO (output_clk),
	.A (clk0),
	.B (clk1),
	.S (output_clk_sel));

mux21   outputclkensel (.MO(output_clk_en), .A(iena0), .B(iena1), .S(output_clk_sel));
mux21   outputregclrsel (.MO(output_reg_clr), .A(clr0), .B(clr1), .S(output_reg_clr_sel));
nmux21  outputclrsel (
	.MO (output_clr),
	.A (1'b0),
	.B (output_reg_clr),
	.S (output_clr_sel));

bmux21  matchoutsel (
	.MO (matchout),
	.A (matchout_int),
	.B (matchout_reg),
	.S (output_reg_sel));

mux21   matchfoundsel (.MO(matchfound), .A(matchfound_int), .B(matchfound_reg), .S(output_reg_sel));

mux21   wdatainsel (.MO(wdatain_int), .A(datain), .B(wdatain_reg), .S(write_logic_sel));
mux21   wrinvsel (.MO(wrinv_int), .A(wrinvert), .B(wrinv_reg), .S(write_logic_sel));

nmux21  weclrsel (.MO(we_clr), .A(clr0), .B(1'b0), .S(we_clr_sel));
nmux21  waddrclrsel (.MO(waddr_clr), .A(clr0), .B(1'b0), .S(waddr_clr_sel));
nmux21  writelogicclrsel (.MO(write_logic_clr), .A(clr0), .B(1'b0), .S(write_logic_clr_sel));

dffe    wereg (.Q(we_reg), .CLK(clk0), .ENA(iena0), .D(we), .CLRN(we_clr), .PRN(1'b1));

AND1    clk0weregdelaybuf (.Y(clk0_delayed), .IN1(clk0));

INV    pt_inv_1 (.Y(clk0_delayed_inv), .IN1(clk0_delayed));

AND2    pt_and2_1 (.Y(we_pulse), .IN1(clk0_delayed_inv), .IN2(we_reg_delayed));

AND1    wedelay_buf (.Y(we_reg_delayed), .IN1(we_reg));

dffe    wdatainreg (.Q(wdatain_reg), .CLK(clk0), .ENA(iena0), .D(datain), .CLRN(write_logic_clr), .PRN(1'b1));
dffe    wrinvreg (.Q(wrinv_reg), .CLK(clk0), .ENA(iena0), .D(wrinvert), .CLRN(write_logic_clr), .PRN(1'b1));

dffe    waddrreg_0 (.Q(waddr_reg[0]), .CLK(clk0), .ENA(iena0), .D(waddr[0]), .CLRN(waddr_clr), .PRN(1'b1));
dffe    waddrreg_1 (.Q(waddr_reg[1]), .CLK(clk0), .ENA(iena0), .D(waddr[1]), .CLRN(waddr_clr), .PRN(1'b1));
dffe    waddrreg_2 (.Q(waddr_reg[2]), .CLK(clk0), .ENA(iena0), .D(waddr[2]), .CLRN(waddr_clr), .PRN(1'b1));
dffe    waddrreg_3 (.Q(waddr_reg[3]), .CLK(clk0), .ENA(iena0), .D(waddr[3]), .CLRN(waddr_clr), .PRN(1'b1));
dffe    waddrreg_4 (.Q(waddr_reg[4]), .CLK(clk0), .ENA(iena0), .D(waddr[4]), .CLRN(waddr_clr), .PRN(1'b1));

dffe    matchoutreg_0 (.Q(matchout_reg[0]), .CLK(output_clk), .ENA(output_clk_en), .D(matchout_int[0]), .CLRN(output_clr), .PRN(1'b1));
dffe    matchoutreg_1 (.Q(matchout_reg[1]), .CLK(output_clk), .ENA(output_clk_en), .D(matchout_int[1]), .CLRN(output_clr), .PRN(1'b1));
dffe    matchoutreg_2 (.Q(matchout_reg[2]), .CLK(output_clk), .ENA(output_clk_en), .D(matchout_int[2]), .CLRN(output_clr), .PRN(1'b1));
dffe    matchoutreg_3 (.Q(matchout_reg[3]), .CLK(output_clk), .ENA(output_clk_en), .D(matchout_int[3]), .CLRN(output_clr), .PRN(1'b1));
dffe    matchoutreg_4 (.Q(matchout_reg[4]), .CLK(output_clk), .ENA(output_clk_en), .D(matchout_int[4]), .CLRN(output_clr), .PRN(1'b1));
dffe    matchoutreg_5 (.Q(matchout_reg[5]), .CLK(output_clk), .ENA(output_clk_en), .D(matchout_int[5]), .CLRN(output_clr), .PRN(1'b1));
dffe    matchoutreg_6 (.Q(matchout_reg[6]), .CLK(output_clk), .ENA(output_clk_en), .D(matchout_int[6]), .CLRN(output_clr), .PRN(1'b1));
dffe    matchoutreg_7 (.Q(matchout_reg[7]), .CLK(output_clk), .ENA(output_clk_en), .D(matchout_int[7]), .CLRN(output_clr), .PRN(1'b1));
dffe    matchoutreg_8 (.Q(matchout_reg[8]), .CLK(output_clk), .ENA(output_clk_en), .D(matchout_int[8]), .CLRN(output_clr), .PRN(1'b1));
dffe    matchoutreg_9 (.Q(matchout_reg[9]), .CLK(output_clk), .ENA(output_clk_en), .D(matchout_int[9]), .CLRN(output_clr), .PRN(1'b1));
dffe    matchoutreg_10 (.Q(matchout_reg[10]), .CLK(output_clk), .ENA(output_clk_en), .D(matchout_int[10]), .CLRN(output_clr), .PRN(1'b1));
dffe    matchoutreg_11 (.Q(matchout_reg[11]), .CLK(output_clk), .ENA(output_clk_en), .D(matchout_int[11]), .CLRN(output_clr), .PRN(1'b1));
dffe    matchoutreg_12 (.Q(matchout_reg[12]), .CLK(output_clk), .ENA(output_clk_en), .D(matchout_int[12]), .CLRN(output_clr), .PRN(1'b1));
dffe    matchoutreg_13 (.Q(matchout_reg[13]), .CLK(output_clk), .ENA(output_clk_en), .D(matchout_int[13]), .CLRN(output_clr), .PRN(1'b1));
dffe    matchoutreg_14 (.Q(matchout_reg[14]), .CLK(output_clk), .ENA(output_clk_en), .D(matchout_int[14]), .CLRN(output_clr), .PRN(1'b1));
dffe    matchoutreg_15 (.Q(matchout_reg[15]), .CLK(output_clk), .ENA(output_clk_en), .D(matchout_int[15]), .CLRN(output_clr), .PRN(1'b1));
dffe    matchfoundreg (.Q(matchfound_reg), .CLK(output_clk), .ENA(output_clk_en), .D(matchfound_int), .CLRN(output_clr), .PRN(1'b1));



wire [1:0] modesel_tmp;
assign modesel_tmp[1] = modesel[9];
assign modesel_tmp[0] = modesel[8];

apex20ke_cam cam1 (
	.inclk(clk0),
	.waddr(waddr_reg),
	.we(we_pulse),
	.outputselect(outputselect),
	.matchout(matchout_int),
	.matchfound(matchfound_int),
	.wrinvert(wrinv_int),
	.datain(wdatain_int),
	.lit(lit),
	.modesel(modesel_tmp));

//assign matchfound = (operation_mode == "encoded_address") ? matchfound_tmp : 'bz;
endmodule

//
//   APEX20KE PTERM ATOM
//
module  apex20ke_pterm (pterm0, pterm1, pexpin, clk, ena, aclr,
                        modesel, dataout, pexpout);

    input  [31:0] pterm0, pterm1;
    input  pexpin, clk, ena, aclr;
    input  [9:0] modesel;
    output dataout, pexpout;

    wire fbk, dffin, combo, dffo;


apex20ke_asynch_pterm pcom (.pterm0(pterm0), .pterm1(pterm1), .pexpin(pexpin),
									 .fbkin(fbk), .combout(combo), .pexpout(pexpout),
									  .regin(dffin), .modesel(modesel));
apex20ke_pterm_register preg (.datain(dffin), .clk(clk), .ena(ena), .aclr(aclr), 
									  .regout(dffo),
									  .fbkout(fbk), .modesel(modesel));

//assign dataout = (output_mode == "comb") ? combo : dffo;
// modesel[8] == 0 => output_mode = "comb"
mux21 mux21_inst1(.MO(dataout), .S(modesel[8]), .A(combo), .B(dffo)); 

endmodule

