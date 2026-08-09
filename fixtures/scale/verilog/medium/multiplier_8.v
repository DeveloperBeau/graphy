// Shift-and-add multiplier, one partial product per cycle.
module multiplier_8(
  input  wire        clk,
  input  wire        rst_n,
  input  wire        start,
  input  wire [7:0]  a,
  input  wire [7:0]  b,
  output reg  [15:0] product,
  output reg         done
);
  reg [3:0]   step;
  wire [15:0] shifted = {8'd0, a} << step[2:0];
  wire [15:0] next_acc;
  wire        cout;

  ripple_adder_16 u_acc(product, b[step[2:0]] ? shifted : 16'd0, 1'b0, next_acc, cout);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      product <= 16'd0;
      step    <= 4'd8;
      done    <= 1'b0;
    end else if (start) begin
      product <= 16'd0;
      step    <= 4'd0;
      done    <= 1'b0;
    end else if (step < 4'd8) begin
      product <= next_acc;
      step    <= step + 4'd1;
      done    <= (step == 4'd7);
    end
  end
endmodule
