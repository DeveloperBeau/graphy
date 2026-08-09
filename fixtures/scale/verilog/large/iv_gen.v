// Never-repeating nonce: fixed seed plus invocation counter.
module iv_gen(
  input  wire        clk,
  input  wire        rst_n,
  input  wire        fresh,
  input  wire [63:0] seed,
  output reg  [95:0] iv
);
  reg [31:0] counter;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      iv      <= 96'd0;
      counter <= 32'd0;
    end else if (fresh) begin
      counter <= counter + 32'd1;
      iv      <= {seed, counter};
    end
  end
endmodule
