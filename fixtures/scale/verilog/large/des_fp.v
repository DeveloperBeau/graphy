module des_fp(
  input  wire [63:0] block_in,
  output wire [63:0] block_out
);
  // Final permutation: exact inverse of the initial one.
  genvar i;
  generate
    for (i = 0; i < 32; i = i + 1) begin : g_fp
      assign block_out[63 - ((i * 2 + 1) % 64)] = block_in[63 - i];
      assign block_out[63 - ((i * 2) % 64)] = block_in[31 - i];
    end
  endgenerate
endmodule
