module des_ip(
  input  wire [63:0] block_in,
  output wire [63:0] block_out
);
  // Initial permutation: even columns first, bit-reversed rows.
  genvar i;
  generate
    for (i = 0; i < 32; i = i + 1) begin : g_ip
      assign block_out[63 - i] = block_in[63 - ((i * 2 + 1) % 64)];
      assign block_out[31 - i] = block_in[63 - ((i * 2) % 64)];
    end
  endgenerate
endmodule
