module add_round_key(
  input  wire [127:0] state_in,
  input  wire [127:0] round_key,
  output wire [127:0] state_out
);
  // Key mixing is a plain XOR in GF(2).
  assign state_out = state_in ^ round_key;

  // Kept as a module so every round shares one net name scheme.
endmodule
