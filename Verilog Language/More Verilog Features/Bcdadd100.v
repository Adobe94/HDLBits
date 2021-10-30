module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    wire [99:0] cout_t;
generate
    genvar i;
    for(i=0;i<100;i=i+1) begin:bcdadd
        if(i==0) begin
            bcd_fadd u_bcd_fadd_0(a[3:0],b[3:0],cin,cout_t[0],sum[3:0]);
        end
        else begin
            bcd_fadd u_bcd_fadd_i(a[i*4+3:i*4],b[i*4+3:i*4],cout_t[i-1],cout_t[i],sum[i*4+3:i*4]);
        end
    end
endgenerate
    assign cout = cout_t[99];
endmodule
