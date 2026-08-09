// Maps keypad codes onto datapath operations.
module opcode_decoder(
  input  wire [4:0] key_code,
  output reg  [3:0] alu_op,
  output reg        is_digit
);
  always @(*) begin
    is_digit = ~key_code[4];
    case (key_code)
      5'h10: alu_op = 4'd0;
      5'h11: alu_op = 4'd1;
      5'h12: alu_op = 4'd2;
      5'h13: alu_op = 4'd3;
      5'h14: alu_op = 4'd4;
      5'h15: alu_op = 4'd5;
      5'h16: alu_op = 4'd6;
      5'h17: alu_op = 4'd7;
      default: alu_op = 4'd15;
    endcase
  end
endmodule
