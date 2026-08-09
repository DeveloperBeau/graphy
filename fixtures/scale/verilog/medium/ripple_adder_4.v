// 4-bit ripple-carry adder, one full adder per bit.
module ripple_adder_4(
  input  wire [3:0] a,
  input  wire [3:0] b,
  input  wire       cin,
  output wire [3:0] sum,
  output wire       cout
);
  wire c1, c2, c3;

  full_adder u_fa0(a[0], b[0], cin, sum[0], c1);
  full_adder u_fa1(a[1], b[1], c1, sum[1], c2);
  full_adder u_fa2(a[2], b[2], c2, sum[2], c3);
  full_adder u_fa3(a[3], b[3], c3, sum[3], cout);
endmodule
