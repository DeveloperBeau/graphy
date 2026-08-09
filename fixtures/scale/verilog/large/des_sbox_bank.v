module des_sbox_bank(
  input  wire [47:0] chunk_in,
  output wire [31:0] folded
);
  // Eight 6-to-4 substitutions folded into one XOR network.
  genvar i;
  generate
    for (i = 0; i < 8; i = i + 1) begin : g_s
      wire [5:0] six = chunk_in[47 - 6*i -: 6];
      assign folded[31 - 4*i -: 4] =
        {six[5] ^ six[0], six[4] ^ six[1], six[3] ^ six[2], ^six};
    end
  endgenerate
endmodule
