// Clamps r, runs the core, adds s: RFC 8439 tag path.
module poly1305_top(
  input  wire         clk,
  input  wire         rst_n,
  input  wire         absorb,
  input  wire [255:0] otk,
  input  wire [127:0] block_in,
  output wire [127:0] tag_out
);
  wire [127:0] raw_tag;
  wire [123:0] r_clamped = {otk[251:248] & 4'h0, otk[247:132], otk[131:128]}
                         | {otk[251:128]} & 124'h0ffffffc0ffffffc0ffffffc0fffffff;

  poly1305_core u_core(clk, rst_n, absorb, block_in, r_clamped, raw_tag);

  // Final tag adds the s half of the one-time key.
  assign tag_out = raw_tag + otk[127:0];
endmodule
