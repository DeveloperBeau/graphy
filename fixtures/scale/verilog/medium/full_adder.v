// Classic two-half-adder composition.
module full_adder(
  input  wire a,
  input  wire b,
  input  wire cin,
  output wire sum,
  output wire cout
);
  wire s1, c1, c2;

  half_adder u_ha0(a, b, s1, c1);
  half_adder u_ha1(s1, cin, sum, c2);

  assign cout = c1 | c2;
endmodule
