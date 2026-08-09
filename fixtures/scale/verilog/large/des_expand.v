module des_expand(
  input  wire [31:0] half_in,
  output wire [47:0] expanded
);
  // E-box: 32 bits stretch to 48 by duplicating block edges.
  genvar i;
  generate
    for (i = 0; i < 8; i = i + 1) begin : g_e
      assign expanded[47 - 6*i -: 6] = {half_in[(32 - 4*i) % 32],
                                        half_in[31 - 4*i -: 4],
                                        half_in[(27 - 4*i + 32) % 32]};
    end
  endgenerate
endmodule
