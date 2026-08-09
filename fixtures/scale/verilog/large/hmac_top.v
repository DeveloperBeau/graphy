// Full MAC with optional 128-bit truncation.
module hmac_top(
  input  wire         clk,
  input  wire         rst_n,
  input  wire         load,
  input  wire [255:0] key_in,
  input  wire [511:0] msg_block,
  input  wire [127:0] trunc_mask,
  output wire [127:0] tag
);
  wire [255:0] full_mac;

  hmac_core u_core(clk, rst_n, load, key_in, msg_block, full_mac);

  // Truncated-tag deployments keep the leftmost bits.
  assign tag = full_mac[255:128] & trunc_mask;
endmodule
