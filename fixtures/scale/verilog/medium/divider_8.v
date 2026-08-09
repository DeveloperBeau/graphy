// Restoring divider, one quotient bit per cycle.
module divider_8(
  input  wire       clk,
  input  wire       rst_n,
  input  wire       start,
  input  wire [7:0] dividend,
  input  wire [7:0] divisor,
  output reg  [7:0] quotient,
  output reg  [7:0] remainder,
  output reg        done
);
  reg [3:0] step;
  wire [8:0] trial = {remainder[6:0], quotient[7]} - {1'b0, divisor};

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      quotient  <= 8'd0;
      remainder <= 8'd0;
      step      <= 4'd8;
      done      <= 1'b0;
    end else if (start) begin
      quotient  <= dividend;
      remainder <= 8'd0;
      step      <= 4'd0;
      done      <= 1'b0;
    end else if (step < 4'd8) begin
      remainder <= trial[8] ? {remainder[6:0], quotient[7]} : trial[7:0];
      quotient  <= {quotient[6:0], ~trial[8]};
      step      <= step + 4'd1;
      done      <= (step == 4'd7);
    end
  end
endmodule
