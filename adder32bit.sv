module addercla4bit(input logic [3:0]a,b,
                    input logic cin,
                    output logic [3:0]sum,
                    output logic cout);
logic [3:0]p,g;
logic [3:0]c;
logic p3to0,g3to0;
always_comb
    begin
        p=a|b;
        g=a&b;
        g3to0=g[3] | p[3] &(g[2] | p[2]&(g[1] | p[1]&g[0]));
        p3to0=p[3]&p[2]&p[1]&p[0];
        c[0]=g[0] | p[0] & cin;
        c[1]=g[1] | p[1] & (g[0] | p[0] & cin);
        c[2]=g[2] | p[2] & (g[1] | p[1] & (g[0] | p[0] & cin));
        c[3]=g[3] | p[3] & (g[2] | p[2] & (g[1] | p[1] & (g[0] | p[0] & cin)));
        cout = (cin & p3to0) | g3to0;
        sum[0]=a[0]^b[0]^cin;
        sum[1]=a[1]^b[1]^c[0];
        sum[2]=a[2]^b[2]^c[1];
        sum[3]=a[3]^b[3]^c[2];
    end
endmodule
module adder32bit(input logic [31:0]a,b,
                    input logic cin,
                    output logic [31:0]sum,
                    output logic cout);
logic [7:0]c;
addercla4bit cla32bit1(a[3:0],b[3:0],cin,sum[3:0],c[0]);
addercla4bit cla32bit2(a[7:4],b[7:4],c[0],sum[7:4],c[1]);
addercla4bit cla32bit3(a[11:8],b[11:8],c[1],sum[11:8],c[2]);
addercla4bit cla32bit4(a[15:12],b[15:12],c[2],sum[15:12],c[3]);
addercla4bit cla32bit5(a[19:16],b[19:16],c[3],sum[19:16],c[4]);
addercla4bit cla32bit6(a[23:20],b[23:20],c[4],sum[23:20],c[5]);
addercla4bit cla32bit7(a[27:24],b[27:24],c[5],sum[27:24],c[6]);
addercla4bit cla32bit8(a[31:28],b[31:28],c[6],sum[31:28],c[7]);
assign cout = c[7];
endmodule




