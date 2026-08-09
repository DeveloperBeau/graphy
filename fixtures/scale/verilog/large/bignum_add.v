module bignum_add(
  input  wire [255:0] a,
  input  wire [255:0] b,
  input  wire         cin,
  output wire [255:0] sum,
  output wire         cout
);
  wire [256:0] wide = {1'b0, a} + {1'b0, b} + {256'd0, cin};

  assign sum  = wide[255:0];
  assign cout = wide[256];

  // Single-cycle limb adder; the sequencer walks wider numbers.
endmodule
