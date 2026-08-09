module attr_decoder(
  input  wire [7:0] attr,
  input  wire       cursor_on,
  output wire [3:0] fg_idx,
  output wire [3:0] bg_idx
);
  wire [3:0] raw_fg = attr[3:0];
  wire [3:0] raw_bg = attr[7:4];

  // Cursor inverts the cell colours.
  assign fg_idx = cursor_on ? raw_bg : raw_fg;
  assign bg_idx = cursor_on ? raw_fg : raw_bg;
endmodule
