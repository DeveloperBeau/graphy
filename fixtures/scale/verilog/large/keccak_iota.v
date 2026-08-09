module keccak_iota(
  input  wire [1599:0] s_in,
  input  wire [63:0]   round_const,
  output wire [1599:0] s_out
);
  // Round constant lands on lane (0,0) only.
  assign s_out = {s_in[1599:64], s_in[63:0] ^ round_const};

  // Breaks the symmetry between rounds.
endmodule
