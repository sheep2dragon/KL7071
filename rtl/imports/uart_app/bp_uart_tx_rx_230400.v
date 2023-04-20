`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/24 11:49:58
// Design Name: 
// Module Name: bp_uart_tx_rx
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bp_uart_tx_rx_230400(
    input        clk,
    
    input        auto_load_en,
    input        tx_start,
    input [7:0]  tx_data,
    output       tx_busy,
    
    output       rx_ready,
    output [7:0] rx_data,
    
    output       data_to_load_valid,
    output [7:0] data_to_load,
    
    output       txd,
    input        rxd

    );

wire tx_data_busy;
wire rx_data_ready;

async_transmitter_230400 u_async_transmitter_230400(
	 .clk       (   clk        ),//input
	 .TxD_start (   tx_start   ),//input
	 .TxD_data  (   tx_data    ),//input[7:0]
	 .TxD       (   txd        ),//output
	 .TxD_busy  (   tx_data_busy   ) //output
);


async_receiver_230400 u_async_receiver_230400(
	 .clk            (  clk        ),//input
	 .RxD            (  rxd        ),//input
	 .RxD_data_ready (  rx_data_ready  ),//output
	 .RxD_data       (  rx_data        ) //output // data received, valid only (for one clock cycle) when RxD_data_ready is asserted
);

assign tx_busy = tx_data_busy | auto_load_en;
assign rx_ready = ( auto_load_en == 1'b1 ) ? 1'b0 : rx_data_ready;
assign data_to_load_valid = auto_load_en & rx_data_ready;
assign data_to_load = rx_data;

endmodule
