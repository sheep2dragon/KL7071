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

module led(
	input    			    clk_sys,
	input 					reset,
	//led
	output reg				fpga_led
	);

//-------------------------signal definition--------------------------------
//-------------------------signal definition--------------------------------
reg		[27:0]		cnt_clk_sys=28'd0;

//-------------------------main code----------------------------------------
//-------------------------main code----------------------------------------
always @(posedge clk_sys)
begin
	if (reset)
		cnt_clk_sys[27:0] <= 28'd0;
	else if (cnt_clk_sys[27:0]>=28'h8000000)		//1.073s, 1Hz
		cnt_clk_sys[27:0] <= 28'd0;
	else
		cnt_clk_sys[27:0] <= cnt_clk_sys[27:0]+28'd1;
end

always @(posedge clk_sys)
begin
	if (reset)
		fpga_led <= 1'b1;
	else if (cnt_clk_sys[27:0]>=28'h8000000)		//1.073s, 1Hz
		fpga_led <= ~fpga_led;						//fpga run led
	else ;
end

endmodule

