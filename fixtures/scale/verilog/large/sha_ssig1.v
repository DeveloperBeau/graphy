module sha_ssig1(
  input  wire [31:0] x,
  output wire [31:0] out
);
  // Small sigma 1: rot 17, rot 19, shift 10.
  // Applied to the word two positions back in the schedule.
  assign out = {x[16:0], x[31:17]}
             ^ {x[18:0], x[31:19]}
             ^ (x >> 10);
endmodule
