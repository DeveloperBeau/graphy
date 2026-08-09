// DES round 8 of 16.
module des_round_8(
  input  wire [31:0] left_in,
  input  wire [31:0] right_in,
  input  wire [47:0] subkey,
  output wire [31:0] left_out,
  output wire [31:0] right_out
);
  localparam ROUND = 8;
  wire [31:0] f_out;

  des_feistel u_f(right_in, subkey, f_out);

  // Feistel swap: right half crosses over untouched.
  assign left_out  = right_in;
  assign right_out = left_in ^ f_out;
endmodule
