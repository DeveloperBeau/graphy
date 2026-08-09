// Streams plaintext words from memory into an engine.
module dma_rd_engine(
  input  wire        clk,
  input  wire        rst_n,
  input  wire        start,
  input  wire [31:0] base_addr,
  input  wire [15:0] words,
  output reg  [31:0] mem_addr,
  output reg         mem_req,
  output reg         busy
);
  reg [15:0] left;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      mem_addr <= 32'd0;
      mem_req  <= 1'b0;
      busy     <= 1'b0;
      left     <= 16'd0;
    end else if (start && !busy) begin
      mem_addr <= base_addr;
      left     <= words;
      busy     <= 1'b1;
      mem_req  <= 1'b1;
    end else if (busy) begin
      mem_addr <= mem_addr + 32'd4;
      left     <= left - 16'd1;
      if (left == 16'd1) begin
        busy    <= 1'b0;
        mem_req <= 1'b0;
      end
    end
  end
endmodule
