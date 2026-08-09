// Sliding 16-word window generates the 64-entry schedule.
module sha_msg_sched(
  input  wire         clk,
  input  wire         rst_n,
  input  wire         load,
  input  wire [511:0] block_in,
  output wire [31:0]  w_out
);
  reg  [511:0] w;
  wire [31:0]  s0_out, s1_out;

  sha_ssig0 u_s0(w[479:448], s0_out);
  sha_ssig1 u_s1(w[63:32], s1_out);

  assign w_out = w[511:480];

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      w <= 512'd0;
    else if (load)
      w <= block_in;
    else
      w <= {w[479:0], w[511:480] + s0_out + w[223:192] + s1_out};
  end
endmodule
