module sha_bsig0(
  input  wire [31:0] x,
  output wire [31:0] out
);
  // Big sigma 0: rotations by 2, 13, 22.
  // Used ahead of the majority function in each compression stage.
  assign out = {x[1:0], x[31:2]}
             ^ {x[12:0], x[31:13]}
             ^ {x[21:0], x[31:22]};
endmodule
