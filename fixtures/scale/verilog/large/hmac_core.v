// HMAC-SHA256: nested hashes over padded keys.
module hmac_core(
  input  wire         clk,
  input  wire         rst_n,
  input  wire         load,
  input  wire [255:0] key_in,
  input  wire [511:0] msg_block,
  output wire [255:0] mac_out
);
  wire [511:0] ipad_block, opad_block;
  wire [255:0] inner_digest;

  hmac_pad   u_ipad(key_in, 1'b0, ipad_block);
  hmac_pad   u_opad(key_in, 1'b1, opad_block);
  sha256_top u_inner(clk, rst_n, load, ipad_block ^ msg_block, inner_digest);
  sha256_top u_outer(clk, rst_n, load, opad_block ^ {inner_digest, 256'd0}, mac_out);
endmodule
