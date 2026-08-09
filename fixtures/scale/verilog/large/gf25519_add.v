// Addition in GF(2^255 - 19) with lazy carry fold.
module gf25519_add(
  input  wire [254:0] a,
  input  wire [254:0] b,
  output wire [254:0] sum
);
  wire [255:0] raw = {1'b0, a} + {1'b0, b};

  // Fold the carry back: 2^255 = 19 mod p.
  assign sum = raw[254:0] + (raw[255] ? 255'd19 : 255'd0);
endmodule
