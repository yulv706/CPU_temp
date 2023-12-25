module au(
  input au_en,
  input [3:0] ac,
  input signed [7:0] a, b,  
  output reg signed [7:0] t,
  output reg gf
);

always @* begin
  t = (au_en == 1'b0) ? 8'hZZ :
      (ac == 4'b1000) ? a + b :
      (ac == 4'b1001) ? b - a :
      (ac == 4'b0100 || ac == 4'b0101 || ac == 4'b1101) ? a :
      8'hZZ;
  
  if(au_en == 1'b1 && ac == 4'b1001 && b > a) gf = 1'b1;
  else if(au_en == 1'b1 && ac == 4'b1001) gf = 1'b0;
end

endmodule
