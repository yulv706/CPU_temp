module ir (
    input clk, ld_ir,
    input [7:0] a,
    output reg [7:0] x
);

// 初始化 x 为 8 位零值
initial begin
    x = 8'b00000000;
end

// 在时钟下降沿更新
always @(negedge clk) begin
    if (ld_ir)
        x <= a;  // 如果 ld_ir 为 1，将寄存器的值更新为输入信号 a
		// 如果 ld_ir 为 0，保持寄存器的当前值
end

endmodule
