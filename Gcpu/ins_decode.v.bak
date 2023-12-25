module ins_decode(en,ir,mova, movb, movc, movd, add, sub, jmp, jg, in1, out1, movi, halt);
  input wire en;
  input wire [3:0] ir;
  output mova, movb, movc, movd, add, sub, jmp, jg, in1, out1, movi, halt;
  reg mova, movb, movc, movd, add, sub, jmp, jg, in1, out1, movi, halt;

  always @* begin
	if (en) begin
    {mova, movb, movc, movd, add, sub, jmp, jg, in1, out1, movi, halt} =
      {ir == 4'b0100, ir == 4'b0101, ir == 4'b0110, ir == 4'b0111,
       ir == 4'b1000, ir == 4'b1001, ir == 4'b1010, ir == 4'b1011,
       ir == 4'b1100, ir == 4'b1101, ir == 4'b1110, ir == 4'b1111};
    end 
    else begin
    {mova, movb, movc, movd, add, sub, jmp, jg, in1, out1, movi, halt} = 12'b0;
    end
  end
endmodule