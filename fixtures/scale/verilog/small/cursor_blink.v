module cursor_blink(
  input  wire        clk,
  input  wire        rst_n,
  input  wire [10:0] cell_addr,
  input  wire [10:0] cursor_addr,
  output wire        cursor_on
);
  reg [24:0] blink_ctr;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      blink_ctr <= 25'd0;
    else
      blink_ctr <= blink_ctr + 25'd1;
  end

  assign cursor_on = (cell_addr == cursor_addr) && blink_ctr[24];
endmodule
