// Payload filler only; never used for key material.
module lfsr_prng(
  input  wire        clk,
  input  wire        rst_n,
  input  wire        step,
  output reg  [31:0] value
);
  wire feedback = value[31] ^ value[21] ^ value[1] ^ value[0];

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      value <= 32'hACE1_2026;
    else if (step)
      value <= {value[30:0], feedback};
  end
endmodule
