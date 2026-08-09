// Bit-serial Montgomery multiply with interleaved reduction.
module mont_mul(
  input  wire         clk,
  input  wire         rst_n,
  input  wire         start,
  input  wire [255:0] x,
  input  wire [255:0] y,
  input  wire [255:0] modulus,
  output reg  [255:0] result,
  output reg          done
);
  reg  [8:0]   step;
  wire [255:0] doubled, reduced, added;
  wire         c0, spill, borrow;

  bignum_shl u_dbl(result, 8'd1, doubled, spill);
  bignum_add u_add(doubled, x[255] ? y : 256'd0, 1'b0, added, c0);
  bignum_sub u_red(added, modulus, reduced, borrow);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      result <= 256'd0;
      step   <= 9'd256;
      done   <= 1'b0;
    end else if (start) begin
      result <= 256'd0;
      step   <= 9'd0;
      done   <= 1'b0;
    end else if (step < 9'd256) begin
      result <= borrow ? added : reduced;
      step   <= step + 9'd1;
      done   <= (step == 9'd255);
    end
  end
endmodule
