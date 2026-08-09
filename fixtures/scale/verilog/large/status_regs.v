// Sticky-free live view of every engine's done line.
module status_regs(
  input  wire        clk,
  input  wire        rst_n,
  input  wire [13:0] engine_done,
  input  wire        fifo_full,
  output reg  [31:0] status_word
);
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      status_word <= 32'd0;
    else
      status_word <= {17'd0, fifo_full, engine_done};
  end
endmodule
