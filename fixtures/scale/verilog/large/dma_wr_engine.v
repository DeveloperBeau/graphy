// Writes ciphertext words back to the results region.
module dma_wr_engine(
  input  wire        clk,
  input  wire        rst_n,
  input  wire        push,
  input  wire [31:0] word_in,
  input  wire [31:0] base_addr,
  output reg  [31:0] mem_addr,
  output reg  [31:0] mem_wdata,
  output reg         mem_we
);
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      mem_addr  <= 32'd0;
      mem_wdata <= 32'd0;
      mem_we    <= 1'b0;
    end else begin
      mem_we <= push;
      if (push) begin
        mem_wdata <= word_in;
        mem_addr  <= (mem_addr == 32'd0) ? base_addr : mem_addr + 32'd4;
      end
    end
  end
endmodule
