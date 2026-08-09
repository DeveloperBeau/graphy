// Derives the 1 kHz scan tick from the 50 MHz core clock.
module clock_divider(
  input  wire clk,
  input  wire rst_n,
  output reg  tick_1k
);
  reg [15:0] count;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      count   <= 16'd0;
      tick_1k <= 1'b0;
    end else if (count == 16'd49999) begin
      count   <= 16'd0;
      tick_1k <= 1'b1;
    end else begin
      count   <= count + 16'd1;
      tick_1k <= 1'b0;
    end
  end
endmodule
