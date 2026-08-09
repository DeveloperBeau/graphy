// Poly1305 MAC datapath: multiply, reduce, accumulate.
module poly1305_core(
  input  wire         clk,
  input  wire         rst_n,
  input  wire         absorb,
  input  wire [127:0] block_in,
  input  wire [123:0] r_clamped,
  output wire [127:0] tag
);
  wire [129:0] acc, mul_out;

  poly1305_mul u_mul(acc, r_clamped, mul_out);
  poly1305_acc u_acc(clk, rst_n, absorb, block_in, mul_out, acc);

  assign tag = acc[127:0];
endmodule
