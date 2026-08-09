// 8-bit magnitude comparator from two 4-bit halves.
module comparator_8(
  input  wire [7:0] a,
  input  wire [7:0] b,
  output wire        eq,
  output wire        lt,
  output wire        gt
);
  wire eq_hi, lt_hi, gt_hi;
  wire eq_lo, lt_lo, gt_lo;

  comparator_4 u_hi(a[7:4], b[7:4], eq_hi, lt_hi, gt_hi);
  comparator_4 u_lo(a[3:0], b[3:0], eq_lo, lt_lo, gt_lo);

  assign eq = eq_hi & eq_lo;
  assign lt = lt_hi | (eq_hi & lt_lo);
  assign gt = gt_hi | (eq_hi & gt_lo);
endmodule
