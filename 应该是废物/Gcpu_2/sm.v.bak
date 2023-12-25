module sm (
    input clk, sm_en,
    output reg sm
);

// 初始化sm
initial begin
    sm = 1'b0;
end

// 在时钟下降沿使用非阻塞赋值操作更新状态机
always @(negedge clk) begin
    if (sm_en)
        sm <= ~sm; // 使能时状态取反
    // 如果不使能，状态保持不变
end

endmodule
