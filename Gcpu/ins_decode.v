module ins_decode(en, ir, mova, movb, movc, movd, add, sub, jmp, jg, in1, out1, movi, halt);
  input wire en;
  input wire [3:0] ir;
  output mova, movb, movc, movd, add, sub, jmp, jg, in1, out1, movi, halt;
  reg mova, movb, movc, movd, add, sub, jmp, jg, in1, out1, movi, halt;

  always @* begin
    if (en) begin
      mova = ir == 4'b0100;
      movb = ir == 4'b0101;
      movc = ir == 4'b0110;
      movd = ir == 4'b0111;
      add  = ir == 4'b1000;
      sub  = ir == 4'b1001;
      jmp  = ir == 4'b1010;
      jg   = ir == 4'b1011;
      in1  = ir == 4'b1100;
      out1 = ir == 4'b1101;
      movi = ir == 4'b1110;
      halt = ir == 4'b1111;
    end 
    else begin
      {mova, movb, movc, movd, add, sub, jmp, jg, in1, out1, movi, halt} = 12'b0;
    end
  end
endmodule
