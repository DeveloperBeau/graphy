// 32-bit ripple-carry adder built from two 16-bit halves.
module ripple_adder_32(
  input  wire [31:0] a,
  input  wire [31:0] b,
  input  wire        cin,
  output wire [31:0] sum,
  output wire        cout
);
  wire c_mid;

  ripple_adder_16 u_lo(a[15:0], b[15:0], cin, sum[15:0], c_mid);
  ripple_adder_16 u_hi(a[31:16], b[31:16], c_mid, sum[31:16], cout);
endmodule
