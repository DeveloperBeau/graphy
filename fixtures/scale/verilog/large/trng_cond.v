// Von Neumann-style whitening of the raw entropy line.
module trng_cond(
  input  wire       clk,
  input  wire       rst_n,
  input  wire       raw_bit,
  output reg  [7:0] whitened,
  output reg        byte_valid
);
  reg [3:0] bit_cnt;
  reg       last;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      whitened   <= 8'd0;
      bit_cnt    <= 4'd0;
      last       <= 1'b0;
      byte_valid <= 1'b0;
    end else begin
      last       <= raw_bit;
      whitened   <= {whitened[6:0], raw_bit ^ last};
      bit_cnt    <= bit_cnt + 4'd1;
      byte_valid <= (bit_cnt == 4'd7);
    end
  end
endmodule
