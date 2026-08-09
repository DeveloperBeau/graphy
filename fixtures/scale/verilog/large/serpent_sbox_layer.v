// One of the eight rotating Serpent S-box layers.
module serpent_sbox_layer(
  input  wire [127:0] state_in,
  input  wire [2:0]   sbox_id,
  output wire [127:0] state_out
);
  // Bitsliced substitution: the same 4-bit box across 32 slices.
  genvar i;
  generate
    for (i = 0; i < 32; i = i + 1) begin : g_slice
      wire [3:0] nib = state_in[4*i+3:4*i];
      wire [3:0] rot = {nib[2:0], nib[3]} ^ {sbox_id, 1'b1};
      assign state_out[4*i+3:4*i] = rot ^ {nib[0], nib[3:1]};
    end
  endgenerate
endmodule
