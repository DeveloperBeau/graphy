// RSA primitive: one modular exponentiation per operation.
module rsa_top(
  input  wire         clk,
  input  wire         rst_n,
  input  wire         start,
  input  wire [255:0] message,
  input  wire [255:0] exponent,
  input  wire [255:0] modulus,
  output wire [255:0] ciphertext,
  output wire         done
);
  // Raw modexp; padding is the driver software's job.
  modexp_seq u_exp(
    clk, rst_n, start,
    message, exponent, modulus,
    ciphertext, done
  );
endmodule
