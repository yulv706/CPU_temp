module con_signal(
    input mova, movb, movc, movd, add, sub, jmp, jg, g, in1, out1, movi, halt, sm,
    input [7:0] ir,
    output reg [1:0] reg_sr, reg_dr, s,
    output reg [3:0] au_ac,
    output reg sm_en, ir_ld, ram_re, ram_wr, pc_ld, pc_in, reg_we, au_en, gf_en, in_en, out_en, mux_s
);

    always @(*) begin
        
        sm_en = ~halt;
        ir_ld = ~sm;
        au_ac = ir[7:4];
        reg_sr = ir[1:0];
        reg_dr = ir[3:2];
        in_en = in1;
        out_en = out1;
        gf_en = sub;
        au_en = add | sub | mova | movb | out1;
        mux_s = mova | movc | movi | add | sub | in1;
        ram_wr = movb;
        ram_re = (~sm) | movc | movi;

        pc_ld = jmp | (jg & g);
        pc_in = (~sm) | movi;
        reg_we = mova | movc | movd | movi | add | sub | in1;

        if (sm && movb) s = 2'b10;
        else if (sm && movc) s = 2'b01;
        else s = 2'b00;
    end
endmodule
