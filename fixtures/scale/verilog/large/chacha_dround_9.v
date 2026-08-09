// ChaCha double round 9 of 10: columns then diagonals.
module chacha_dround_9(
  input  wire [511:0] s_in,
  output wire [511:0] s_out
);
  localparam DROUND = 9;
  wire [511:0] c;

  // Column pass.
  chacha_qround q0(s_in[511:480], s_in[383:352], s_in[255:224], s_in[127:96], c[511:480], c[383:352], c[255:224], c[127:96]);
  chacha_qround q1(s_in[479:448], s_in[351:320], s_in[223:192], s_in[95:64], c[479:448], c[351:320], c[223:192], c[95:64]);
  chacha_qround q2(s_in[447:416], s_in[319:288], s_in[191:160], s_in[63:32], c[447:416], c[319:288], c[191:160], c[63:32]);
  chacha_qround q3(s_in[415:384], s_in[287:256], s_in[159:128], s_in[31:0], c[415:384], c[287:256], c[159:128], c[31:0]);

  // Diagonal pass.
  chacha_qround q4(c[511:480], c[351:320], c[191:160], c[31:0], s_out[511:480], s_out[351:320], s_out[191:160], s_out[31:0]);
  chacha_qround q5(c[479:448], c[319:288], c[159:128], c[127:96], s_out[479:448], s_out[319:288], s_out[159:128], s_out[127:96]);
  chacha_qround q6(c[447:416], c[287:256], c[255:224], c[95:64], s_out[447:416], s_out[287:256], s_out[255:224], s_out[95:64]);
  chacha_qround q7(c[415:384], c[383:352], c[223:192], c[63:32], s_out[415:384], s_out[383:352], s_out[223:192], s_out[63:32]);
endmodule
