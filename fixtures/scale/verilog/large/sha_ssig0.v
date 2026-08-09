module sha_ssig0(
  input  wire [31:0] x,
  output wire [31:0] out
);
  // Small sigma 0: rot 7, rot 18, shift 3.
  // Applied to the word sixteen positions back in the schedule.
  assign out = {x[6:0], x[31:7]}
             ^ {x[17:0], x[31:18]}
             ^ (x >> 3);
endmodule
