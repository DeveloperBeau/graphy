// CTR-mode counter block increment.
module ctr_inc(
  input  wire [127:0] block_in,
  output wire [127:0] block_out
);
  // Big-endian increment of the low 32-bit counter word.
  wire [31:0] ctr = {block_in[7:0], block_in[15:8],
                     block_in[23:16], block_in[31:24]};
  wire [31:0] bumped = ctr + 32'd1;

  assign block_out = {block_in[127:32], bumped[7:0], bumped[15:8],
                      bumped[23:16], bumped[31:24]};
endmodule
