// BLAKE2b G: adds with message words, rotates 32/24/16/63.
module blake2_g(
  input  wire [63:0] a_in,
  input  wire [63:0] b_in,
  input  wire [63:0] c_in,
  input  wire [63:0] d_in,
  input  wire [63:0] m0,
  input  wire [63:0] m1,
  output wire [63:0] a_out,
  output wire [63:0] b_out,
  output wire [63:0] c_out,
  output wire [63:0] d_out
);
  wire [63:0] a1 = a_in + b_in + m0;
  wire [63:0] d1x = d_in ^ a1;
  wire [63:0] d1 = {d1x[31:0], d1x[63:32]};
  wire [63:0] c1 = c_in + d1;
  wire [63:0] b1x = b_in ^ c1;
  wire [63:0] b1 = {b1x[23:0], b1x[63:24]};
  wire [63:0] a2 = a1 + b1 + m1;
  wire [63:0] d2x = d1 ^ a2;
  wire [63:0] d2 = {d2x[15:0], d2x[63:16]};
  wire [63:0] c2 = c1 + d2;
  wire [63:0] b2x = b1 ^ c2;

  assign a_out = a2;
  assign b_out = {b2x[62:0], b2x[63]};
  assign c_out = c2;
  assign d_out = d2;
endmodule
