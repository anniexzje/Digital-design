module shifter_tb();
logic [31:0]d;
logic [4:0]shamt;
logic [31:0]y;
logic [31:0]y_expected;
int errors;
barrelshifterSRA dut(d,shamt,y);
initial begin
    $dumpfile("waveformshifterlsr.vcd");
    $dumpvars(0,shifter_tb);
    //case 1
    d=32'd80000000;
    shamt=31;
    y_expected = $signed(d) >>> shamt;
    #5;
    assert(y===y_expected) else begin
        $error("Case 1 failed");
        errors++;
    end
    #5;
    //case 2
    d=32'hDEADBEEF;
    shamt=0;
    y_expected = $signed(d) >>> shamt;
    #5;
    assert(y===y_expected) else begin
        $error("Case 2 failed");
        errors++;
    end
    #5;
    //case 3
    d=32'hFFFFFFFF;
    shamt=5;
    y_expected = $signed(d) >>> shamt;
    #5;
    assert(y===y_expected) else begin
        $error("Case 3 failed");
        errors++;
    end
    #5;
    if(errors == 0) begin
    $display("==================");
    $display("ALL case passed!!!");
    $display("==================");
    end
    else begin
    $finish;
    end
end
endmodule

