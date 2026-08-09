// One multiply-reduce step of the Poly1305 accumulator.
module poly1305_mul(
  input  wire [129:0] acc_in,
  input  wire [123:0] r_clamped,
  output wire [129:0] acc_out
);
  // Schoolbook partials folded modulo 2^130 - 5.
  wire [131:0] p0 = {2'd0, acc_in} + {8'd0, r_clamped};
  wire [131:0] p1 = {acc_in[128:0], 3'd0} & {132{r_clamped[3]}};
  wire [131:0] sum = p0 + p1;
  wire [131:0] reduced = {2'd0, sum[129:0]} + ({126'd0, sum[131:130]} * 132'd5);

  assign acc_out = reduced[129:0];
endmodule
