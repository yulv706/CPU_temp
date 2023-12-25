module reg_group (
    input clk, we,
    input [1:0] sr, dr,
    input [7:0] i,
    output reg [7:0] s, d
);
reg [7:0] R0, R1, R2, R3;

initial begin
R0=8'b00000001;
R3=8'b00000111;
end
 
always @(sr or dr or R0 or R1 or R2 or R3)
  begin
    case (sr)
        2'b00: s = R0;
        2'b01: s = R1;
        2'b10: s = R2;
        default: s = R3;
    endcase

    case (dr)
        2'b00: d = R0;
        2'b01: d = R1;
        2'b10: d = R2;
        default: d = R3;
    endcase
  end

always @(negedge clk)
  begin
    case({we,dr})
       3'b100: R0 <= i;
       3'b101: R1 <= i;
       3'b110: R2 <= i;
       3'b111: R3 <= i;
       default: ;
    endcase
  end
endmodule
