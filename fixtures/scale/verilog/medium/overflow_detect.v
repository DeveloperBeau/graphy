module overflow_detect(
  input  wire sign_a,
  input  wire sign_b,
  input  wire sign_result,
  input  wire subtracting,
  output wire overflow
);
  wire effective_sign_b = sign_b ^ subtracting;

  // Overflow: operands agree in sign, result disagrees.
  assign overflow = (sign_a == effective_sign_b) &&
                    (sign_result != sign_a);
endmodule
