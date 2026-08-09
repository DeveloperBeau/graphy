// 32-deep elastic buffer between engines and the DMA writer.
module result_fifo(
  input  wire        clk,
  input  wire        rst_n,
  input  wire        push,
  input  wire [31:0] word_in,
  input  wire        pop,
  output wire [31:0] word_out,
  output wire        empty,
  output wire        full
);
  reg [31:0] mem [0:31];
  reg [5:0]  wr_ptr, rd_ptr;

  assign empty    = (wr_ptr == rd_ptr);
  assign full     = (wr_ptr[4:0] == rd_ptr[4:0]) && (wr_ptr[5] != rd_ptr[5]);
  assign word_out = mem[rd_ptr[4:0]];

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      wr_ptr <= 6'd0;
      rd_ptr <= 6'd0;
    end else begin
      if (push && !full) begin
        mem[wr_ptr[4:0]] <= word_in;
        wr_ptr <= wr_ptr + 6'd1;
      end
      if (pop && !empty)
        rd_ptr <= rd_ptr + 6'd1;
    end
  end
endmodule
