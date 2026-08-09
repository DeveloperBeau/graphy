// 4000-cycle settle filter for mechanical key contacts.
module debounce(
  input  wire clk,
  input  wire rst_n,
  input  wire raw,
  output reg  stable
);
  reg [11:0] count;
  reg        sync;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      count  <= 12'd0;
      sync   <= 1'b0;
      stable <= 1'b0;
    end else begin
      sync <= raw;
      if (sync == stable)
        count <= 12'd0;
      else if (count == 12'd4000)
        stable <= sync;
      else
        count <= count + 12'd1;
    end
  end
endmodule
