// Running total shown on the display between operations.
module accumulator(
  input  wire        clk,
  input  wire        rst_n,
  input  wire        latch,
  input  wire        clear,
  input  wire [15:0] alu_result,
  output reg  [15:0] total
);
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      total <= 16'd0;
    else if (clear)
      total <= 16'd0;
    else if (latch)
      total <= alu_result;
  end
endmodule
