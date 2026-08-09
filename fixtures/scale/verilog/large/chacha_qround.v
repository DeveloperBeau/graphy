// ChaCha quarter round: add, xor, rotate by 16/12/8/7.
module chacha_qround(
  input  wire [31:0] a_in,
  input  wire [31:0] b_in,
  input  wire [31:0] c_in,
  input  wire [31:0] d_in,
  output wire [31:0] a_out,
  output wire [31:0] b_out,
  output wire [31:0] c_out,
  output wire [31:0] d_out
);
  wire [31:0] a1 = a_in + b_in;
  wire [31:0] d1x = d_in ^ a1;
  wire [31:0] d1 = {d1x[15:0], d1x[31:16]};
  wire [31:0] c1 = c_in + d1;
  wire [31:0] b1x = b_in ^ c1;
  wire [31:0] b1 = {b1x[19:0], b1x[31:20]};
  wire [31:0] a2 = a1 + b1;
  wire [31:0] d2x = d1 ^ a2;
  wire [31:0] d2 = {d2x[23:0], d2x[31:24]};
  wire [31:0] c2 = c1 + d2;
  wire [31:0] b2x = b1 ^ c2;

  assign a_out = a2;
  assign b_out = {b2x[24:0], b2x[31:25]};
  assign c_out = c2;
  assign d_out = d2;
endmodule
