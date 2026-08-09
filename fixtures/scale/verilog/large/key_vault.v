// Eight write-only key slots with a global zeroize line.
module key_vault(
  input  wire         clk,
  input  wire         rst_n,
  input  wire         load,
  input  wire [2:0]   slot,
  input  wire [255:0] key_in,
  input  wire         zeroize,
  output wire [255:0] key_out
);
  reg [255:0] slots [0:7];
  reg [2:0]   active;
  integer i;

  assign key_out = slots[active];

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n || zeroize) begin
      for (i = 0; i < 8; i = i + 1)
        slots[i] <= 256'd0;
      active <= 3'd0;
    end else if (load) begin
      slots[slot] <= key_in;
      active      <= slot;
    end
  end
endmodule
