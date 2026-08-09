// Radix-4 Booth multiplier: eight recoded partial products.
module booth_multiplier_16(
  input  wire        clk,
  input  wire        rst_n,
  input  wire        start,
  input  wire [15:0] a,
  input  wire [15:0] b,
  output reg  [31:0] product,
  output reg         done
);
  reg  [3:0]  step;
  wire [1:0]  mag;
  wire        neg;
  wire [31:0] pp_raw = {16'd0, a} << {step, 1'b0};
  wire [31:0] pp = (mag == 2'd0) ? 32'd0 :
                   (mag == 2'd1) ? pp_raw : (pp_raw << 1);
  wire [31:0] addend = neg ? (~pp + 32'd1) : pp;
  wire [31:0] next_acc;
  wire        cout;

  booth_encoder   u_enc({b[{step, 1'b1}], b[{step, 1'b0}], (step == 4'd0) ? 1'b0 : b[{step, 1'b0} - 1]}, mag, neg);
  ripple_adder_32 u_acc(product, addend, 1'b0, next_acc, cout);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      product <= 32'd0;
      step    <= 4'd8;
      done    <= 1'b0;
    end else if (start) begin
      product <= 32'd0;
      step    <= 4'd0;
      done    <= 1'b0;
    end else if (step < 4'd8) begin
      product <= next_acc;
      step    <= step + 4'd1;
      done    <= (step == 4'd7);
    end
  end
endmodule
