module top_module (
    input clk,
    input j,
    input k,
    output Q); 
    always @(posedge clk) begin
        if(j ~^ k) // 同或
            Q <= j ? ~Q : Q;
        else Q <= j ? 1 : 0;
    end
endmodule
