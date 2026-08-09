module rounding_unit(
  input  wire [15:0] mantissa,
  input  wire        guard,
  input  wire        sticky,
  output wire [15:0] rounded,
  output wire        overflow
);
  // Round-to-nearest-even on the guard/sticky pair.
  wire round_up = guard & (sticky | mantissa[0]);
  wire [16:0] bumped = {1'b0, mantissa} + {16'd0, round_up};

  assign rounded  = bumped[15:0];
  assign overflow = bumped[16];
endmodule
