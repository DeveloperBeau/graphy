// Register window: engine select, kick, and status readback.
module bus_slave(
  input  wire        clk,
  input  wire        rst_n,
  input  wire        sel,
  input  wire        wr,
  input  wire [7:0]  addr,
  input  wire [31:0] wdata,
  input  wire [31:0] status_word,
  output reg  [31:0] rdata,
  output reg  [7:0]  engine_sel,
  output reg         kick
);
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      rdata      <= 32'd0;
      engine_sel <= 8'd0;
      kick       <= 1'b0;
    end else begin
      kick <= sel && wr && (addr == 8'h00);
      if (sel && wr && (addr == 8'h04))
        engine_sel <= wdata[7:0];
      if (sel && !wr)
        rdata <= (addr == 8'h08) ? status_word : {24'd0, engine_sel};
    end
  end
endmodule
