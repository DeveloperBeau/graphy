// Text-mode display pipeline: 80x30 cells, 8x16 glyphs.
module display_top(
  input  wire        clk,
  input  wire        rst_n,
  input  wire        host_wr,
  input  wire [7:0]  host_data,
  output wire        hsync,
  output wire        vsync,
  output wire [3:0]  pixel
);
  wire [9:0]  px_x, px_y;
  wire        active;
  wire [7:0]  char_code, attr, wr_char;
  wire [10:0] cell_addr, wr_addr;
  wire        cursor_on, wr_en;
  wire [7:0]  glyph_row;
  wire [3:0]  fg_idx, bg_idx, glyph_px;
  wire [3:0]  scroll_line;

  timing_gen     u_timing(clk, rst_n, px_x, px_y, hsync, vsync, active);
  host_if        u_host(clk, rst_n, host_wr, host_data, wr_en, wr_addr, wr_char);
  scroll_ctrl    u_scroll(clk, rst_n, wr_en, wr_addr, scroll_line);
  vram           u_vram(clk, wr_en, wr_addr, wr_char, cell_addr, char_code, attr);
  glyph_renderer u_glyph(clk, char_code, px_y[3:0], glyph_row);
  cursor_blink   u_cursor(clk, rst_n, cell_addr, wr_addr, cursor_on);
  attr_decoder   u_attr(attr, cursor_on, fg_idx, bg_idx);
  palette_lut    u_pal(clk, glyph_row[7 - px_x[2:0]] & active, fg_idx, bg_idx, glyph_px);
  pixel_mux      u_mux(clk, glyph_px, active, pixel);
  line_buffer    u_line(clk, px_x, px_y, scroll_line, cell_addr);
endmodule
