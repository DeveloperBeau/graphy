module fixed_point_scaler(
  input  wire [15:0] value,
  input  wire [3:0]  fraction_bits,
  output wire [15:0] integer_part
);
  // Arithmetic shift preserves the sign of fixed-point values.
  // fraction_bits selects how many low bits count as the fractional part.
  // Used to convert accumulator readings before they hit the display.
  shifter_right_16 u_shift(value, fraction_bits, 1'b1, integer_part);
endmodule
