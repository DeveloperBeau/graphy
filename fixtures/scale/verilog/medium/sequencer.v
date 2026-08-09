// Four-state control loop: enter, issue, wait, show.
module sequencer(
  input  wire       clk,
  input  wire       rst_n,
  input  wire       key_ready,
  input  wire       is_digit,
  input  wire       alu_done,
  output reg        load_operand,
  output reg        start_alu,
  output reg        latch_result
);
  localparam ENTRY = 2'd0, ISSUE = 2'd1, WAIT = 2'd2, SHOW = 2'd3;
  reg [1:0] state;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      state        <= ENTRY;
      load_operand <= 1'b0;
      start_alu    <= 1'b0;
      latch_result <= 1'b0;
    end else begin
      load_operand <= (state == ENTRY) && key_ready && is_digit;
      start_alu    <= (state == ENTRY) && key_ready && !is_digit;
      latch_result <= (state == WAIT) && alu_done;
      case (state)
        ENTRY: if (key_ready && !is_digit) state <= ISSUE;
        ISSUE: state <= WAIT;
        WAIT:  if (alu_done) state <= SHOW;
        SHOW:  state <= ENTRY;
      endcase
    end
  end
endmodule
