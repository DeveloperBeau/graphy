// Time-multiplexes four digits through one decoder.
module display_scan(
  input  wire        clk,
  input  wire        rst_n,
  input  wire [15:0] value,
  output wire [6:0]  segments,
  output reg  [3:0]  digit_sel
);
  reg  [1:0]  idx;
  wire [3:0]  nibble = value[{idx, 2'b00} +: 4];

  seven_seg_decoder u_seg(nibble, segments);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      idx       <= 2'd0;
      digit_sel <= 4'b1110;
    end else begin
      idx       <= idx + 2'd1;
      digit_sel <= {digit_sel[2:0], digit_sel[3]};
    end
  end
endmodule
