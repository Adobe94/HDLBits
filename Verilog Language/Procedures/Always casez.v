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
/*
always @(*) begin
	casez(1)
		in[0]: pos = 'd0;
		in[1]: pos = 'd1;
		in[2]: pos = 'd2;
		in[3]: pos = 'd3;
		in[4]: pos = 'd4;
		in[5]: pos = 'd5;
		in[6]: pos = 'd6;
		in[7]: pos = 'd7;
		default: pos = 'd0;
	endcase
end
*/
