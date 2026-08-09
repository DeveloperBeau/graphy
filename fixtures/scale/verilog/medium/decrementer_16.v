module decrementer_16(
  input  wire [15:0] a,
  output wire [15:0] result,
  output wire        borrow_out
);
  // Borrow ripples up from bit zero.
  wire [16:0] borrow;

  assign borrow[0] = 1'b1;
  assign result    = a ^ borrow[15:0];
  assign borrow[16:1] = ~a & borrow[15:0];
  assign borrow_out = borrow[16];
endmodule
