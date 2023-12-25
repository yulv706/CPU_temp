module reg_group (
    input clk, we,
    input [1:0] sr, dr,
    input [7:0] i,
    output reg [7:0] s, d
);
reg [7:0] R0, R1, R2, R3;
parameter R0_SET = 2'b00, R1_SET = 2'b01, R2_SET = 2'b10, R3_SET = 2'b11;

initial begin
    R3 = 8'b00000111;
    R0 = 8'b00000001;
end

// ����״̬������߼�
always @(sr or dr or R0 or R1 or R2 or R3) begin
    case (sr)
        R0_SET: s = R0;
        R1_SET: s = R1;
        R2_SET: s = R2;
        default: s = R3;
    endcase

    case (dr)
        R0_SET: d = R0;
        R1_SET: d = R1;
        R2_SET: d = R2;
        default: d = R3;
    endcase
end
// ʱ���½��ش�����д���߼�
always @(negedge clk) begin
    if (we == 1'b1) begin
        if (dr == R0_SET)
            R0 <= i;
        else if (dr == R1_SET)
            R1 <= i;
        else if (dr == R2_SET)
            R2 <= i;
        else
            R3 <= i; 
    end
end
endmodule