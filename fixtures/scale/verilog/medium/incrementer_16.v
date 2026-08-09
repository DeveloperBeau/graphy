module incrementer_16(
  input  wire [15:0] a,
  output wire [15:0] result,
  output wire        wrap
);
  // Half-adder chain specialised for +1.
  wire [16:0] carry;

  assign carry[0] = 1'b1;
  assign result   = a ^ carry[15:0];
  assign carry[16:1] = a & carry[15:0];
  assign wrap     = carry[16];
endmodule
