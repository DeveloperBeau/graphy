// 8-bit ripple-carry adder built from two 4-bit halves.
module ripple_adder_8(
  input  wire [7:0] a,
  input  wire [7:0] b,
  input  wire        cin,
  output wire [7:0] sum,
  output wire        cout
);
  wire c_mid;

  ripple_adder_4 u_lo(a[3:0], b[3:0], cin, sum[3:0], c_mid);
  ripple_adder_4 u_hi(a[7:4], b[7:4], c_mid, sum[7:4], cout);
endmodule
