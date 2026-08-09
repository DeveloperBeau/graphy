// Radix-4 Booth recoding of a multiplier triple.
module booth_encoder(
  input  wire [2:0] triple,
  output reg  [1:0] magnitude,
  output reg        negate
);
  always @(*) begin
    case (triple)
      3'b000, 3'b111: begin magnitude = 2'd0; negate = 1'b0; end
      3'b001, 3'b010: begin magnitude = 2'd1; negate = 1'b0; end
      3'b011:         begin magnitude = 2'd2; negate = 1'b0; end
      3'b100:         begin magnitude = 2'd2; negate = 1'b1; end
      default:        begin magnitude = 2'd1; negate = 1'b1; end
    endcase
  end
endmodule
