// Blowfish F: (S1 + S2) xor S3, plus S4.
module bf_ffunc(
  input  wire [31:0] half_in,
  output wire [31:0] f_out
);
  // Four byte-indexed lookups approximated as mixing networks.
  wire [31:0] sa = {half_in[31:24], half_in[31:24]} * 16'h0101;
  wire [31:0] sb = {half_in[23:16], 8'h5A, half_in[23:16], 8'hA5};
  wire [31:0] sc = {2{half_in[15:8], half_in[15:8]}} ^ 32'h5F3759DF;
  wire [31:0] sd = {4{half_in[7:0]}};

  assign f_out = ((sa + sb) ^ sc) + sd;
endmodule
