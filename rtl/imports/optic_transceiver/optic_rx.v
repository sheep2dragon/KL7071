//==========================================================================
// Data				:	2016-09-22
// Author			:	Chen Biao
// Email			:	biao.chen@keliangtek.com
// purpose			:	
//--------------------------------------------------------------------------
// Revision record	:
// data			person			issue number		detail
//
//==========================================================================
`timescale 1 ns / 1 ns

module optic_rx(
    input 					reset,
    input 					clk_rx,								//clk 250m
    //debug info, clk rx domain
    output reg 				rx_comm_err,						//LC channel rx communication error, 1:err 0: normal
    output reg 				rx_verify_err,						//LC channel rx verify error, 1:err 0: normal
    //serial data
(* MARK_DEBUG="true" *)    input 					phy_rxd,
    //user interface, clk rx domain
    output reg 	[7:0]		rxd_data='d0
	);

(* MARK_DEBUG="true" *)reg 	[4:0]				rx_state;// one-hot state machine
parameter 					IDLE				= 5'h1;
parameter 					RX_HEADER			= 5'h2;
parameter 					RX_DATA				= 5'h4; 
parameter 					RX_VERIFY			= 5'h8; 
parameter 					RX_TAIL				= 5'h10;

parameter 					BIT6_CNT			= 6'd31;		//1 50m clk equal 5 250m, 7-8 50m

//-------------------------signal definition--------------------------------
//-------------------------signal definition--------------------------------
//clk rx domain
(* MARK_DEBUG="true" *)reg 	[4:0]				phy_rxd_dly;
(* MARK_DEBUG="true" *)reg 						phy_rxd_negedge;
(* MARK_DEBUG="true" *)reg 						phy_rxd_posedge;
(* MARK_DEBUG="true" *)reg 	[5:0]				sync_bit_clk_cnt;
(* MARK_DEBUG="true" *)reg 	[2:0]				bit_clk_cnt;				//1-5, 20ns
(* MARK_DEBUG="true" *)reg 	[2:0]				bit_cnt;					//0-7, 8 bits of 1 byte
(* MARK_DEBUG="true" *)reg 	[2:0]				ver_cnt;					//0-7, 8 bits of 1 byte
(* MARK_DEBUG="true" *)reg 						byte_cnt;					//0-1, 2 bytes
(* MARK_DEBUG="true" *)reg 	[7:0]				rxd_data_shift_reg='d0;
(* MARK_DEBUG="true" *)reg 	[7:0]				verify_shift_reg;
(* MARK_DEBUG="true" *)reg  [11:0]				tail_over_time_cnt;

//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
always @(posedge clk_rx)
begin
	phy_rxd_dly <= {phy_rxd_dly[3:0],phy_rxd};
	phy_rxd_negedge <= ~phy_rxd_dly[2] & phy_rxd_dly[3];
	phy_rxd_posedge <= phy_rxd_dly[2] & ~phy_rxd_dly[3];
end

//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
//sync cnt
always @(posedge clk_rx)
begin
	if (phy_rxd_negedge==1'b1 || phy_rxd_posedge==1'b1)
		sync_bit_clk_cnt[5:0] <= 6'd0;
	else
		sync_bit_clk_cnt[5:0] <= sync_bit_clk_cnt[5:0] + 6'd1;
end

always @(posedge clk_rx)
begin
	if (phy_rxd_negedge==1'b1 || phy_rxd_posedge==1'b1)
		rx_comm_err <= 1'b0;
	else if (sync_bit_clk_cnt[5:0]>=6'd63)
		rx_comm_err <= 1'b1;
	else ;
end



always @ (posedge clk_rx)
if(reset)
tail_over_time_cnt <= 16'h0;
else if(rx_state == IDLE)
tail_over_time_cnt <= 16'h0;
else if(tail_over_time_cnt[11])
tail_over_time_cnt <= tail_over_time_cnt;
else if(rx_state != IDLE)
tail_over_time_cnt <= tail_over_time_cnt + 1'b1;
else 
tail_over_time_cnt <= 16'h0;

always @ (posedge clk_rx)
if(reset)
	rx_state <= IDLE;
else if(tail_over_time_cnt[11])
	rx_state <= IDLE;
else case (rx_state)
	IDLE 		:
		if(sync_bit_clk_cnt[5:0]>=BIT6_CNT && phy_rxd_posedge) //______..._/`    long time zero and get posedge ,state go to RX_HEADER
			rx_state <= RX_HEADER;
		else
			rx_state <= IDLE;
	RX_HEADER 	:
		if(phy_rxd_negedge | (bit_clk_cnt[2:0]>=3'd5))		//______..._/`\_  after get negedge ,state go to RX_DATA 
		//(bit_clk_cnt[2:0]>=3'd5  if bit_clk_cnt[2:0]>=3'd5 then the first rx_data's data is "1"
			rx_state <= RX_DATA;
		else 
			rx_state <= RX_HEADER;
	RX_DATA 	:
		if(bit_clk_cnt[2:0]>=3'd5 && bit_cnt[2:0]>=3'd7)		// get one byte data go to RX_TAIL
			rx_state <= RX_VERIFY;
		else if(bit_clk_cnt[2:0]>=3'd3 && bit_cnt[2:0]>=3'd7 && (phy_rxd_negedge==1'b1 || phy_rxd_posedge==1'b1))		// get one byte data go to RX_TAIL
			rx_state <= RX_VERIFY;
		else 
			rx_state <= RX_DATA;
	RX_VERIFY   :
		if(bit_clk_cnt[2:0]>=3'd5 && ver_cnt[2:0]>=3'd7)		// get one byte data go to RX_TAIL
			rx_state <= RX_TAIL;
		else if(bit_clk_cnt[2:0]>=3'd3 && ver_cnt[2:0]>=3'd7 && (phy_rxd_negedge==1'b1 || phy_rxd_posedge==1'b1))		// get one byte data go to RX_TAIL
			rx_state <= RX_TAIL;	
		else 
			rx_state <= RX_VERIFY;
	RX_TAIL 	:
		if(sync_bit_clk_cnt[5:0]>=BIT6_CNT && phy_rxd_dly[3]==1'b1)//long time high ,state go to IDLE 
			rx_state <= IDLE;
		else if(tail_over_time_cnt[11])								//if over time then the state machine is abnormal 
			rx_state <= IDLE;
		else 
			rx_state <= RX_TAIL;
	default 	:
			rx_state <= IDLE;
	endcase
	

//--------------------------------------------------------------------------
//receive cnt
always @(posedge clk_rx)
begin
	if (reset)
		bit_clk_cnt[2:0] <= 3'd0;
	else if (rx_state==RX_HEADER && bit_clk_cnt == 3'b0 )
		bit_clk_cnt[2:0] <= 3'd1;								//last bit of header 8'h01
	else if (rx_state==RX_VERIFY && bit_clk_cnt[2:0]>=3'd5 && ver_cnt[2:0]>=3'd7)
		bit_clk_cnt[2:0] <= 3'd0;								//last bit of data
	else if((phy_rxd_negedge==1'b1 || phy_rxd_posedge==1'b1)   ) // add by chen baoquan to realignment in RX_DATA
		bit_clk_cnt[2:0] <= 3'd1;
	else if (bit_clk_cnt[2:0]>=3'd5)
		bit_clk_cnt[2:0] <= 3'd1;
	else if (bit_clk_cnt[2:0]>3'd0)
		bit_clk_cnt[2:0] <= bit_clk_cnt[2:0] + 3'd1;
	else ;
end

always @(posedge clk_rx)
begin
	if (reset)
		bit_cnt[2:0] <= 3'd0;
	else if (rx_state==RX_HEADER)//bit_cnt reinit 
		bit_cnt[2:0] <= 3'd0;
	else if (rx_state==RX_DATA && bit_clk_cnt[2:0]>=3'd5 && bit_cnt[2:0]>=3'd7)
		bit_cnt[2:0] <= 3'd0;								//last bit of data
	else if(rx_state==RX_DATA && bit_clk_cnt[2:0]>=3'd3 && bit_cnt[2:0]>=3'd7 && (phy_rxd_negedge==1'b1 || phy_rxd_posedge==1'b1))
		bit_cnt[2:0] <= 3'd0;
	else if (rx_state==RX_DATA && bit_clk_cnt[2:0]>=3'd5)
		bit_cnt[2:0] <= bit_cnt[2:0] + 3'd1;
	else if (rx_state==RX_DATA && (phy_rxd_negedge==1'b1 || phy_rxd_posedge==1'b1) && bit_clk_cnt[2:0]>=3'd3 )
	// add by chen baoquan to realignment in RX_DATA
	//bit_clk_cnt[2:0]>=3'd3 then the pose signal or nege signal is sooner than normal,
	//if bit_clk_cnt == 0 or 1 then the pose signal is later than normal and (rx_state==RX_DATA && bit_clk_cnt[2:0]>=3'd5) this condition had been vaild
	//then the bit_cnt would be add 1 twice
		bit_cnt[2:0] <= bit_cnt[2:0] + 3'd1;
	else ;
end

always @(posedge clk_rx)
begin
	if (reset)
		ver_cnt[2:0] <= 3'd0;
	else if (rx_state==RX_HEADER)//bit_cnt reinit 
		ver_cnt[2:0] <= 3'd0;
	else if (rx_state==RX_VERIFY && bit_clk_cnt[2:0]>=3'd5 && ver_cnt[2:0]>=3'd7)
		ver_cnt[2:0] <= 3'd0;								//last bit of data
	else if (rx_state==RX_VERIFY && bit_clk_cnt[2:0]>=3'd3 && ver_cnt[2:0]>=3'd7 && (phy_rxd_negedge==1'b1 || phy_rxd_posedge==1'b1))
		ver_cnt[2:0] <= 3'd0;								//last bit of data		
	else if (rx_state==RX_VERIFY && bit_clk_cnt[2:0]>=3'd5)
		ver_cnt[2:0] <= ver_cnt[2:0] + 3'd1;
	else if (rx_state==RX_VERIFY && (phy_rxd_negedge==1'b1 || phy_rxd_posedge==1'b1) && bit_clk_cnt[2:0]>=3'd3 )
	// add by chen baoquan to realignment in RX_VERIFY
	//bit_clk_cnt[2:0]>=3'd3 then the pose signal or nege signal is sooner than normal,
	//if bit_clk_cnt == 0 or 1 then the pose signal is later than normal and (rx_state==RX_DATA && bit_clk_cnt[2:0]>=3'd5) this condition had been vaild
	//then the bit_cnt would be add 1 twice
		ver_cnt[2:0] <= ver_cnt[2:0] + 3'd1;
	else ;
end

//always @(posedge clk_rx)
//begin
//	if (rx_state==RX_HEADER && phy_rxd_posedge==1'b1)
//		byte_cnt <= 1'b0;
//	else if (rx_state==RX_DATA && bit_clk_cnt[2:0]>=3'd5 && bit_cnt[2:0]>=3'd7)
//		byte_cnt <= ~byte_cnt;
//	else if (rx_state==RX_DATA && phy_rxd_posedge && bit_cnt[2:0]>=3'd7 && bit_clk_cnt[2:0]>=3'd3)// add by chen baoquan to realignment in RX_DATA
//		byte_cnt <= ~byte_cnt;
//	else if (rx_state==RX_DATA && phy_rxd_negedge && bit_cnt[2:0]>=3'd7 && bit_clk_cnt[2:0]>=3'd3)// add by chen baoquan to realignment in RX_DATA
//		byte_cnt <= ~byte_cnt;
//	else 
//		byte_cnt <= byte_cnt;
//end

//--------------------------------------------------------------------------
//receive data shift reg
always @(posedge clk_rx)
begin
	if (rx_state==RX_DATA && bit_clk_cnt[2:0]==3'd3 )
		rxd_data_shift_reg[7:0] <= {rxd_data_shift_reg[6:0],phy_rxd_dly[4]};
	else ;
end

//receive verify shift reg
always @(posedge clk_rx)
begin
	if (rx_state==RX_VERIFY && bit_clk_cnt[2:0]==3'd3 )
		verify_shift_reg[7:0] <= {verify_shift_reg[6:0],phy_rxd_dly[4]};
	else ;
end

//receive verify bit, 1:err 0:normal
always @(posedge clk_rx)
begin
	if (rx_state==RX_TAIL && rxd_data_shift_reg[7:0]==(~verify_shift_reg[7:0]))
		rx_verify_err <= 1'b0;
	else if (rx_state==RX_TAIL)
		rx_verify_err <= 1'b1;
	else ;
end

//refresh data when verify correct
always @(posedge clk_rx)
begin
	if (rx_state==RX_TAIL && sync_bit_clk_cnt[5:0]>=BIT6_CNT && phy_rxd_dly[3]==1'b1 && rx_verify_err==1'b0)
		rxd_data[7:0] <= rxd_data_shift_reg[7:0];
	else ;
end

endmodule
