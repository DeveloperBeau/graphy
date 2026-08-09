module sha_ch(
  input  wire [31:0] e,
  input  wire [31:0] f,
  input  wire [31:0] g,
  output wire [31:0] out
);
  // Choose: e selects between f and g bitwise.
  assign out = (e & f) ^ (~e & g);

  // One of the two SHA-256 boolean selectors.
endmodule
