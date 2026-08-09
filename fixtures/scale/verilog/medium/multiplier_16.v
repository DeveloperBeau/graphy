// 16x16 shift-and-add multiplier.
module multiplier_16(
  input  wire        clk,
  input  wire        rst_n,
  input  wire        start,
  input  wire [15:0] a,
  input  wire [15:0] b,
  output reg  [31:0] product,
  output reg         done
);
  reg [4:0]   step;
  wire [31:0] shifted = {16'd0, a} << step[3:0];
  wire [31:0] next_acc;
  wire        cout;

  ripple_adder_32 u_acc(product, b[step[3:0]] ? shifted : 32'd0, 1'b0, next_acc, cout);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      product <= 32'd0;
      step    <= 5'd16;
      done    <= 1'b0;
    end else if (start) begin
      product <= 32'd0;
      step    <= 5'd0;
      done    <= 1'b0;
    end else if (step < 5'd16) begin
      product <= next_acc;
      step    <= step + 5'd1;
      done    <= (step == 5'd15);
    end
  end
endmodule
