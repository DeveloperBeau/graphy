// Logarithmic left shifter: four mux stages.
module shifter_left_16(
  input  wire [15:0] a,
  input  wire [3:0]  amount,
  output wire [15:0] result
);
  wire [15:0] s1 = amount[0] ? {a[14:0], 1'b0} : a;
  wire [15:0] s2 = amount[1] ? {s1[13:0], 2'b00} : s1;
  wire [15:0] s4 = amount[2] ? {s2[11:0], 4'b0000} : s2;

  assign result = amount[3] ? {s4[7:0], 8'b0} : s4;
endmodule
