module barrelshifterLSR(
    input  logic [31:0] d,
    input  logic [ 4:0] shamt,
    output logic [31:0] y
);
  genvar i;
  logic [31:0] s0, s1, s2, s3;
  //tang 0 dich 1 bit
 mux2to1 mux00(1'b0,d[31],shamt[0],s0[31]);
        generate 
            for(i=0;i<31;i++) begin:stage0
                mux2to1 mux0(d[i+1],d[i],shamt[0],s0[i]);
                end
        endgenerate
  //tang 1 dich 2 bit
  mux2to1 mux10 (
      1'b0,
      s0[31],
      shamt[1],
      s1[31]
  );
  mux2to1 mux11 (
      1'b0,
      s0[30],
      shamt[1],
      s1[30]
  );
  generate
    for (i = 0; i < 30; i++) begin : stage1
      mux2to1 m (
          s0[i+2],
          s0[i],
          shamt[1],
          s1[i]
      );
    end
  endgenerate
  //tang 2 dich 4 bit
  mux2to1 mux20 (
      1'b0,
      s1[31],
      shamt[2],
      s2[31]
  );
  mux2to1 mux21 (
      1'b0,
      s1[30],
      shamt[2],
      s2[30]
  );
  mux2to1 mux22 (
      1'b0,
      s1[29],
      shamt[2],
      s2[29]
  );
  mux2to1 mux23 (
      1'b0,
      s1[28],
      shamt[2],
      s2[28]
  );
  generate
    for (i = 0; i < 28; i++) begin : stage2
      mux2to1 mux2 (
          s1[i+4],
          s1[i],
          shamt[2],
          s2[i]
      );
    end
  endgenerate
  //tang 3 dich 8 bit
  generate
    for (i = 31; i >= 24; i--) begin : stage31
      mux2to1 mux3 (
          1'b0,
          s2[i],
          shamt[3],
          s3[i]
      );
    end
    for (i = 0; i < 24; i++) begin : stage32
      mux2to1 mux3 (
          s2[i+8],
          s2[i],
          shamt[3],
          s3[i]
      );
    end
  endgenerate
  //tang 4 dich 16 bit
  generate
    for (i = 31; i >= 16; i--) begin : stage41
      mux2to1 mux4 (
          1'b0,
          s3[i],
          shamt[4],
          y[i]
      );
    end
    for (i = 0; i <16; i++) begin : stage42
      mux2to1 mux4 (
          s3[i+16],
          s3[i],
          shamt[4],
          y[i]
      );
    end
  endgenerate
endmodule

