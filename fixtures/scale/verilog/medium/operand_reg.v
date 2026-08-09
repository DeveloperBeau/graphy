// Holds an operand; digits shift in from the keypad.
module operand_reg(
  input  wire        clk,
  input  wire        rst_n,
  input  wire        load,
  input  wire        shift_digit,
  input  wire [3:0]  digit,
  input  wire [15:0] load_value,
  output reg  [15:0] value
);
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      value <= 16'd0;
    else if (load)
      value <= load_value;
    else if (shift_digit)
      value <= {value[11:0], digit};
  end
endmodule
