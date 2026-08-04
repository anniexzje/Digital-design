module testbench();
logic [31:0]a,b;
logic cin,cout;
logic [31:0]sum;
logic [32:0]expected; //32 bit bao gom ca sum va cout cua block cuoi
adder32bit dut(a,b,cin,sum,cout);
int errors = 0;
initial begin
    $dumpfile("waveform32bitcla.vcd");
    $dumpvars(0,testbench);
    repeat(1000) begin
        a=$urandom;
        b=$urandom;
        cin = $urandom_range(0,1);
        expected = a + b + cin;
        # 1;
        assert({cout,sum}==expected)
        else begin
            $display("Failed");
            $display("a=%d",a);
            $display("b=%d",b);
            $display("cin=%d",cin);
            $display("cout=%d",cout);
            $display("sum=%d",sum);
            $display("expected=%d",expected);
            errors++;
            $finish;
        end
    end
    if(errors ==0) begin
        $display("All tests passed!");
    end
    else begin
        $display(" %d test failed!",errors);
        $finish;
    end
end
endmodule

