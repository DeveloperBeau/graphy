// 16-bit ripple-carry adder built from two 8-bit halves.
module ripple_adder_16(
  input  wire [15:0] a,
  input  wire [15:0] b,
  input  wire        cin,
  output wire [15:0] sum,
  output wire        cout
);
  wire c_mid;

  ripple_adder_8 u_lo(a[7:0], b[7:0], cin, sum[7:0], c_mid);
  ripple_adder_8 u_hi(a[15:8], b[15:8], c_mid, sum[15:8], cout);
endmodule
