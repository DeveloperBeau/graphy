module mont_reduce(
  input  wire [255:0] t_low,
  input  wire [255:0] modulus,
  output wire [255:0] reduced
);
  wire [255:0] diff;
  wire         borrow;

  bignum_sub u_sub(t_low, modulus, diff, borrow);

  // Final conditional subtraction into canonical range.
  assign reduced = borrow ? t_low : diff;
endmodule
