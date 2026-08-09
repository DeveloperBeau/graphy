// Bit-serial field multiply: double-and-add over the prime field.
module gf25519_mul(
  input  wire         clk,
  input  wire         rst_n,
  input  wire         start,
  input  wire [254:0] a,
  input  wire [254:0] b,
  output reg  [254:0] product,
  output reg          done
);
  reg [8:0] step;
  wire [254:0] doubled, accum;

  gf25519_add u_dbl(product, product, doubled);
  gf25519_add u_acc(doubled, b[254] ? a : 255'd0, accum);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      product <= 255'd0;
      step    <= 9'd255;
      done    <= 1'b0;
    end else if (start) begin
      product <= 255'd0;
      step    <= 9'd0;
      done    <= 1'b0;
    end else if (step < 9'd255) begin
      product <= accum;
      step    <= step + 9'd1;
      done    <= (step == 9'd254);
    end
  end
endmodule
