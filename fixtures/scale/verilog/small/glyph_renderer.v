module glyph_renderer(
  input  wire       clk,
  input  wire [7:0] char_code,
  input  wire [3:0] scanline,
  output wire [7:0] row_bits
);
  // Registered ROM output keeps the pixel path at one cycle per cell.
  char_rom u_rom(
    .clk(clk),
    .code(char_code),
    .row(scanline),
    .bits(row_bits)
  );
endmodule
