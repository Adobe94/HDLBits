module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //
reg [3:0] LEDR_ins;
wire [3:0] W;

assign W = {KEY[3],LEDR[3:1]};

always @(posedge KEY[0]) begin
	LEDR <= LEDR_ins;
end

generate 
	genvar geni;
	for(geni = 0; geni < 4; geni = geni + 1) begin: loop
		MUXDFF(
		.Q_nxt	(LEDR[geni]),
		.w		(W[geni]),
		.E		(KEY[1]),
		.R		(SW[geni]),
		.L		(KEY[2]),
		.D_pre	(LEDR_ins[geni])
		);
	end
endgenerate

endmodule

module MUXDFF (
input Q_nxt,
input w,
input E,
input R,
input L,
output D_pre
);

assign D_pre = L ? R : (E ? w : Q_nxt); 

endmodule
