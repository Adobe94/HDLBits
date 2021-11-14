module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    assign ena[3:1] = {{q[11:8] == 'd9 && q[7:4] == 'd9 && q[3:0] == 'd9}, {q[7:4] == 'd9 && q[3:0] == 'd9}, {q[3:0] == 'd9}};
    count10 count_1(clk, 1'b1, reset, q[3:0]);
    count10 count_10(clk, ena[1], reset, q[7:4]);
    count10 count_100(clk, ena[2], reset, q[11:8]);
    count10 count_1000(clk, ena[3], reset, q[15:12]);
    
endmodule


module count10 (input clk, input enable, input reset, output reg [3:0] q);
    always @(posedge clk) begin
        if(reset) q <= 'd0; 
        else if(enable) begin
            if(q >= 'd9) q <= 'd0;
            else q <= q + 1;
        end
        else q <= q;
    end
endmodule
