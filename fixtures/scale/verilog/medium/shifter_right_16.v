// Logarithmic right shifter with arithmetic fill.
module shifter_right_16(
  input  wire [15:0] a,
  input  wire [3:0]  amount,
  input  wire        arithmetic,
  output wire [15:0] result
);
  wire fill = arithmetic & a[15];
  wire [15:0] s1 = amount[0] ? {fill, a[15:1]} : a;
  wire [15:0] s2 = amount[1] ? {{2{fill}}, s1[15:2]} : s1;
  wire [15:0] s4 = amount[2] ? {{4{fill}}, s2[15:4]} : s2;

  assign result = amount[3] ? {{8{fill}}, s4[15:8]} : s4;
endmodule
