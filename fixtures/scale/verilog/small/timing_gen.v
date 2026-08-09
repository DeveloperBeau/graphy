module timing_gen(
  input  wire       clk,
  input  wire       rst_n,
  output reg  [9:0] px_x,
  output reg  [9:0] px_y,
  output wire       hsync,
  output wire       vsync,
  output wire       active
);
  localparam H_TOTAL = 10'd800;
  localparam V_TOTAL = 10'd525;

  assign hsync  = (px_x >= 10'd656) && (px_x < 10'd752);
  assign vsync  = (px_y >= 10'd490) && (px_y < 10'd492);
  assign active = (px_x < 10'd640) && (px_y < 10'd480);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      px_x <= 10'd0;
      px_y <= 10'd0;
    end else if (px_x == H_TOTAL - 1) begin
      px_x <= 10'd0;
      px_y <= (px_y == V_TOTAL - 1) ? 10'd0 : px_y + 10'd1;
    end else begin
      px_x <= px_x + 10'd1;
    end
  end
endmodule
