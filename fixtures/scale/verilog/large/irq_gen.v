// Edge-detects completion pulses into a level interrupt.
module irq_gen(
  input  wire        clk,
  input  wire        rst_n,
  input  wire [13:0] engine_done,
  input  wire [13:0] irq_mask,
  input  wire        ack,
  output reg         irq
);
  reg [13:0] seen;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      seen <= 14'd0;
      irq  <= 1'b0;
    end else begin
      seen <= engine_done & ~irq_mask;
      irq  <= ack ? 1'b0 : (irq | |(engine_done & ~seen & ~irq_mask));
    end
  end
endmodule
