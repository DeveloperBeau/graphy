// Triple-DES wrapper around three des_top instances.
module tdes_wrap(
  input  wire        clk,
  input  wire        rst_n,
  input  wire        load_key,
  input  wire [55:0] key_a,
  input  wire [55:0] key_b,
  input  wire [55:0] key_c,
  input  wire [63:0] block_in,
  output wire [63:0] block_out
);
  wire [63:0] stage_a, stage_b;

  // EDE keying order for two- and three-key operation.
  des_top u_enc1(clk, rst_n, load_key, key_a, block_in, stage_a);
  des_top u_dec(clk, rst_n, load_key, key_b, stage_a, stage_b);
  des_top u_enc2(clk, rst_n, load_key, key_c, stage_b, block_out);
endmodule
