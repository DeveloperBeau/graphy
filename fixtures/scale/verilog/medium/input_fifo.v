// Eight-deep keystroke queue between scanner and sequencer.
module input_fifo(
  input  wire       clk,
  input  wire       rst_n,
  input  wire       push,
  input  wire [4:0] key_in,
  input  wire       pop,
  output wire [4:0] key_out,
  output wire       empty
);
  reg [4:0] mem [0:7];
  reg [3:0] wr_ptr, rd_ptr;

  assign empty   = (wr_ptr == rd_ptr);
  assign key_out = mem[rd_ptr[2:0]];

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      wr_ptr <= 4'd0;
      rd_ptr <= 4'd0;
    end else begin
      if (push) begin
        mem[wr_ptr[2:0]] <= key_in;
        wr_ptr <= wr_ptr + 4'd1;
      end
      if (pop && !empty)
        rd_ptr <= rd_ptr + 4'd1;
    end
  end
endmodule
