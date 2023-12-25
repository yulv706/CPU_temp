module mux2_1 (
  input [7:0] a,
  input [7:0] b,
  input s,
  output reg [7:0] y
);

always @(a, b, s)
begin
  if (s == 0)
    y = a;
  else
    y = b;
end
endmodule
