module psw (
    input clk, g, g_en,
    output reg gf
);


initial begin
    gf = 1'b0;
end


always @(negedge clk) begin
    if (g_en)
        gf <= g; 
end

endmodule
