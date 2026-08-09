// Theta step of the Keccak-f[1600] permutation.
module keccak_theta(
  input  wire [1599:0] s_in,
  output wire [1599:0] s_out
);
  // Column parity mixed back into every lane.
  wire [319:0] parity;
  genvar x, y;
  generate
    for (x = 0; x < 5; x = x + 1) begin : g_par
      assign parity[64*x+63:64*x] = s_in[64*x+63:64*x]
        ^ s_in[64*(x+5)+63:64*(x+5)] ^ s_in[64*(x+10)+63:64*(x+10)]
        ^ s_in[64*(x+15)+63:64*(x+15)] ^ s_in[64*(x+20)+63:64*(x+20)];
    end
    for (y = 0; y < 25; y = y + 1) begin : g_mix
      assign s_out[64*y+63:64*y] = s_in[64*y+63:64*y]
        ^ parity[64*((y+4)%5)+63:64*((y+4)%5)]
        ^ {parity[64*((y+1)%5)+62:64*((y+1)%5)], parity[64*((y+1)%5)+63]};
    end
  endgenerate
endmodule
