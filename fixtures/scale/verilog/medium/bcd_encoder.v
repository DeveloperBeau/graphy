// Shift-add-3 stages of a binary to BCD converter.
module bcd_encoder(
  input  wire [7:0]  binary,
  output wire [11:0] bcd
);
  wire [3:0] h0, t0, u0;
  wire [3:0] h1, t1, u1;

  // Two correction layers cover an 8-bit input range.
  bcd_digit u_u0({3'd0, binary[7]}, u0);
  bcd_digit u_t0(4'd0, t0);
  bcd_digit u_h0(4'd0, h0);
  bcd_digit u_u1({u0[2:0], binary[6]}, u1);
  bcd_digit u_t1({t0[2:0], u0[3]}, t1);
  bcd_digit u_h1({h0[2:0], t0[3]}, h1);

  assign bcd = {h1, t1, {u1[2:0], binary[5]}};
endmodule
