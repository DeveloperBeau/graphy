// Branch-free conditional swap for the Montgomery ladder.
module cswap(
  input  wire         swap_bit,
  input  wire [254:0] a_in,
  input  wire [254:0] b_in,
  output wire [254:0] a_out,
  output wire [254:0] b_out
);
  // Constant-time swap: mask-and-xor, no branches.
  wire [254:0] mask = {255{swap_bit}};
  wire [254:0] t = (a_in ^ b_in) & mask;

  assign a_out = a_in ^ t;
  assign b_out = b_in ^ t;
endmodule
