// Square-and-multiply ladder driving the Montgomery unit.
module modexp_seq(
  input  wire         clk,
  input  wire         rst_n,
  input  wire         start,
  input  wire [255:0] base,
  input  wire [255:0] exponent,
  input  wire [255:0] modulus,
  output reg  [255:0] result,
  output reg          done
);
  reg  [8:0]   bit_idx;
  reg          phase;
  wire [255:0] mul_out;
  wire         mul_done;

  mont_mul u_mul(clk, rst_n, start || (phase && mul_done),
                 phase ? result : base, result, modulus, mul_out, mul_done);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      result  <= 256'd1;
      bit_idx <= 9'd256;
      phase   <= 1'b0;
      done    <= 1'b0;
    end else if (start) begin
      result  <= 256'd1;
      bit_idx <= 9'd0;
      phase   <= 1'b0;
      done    <= 1'b0;
    end else if (mul_done && bit_idx < 9'd256) begin
      result  <= exponent[bit_idx[7:0]] || phase ? mul_out : result;
      phase   <= ~phase;
      bit_idx <= phase ? bit_idx + 9'd1 : bit_idx;
      done    <= (bit_idx == 9'd255) && phase;
    end
  end
endmodule
