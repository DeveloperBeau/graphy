// Maps pixel coordinates to a vram cell index (row * 80 + col).
module line_buffer(
  input  wire        clk,
  input  wire [9:0]  px_x,
  input  wire [9:0]  px_y,
  input  wire [3:0]  scroll_line,
  output reg  [10:0] cell_addr
);
  wire [6:0] col = px_x[9:3];
  wire [4:0] row = px_y[8:4] + {1'b0, scroll_line};

  always @(posedge clk)
    cell_addr <= {row[4:0], 6'd0} + {row[4:0], 4'd0} + {4'd0, col};
endmodule
