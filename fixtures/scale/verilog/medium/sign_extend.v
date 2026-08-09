module sign_extend(
  input  wire [7:0]  narrow,
  output wire [15:0] wide
);
  // Replicate the sign bit across the upper half.
  assign wide = {{8{narrow[7]}}, narrow};

  // Byte-entry mode feeds the 16-bit datapath through here.
  // Digit keys stay unsigned; only the +/- key exercises this path.
endmodule
