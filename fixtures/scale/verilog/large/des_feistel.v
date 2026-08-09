// The DES F function: expand, key-mix, substitute, permute.
module des_feistel(
  input  wire [31:0] half_in,
  input  wire [47:0] subkey,
  output wire [31:0] f_out
);
  wire [47:0] stretched;
  wire [31:0] substituted;

  des_expand    u_e(half_in, stretched);
  des_sbox_bank u_s(stretched ^ subkey, substituted);
  des_pbox      u_p(substituted, f_out);
endmodule
