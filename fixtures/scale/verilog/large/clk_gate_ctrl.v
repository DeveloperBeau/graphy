// One registered enable per engine; idle families stop toggling.
module clk_gate_ctrl(
  input  wire        clk,
  input  wire        rst_n,
  input  wire [13:0] engine_active,
  output reg  [13:0] engine_clk_en
);
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      engine_clk_en <= 14'd0;
    else
      engine_clk_en <= engine_active;
  end
endmodule
