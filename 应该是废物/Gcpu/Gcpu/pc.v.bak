module pc (
    input clk, in_pc, ld_pc,
    input [7:0] a,
    output reg [7:0] c
);

//PC初始值为00000000
initial begin
    c = 8'b00000000;
end

always @(negedge clk) begin
    if (in_pc && ~ld_pc)
        c <= c + 1'b1; // in_pc为1且ld_pc为0,递增c
    else if (~in_pc && ld_pc)
        c <= a; // in_pc为0 且ld_pc为1,c设置为输入信号a
end

endmodule
