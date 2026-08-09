module mix_columns(
  input  wire [127:0] state_in,
  output wire [127:0] state_out
);
  // xtime on every byte, then the column mixing pattern.
  wire [127:0] dbl;
  genvar i;
  generate
    for (i = 0; i < 16; i = i + 1) begin : g_xtime
      assign dbl[8*i+7:8*i] = {state_in[8*i+6:8*i], 1'b0}
                              ^ (state_in[8*i+7] ? 8'h1b : 8'h00);
    end
  endgenerate

  assign state_out = dbl ^ {state_in[95:0], state_in[127:96]}
                   ^ {state_in[63:0], state_in[127:64]}
                   ^ {dbl[95:0], dbl[127:96]};
endmodule
