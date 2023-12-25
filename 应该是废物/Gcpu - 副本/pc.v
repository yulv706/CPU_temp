module pc (
    input clk, in_pc, ld_pc,
    input [7:0] a,
    output reg [7:0] c
);

initial begin
    c = 8'b00000000;
end

always @(negedge clk) begin
    if (in_pc && ~ld_pc)
        c <= c + 1'b1; 
    else if (~in_pc && ld_pc)
        c <= a; 
end

endmodule
