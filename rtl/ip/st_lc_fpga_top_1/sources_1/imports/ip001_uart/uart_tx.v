//==========================================================================
// Data				:	2015-03-19
// Author			:	Chen Biao
// Email			:	biao.chen@keliangtek.com
// purpose			:	IP001, uart	tx
//--------------------------------------------------------------------------
// Revision record	:
// data			person			issue number		detail
//
//==========================================================================
`timescale 1 ns / 1 ns

module uart_tx# (
    parameter 				CLK_NUM_PER_BIT = 11'd1085,	//default 115200
    parameter 				PARITY_CFG = 3'b000,		//000: no parity
														//001: odd
														//010: even
														//011: space,always 0
														//100: mark,always 1
    parameter  				STOP_BIT_NUM = 2'b00		//00: 1bit
														//01: 1.5bits
														//10: 2bits
)
(
	input					reset,
	input					clk,
	//uart interface with peripheral
	output	reg				com_232_tx,
	//user interface, user can difine freely for this data exchange buffer
	input					tx_valid,			//high pulse tx, same edge with serial_tx_data
	input		[7:0]		serial_tx_data,
	output	reg				tx_busy				//0: tx free   1: tx ongoing
	);

//-------------------------signal definition--------------------------------
//-------------------------signal definition--------------------------------
wire 	[10:0]				clk_num_per_bit;
reg		[10:0]				per_bit_cnt;
reg		[3:0]				payload_bit_cnt;
reg		[9:0]				serial_tx_data_reg;
reg 						tx_bit_clk;
reg 	[1:0]				tx_bit_clk_dly;
reg 						tx_bit_clk_negedge;
reg 	[2:0]				tx_bit_clk_negedge_dly;
reg 						pending_tx;

//-------------------------ipcore & module----------------------------------
//-------------------------ipcore & module----------------------------------
assign clk_num_per_bit = CLK_NUM_PER_BIT;

always @(posedge clk)
begin
	tx_bit_clk_dly[1:0] <= {tx_bit_clk_dly[0],tx_bit_clk};
	tx_bit_clk_negedge <= ~tx_bit_clk_dly[0] & tx_bit_clk_dly[1];
	tx_bit_clk_negedge_dly[2:0] <= {tx_bit_clk_negedge_dly[1:0],tx_bit_clk_negedge};
end

always @(posedge clk)
begin
	if (tx_valid==1'b1)
		serial_tx_data_reg <= {1'b1,serial_tx_data,1'b0};		//Start bit, 0
	else ;
end

always @(posedge clk)
begin
	if (reset)
		per_bit_cnt[10:0] <= 11'd0;
	else if (per_bit_cnt[10:0]>=clk_num_per_bit[10:0])
		per_bit_cnt[10:0] <= 11'd1;
	else
		per_bit_cnt[10:0] <= per_bit_cnt[10:0] + 11'd1;
end

always @(posedge clk)
begin
	if (reset)
		tx_bit_clk <= 1'b0;
	else if (per_bit_cnt[10:0]==11'd1)
		tx_bit_clk <= 1'b1;
	else if (per_bit_cnt[10:0]=={1'b0,clk_num_per_bit[10:1]})
		tx_bit_clk <= 1'b0;
	else ;		
end

always @(posedge clk)
begin
	if (reset)
		pending_tx <= 1'b0;
	else if (tx_valid==1'b1)
		pending_tx <= 1'b1;
	else if (pending_tx==1'b1 && tx_bit_clk_negedge_dly[0]==1'b1)
		pending_tx <= 1'b0;
	else ;
end

always @(posedge clk)
begin
	if (reset)
		payload_bit_cnt[3:0] <= 4'd0;
	else if (pending_tx==1'b1 && tx_bit_clk_negedge_dly[0]==1'b1)
		payload_bit_cnt[3:0] <= 4'd1;
	else if (tx_bit_clk_negedge_dly[0]==1'b1 && payload_bit_cnt[3:0]>=4'd10)
		payload_bit_cnt[3:0] <= 4'd0;
	else if (tx_bit_clk_negedge_dly[0]==1'b1 && payload_bit_cnt[3:0]>4'd0)
		payload_bit_cnt[3:0] <= payload_bit_cnt[3:0] + 4'd1;
	else ;
end

always @(posedge clk)
begin
	if (reset)
		com_232_tx <= 1'b1;
	else if (tx_bit_clk_negedge_dly[2]==1'b1 && payload_bit_cnt[3:0]>4'd0)
		case (payload_bit_cnt[3:0])
			4'd1:	com_232_tx <= serial_tx_data_reg[0];
			4'd2:	com_232_tx <= serial_tx_data_reg[1];
			4'd3:	com_232_tx <= serial_tx_data_reg[2];
			4'd4:	com_232_tx <= serial_tx_data_reg[3];
			4'd5:	com_232_tx <= serial_tx_data_reg[4];
			4'd6:	com_232_tx <= serial_tx_data_reg[5];
			4'd7:	com_232_tx <= serial_tx_data_reg[6];
			4'd8:	com_232_tx <= serial_tx_data_reg[7];
			4'd9:	com_232_tx <= serial_tx_data_reg[8];
			4'd10:	com_232_tx <= serial_tx_data_reg[9];
			default: com_232_tx <= 1'b1;
		endcase
	else ;
end

always @(posedge clk)
begin
	if (reset)
		tx_busy <= 1'b0;
	else if (tx_bit_clk_negedge_dly[2]==1'b1 && payload_bit_cnt[3:0]>4'd0)
		tx_busy <= 1'b1;
	else if (tx_bit_clk_negedge_dly[2]==1'b1)
		tx_busy <= 1'b0;
	else ;
end

endmodule

