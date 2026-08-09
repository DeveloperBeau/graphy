// One-cycle registered foreground/background select.
module palette_lut(
  input  wire       clk,
  input  wire       glyph_bit,
  input  wire [3:0] fg_idx,
  input  wire [3:0] bg_idx,
  output reg  [3:0] colour
);
  always @(posedge clk)
    colour <= glyph_bit ? fg_idx : bg_idx;
endmodule
