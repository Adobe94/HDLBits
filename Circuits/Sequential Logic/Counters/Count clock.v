module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
wire over[4:0];
reg am_pm;
assign over[1] = (ss[7:4] == 'd5) && (ss[3:0] == 'd9);
assign over[2] = (ss[7:4] == 'd5) && (ss[3:0] == 'd9) && (mm[3:0] == 'd9);
assign over[3] = (ss[7:4] == 'd5) && (ss[3:0] == 'd9) && (mm[3:0] == 'd9) && (mm[7:4] == 'd5);
assign over[4] = (ss[7:4] == 'd5) && (ss[3:0] == 'd9) && (mm[3:0] == 'd9) && (mm[7:4] == 'd5) && ((hh[3:0]== 'd2) && (hh[7:4] == 'd1)) || ((ss[7:4] == 'd5) && (ss[3:0] == 'd9) && (mm[3:0] == 'd9) && (mm[7:4] == 'd5) && ((hh[3:0]== 'd9) && (hh[7:4] == 'd0)));
cnt u_cnt_s(
.clk (clk),
.reset (reset),
.ena (ena),
.upper (4'd9),
.num (ss[3:0]),
.over (over[0])
);
cnt u_cnt_ss(
.clk (clk),
.reset (reset),
.ena (over[0]),
.upper (4'd5),
.num (ss[7:4]),
.over ()
);

cnt u_cnt_m(
.clk (clk),
.reset (reset),
.ena (over[1]),
.upper (4'd9),
.num (mm[3:0]),
.over ()
);

cnt u_cnt_mm(
.clk (clk),
.reset (reset),
.ena (over[2]),
.upper (4'd5),
.num (mm[7:4]),
.over ()
);

cnt_hh_one u_cnt_hh_one(
.clk (clk),
.reset (reset),
.ena	(over[3]),
.hh_ten (hh[7:4]),
.hh_one (hh[3:0]),
.over 	()
);

cnt_hh_ten u_cnt_hh_ten(
.clk	(clk),
.reset	(reset),
.ena	(over[4]),
.hh_ten	(hh[7:4])
);
 always @(posedge clk) begin
	if(reset) begin
		am_pm <= 'b0;
	end
	else if((ss[7:4] == 'd5) && (ss[3:0] == 'd9) && (mm[3:0] == 'd9) && (mm[7:4] == 'd5) && ((hh[3:0]== 'd1) && (hh[7:4] == 'd1))) begin
		am_pm <= ~ am_pm;
	end
end
assign pm = am_pm; 
endmodule

module cnt(
input clk,
input reset,
input ena,
input [3:0] upper,
output reg [3:0] num,
output reg over
);
always @(posedge clk) begin
	if(reset) begin
		num <= 'd0;
	end
	else if(ena) begin
		if(num >= upper) begin
			num <= 'd0;
		end
		else begin
			num <= num + 'd1;
		end
	end
end
assign over = ((num == upper) && ena) ? 1'b1 : 1'b0;
endmodule

module cnt_hh_one(
input clk,
input reset,
input ena,
input hh_ten,
output reg [3:0] hh_one,
output reg over
);
always @(posedge clk) begin
	if(reset) begin
		hh_one <= 'd2; // 12:00 AM
	end
	else if(ena) begin
		if(hh_ten == 'd1 && hh_one == 'd2) begin
			hh_one <= 'd1; // 01:00 AM
			over <= 'b1;
		end
		else if(hh_one >= 'd9) begin
			hh_one <= 'd0;
			over <= 'b1;
		end
		else begin
			hh_one <= hh_one + 'd1;
			over <= 'b0;
		end
	end
end
endmodule

module cnt_hh_ten(
input clk,
input reset,
input ena,
output reg [3:0] hh_ten
);
always @(posedge clk) begin
	if(reset) begin
		hh_ten <= 'd1;
	end
	else if(ena) begin
		if(hh_ten == 'd1) begin
			hh_ten <= 'd0;
		end
		else begin
			hh_ten <= 'd1;
		end
	end
end

endmodule
