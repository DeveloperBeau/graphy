module scroll_ctrl(
  input  wire        clk,
  input  wire        rst_n,
  input  wire        wr_en,
  input  wire [10:0] wr_addr,
  output reg  [3:0]  scroll_line
);
  localparam LAST_CELL = 11'd2399;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      scroll_line <= 4'd0;
    else if (wr_en && wr_addr == LAST_CELL)
      scroll_line <= scroll_line + 4'd1;
  end
endmodule
