module des_pbox(
  input  wire [31:0] mixed_in,
  output wire [31:0] permuted
);
  // P permutation spreads each S-box nibble across the word.
  genvar i;
  generate
    for (i = 0; i < 32; i = i + 1) begin : g_p
      assign permuted[31 - i] = mixed_in[31 - ((i * 7 + 5) % 32)];
    end
  endgenerate
endmodule
