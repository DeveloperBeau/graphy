module crypto_chip_top(
  input  wire        clk,
  input  wire        rst_n,
  input  wire        bus_sel,
  input  wire        bus_wr,
  input  wire [7:0]  bus_addr,
  input  wire [31:0] bus_wdata,
  output wire [31:0] bus_rdata,
  output wire        irq
);
  wire [7:0]   eng_sel;   wire kick, fifo_empty, fifo_full, rsa_done, x_done;
  wire [13:0]  eng_done, eng_clk_en;
  wire [31:0]  status, fifo_out;
  wire [127:0] aes_out_blk, hmac_tag, poly_tag, tf_out, sp_out;
  wire [63:0]  tdes_out, bf_out;
  wire [511:0] chacha_ks, b2_out;
  wire [255:0] sha_digest, sha3_digest_pad, rsa_out;
  wire [254:0] x_out;
  bus_slave     u_bus(clk, rst_n, bus_sel, bus_wr, bus_addr, bus_wdata, status, bus_rdata, eng_sel, kick);
  status_regs   u_status(clk, rst_n, eng_done, fifo_full, status);
  irq_gen       u_irq(clk, rst_n, eng_done, 14'd0, bus_addr == 8'hFC, irq);
  clk_gate_ctrl u_gate(clk, rst_n, {6'd0, eng_sel}, eng_clk_en);
  result_fifo   u_fifo(clk, rst_n, kick, aes_out_blk[31:0], bus_sel && !bus_wr, fifo_out, fifo_empty, fifo_full);

  aes_top      u_aes(clk, rst_n, kick, {4{bus_wdata}}, {4{bus_wdata}}, aes_out_blk);
  tdes_wrap    u_tdes(clk, rst_n, kick, 56'd1, 56'd2, 56'd3, {2{bus_wdata}}, tdes_out);
  chacha_top   u_chacha({8{bus_wdata}}, {3{bus_wdata}}, bus_wdata, chacha_ks);
  poly1305_top u_poly(clk, rst_n, kick, {8{bus_wdata}}, {4{bus_wdata}}, poly_tag);
  sha256_top   u_sha(clk, rst_n, kick, {16{bus_wdata}}, sha_digest);
  sha3_top     u_sha3({34{bus_wdata}}, {16{bus_wdata}}, sha3_digest_pad);
  blowfish_top u_bf(clk, rst_n, kick, {14{bus_wdata}}, {2{bus_wdata}}, bf_out);
  twofish_top  u_tf({2{bus_wdata}}, {4{bus_wdata}}, tf_out);
  serpent_top  u_sp({4{bus_wdata}}, {4{bus_wdata}}, sp_out);
  blake2_top   u_b2({16{bus_wdata}}, {8{bus_wdata}}, b2_out);
  hmac_top     u_hmac(clk, rst_n, kick, {8{bus_wdata}}, {16{bus_wdata}}, {4{32'hffffffff}}, hmac_tag);
  rsa_top      u_rsa(clk, rst_n, kick, {8{bus_wdata}}, {8{bus_wdata}}, {8{bus_wdata}}, rsa_out, rsa_done);
  x25519_top   u_x(clk, rst_n, kick, {8{bus_wdata}} >> 1, {8{bus_wdata}} >> 1, x_out, x_done);

  assign eng_done = {rsa_done, x_done, 12'hFFF};
endmodule
