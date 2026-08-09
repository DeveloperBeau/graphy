module tf_pht(
  input  wire [31:0] a_in,
  input  wire [31:0] b_in,
  output wire [31:0] a_out,
  output wire [31:0] b_out
);
  // Pseudo-Hadamard transform mixes the two g outputs.
  assign a_out = a_in + b_in;
  assign b_out = a_in + (b_in << 1);
endmodule
