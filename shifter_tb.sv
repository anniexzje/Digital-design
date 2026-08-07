module shifter_tb();
logic [31:0]d;
logic [4:0]shamt;
logic [31:0]y;
logic [31:0]y_expected;
barrelshifterLSR dut(d,shamt,y);
initial begin
    $dumpfile("waveformshifterlsr.vcd");
    $dumpvars(0,shifter_tb);
    //case 1
    d=32'd12345678;
    shamt=5;
    y_expected = d >> shamt;
    #5;
    assert(y===y_expected) else $error("Case 1 failed");
    #5;
    //case 2
    d=32'h11111111;
    shamt=31;
    y_expected = d >> shamt;
    #5;
    assert(y===y_expected) else $error("Case 2 failed");
    #5;
    //case 3
    d=32'h12345678;
    shamt=10;
    y_expected = d >> shamt;
    #5;
    assert(y===y_expected) else $error("Case 3 failed");
    #5;
    $finish;
end
endmodule

