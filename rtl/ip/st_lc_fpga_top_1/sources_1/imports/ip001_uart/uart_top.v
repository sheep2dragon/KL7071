//==========================================================================
// Data				:	2015-03-19
// Author			:	Chen Biao
// Email			:	biao.chen@keliangtek.com
// purpose			:	IP001, uart	
//--------------------------------------------------------------------------
// Revision record	:
// data			person			issue number		detail
//
//==========================================================================
`timescale 1 ns / 1 ns

module uart_top# (
    parameter 				SYS_CLK_FREQ = 125,			//Clock frequency Unit: MHz
    parameter 				BAUD_RATE = 115200,
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
	output					com_232_tx,
	//user interface, user can difine freely for this data exchange buffer
	input					tx_valid,			//high pulse tx, same edge with serial_tx_data
	input		[7:0]		serial_tx_data,
	output					tx_busy,			//0: tx free   1: tx ongoing
	output					rx_valid,			//high pulse rx, same edge with serial_rx_data
	output		[7:0]		serial_rx_data,
	output					parity_err_flag		//0:normal 1:parity bit err
	);

localparam 					CLK_NUM_PER_BIT			= (SYS_CLK_FREQ*1000*1000)/BAUD_RATE;
//115200:	1085
//1M:		125
//5M:		25
//10M:		12
//12.5M:	10

//-------------------------signal definition--------------------------------
//-------------------------signal definition--------------------------------

//-------------------------main code----------------------------------------
//-------------------------main code----------------------------------------
//-------------------------ipcore & module----------------------------------
//-------------------------ipcore & module----------------------------------
uart_tx# (
    .CLK_NUM_PER_BIT(CLK_NUM_PER_BIT),
    .PARITY_CFG(PARITY_CFG),
    .STOP_BIT_NUM(STOP_BIT_NUM)
)
 	U_uart_tx(
	.reset(reset),
	.clk(clk),
	//uart interface with peripheral
	.com_232_tx(com_232_tx),
	//user interface, user can difine freely for this data exchange buffer
	.tx_valid(tx_valid),			//high pulse tx, same edge with serial_tx_data
	.serial_tx_data(serial_tx_data),
	.tx_busy(tx_busy)				//0: tx free   1: tx ongoing
	);

uart_rx# (
    .CLK_NUM_PER_BIT(CLK_NUM_PER_BIT),
    .PARITY_CFG(PARITY_CFG),
    .STOP_BIT_NUM(STOP_BIT_NUM)
)
	U_uart_rx(
	.reset(reset),
	.clk(clk),
	//uart interface with peripheral
	.com_232_rx(com_232_rx),
	//user interface, user can difine freely for this data exchange buffer
	.rx_valid(rx_valid),						//high pulse rx, same edge with serial_rx_data
	.serial_rx_data(serial_rx_data),
	.parity_err_flag(parity_err_flag)			//0:normal 1:parity bit err
	);

endmodule

