//==========================================================================
// Data				:	2017-07-01
// Author			:	Chen Biao
// Email			:	biao.chen@keliangtek.com
// purpose			:	uart	
//--------------------------------------------------------------------------
// Revision record	:
// data			person			issue number		detail
//
//==========================================================================
`timescale 1 ns / 1 ns

module uart_app_s#(
    parameter 				CH_NUM = 14			//optic board channel 0-13
)
(
    input 					reset,
    input 					clk_sys,
    output reg 				fpga_led,
    //initial information
    input 	 	[31:0]		fpga_version_optic,
    input 	 	[31:0]		fpga_time_optic,
    input 	 	[13:0]		sfp_abs,				//sfp absent, inverse at k7 fpga, original is 0:present  1:absent
    input 	 	[13:0]		sfp_los,				//sfp rx los, inverse at k7 fpga, original is 0:normal 1:los
    input 	 	[13:0]		rx_comm_err,			//LC channel rx communication error, 1:err 0: normal
    input 	 	[13:0]		rx_verify_err,			//LC channel rx CRC error, 1:err 0: normal
    input 	 	[10:0]		serdes_state,
	//reset cmd
    output reg 				soft_reset_cmd,							//high pulse, sofeware reset, take back state machine to STANDBY
	//spi flash switch
    output reg 				spi_flash_switch,						//0: traffic data  1:spi flash download
    //fault sim configuration, cmd
    output reg 	[CH_NUM*2-1:0]			optic_tx_comm_fault='d0,	//00:no fault 01: comm fault 10: crc fault
    output reg 	[CH_NUM-1:0]			optic_rx_comm_fault='d0,	//0: no fault 1: comm fault
	//uart interface
    input 					a7_led,
    input 					com_232_rx,
    output  				com_232_tx
	);

localparam 					BAUD_RATE 		= 12.5*1000*1000;	//12.5M simulation
localparam 					TX_DATA_LENGTH	= 5'd18;
localparam 					TX_RXCMD_BUFFER	= 8'h03;

//-------------------------signal definition--------------------------------
//-------------------------signal definition--------------------------------
reg 	[2:0]				a7_led_rx_dly;
reg 						tx_valid;
reg 	[7:0]				serial_tx_data;
wire 						tx_busy;
reg 						tx_busy_reg;
wire 						rx_valid;
wire 	[7:0]				serial_rx_data;
reg 	[4:0]				tx_data_cnt;
reg 						tx_length_char_cnt;
reg 	[4:0]				tx_frame_state;
localparam 					TX_IDLE			=5'b00000;
localparam 					TX_HEADER		=5'b00001;
localparam 					TX_CHARACTER	=5'b00010;
localparam 					TX_LENGTH		=5'b00100;
localparam 					TX_PAYLOAD		=5'b01000;
localparam 					TX_FRAME_END	=5'b10000;
reg 	[4:0]				rx_frame_state;
parameter 					RX_IDLE			=5'b00000;
parameter 					RX_HEADER		=5'b00001;
parameter 					RX_CHARACTER	=5'b00010;
parameter 					RX_LENGTH		=5'b00100;
parameter 					RX_PAYLOAD		=5'b01000;
parameter 					RX_FRAME_END	=5'b10000;
reg 	[6:0]				rx_data_cnt;
reg 	[6:0]				rx_data_length;
reg 						rx_length_char_cnt;
reg 	[7:0]				rx_txcmd_buffer;
reg 						fault_reset_cmd;						//high pulse, fault sim reset

//-------------------------ipcore & module----------------------------------
//-------------------------ipcore & module----------------------------------
//transfer Uart
uart_top# (
    .SYS_CLK_FREQ(100),				//Clock frequency Unit: MHz
    .BAUD_RATE(BAUD_RATE),			//Baud Rate Unit: bits/s
    .PARITY_CFG(3'b000),
    .STOP_BIT_NUM(2'b00)
)
 	U_uart_top(
	.reset(reset),
	.clk(clk_sys),
	//uart interface with peripheral
	.com_232_rx(com_232_rx),
	.com_232_tx(com_232_tx),
	//user interface, user can difine freely for this data exchange buffer
	.tx_valid(tx_valid),						//high pulse tx, same edge with serial_tx_data
	.serial_tx_data(serial_tx_data),
	.tx_busy(tx_busy),							//0: tx free   1: tx ongoing
	.rx_valid(rx_valid),						//high pulse rx, same edge with serial_rx_data
	.serial_rx_data(serial_rx_data),
	.parity_err_flag()							//0:normal 1:parity bit err
	);

//-------------------------main code----------------------------------------
//-------------------------main code----------------------------------------
always @(posedge clk_sys)
begin
	//
	a7_led_rx_dly <= {a7_led_rx_dly[1:0], a7_led};
	fpga_led <= a7_led_rx_dly[2];
	//Uart tx
	tx_busy_reg <= tx_busy;
end

//-------------------------uart rx------------------------------------------
//-------------------------uart rx------------------------------------------
always @(posedge clk_sys)
begin
	if (reset)
		rx_frame_state <= RX_IDLE;
	else if (rx_valid==1'b1 && rx_frame_state==RX_IDLE && serial_rx_data[7:0]==8'hBE)
		rx_frame_state <= RX_HEADER;
	else if (rx_valid==1'b1 && rx_frame_state==RX_HEADER)
		rx_frame_state <= RX_CHARACTER;
	else if (rx_valid==1'b1 && rx_frame_state==RX_CHARACTER)
		rx_frame_state <= RX_LENGTH;
	else if (rx_valid==1'b1 && rx_frame_state==RX_LENGTH && rx_length_char_cnt==1'b1)
		rx_frame_state <= RX_PAYLOAD;
	else if (rx_valid==1'b1 && rx_frame_state==RX_PAYLOAD && rx_data_cnt[6:0]>=rx_data_length[6:0])
		rx_frame_state <= RX_FRAME_END;
	else if (rx_frame_state==RX_FRAME_END && serial_rx_data[7:0]==8'hED)
		rx_frame_state <= RX_IDLE;
	else ;
end

always @(posedge clk_sys)
begin
	if (reset)
		rx_length_char_cnt <= 1'b0;
	else if (rx_valid==1'b1 && rx_frame_state==RX_LENGTH && rx_length_char_cnt==1'b1)
		rx_length_char_cnt <= 1'b0;		//end of rx length
	else if (rx_valid==1'b1 && rx_frame_state==RX_LENGTH)
		rx_length_char_cnt <= 1'b1;
	else ;
end

always @(posedge clk_sys)
begin
	if (rx_frame_state==RX_IDLE)
		rx_data_cnt[6:0] <= 7'd0;
	else if (rx_frame_state==RX_FRAME_END && serial_rx_data[7:0]==8'hED)
		rx_data_cnt[6:0] <= 7'd0;
	else if (rx_valid==1'b1 && rx_frame_state==RX_LENGTH && rx_length_char_cnt==1'b1)
		rx_data_cnt[6:0] <= 7'd1;
	else if (rx_valid==1'b1 && rx_frame_state==RX_PAYLOAD && rx_data_cnt[6:0]<rx_data_length[6:0])
		rx_data_cnt[6:0] <= rx_data_cnt[6:0] + 7'd1;
	else ;
end

always @(posedge clk_sys)
begin
	if (rx_valid==1'b1 && rx_frame_state==RX_LENGTH && rx_length_char_cnt==1'b0)
		rx_data_length[6:0] <= serial_rx_data[6:0];
	else ;
end

always @(posedge clk_sys)
begin
	if (rx_valid==1'b1 && rx_frame_state==RX_HEADER)
		rx_txcmd_buffer[7:0] <= serial_rx_data[7:0];
	else ;
end

//--------------------------------------------------------------------------uart rx 0x00
//fault sim configuration, cmd
always @(posedge clk_sys)
begin
    if (reset)
        spi_flash_switch <= 1'b0;
	else if (rx_frame_state==RX_FRAME_END && serial_rx_data[7:0]==8'hED && rx_txcmd_buffer[7:0]==8'h00)
		spi_flash_switch <= 1'b1;
	else if (soft_reset_cmd==1'b1)
        spi_flash_switch <= 1'b0;
    else ;
end

//--------------------------------------------------------------------------uart rx 0x04
//fault sim configuration, cmd
always @(posedge clk_sys)
begin
	if (rx_valid==1'b1 && rx_txcmd_buffer[7:0]==8'h04 && rx_data_cnt[6:0]==7'd1 && serial_rx_data[7:0]==8'h00)
		soft_reset_cmd <= 1'b1;
	else
		soft_reset_cmd <= 1'b0;
end

always @(posedge clk_sys)
begin
	if (rx_valid==1'b1 && rx_txcmd_buffer[7:0]==8'h04 && rx_data_cnt[6:0]==7'd1 && serial_rx_data[7:0]==8'h01)
		fault_reset_cmd <= 1'b1;
	else
		fault_reset_cmd <= 1'b0;
end

//--------------------------------------------------------------------------uart rx 0x20
//fault sim configuration, cmd
always @(posedge clk_sys)
begin
	if (soft_reset_cmd==1'b1 || fault_reset_cmd==1'b1)
		optic_tx_comm_fault[27:0] <= 28'd0; 
	else if (rx_valid==1'b1 && rx_txcmd_buffer[7:0]==8'h20)
		case (rx_data_cnt[6:0])
			7'd2:	 optic_tx_comm_fault[1:0] <= serial_rx_data[1:0];
			7'd10:	 optic_tx_comm_fault[3:2] <= serial_rx_data[1:0];
			7'd18:	 optic_tx_comm_fault[5:4] <= serial_rx_data[1:0];
			7'd26:	 optic_tx_comm_fault[7:6] <= serial_rx_data[1:0];
			7'd34:	 optic_tx_comm_fault[9:8] <= serial_rx_data[1:0];
			7'd42:	 optic_tx_comm_fault[11:10] <= serial_rx_data[1:0];
			7'd50:	 optic_tx_comm_fault[13:12] <= serial_rx_data[1:0];
			7'd58:	 optic_tx_comm_fault[15:14] <= serial_rx_data[1:0];
			7'd66:	 optic_tx_comm_fault[17:16] <= serial_rx_data[1:0];
			7'd74:	 optic_tx_comm_fault[19:18] <= serial_rx_data[1:0];
			7'd82:	 optic_tx_comm_fault[21:20] <= serial_rx_data[1:0];
			7'd90:	 optic_tx_comm_fault[23:22] <= serial_rx_data[1:0];
			7'd98:	 optic_tx_comm_fault[25:24] <= serial_rx_data[1:0];
			7'd106:  optic_tx_comm_fault[27:26] <= serial_rx_data[1:0];
			default : ;
		endcase
	else ;
end

always @(posedge clk_sys)
begin
	if (soft_reset_cmd==1'b1 || fault_reset_cmd==1'b1)
		optic_rx_comm_fault[13:0] <= 14'd0; 
	else if (rx_valid==1'b1 && rx_txcmd_buffer[7:0]==8'h20)
		case (rx_data_cnt[6:0])
			{7'd2  +7'd1}:	optic_rx_comm_fault[0] <= serial_rx_data[1] | serial_rx_data[0];
			{7'd10 +7'd1}:	optic_rx_comm_fault[1] <= serial_rx_data[1] | serial_rx_data[0];
			{7'd18 +7'd1}:	optic_rx_comm_fault[2] <= serial_rx_data[1] | serial_rx_data[0];
			{7'd26 +7'd1}:	optic_rx_comm_fault[3] <= serial_rx_data[1] | serial_rx_data[0];
			{7'd34 +7'd1}:	optic_rx_comm_fault[4] <= serial_rx_data[1] | serial_rx_data[0];
			{7'd42 +7'd1}:	optic_rx_comm_fault[5] <= serial_rx_data[1] | serial_rx_data[0];
			{7'd50 +7'd1}:	optic_rx_comm_fault[6] <= serial_rx_data[1] | serial_rx_data[0];
			{7'd58 +7'd1}:	optic_rx_comm_fault[7] <= serial_rx_data[1] | serial_rx_data[0];
			{7'd66 +7'd1}:	optic_rx_comm_fault[8] <= serial_rx_data[1] | serial_rx_data[0];
			{7'd74 +7'd1}:	optic_rx_comm_fault[9] <= serial_rx_data[1] | serial_rx_data[0];
			{7'd82 +7'd1}:	optic_rx_comm_fault[10] <= serial_rx_data[1] | serial_rx_data[0];
			{7'd90 +7'd1}:	optic_rx_comm_fault[11] <= serial_rx_data[1] | serial_rx_data[0];
			{7'd98 +7'd1}:	optic_rx_comm_fault[12] <= serial_rx_data[1] | serial_rx_data[0];
			{7'd106+7'd1}:  optic_rx_comm_fault[13] <= serial_rx_data[1] | serial_rx_data[0];
			default : ;
		endcase
	else ;
end

//-------------------------uart tx------------------------------------------
//-------------------------uart tx------------------------------------------
//uart tx state machine
always @(posedge clk_sys)
begin
	if (reset)
		tx_frame_state <= TX_IDLE;
	else if (a7_led_rx_dly[2]==1'b0 && fpga_led==1'b1)
		tx_frame_state <= TX_HEADER;
	else if (tx_busy==1'b0 && tx_busy_reg==1'b1 && tx_frame_state==TX_HEADER)
		tx_frame_state <= TX_CHARACTER;
	else if (tx_busy==1'b0 && tx_busy_reg==1'b1 && tx_frame_state==TX_CHARACTER)
		tx_frame_state <= TX_LENGTH;
	else if (tx_busy==1'b0 && tx_busy_reg==1'b1 && tx_frame_state==TX_LENGTH && tx_length_char_cnt==1'b1)
		tx_frame_state <= TX_PAYLOAD;
	else if (tx_busy==1'b0 && tx_busy_reg==1'b1 && tx_frame_state==TX_PAYLOAD && tx_data_cnt[4:0]>=TX_DATA_LENGTH)
		tx_frame_state <= TX_FRAME_END;
	else if (tx_busy==1'b0 && tx_busy_reg==1'b1 && tx_frame_state==TX_FRAME_END)
		tx_frame_state <= TX_IDLE;
	else ;
end

always @(posedge clk_sys)
begin
	if (reset)
		tx_length_char_cnt <= 1'b0;
	else if (tx_busy==1'b0 && tx_busy_reg==1'b1 && tx_frame_state==TX_LENGTH && tx_length_char_cnt==1'b1)
		tx_length_char_cnt <= 1'b0;		//end of tx length
	else if (tx_busy==1'b0 && tx_busy_reg==1'b1 && tx_frame_state==TX_LENGTH)
		tx_length_char_cnt <= 1'b1;
	else ;
end
//
always @(posedge clk_sys)
begin
	if (reset)
		tx_data_cnt[4:0] <= 5'd0;
	else if (tx_busy==1'b0 && tx_busy_reg==1'b1 && tx_frame_state==TX_PAYLOAD && tx_data_cnt[4:0]>=TX_DATA_LENGTH)
		tx_data_cnt[4:0] <= 5'd0;		//end of tx
	else if (tx_busy==1'b0 && tx_busy_reg==1'b1 && tx_frame_state==TX_LENGTH && tx_length_char_cnt==1'b1)
		tx_data_cnt[4:0] <= 5'd1;
	else if (tx_busy==1'b0 && tx_busy_reg==1'b1 && tx_frame_state==TX_PAYLOAD && tx_data_cnt[4:0]<TX_DATA_LENGTH)
		tx_data_cnt[4:0] <= tx_data_cnt[4:0] + 5'd1;
	else ;
end

//--------------------------------------------------------------------------
//assign uart tx frame
always @(posedge clk_sys)
begin
	if (a7_led_rx_dly[2]==1'b0 && fpga_led==1'b1)
		{tx_valid, serial_tx_data[7:0]} <= {1'b1, 8'hBE};						//tx frame TX_HEADER
	else if (tx_busy==1'b0 && tx_busy_reg==1'b1 && tx_frame_state==TX_HEADER)
		{tx_valid, serial_tx_data[7:0]} <= {1'b1,TX_RXCMD_BUFFER};				//tx frame Uart ack cmd
	else if (tx_busy==1'b0 && tx_busy_reg==1'b1 && tx_frame_state==TX_CHARACTER)
		{tx_valid, serial_tx_data[7:0]} <= {1'b1,8'd0};							//tx frame length MSB
	else if (tx_busy==1'b0 && tx_busy_reg==1'b1 && tx_frame_state==TX_LENGTH && tx_length_char_cnt==1'b0)
		{tx_valid, serial_tx_data[7:0]} <= {1'b1,3'd0,TX_DATA_LENGTH};			//tx frame length LSB
	else if ((tx_busy==1'b0 && tx_busy_reg==1'b1 && tx_frame_state==TX_LENGTH && tx_length_char_cnt==1'b1) ||
			(tx_busy==1'b0 && tx_busy_reg==1'b1 && tx_frame_state==TX_PAYLOAD && tx_data_cnt[4:0]!=TX_DATA_LENGTH))
		begin
			case (tx_data_cnt[4:0])
				5'd0:	{tx_valid, serial_tx_data[7:0]} <= {1'b1,fpga_version_optic[31:24]};
				5'd1:	{tx_valid, serial_tx_data[7:0]} <= {1'b1,fpga_version_optic[23:16]};
				5'd2:	{tx_valid, serial_tx_data[7:0]} <= {1'b1,fpga_version_optic[15:8]};
				5'd3:	{tx_valid, serial_tx_data[7:0]} <= {1'b1,fpga_version_optic[7:0]};
				5'd4:	{tx_valid, serial_tx_data[7:0]} <= {1'b1,fpga_time_optic[31:24]};
				5'd5:	{tx_valid, serial_tx_data[7:0]} <= {1'b1,fpga_time_optic[23:16]};
				5'd6:	{tx_valid, serial_tx_data[7:0]} <= {1'b1,fpga_time_optic[15:8]};
				5'd7:	{tx_valid, serial_tx_data[7:0]} <= {1'b1,fpga_time_optic[7:0]};
				5'd8:	{tx_valid, serial_tx_data[7:0]} <= {1'b1,2'd0,sfp_abs[13:8]};
				5'd9:	{tx_valid, serial_tx_data[7:0]} <= {1'b1,sfp_abs[7:0]};
				5'd10:	{tx_valid, serial_tx_data[7:0]} <= {1'b1,2'd0,sfp_los[13:8]};
				5'd11:	{tx_valid, serial_tx_data[7:0]} <= {1'b1,sfp_los[7:0]};
				5'd12:	{tx_valid, serial_tx_data[7:0]} <= {1'b1,2'd0,rx_comm_err[13:8]};
				5'd13:	{tx_valid, serial_tx_data[7:0]} <= {1'b1,rx_comm_err[7:0]};
				5'd14:	{tx_valid, serial_tx_data[7:0]} <= {1'b1,2'd0,rx_verify_err[13:8]};
				5'd15:	{tx_valid, serial_tx_data[7:0]} <= {1'b1,rx_verify_err[7:0]};
				5'd16:	{tx_valid, serial_tx_data[7:0]} <= {1'b1,5'd0,serdes_state[10:8]};
				5'd17:	{tx_valid, serial_tx_data[7:0]} <= {1'b1,serdes_state[7:0]};
				default: {tx_valid, serial_tx_data[7:0]} <= {1'b0, 8'd0};
			endcase
		end		
	else if (tx_busy==1'b0 && tx_busy_reg==1'b1 && tx_frame_state==TX_PAYLOAD && tx_data_cnt[4:0]==TX_DATA_LENGTH)
		{tx_valid, serial_tx_data[7:0]} <= {1'b1,8'hED};						//tx frame End
	else
		{tx_valid, serial_tx_data[7:0]} <= {1'b0, serial_tx_data[7:0]};
end

endmodule

