// Holds the running MAC state between message blocks.
module poly1305_acc(
  input  wire         clk,
  input  wire         rst_n,
  input  wire         absorb,
  input  wire [127:0] block_in,
  input  wire [129:0] mul_result,
  output reg  [129:0] acc
);
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      acc <= 130'd0;
    else if (absorb)
      acc <= mul_result + {1'b1, block_in, 1'b0};
  end
endmodule
