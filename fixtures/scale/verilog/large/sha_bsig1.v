module sha_bsig1(
  input  wire [31:0] x,
  output wire [31:0] out
);
  // Big sigma 1: rotations by 6, 11, 25.
  // Feeds the choose function ahead of the T1 temporary.
  assign out = {x[5:0], x[31:6]}
             ^ {x[10:0], x[31:11]}
             ^ {x[24:0], x[31:25]};
endmodule
