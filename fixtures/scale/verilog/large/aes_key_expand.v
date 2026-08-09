// On-the-fly AES-128 key schedule, one round key per cycle.
module aes_key_expand(
  input  wire         clk,
  input  wire         rst_n,
  input  wire         load,
  input  wire [127:0] cipher_key,
  output reg  [127:0] round_key,
  output reg  [3:0]   round_idx
);
  wire [31:0] rotated = {round_key[23:0], round_key[31:24]};
  wire [31:0] subbed;
  wire [7:0]  rcon = 8'h01 << round_idx[2:0];

  aes_sub_word u_sw(rotated, subbed);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      round_key <= 128'd0;
      round_idx <= 4'd0;
    end else if (load) begin
      round_key <= cipher_key;
      round_idx <= 4'd0;
    end else begin
      round_key <= {round_key[127:96] ^ subbed ^ {rcon, 24'd0},
                    round_key[95:0] ^ round_key[127:32]};
      round_idx <= round_idx + 4'd1;
    end
  end
endmodule
