// Serpent stage 7 of 8: four rounds share each S-box.
module serpent_stage_7(
  input  wire [127:0] state_in,
  input  wire [127:0] round_key,
  output wire [127:0] state_out
);
  localparam STAGE = 7;
  wire [127:0] keyed = state_in ^ round_key;
  wire [127:0] substituted;

  serpent_sbox_layer u_sbox(keyed, 3'd6, substituted);
  serpent_lt         u_lt(substituted, state_out);
endmodule
