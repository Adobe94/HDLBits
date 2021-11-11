module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] in_old;
    always @(posedge clk) begin
        in_old <= in;
    end
    always @(posedge clk) begin
        if(reset) out <= 'b0;
        else begin
            out <= ((in ^ in_old) & (~in)) | out;
        end
    end
endmodule
