// Dual-plane text buffer: 80x30 characters plus attributes.
module vram(
  input  wire        clk,
  input  wire        wr_en,
  input  wire [10:0] wr_addr,
  input  wire [7:0]  wr_data,
  input  wire [10:0] rd_addr,
  output reg  [7:0]  char_code,
  output reg  [7:0]  attr
);
  reg [7:0] chars [0:2399];
  reg [7:0] attrs [0:2399];

  always @(posedge clk) begin
    if (wr_en)
      chars[wr_addr] <= wr_data;
    char_code <= chars[rd_addr];
    attr      <= attrs[rd_addr];
  end
endmodule
