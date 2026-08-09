// 8x16 bitmap glyph store, code page 437 layout.
module char_rom(
  input  wire       clk,
  input  wire [7:0] code,
  input  wire [3:0] row,
  output reg  [7:0] bits
);
  reg [7:0] rom [0:4095];

  initial begin
    $readmemh("glyphs_8x16.hex", rom);
  end

  always @(posedge clk)
    bits <= rom[{code, row}];
endmodule
