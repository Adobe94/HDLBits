// synthesis verilog_input_version verilog_2001
module top_module (
    input [7:0] in,
    output reg [2:0] pos  );
always @(*) begin
	casez(in)
		8'b????_???1: pos = 'd0;
		8'b????_??10: pos = 'd1;
		8'b????_?100: pos = 'd2;
		8'b????_1000: pos = 'd3;
		8'b???1_0000: pos = 'd4;
		8'b??10_0000: pos = 'd5;
		8'b?100_0000: pos = 'd6;
		8'b1000_0000: pos = 'd7;
		default: pos = 'd0;
	endcase
end
endmodule
