// Expands and masks the key for the inner or outer hash.
module hmac_pad(
  input  wire [255:0] key_in,
  input  wire         outer,
  output wire [511:0] padded
);
  // ipad = 0x36 repeated, opad = 0x5c repeated.
  wire [511:0] pad_const = outer ? {64{8'h5c}} : {64{8'h36}};

  assign padded = {key_in, 256'd0} ^ pad_const;
endmodule
