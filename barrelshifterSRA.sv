module barrelshifterSRA(input logic [31:0]d,
                        input logic [4:0]shamt,
                        output logic [31:0]y);
logic [31:0] s0,s1,s2,s3;
//tang logic 0 dich 1 bit
genvar i;
mux2to1 m00(d[31],d[31],shamt[0],s0[31]);
generate
    for(i=0;i<31;i++) begin:stage0
    mux2to1 m(d[i+1],d[i],shamt[0],s0[i]);
end
endgenerate
//tang logic 1 dich 2 bit
mux2to1 m10(s0[31],s0[31],shamt[1],s1[31]);
mux2to1 m11(s0[31],s0[30],shamt[1],s1[30]);
generate 
    for(i=0;i<30;i++) begin:stage1
        mux2to1 m(s0[i+2],s0[i],shamt[0],s1[i]);
    end
endgenerate
//tang logic 2 dich 4 bit
generate
    for(i=31;i>=28;i--) begin:stage20
        mux2to1 m(s1[31],s1[i],shamt[2],s2[i]);
    end
    for(i=0;i<28;i++) begin:stage21
        mux2to1 m(s1[i+4],s1[i],shamt[2],s2[i]);
    end
endgenerate
//tang logic 3 dich 8 bit
generate
    for(i=31;i>=24;i--) begin:stage30
        mux2to1 m(s2[31],s2[i],shamt[3],s3[i]);
    end
    for(i=0;i<24;i++) begin:stage31
        mux2to1 m(s2[i+8],s2[i],shamt[3],s3[i]);
    end
endgenerate
//tang logic 4 dich 16 bit
generate 
    for(i=31;i>=16;i--) begin:stage40
        mux2to1 m(s3[31],s3[i],shamt[4],y[i]);
    end
    for(i=0;i<16;i++) begin:stage41
        mux2to1 m(s3[i+16],s3[i],shamt[4],y[i]);
    end
endgenerate
endmodule


