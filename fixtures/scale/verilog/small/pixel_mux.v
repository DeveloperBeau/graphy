// Blanks the output outside the active region.
module pixel_mux(
  input  wire       clk,
  input  wire [3:0] colour,
  input  wire       active,
  output reg  [3:0] pixel
);
  always @(posedge clk)
    pixel <= active ? colour : 4'd0;
endmodule
