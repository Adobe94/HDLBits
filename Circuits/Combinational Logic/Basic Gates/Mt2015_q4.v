module top_module (input x, input y, output z);
    wire z_A,z_B,z_u,z_d;
task A;
    input x,y;
    output z;
    begin
    	z = (x^y) & x;
    end
endtask
task B;
    input x,y;
    output z;
    begin
        z = ~(x ^ y);
    end
endtask
    always @(*) begin
        A(x,y,z_A);
        B(x,y,z_B);
    end
    assign z_u = z_A | z_B;
    assign z_d = z_A & z_B;
    assign z = z_u ^ z_d;
endmodule
