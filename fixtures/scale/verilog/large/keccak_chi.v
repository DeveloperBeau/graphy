// Chi step: the only nonlinear layer in Keccak.
module keccak_chi(
  input  wire [1599:0] s_in,
  output wire [1599:0] s_out
);
  // Row-wise nonlinear mix: a ^= (~b & c) along each row.
  genvar y, x;
  generate
    for (y = 0; y < 5; y = y + 1) begin : g_row
      for (x = 0; x < 5; x = x + 1) begin : g_col
        assign s_out[64*(5*y+x)+63:64*(5*y+x)] =
          s_in[64*(5*y+x)+63:64*(5*y+x)]
          ^ (~s_in[64*(5*y+(x+1)%5)+63:64*(5*y+(x+1)%5)]
             & s_in[64*(5*y+(x+2)%5)+63:64*(5*y+(x+2)%5)]);
      end
    end
  endgenerate
endmodule
