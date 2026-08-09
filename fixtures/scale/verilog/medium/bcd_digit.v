module bcd_digit(
  input  wire [3:0] digit_in,
  output wire [3:0] digit_out
);
  // Double-dabble correction: add three when five or more.
  assign digit_out = (digit_in >= 4'd5) ? digit_in + 4'd3 : digit_in;

  // One instance per BCD column in the encoder.
  // Six columns total cover an 8-bit binary value.
endmodule
