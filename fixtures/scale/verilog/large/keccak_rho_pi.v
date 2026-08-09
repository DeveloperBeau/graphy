// Combined rho rotation and pi permutation stage.
module keccak_rho_pi(
  input  wire [1599:0] s_in,
  output wire [1599:0] s_out
);
  // Lane rotations (rho) then the fixed lane shuffle (pi).
  genvar i;
  generate
    for (i = 0; i < 25; i = i + 1) begin : g_lane
      wire [63:0] lane = s_in[64*i+63:64*i];
      wire [5:0]  rot = (i * 7 + 3) % 64;
      wire [63:0] spun = (lane << rot) | (lane >> (64 - rot));
      assign s_out[64*((i*6+4)%25)+63:64*((i*6+4)%25)] = spun;
    end
  endgenerate
endmodule
