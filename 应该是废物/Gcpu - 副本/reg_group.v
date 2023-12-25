module reg_group(
    input clk,we,
    input [1:0] sr,dr,
    input [7:0] i,
    output reg[7:0] s,d);
reg [7:0] R0,R1,R2,R3;

initial begin
R3=8'b00000111;
R1=8'b00000001;
end

always @(sr or dr or R0 or R1 or R2 or R3) 
begin
    case (sr)
    2'b00: s=R0;
    2'b01: s=R1;
    2'b10: s=R2;
    2'b11: s=R3;
    endcase

    case (dr)
    2'b00: d=R0;
    2'b01: d=R1;
    2'b10: d=R2;
    2'b11: d=R3;
    endcase
end

always @(negedge clk) 
begin
    if(we==1'b1)
    begin
        if (dr == 2'b00)
            R0 <= i;
        else if (dr == 2'b01)
            R1 <= i;
        else if (dr == 2'b10)
            R2 <= i;
        else
            R3 <= i;
    end
end
endmodule