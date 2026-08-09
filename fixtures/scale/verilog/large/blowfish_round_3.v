// Blowfish Feistel round 3 of 16.
module blowfish_round_3(
  input  wire [31:0] left_in,
  input  wire [31:0] right_in,
  input  wire [31:0] p_entry,
  output wire [31:0] left_out,
  output wire [31:0] right_out
);
  localparam ROUND = 3;
  wire [31:0] mixed = left_in ^ p_entry;
  wire [31:0] f_out;

  bf_ffunc u_f(mixed, f_out);

  assign left_out  = right_in ^ f_out;
  assign right_out = mixed;
endmodule
