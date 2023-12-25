module sm (
    input clk, sm_en,
    output reg sm
);

initial begin
    sm = 1'b0;
end


always @(negedge clk) begin
    if (sm_en)
        sm <= ~sm; 
end

endmodule
