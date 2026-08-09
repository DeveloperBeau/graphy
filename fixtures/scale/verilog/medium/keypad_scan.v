// 4x4 matrix scanner: walks one low column at a time.
module keypad_scan(
  input  wire       clk,
  input  wire       rst_n,
  input  wire [3:0] rows,
  output reg  [3:0] cols,
  output wire       key_valid,
  output wire [4:0] key_code
);
  reg  [1:0] col_idx;
  wire       any_row;

  debounce u_db(clk, rst_n, |rows, any_row);

  assign key_valid = any_row;
  assign key_code  = {col_idx, rows[1:0], rows[3] | rows[2]};

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      col_idx <= 2'd0;
      cols    <= 4'b1110;
    end else if (!any_row) begin
      col_idx <= col_idx + 2'd1;
      cols    <= {cols[2:0], cols[3]};
    end
  end
endmodule
