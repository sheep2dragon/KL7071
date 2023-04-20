//==========================================================================
// Data				:	2016-06-14
// Author			:	Chen Biao
// Email			:	biao.chen@keliangtek.com
// purpose			:	
//--------------------------------------------------------------------------
// Revision record	:
// data			person			issue number		detail
//
//==========================================================================
`timescale 1 ns / 1 ns

module optic_tx(
    input 					reset,
    input 					clk_sys,
    input 					clk_tx,					//clk 50m
    //user interface, clk sys domain
    input 					tx_wea,
    input 					tx_waddr,
    input 		[31:0]		tx_wdata,
	//tx ctrl, clk tx domain
    input 					tx_comm_fault,			//0:no fault, 1:fault
    input 					tx_crc_fault,			//0:no fault, 1:fault
    input 					trans_start,
    output      [7:0]       debug_tx_data,
    output      [7:0]       debug_tx_raddr,
    output                  debug_tx_flag,
    output      [2:0]       debug_tx_bit_cnt,
    //serial data
    output reg 				phy_txd=1'b0
	);

//-------------------------signal definition--------------------------------
//-------------------------signal definition--------------------------------
//clk tx domain
 (* MARK_DEBUG="true" *)reg 	[2:0]				tx_raddr;
 (* MARK_DEBUG="true" *)wire 	[7:0]				tx_rdata;
 (* MARK_DEBUG="true" *)reg 						tx_flag;
 (* MARK_DEBUG="true" *)reg 						tx_flag_dly;
 (* MARK_DEBUG="true" *)reg 	[2:0]				tx_bit_cnt=3'd0;		//0-7
 (* MARK_DEBUG="true" *)reg 	[3:0]				tx_byte_cnt=4'd0;		//0-7, 0:header, 1-4:Vc, 5-8:ST, 9-10:CRC, 11:tail
 (* MARK_DEBUG="true" *)reg 						crc_en;
 (* MARK_DEBUG="true" *)wire 	[15:0]				crc_result_out;
 (* MARK_DEBUG="true" *)wire 						crc_result_ok;
 (* MARK_DEBUG="true" *)reg 	[7:0]				tx_shift_reg;
 
 assign debug_tx_data = tx_rdata;
 assign debug_tx_raddr = tx_raddr;          
 assign debug_tx_flag = tx_flag_dly;
 assign debug_tx_bit_cnt = tx_bit_cnt;
 
//-------------------------ipcore & module----------------------------------
//-------------------------ipcore & module----------------------------------
dpram_w512x32_r2048x8 	U_dpram_optic_tx(
    .clka(clk_sys),
    .ena(1'b1),
    .wea(tx_wea),
    .addra({8'd0,tx_waddr}),
    .dina({tx_wdata[7:0],tx_wdata[15:8],tx_wdata[23:16],tx_wdata[31:24]}),
    .clkb(clk_tx),
    .enb(1'b1),
    .addrb({8'd0,tx_raddr[2:0]}), 
    .doutb(tx_rdata[7:0]) 
);

   (* keep_hierarchy="yes" *) crc_tx  U_crc_tx(
    .clk(clk_tx),
    .sclr(trans_start),
    .data_in(tx_rdata[7:0]),
    .crc_en(crc_en),
    .data_out(crc_result_out[15:0]),
    .data_ok(crc_result_ok)
  );

//--------------------------------------------------------------------------
always @(posedge clk_tx)
begin
	tx_flag_dly <= tx_flag;
end

//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
//tx flag, hold until tx end
always @(posedge clk_tx)
begin
	if (reset)
		tx_flag <= 1'b0;
	else if (trans_start==1'b1)
		tx_flag <= 1'b1;
	else if (tx_bit_cnt[2:0]>=3'd7 && tx_byte_cnt[3:0]>=4'd11)
		tx_flag <= 1'b0;
	else ;
end

always @(posedge clk_tx)
begin
	if (tx_bit_cnt[2:0]>=3'd7 && tx_byte_cnt[3:0]>=4'd11)
		tx_bit_cnt[2:0] <= 3'd0;
	else if (tx_flag==1'b1)
		tx_bit_cnt[2:0] <= tx_bit_cnt[2:0] + 3'd1;
	else ;
end

always @(posedge clk_tx)
begin
	if (tx_bit_cnt[2:0]>=3'd7 && tx_byte_cnt[3:0]>=4'd11)
		tx_byte_cnt[3:0] <= 4'd0;
	else if (tx_bit_cnt[2:0]>=3'd7)
		tx_byte_cnt[3:0] <= tx_byte_cnt[3:0] + 4'd1;
	else ;
end

//--------------------------------------------------------------------------
//dpram read, only use first 4 addr, 0-3
always @(posedge clk_tx)
begin
	if (tx_bit_cnt[2:0]==3'd4)
		tx_raddr[2:0] <= tx_byte_cnt[2:0];
	else ;
end

//--------------------------------------------------------------------------
//crc enable
always @(posedge clk_tx)
begin
	if (tx_crc_fault==1'b0 && tx_bit_cnt[2:0]>=3'd7 && tx_byte_cnt[3:0]<=4'd7)
		crc_en <= 1'b1;
	else
		crc_en <= 1'b0;
end

//--------------------------------------------------------------------------
//optic tx
always @(posedge clk_tx)
begin
	if (tx_bit_cnt[2:0]==3'd0)
		case (tx_byte_cnt[3:0])
			4'd0:	tx_shift_reg[7:0] <= 8'h01;							//header
			4'd1,4'd2,4'd3,4'd4,4'd5,4'd6,4'd7,4'd8:	tx_shift_reg[7:0] <= tx_rdata[7:0];	//Vc, ST
			4'd9:	tx_shift_reg[7:0] <= crc_result_out[15:8];			//CRC MSB
			4'd10:	tx_shift_reg[7:0] <= crc_result_out[7:0];			//CRC LSB
			4'd11:	tx_shift_reg[7:0] <= 8'hFF;
			default: ;
		endcase
	else if (tx_flag==1'b1)
		tx_shift_reg[7:0] <= {tx_shift_reg[6:0],1'b0};
	else ;
end

always @(posedge clk_tx)
begin
	if (tx_comm_fault==1'b1)
		phy_txd <= 1'b0;
	else if (tx_flag_dly==1'b1)
		phy_txd <= tx_shift_reg[7];
	else
		phy_txd <= ~phy_txd;
end

endmodule
