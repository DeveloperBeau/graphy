// P-array initialised from key material xor pi digits.
module bf_key_sched(
  input  wire         clk,
  input  wire         rst_n,
  input  wire         load,
  input  wire [447:0] key_material,
  output reg  [31:0]  p_entry,
  output reg  [4:0]   p_index
);
  reg [575:0] p_array;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      p_array <= 576'd0;
      p_entry <= 32'd0;
      p_index <= 5'd0;
    end else if (load) begin
      p_array <= {key_material, key_material[447:320]} ^ {18{32'h243F6A88}};
      p_index <= 5'd0;
    end else begin
      p_entry <= p_array[575:544];
      p_array <= {p_array[543:0], p_array[575:544]};
      p_index <= p_index + 5'd1;
    end
  end
endmodule
