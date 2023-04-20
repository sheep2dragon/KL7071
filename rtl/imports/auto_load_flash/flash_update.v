`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: <Shanghai Keliang Information Technology, Co.,Ltd>
// Engineer: yanglonglong
// 
// Create Date: 2021/12/13 14:50:05
// Design Name: 
// Module Name: flash_update
// Project Name: 
// Target Devices: xc7a15tcsg325-2
// Tool Versions: vivado2017.4
// Description: A7 board flash read / write control
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module flash_update(
    input       clk125m,
    input       rst,

    input       sys_clk,

    output      fifo_full,
    input       flash_data_rx_done,
    input       load_data_valid,
    input [7:0] load_data,
    input [1:0] load_device_select,

    output      flash_load_state_end,

    output      flash_cs,
    output      flash_di,
    output      flash_spi_clk_sw,
    output      flash_wp_n,
    output      flash_hold,
    input       flash_do

    );
    
wire       flash_clk;

assign flash_spi_clk_sw = 1'b0;
assign flash_wp_n       = 1'b1;
assign flash_hold       = 1'b1;


flash_top  u_flash_top(
       .clk                       (   clk125m     ),//input
       .reset                     (   rst         ),//input
       .sys_clk                   (   sys_clk     ),//input
       
       .flash_clk                 (   flash_clk   ),//output
       .device_type               (   2'b10       ),//input[1:0]  2'b01:K7     2'b10:A7
       
       .flash_page_byte_valid     (   load_data_valid  ),//input
       .flash_page_byte           (   load_data        ),//input[7:0]
       .fifo_full                 (   fifo_full        ),//output
       
       .flash_sector_num          (   9'd286       ),//input[8:0] 286
       .flash_page_num            (   24'd73184    ),//input[23:0] 73184
       .flash_fifo_wr_data_count  (                ),//output[12:0]
       
       .i_flash_data_rx_done      (  flash_data_rx_done  ),//input
       .load_device_select        (  load_device_select  ),//input[1:0]

       .flash_load_state_end      (  flash_load_state_end  ),//output

       .o_flash_cs                (  flash_cs     ) ,//output
       .o_flash_din               (  flash_di     ) ,//output
       .i_flash_dout              (  flash_do     )  //input
);


      
endmodule
