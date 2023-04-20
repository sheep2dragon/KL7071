//==========================================================================
// Data				:	2016-02-03
// Author			:	Chen Biao
// Email			:	biao.chen@keliangtek.com
// purpose			:	fpga led
//--------------------------------------------------------------------------
// Revision record	:
// data			person			issue number		detail
//
//==========================================================================
`timescale 1 ns / 1 ns

module rst_ctrl_high(					//reset 1us
//clk & rst
    input 					clk_sys,
    input 					locked,
    output reg 				fpga_rst
	);

//-------------------------signal definition--------------------------------
//-------------------------signal definition--------------------------------
reg 	[3:0]		locked_dly;
reg 	[6:0]		fpga_rst_cnt;

//-------------------------main code----------------------------------------
//-------------------------main code----------------------------------------
always @(posedge clk_sys)
begin
	locked_dly[3:0] <= {locked_dly[2:0], locked};
end

always @(posedge clk_sys)
begin
	if (locked_dly[2]==1'b1 && locked_dly[3]==1'b0)		//locked posedge
		fpga_rst_cnt[6:0] <= 7'd1;
	else if (fpga_rst_cnt[6:0]>=7'd127)
		fpga_rst_cnt[6:0] <= 7'd0;
	else if (fpga_rst_cnt[6:0]>7'd0)
		fpga_rst_cnt[6:0] <= fpga_rst_cnt[6:0] + 7'd1;
	else ;
end

always @(posedge clk_sys)
begin
	if (fpga_rst_cnt[6:0]==10'd2)
		fpga_rst <= 1'b1;
	else if (fpga_rst_cnt[6:0]>=7'd127)
		fpga_rst <= 1'b0;
	else ;
end

endmodule

