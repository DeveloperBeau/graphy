// One BLAKE2b round: column pass then diagonal pass.
module blake2_mix(
  input  wire [511:0] v_in,
  input  wire [255:0] msg_words,
  output wire [511:0] v_out
);
  wire [511:0] col;

  // Column mixing: four independent G applications.
  blake2_g g0(v_in[511:448], v_in[383:320], v_in[255:192], v_in[127:64], msg_words[255:192], msg_words[191:128], col[511:448], col[383:320], col[255:192], col[127:64]);
  blake2_g g1(v_in[447:384], v_in[319:256], v_in[191:128], v_in[63:0], msg_words[127:64], msg_words[63:0], col[447:384], col[319:256], col[191:128], col[63:0]);

  // Diagonal mixing on the rotated view.
  blake2_g g2(col[511:448], col[319:256], col[127:64], col[191:128], msg_words[255:192], msg_words[63:0], v_out[511:448], v_out[319:256], v_out[127:64], v_out[191:128]);
  blake2_g g3(col[447:384], col[383:320], col[63:0], col[255:192], msg_words[191:128], msg_words[127:64], v_out[447:384], v_out[383:320], v_out[63:0], v_out[255:192]);
endmodule
