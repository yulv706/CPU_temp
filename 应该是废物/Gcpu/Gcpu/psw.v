module psw (
    input clk, g, g_en,
    output reg gf
);

// gf初始值为0
initial begin
    gf = 1'b0;
end

// 在时钟下降沿更新寄存器
always @(negedge clk) begin
    if (g_en)
        gf <= g; // 如果 g_en 为 1，将寄存器的值更新为输入信号 g
end

endmodule
