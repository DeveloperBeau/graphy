// Operation hub: combinational ops finish in one cycle.
module alu_core(
  input  wire        clk,
  input  wire        rst_n,
  input  wire        start,
  input  wire [3:0]  alu_op,
  input  wire [15:0] operand_a,
  input  wire [15:0] operand_b,
  output wire [15:0] result,
  output wire        done,
  output wire        flag_zero,
  output wire        flag_negative,
  output wire        flag_overflow
);
  wire [15:0] add_r, sub_r, div_q, div_rem, shift_r, cmp_r;
  wire [31:0] mul_r;
  wire        add_c, sub_b, mul_done, div_done, eq, lt, gt;

  ripple_adder_16   u_add(operand_a, operand_b, 1'b0, add_r, add_c);
  subtractor_16     u_sub(operand_a, operand_b, sub_r, sub_b);
  multiplier_16     u_mul(clk, rst_n, start && (alu_op == 4'd2), operand_a, operand_b, mul_r, mul_done);
  divider_16        u_div(clk, rst_n, start && (alu_op == 4'd3), operand_a, operand_b, div_q, div_rem, div_done);
  barrel_shifter_16 u_shift(operand_a, operand_b[3:0], ~alu_op[0], 1'b1, shift_r);
  comparator_16     u_cmp(operand_a, operand_b, eq, lt, gt);
  flags_unit        u_flags(result, operand_a[15], operand_b[15], alu_op == 4'd1, flag_zero, flag_negative, flag_overflow);
  result_mux        u_mux(alu_op, add_r, sub_r, mul_r, div_q, shift_r, {13'd0, gt, eq, lt}, result);

  assign done = (alu_op == 4'd2) ? mul_done :
                (alu_op == 4'd3) ? div_done : 1'b1;
endmodule
