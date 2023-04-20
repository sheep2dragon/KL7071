//==========================================================================
// Data				:	2015-03-19
// Author			:	Chen Biao
// Email			:	biao.chen@keliangtek.com
// purpose			:	IP001, uart	rx
//--------------------------------------------------------------------------
// Revision record	:
// data			person			issue number		detail
//
//==========================================================================
`timescale 1 ns / 1 ns

module uart_rx# (
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
	input					com_232_rx,
	//user interface, user can difine freely for this data exchange buffer
	output	reg				rx_valid,			//high pulse rx, same edge with serial_rx_data
	output	reg	[7:0]		serial_rx_data,
	output	reg				parity_err_flag		//0:normal 1:parity bit err
	);

//-------------------------signal definition--------------------------------
//-------------------------signal definition--------------------------------
wire 	[10:0]				clk_num_per_bit;
reg		[4:0]				rx_state;
parameter					IDLE		=5'b00001;
parameter					START_BIT	=5'b00010;
parameter					PAYLOAD		=5'b00100;
parameter					PARITY_BIT	=5'b01000;
parameter					STOP_BIT	=5'b10000;

reg		[3:0]				com_232_rx_reg;
reg		[10:0]				per_bit_cnt;
reg		[3:0]				payload_bit_cnt;
reg		[1:0]				stop_bit_cnt;
reg		[7:0]				serial_rx_data_buf;
reg							sum_all_bits;
reg							parity_bit_reg;

//-------------------------ipcore & module----------------------------------
//-------------------------ipcore & module----------------------------------
assign clk_num_per_bit = CLK_NUM_PER_BIT;

always @(posedge clk)
begin
	com_232_rx_reg[3:0] <= {com_232_rx_reg[2:0],com_232_rx};
end

always @(posedge clk)
begin
	if (reset)
		rx_state <= IDLE;
	else if (com_232_rx_reg[2]==1'b0 && com_232_rx_reg[3]==1'b1 && rx_state==IDLE)
		rx_state <= START_BIT;
	else if (per_bit_cnt[10:0]>=clk_num_per_bit[10:0] && rx_state==START_BIT)
		rx_state <= PAYLOAD;
	else if (per_bit_cnt[10:0]>=clk_num_per_bit[10:0] && rx_state==PAYLOAD && payload_bit_cnt[3:0]>=4'd8 && PARITY_CFG!=3'd0)
		rx_state <= PARITY_BIT;
	else if (per_bit_cnt[10:0]>=clk_num_per_bit[10:0] && rx_state==PAYLOAD && payload_bit_cnt[3:0]>=4'd8 && PARITY_CFG==3'd0)
		rx_state <= STOP_BIT;
	else if (per_bit_cnt[10:0]>=clk_num_per_bit[10:0] && rx_state==PARITY_BIT)
		rx_state <= STOP_BIT;
	else if (per_bit_cnt[10:0]>={1'b0,clk_num_per_bit[10:1]} && rx_state==STOP_BIT && ((STOP_BIT_NUM==2'd0 && stop_bit_cnt==2'd1)
						|| (STOP_BIT_NUM==2'd2 && stop_bit_cnt==2'd2)))
		rx_state <= IDLE;
	else if (per_bit_cnt[10:0]>={clk_num_per_bit[10:0]} && rx_state==STOP_BIT && STOP_BIT_NUM==2'd1 && stop_bit_cnt==2'd2)
		rx_state <= IDLE;
	else ;
end

always @(posedge clk)
begin
	if (reset)
		per_bit_cnt[10:0] <= 11'd0;
	else if (com_232_rx_reg[2]==1'b0 && com_232_rx_reg[3]==1'b1 && rx_state==IDLE)
		per_bit_cnt[10:0] <= 11'd1;
	else if (per_bit_cnt[10:0]>=clk_num_per_bit[10:0] && rx_state!=STOP_BIT)
		per_bit_cnt[10:0] <= 11'd1;
	else if (per_bit_cnt[10:0]>={(clk_num_per_bit[10:9]+2'd1),clk_num_per_bit[8:1]} && rx_state==STOP_BIT && STOP_BIT_NUM==2'd0 && stop_bit_cnt==2'd1)
		per_bit_cnt[10:0] <= 11'd0;
	else if (per_bit_cnt[10:0]>=clk_num_per_bit[10:0] && rx_state==STOP_BIT && STOP_BIT_NUM!=2'd0 && stop_bit_cnt==2'd1)
		per_bit_cnt[10:0] <= 11'd1;
	else if (per_bit_cnt[10:0]>={1'b0,(clk_num_per_bit[10]+1'b1),clk_num_per_bit[9:2]} && rx_state==STOP_BIT && STOP_BIT_NUM==2'd1 && stop_bit_cnt==2'd2)
		per_bit_cnt[10:0] <= 11'd0;
	else if (per_bit_cnt[10:0]>={(clk_num_per_bit[10:9]+2'd1),clk_num_per_bit[8:1]} && rx_state==STOP_BIT && STOP_BIT_NUM==2'd2 && stop_bit_cnt==2'd2)
		per_bit_cnt[10:0] <= 11'd0;
	else if (per_bit_cnt[10:0]>0)
		per_bit_cnt[10:0] <= per_bit_cnt[10:0]+11'd1;
	else ;
end

always @(posedge clk)
begin
	if (reset)
		payload_bit_cnt[3:0] <= 4'd0;
	else if (com_232_rx_reg[2]==1'b0 && com_232_rx_reg[3]==1'b1 && rx_state==IDLE)
		payload_bit_cnt[3:0] <= 4'd0;
	else if (per_bit_cnt[10:0]>=clk_num_per_bit[10:0] && rx_state==START_BIT)
		payload_bit_cnt[3:0] <= 4'd1;
	else if (per_bit_cnt[10:0]>=clk_num_per_bit[10:0] && rx_state==PAYLOAD && payload_bit_cnt[3:0]>=4'd8)
		payload_bit_cnt[3:0] <= 4'd0;
	else if (per_bit_cnt[10:0]>=clk_num_per_bit[10:0] && rx_state==PAYLOAD)
		payload_bit_cnt[3:0] <= payload_bit_cnt[3:0]+4'd1;
	else ;
end

always @(posedge clk)
begin
	if (reset)
		stop_bit_cnt[1:0] <= 2'd0;
	else if (com_232_rx_reg[2]==1'b0 && com_232_rx_reg[3]==1'b1 && rx_state==IDLE)
		stop_bit_cnt[1:0] <= 2'd0;
	else if (per_bit_cnt[10:0]>=clk_num_per_bit[10:0] && rx_state==PARITY_BIT)
		stop_bit_cnt[1:0] <= 2'd1;
	else if (per_bit_cnt[10:0]>=clk_num_per_bit[10:0] && rx_state==PAYLOAD && PARITY_CFG==3'd0 && payload_bit_cnt[3:0]>=4'd8)
		stop_bit_cnt[1:0] <= 2'd1;
	else if (per_bit_cnt[10:0]>={(clk_num_per_bit[10:9]+2'd1),clk_num_per_bit[8:1]} && rx_state==STOP_BIT && STOP_BIT_NUM==2'd0 && stop_bit_cnt==2'd1)
		stop_bit_cnt[1:0] <= 2'd0;
	else if (per_bit_cnt[10:0]>=clk_num_per_bit[10:0] && rx_state==STOP_BIT && STOP_BIT_NUM!=2'd0 && stop_bit_cnt==2'd1)
		stop_bit_cnt[1:0] <= 2'd2;
	else if (per_bit_cnt[10:0]>={1'b0,(clk_num_per_bit[10]+1'b1),clk_num_per_bit[9:2]} && rx_state==STOP_BIT && STOP_BIT_NUM==2'd1 && stop_bit_cnt==2'd2)
		stop_bit_cnt[1:0] <= 2'd0;
	else if (per_bit_cnt[10:0]>={(clk_num_per_bit[10:9]+2'd1),clk_num_per_bit[8:1]} && rx_state==STOP_BIT && STOP_BIT_NUM==2'd2 && stop_bit_cnt==2'd2)
		stop_bit_cnt[1:0] <= 2'd0;
	else ;
end

always @(posedge clk)
begin
	if (com_232_rx_reg[2]==1'b0 && com_232_rx_reg[3]==1'b1 && rx_state==IDLE)
		serial_rx_data_buf[7:0] <= 8'd0;
	else if (per_bit_cnt[10:0]=={1'b0,clk_num_per_bit[10:1]} && rx_state==PAYLOAD)
		serial_rx_data_buf[7:0] <= {com_232_rx_reg[3],serial_rx_data_buf[7:1]};
	else ;
end

always @(posedge clk)
begin
	if (com_232_rx_reg[2]==1'b0 && com_232_rx_reg[3]==1'b1 && rx_state==IDLE)
		parity_bit_reg <= 1'b0;
	else if (PARITY_CFG[2:0]==3'd0)
		parity_bit_reg <= 1'b0;
	else if (per_bit_cnt[10:0]=={1'b0,clk_num_per_bit[10:1]} && rx_state==PARITY_BIT)
		parity_bit_reg <= com_232_rx_reg[3];
	else ;
end

always @(posedge clk)
begin
	if (com_232_rx_reg[2]==1'b0 && com_232_rx_reg[3]==1'b1 && rx_state==IDLE)
		sum_all_bits <= 1'b0;
	else if (rx_state==STOP_BIT && stop_bit_cnt==2'd1)
		begin
			case (per_bit_cnt[10:0])
				11'd1:	sum_all_bits <= serial_rx_data_buf[0];
				11'd2:	sum_all_bits <= sum_all_bits + serial_rx_data_buf[1];
				11'd3:	sum_all_bits <= sum_all_bits + serial_rx_data_buf[2];
				11'd4:	sum_all_bits <= sum_all_bits + serial_rx_data_buf[3];
				11'd5:	sum_all_bits <= sum_all_bits + serial_rx_data_buf[4];
				11'd6:	sum_all_bits <= sum_all_bits + serial_rx_data_buf[5];
				11'd7:	sum_all_bits <= sum_all_bits + serial_rx_data_buf[6];
				11'd8:	sum_all_bits <= sum_all_bits + serial_rx_data_buf[7];
				default: ;
			endcase
		end
	else ;
end

always @(posedge clk)
begin
	if (reset)
		parity_err_flag <= 1'b0;
	else if (com_232_rx_reg[2]==1'b0 && com_232_rx_reg[3]==1'b1 && rx_state==IDLE)
		parity_err_flag <= 1'b0;
	else if (per_bit_cnt[10:0]>={(clk_num_per_bit[10:9]+2'd1),clk_num_per_bit[8:1]} && rx_state==STOP_BIT && stop_bit_cnt==2'd1)
		case (PARITY_CFG[2:0])
			3'd0:	parity_err_flag <= 1'b0;	//no parity, jump to Stop bit directly
			3'd1:	//odd, when sum is 1, odd parity is 0; otherwise, odd parity is 1. Odd bit to make sure that sum+odd has odd 1
				begin
					if (sum_all_bits^parity_bit_reg ==1'b1)
						parity_err_flag <= 1'b0;
					else
						parity_err_flag <= 1'b1;
				end
			3'd2:	//even, when sum is 1, even parity is 1; otherwise, even parity is 0. Even bit to make sure that sum+even has even 1
				begin
					if (sum_all_bits^parity_bit_reg ==1'b0)
						parity_err_flag <= 1'b1;
					else
						parity_err_flag <= 1'b0;
				end
			3'd3:	//space,always 0
				begin
					if (parity_bit_reg ==1'b0)
						parity_err_flag <= 1'b0;
					else
						parity_err_flag <= 1'b1;
				end
			3'd4:	//mark,always 1
				begin
					if (parity_bit_reg ==1'b1)
						parity_err_flag <= 1'b0;
					else
						parity_err_flag <= 1'b1;
				end
			default:parity_err_flag <= 1'b0;
		endcase
	else ;
end

always @(posedge clk)
begin
	if (per_bit_cnt[10:0]=={1'b0,clk_num_per_bit[10:1]} && rx_state==STOP_BIT && stop_bit_cnt==2'd1)
		begin
			rx_valid <= 1'b1;
			serial_rx_data[7:0] <= serial_rx_data_buf[7:0];
		end
	else
		begin
			rx_valid <= 1'b0;
			serial_rx_data[7:0] <= serial_rx_data[7:0];
		end
end

endmodule

