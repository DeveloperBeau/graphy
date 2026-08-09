// Scalar-multiplication front end for the shared-secret op.
module x25519_top(
  input  wire         clk,
  input  wire         rst_n,
  input  wire         start,
  input  wire [254:0] scalar,
  input  wire [254:0] base_point,
  output wire [254:0] shared_point,
  output wire         done
);
  wire [254:0] xa, xb, x2n, z2n;
  wire         step_done;

  cswap             u_swap(scalar[254], base_point, 255'd9, xa, xb);
  point_ladder_step u_step(clk, rst_n, start, xa, xb, base_point, x2n, z2n, step_done);

  assign shared_point = x2n;
  assign done         = step_done;
endmodule
