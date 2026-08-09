// Applies keystream to plaintext with tail-byte masking.
module xor_stream(
  input  wire [127:0] keystream,
  input  wire [127:0] data_in,
  input  wire [4:0]   valid_bytes,
  output wire [127:0] data_out
);
  // Mask keeps trailing bytes of a short final block untouched.
  wire [127:0] mask = ~(128'hffffffffffffffffffffffffffffffff
                        >> {valid_bytes, 3'b000});

  assign data_out = data_in ^ (keystream & ~mask);
endmodule
