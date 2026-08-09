module flags_unit(
  input  wire [15:0] result,
  input  wire        sign_a,
  input  wire        sign_b,
  input  wire        subtracting,
  output wire        flag_zero,
  output wire        flag_negative,
  output wire        flag_overflow
);
  zero_detect     u_zero(result, flag_zero);
  overflow_detect u_ovf(sign_a, sign_b, result[15], subtracting, flag_overflow);

  assign flag_negative = result[15];
endmodule
