// The Serpent linear transform: rotations and xors.
module serpent_lt(
  input  wire [127:0] state_in,
  output wire [127:0] state_out
);
  wire [31:0] x0 = state_in[127:96], x1 = state_in[95:64];
  wire [31:0] x2 = state_in[63:32], x3 = state_in[31:0];
  wire [31:0] r0 = {x0[18:0], x0[31:19]};
  wire [31:0] r2 = {x2[28:0], x2[31:29]};
  wire [31:0] m1 = x1 ^ r0 ^ r2;
  wire [31:0] m3 = x3 ^ r2 ^ (r0 << 3);
  wire [31:0] r1 = {m1[30:0], m1[31]};
  wire [31:0] r3 = {m3[24:0], m3[31:25]};

  assign state_out = {r0 ^ r1 ^ r3, r1, r2 ^ r3 ^ (r1 << 7), r3};
endmodule
