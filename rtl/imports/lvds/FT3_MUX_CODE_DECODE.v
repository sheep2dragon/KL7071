module FT3_MUX_CODE_DECODE
(
input clk,//clk 100M
input reset,
input [3:0] FT3_CODE_IN,//12.5M
input [3:0] spi_interface_i,
output [3:0] spi_interface_o,
output [1:0] DDR_FT3_UP,
input  [1:0] DDR_FT3_DOWN,
output  [3:0] FT3_CODE_OUT,
input         spi_switch

);


wire [3:0] lvds_spi_i_net ;
wire [3:0] lvds_spi_o_net;
assign lvds_spi_i_net = spi_switch ? spi_interface_i : FT3_CODE_IN;
assign FT3_CODE_OUT = lvds_spi_o_net;
assign spi_interface_o = lvds_spi_o_net;
/*
genvar <var>;
generate
for (<var>=0; <var> < <limit>; <var>=<var>+1)
begin: <label>
   <instantiation>
end
endgenerate

*/

genvar i;
generate
  for (i = 0;i < 4;i=i+1)
  begin:  io_ddr_ctrl
      IDDR #(
.DDR_CLK_EDGE("SAME_EDGE"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                //    or "SAME_EDGE_PIPELINED" 
.INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
.INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
.SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
) IDDR_inst (
.Q1(lvds_spi_o_net[2*i]), // 1-bit output for positive edge of clock 
.Q2(lvds_spi_o_net[2*i+1]), // 1-bit output for negative edge of clock
.C(clk),   // 1-bit clock input
.CE(1'b1), // 1-bit clock enable input
.D(DDR_FT3_DOWN[i]),   // 1-bit DDR data input
.R(reset),   // 1-bit reset
.S(1'b0)    // 1-bit set
);


ODDR #(
.DDR_CLK_EDGE("SAME_EDGE"), // "OPPOSITE_EDGE" or "SAME_EDGE" 
.INIT(1'b0),    // Initial value of Q: 1'b0 or 1'b1
.SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
) ODDR_inst (
.Q(DDR_FT3_UP[i]),   // 1-bit DDR output
.C(clk),   // 1-bit clock input
.CE(1'b1), // 1-bit clock enable input
.D1(lvds_spi_i_net[2*i + 1]), // 1-bit data input (positive edge)
.D2(lvds_spi_i_net[2*i]), // 1-bit data input (negative edge)
.R(reset),   // 1-bit reset
.S(1'b0)    // 1-bit set
); 
      
  end
endgenerate

endmodule