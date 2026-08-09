// Keccak-f[1600] round 11 of 24.
module keccak_round_11(
  input  wire [1599:0] s_in,
  output wire [1599:0] s_out
);
  localparam [63:0] RC = 64'h0000000080008009;
  wire [1599:0] after_theta, after_rho_pi, after_chi;

  keccak_theta  u_theta(s_in, after_theta);
  keccak_rho_pi u_rho_pi(after_theta, after_rho_pi);
  keccak_chi    u_chi(after_rho_pi, after_chi);
  keccak_iota   u_iota(after_chi, RC, s_out);
endmodule
