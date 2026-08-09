// 16-bit restoring divider around the shared subtractor.
module divider_16(
  input  wire        clk,
  input  wire        rst_n,
  input  wire        start,
  input  wire [15:0] dividend,
  input  wire [15:0] divisor,
  output reg  [15:0] quotient,
  output reg  [15:0] remainder,
  output reg         done
);
  reg  [4:0]  step;
  wire [15:0] shifted = {remainder[14:0], quotient[15]};
  wire [15:0] diff;
  wire        borrow;

  subtractor_16 u_sub(shifted, divisor, diff, borrow);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      quotient  <= 16'd0;
      remainder <= 16'd0;
      step      <= 5'd16;
      done      <= 1'b0;
    end else if (start) begin
      quotient  <= dividend;
      remainder <= 16'd0;
      step      <= 5'd0;
      done      <= 1'b0;
    end else if (step < 5'd16) begin
      remainder <= borrow ? shifted : diff;
      quotient  <= {quotient[14:0], ~borrow};
      step      <= step + 5'd1;
      done      <= (step == 5'd15);
    end
  end
endmodule
