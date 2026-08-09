module zero_detect(
  input  wire [15:0] value,
  output wire        is_zero
);
  // Wide NOR: true only when every bit is clear.
  assign is_zero = ~(|value);

  // Kept as its own unit so the flag path is one gate deep.
  // flags_unit instantiates this alongside overflow_detect.
endmodule
