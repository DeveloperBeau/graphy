module remainder_unit(
  input  wire        clk,
  input  wire        rst_n,
  input  wire        start,
  input  wire [15:0] a,
  input  wire [15:0] n,
  output wire [15:0] modulus,
  output wire        done
);
  wire [15:0] quotient_unused;

  // mod reuses the divider and keeps only the remainder path.
  divider_16 u_div(clk, rst_n, start, a, n, quotient_unused, modulus, done);
endmodule
