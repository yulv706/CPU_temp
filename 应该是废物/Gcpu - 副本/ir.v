module ir (
    input clk, ld_ir,
    input [7:0] a,
    output reg [7:0] x
);


initial begin
    x = 8'b00000000;
end

always @(negedge clk) begin
    if (ld_ir)
        x <= a;  
end

endmodule
