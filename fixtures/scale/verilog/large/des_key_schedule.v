// Rotating C/D halves produce one 48-bit subkey per round.
module des_key_schedule(
  input  wire         clk,
  input  wire         rst_n,
  input  wire         load,
  input  wire [55:0]  key56,
  output reg  [47:0]  subkey,
  output reg  [3:0]   round_no
);
  reg [27:0] c_half, d_half;
  wire one_shift = (round_no == 4'd0) || (round_no == 4'd1) ||
                   (round_no == 4'd8) || (round_no == 4'd15);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      c_half   <= 28'd0;
      d_half   <= 28'd0;
      subkey   <= 48'd0;
      round_no <= 4'd0;
    end else if (load) begin
      c_half   <= key56[55:28];
      d_half   <= key56[27:0];
      round_no <= 4'd0;
    end else begin
      c_half   <= one_shift ? {c_half[26:0], c_half[27]}
                            : {c_half[25:0], c_half[27:26]};
      d_half   <= one_shift ? {d_half[26:0], d_half[27]}
                            : {d_half[25:0], d_half[27:26]};
      subkey   <= {c_half[23:0], d_half[27:4]};
      round_no <= round_no + 4'd1;
    end
  end
endmodule
