// 4-bit carry-lookahead slice: generate/propagate network.
module carry_lookahead_4(
  input  wire [3:0] a,
  input  wire [3:0] b,
  input  wire       cin,
  output wire [3:0] sum,
  output wire       cout
);
  wire [3:0] g = a & b;
  wire [3:0] p = a ^ b;
  wire [3:0] c;

  assign c[0] = cin;
  assign c[1] = g[0] | (p[0] & cin);
  assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
  assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]);
  assign cout = g[3] | (p[3] & c[3]);
  assign sum  = p ^ c;
endmodule
