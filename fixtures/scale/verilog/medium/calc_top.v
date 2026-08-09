// Desk calculator: keypad in, seven-segment display out.
module calc_top(
  input  wire       clk,
  input  wire       rst_n,
  input  wire [3:0] keypad_rows,
  output wire [3:0] keypad_cols,
  output wire [6:0] segments,
  output wire [3:0] digit_sel
);
  wire        key_valid, key_empty, is_digit, alu_done;
  wire        load_operand, start_alu, latch_result;
  wire [4:0]  key_code, queued_key;
  wire [3:0]  alu_op;
  wire [15:0] operand_a, alu_result, shown;
  wire        fz, fn, fo, tick;

  clock_divider  u_tick(clk, rst_n, tick);
  keypad_scan    u_keys(clk, rst_n, keypad_rows, keypad_cols, key_valid, key_code);
  input_fifo     u_queue(clk, rst_n, key_valid, key_code, start_alu | load_operand, queued_key, key_empty);
  opcode_decoder u_dec(queued_key, alu_op, is_digit);
  sequencer      u_seq(clk, rst_n, ~key_empty, is_digit, alu_done, load_operand, start_alu, latch_result);
  operand_reg    u_op_a(clk, rst_n, 1'b0, load_operand, queued_key[3:0], 16'd0, operand_a);
  alu_core       u_alu(clk, rst_n, start_alu, alu_op, operand_a, shown, alu_result, alu_done, fz, fn, fo);
  accumulator    u_acc(clk, rst_n, latch_result, 1'b0, alu_result, shown);
  display_scan   u_disp(clk, rst_n, shown, segments, digit_sel);
endmodule
