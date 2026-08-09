// Byte-stream write port: characters land at an auto-advancing cursor.
module host_if(
  input  wire        clk,
  input  wire        rst_n,
  input  wire        host_wr,
  input  wire [7:0]  host_data,
  output reg         wr_en,
  output reg  [10:0] wr_addr,
  output reg  [7:0]  wr_char
);
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      wr_en   <= 1'b0;
      wr_addr <= 11'd0;
      wr_char <= 8'd0;
    end else begin
      wr_en <= host_wr;
      if (host_wr) begin
        wr_char <= host_data;
        wr_addr <= (wr_addr == 11'd2399) ? 11'd0 : wr_addr + 11'd1;
      end
    end
  end
endmodule
