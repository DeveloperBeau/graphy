// Digit-recurrence square root, two radicand bits per step.
module sqrt_unit(
  input  wire        clk,
  input  wire        rst_n,
  input  wire        start,
  input  wire [15:0] radicand,
  output reg  [7:0]  root,
  output reg         done
);
  reg  [3:0]  step;
  reg  [15:0] rem;
  wire [15:0] trial = {root, 1'b1} << (2 * (4'd7 - step));
  wire [15:0] diff;
  wire        borrow;

  subtractor_16 u_sub(rem, trial, diff, borrow);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      root <= 8'd0;
      rem  <= 16'd0;
      step <= 4'd8;
      done <= 1'b0;
    end else if (start) begin
      root <= 8'd0;
      rem  <= radicand;
      step <= 4'd0;
      done <= 1'b0;
    end else if (step < 4'd8) begin
      rem  <= borrow ? rem : diff;
      root <= {root[6:0], ~borrow};
      step <= step + 4'd1;
      done <= (step == 4'd7);
    end
  end
endmodule
