// 16-bit adder from four lookahead slices.
module cla_adder_16(
  input  wire [15:0] a,
  input  wire [15:0] b,
  input  wire        cin,
  output wire [15:0] sum,
  output wire        cout
);
  wire c4, c8, c12;

  carry_lookahead_4 u_s0(a[3:0], b[3:0], cin, sum[3:0], c4);
  carry_lookahead_4 u_s1(a[7:4], b[7:4], c4, sum[7:4], c8);
  carry_lookahead_4 u_s2(a[11:8], b[11:8], c8, sum[11:8], c12);
  carry_lookahead_4 u_s3(a[15:12], b[15:12], c12, sum[15:12], cout);
endmodule
