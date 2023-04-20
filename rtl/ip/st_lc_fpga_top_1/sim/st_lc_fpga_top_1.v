// (c) Copyright 1995-2018 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:user:st_lc_fpga_top:1.0
// IP Revision: 2

`timescale 1ns/1ps

(* DowngradeIPIdentifiedWarnings = "yes" *)
module st_lc_fpga_top_1 (
  FPGA_RST_N,
  MGT_REFCLK_216_P,
  MGT_REFCLK_216_N,
  USER_CLK_P,
  USER_CLK_N,
  FMC_LPC_TX0,
  TP23,
  SFPP8_ABS_8,
  SFPP9_ABS_9,
  SFPP12_SCL,
  SFPP1_SCL,
  SFPP13_LOS,
  SFPP12_ABS_12,
  SFPP0_SDA,
  SFPP1_SDA,
  SFPP0_SCL,
  SFPP11_SCL,
  SFPP1_ABS_1,
  SFPP11_SDA,
  SFPP1_LOS,
  SFPP1_TX_DIS,
  SFPP0_TX_DIS,
  SFPP0_LOS,
  SFPP11_LOS,
  SFPP0_ABS_0,
  SFPP11_ABS_11,
  SFPP10_ABS_10,
  SFPP11_TX_DIS,
  SFPP10_LOS,
  SFPP13_ABS_13,
  SFPP10_TX_DIS,
  SFPP12_TX_DIS,
  SFPP12_LOS,
  SFPP9_LOS,
  SFPP13_TX_DIS,
  SFPP5_ABS_5,
  SFPP8_TX_DIS,
  SFPP5_LOS,
  TP22,
  FSD_DATA0,
  SFPP_RD0,
  SFPP_RD1,
  SFPP_RD2,
  SFPP_RD3,
  SFPP_RD11,
  SFPP_RD10,
  SFPP_RD12,
  SFPP_RD13,
  SFPP_RD4,
  SFPP_RD8,
  SFPP_RD5,
  SFPP_RD9,
  SFPP_RD7,
  SFPP_RD6,
  FTX_DATA7,
  SFPP_TD0,
  SFPP_TD1,
  SFPP_TD9,
  SFPP_TD11,
  SFPP_TD5,
  SFPP_TD13,
  SFPP_TD12,
  SFPP_TD10,
  SFPP_TD7,
  SFPP_TD6,
  SFPP10_SDA,
  SFPP10_SCL,
  SFPP13_SCL,
  SFPP12_SDA,
  SFPP8_LOS,
  SFPP13_SDA,
  SFPP_TD2,
  SFPP_TD3,
  SFPP_TD4,
  SFPP_TD8,
  SFPP9_TX_DIS,
  SFPP9_SCL,
  SFPP9_SDA,
  SFPP8_SDA,
  SFPP4_SCL,
  SFPP2_SCL,
  SFPP3_SCL,
  SFPP3_SDA,
  SFPP2_SDA,
  SFPP7_SDA,
  SFPP4_SDA,
  SFPP7_SCL,
  SFPP5_SCL,
  SFPP5_SDA,
  SFPP6_SDA,
  SFPP6_SCL,
  SFPP8_SCL,
  SFPP2_TX_DIS,
  SFPP3_TX_DIS,
  SFPP2_ABS_2,
  SFPP2_LOS,
  SFPP3_LOS,
  SFPP3_ABS_3,
  SFPP6_ABS_6,
  SFPP6_TX_DIS,
  SFPP7_TX_DIS,
  SFPP7_LOS,
  SFPP7_ABS_7,
  SFPP4_TX_DIS,
  SFPP4_LOS,
  SFPP6_LOS,
  SFPP5_TX_DIS,
  SFPP4_ABS_4,
  FMC_LPC_GTX00_P,
  FMC_LPC_GTX00_N,
  FMC_LPC_GRX00_P,
  FMC_LPC_GRX00_N,
  FMC_LPC_TX,
  FMC_LPC_RX,
  HP_UART_TX,
  HP_UART_RX,
  EEPROM_IIC_SCL,
  EEPROM_IIC_SDA,
  FLASH_SPI_CLK_SW,
  FLASH_SPI_CS,
  FLASH_SPI_DI,
  FLASH_SPI_DO,
  FLASH_WP_N,
  FLASH_HOLD,
  FLASH_SPI_IO_CLK,
  DEBUG_UART_TX0,
  DEBUG_UART_RX0,
  DEBUG_UART_TX1,
  DEBUG_UART_RX1,
  LED1_ON,
  LED2_ON,
  LED3_ON,
  reset,
  clk_sys,
  clk_125M,
  clk_50M,
  clk_250M,
  vc_trans_data,
  st_trans_data,
  trans_start,
  phy_txd,
  rx_comm_err,
  rx_verify_err,
  phy_rxd,
  rxd_data
);

input wire FPGA_RST_N;
input wire MGT_REFCLK_216_P;
input wire MGT_REFCLK_216_N;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 USER_CLK_P CLK" *)
input wire USER_CLK_P;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 USER_CLK_N CLK" *)
input wire USER_CLK_N;
input wire FMC_LPC_TX0;
output wire TP23;
input wire SFPP8_ABS_8;
input wire SFPP9_ABS_9;
output wire SFPP12_SCL;
output wire SFPP1_SCL;
input wire SFPP13_LOS;
input wire SFPP12_ABS_12;
output wire SFPP0_SDA;
output wire SFPP1_SDA;
output wire SFPP0_SCL;
output wire SFPP11_SCL;
input wire SFPP1_ABS_1;
output wire SFPP11_SDA;
input wire SFPP1_LOS;
output wire SFPP1_TX_DIS;
output wire SFPP0_TX_DIS;
input wire SFPP0_LOS;
input wire SFPP11_LOS;
input wire SFPP0_ABS_0;
input wire SFPP11_ABS_11;
input wire SFPP10_ABS_10;
output wire SFPP11_TX_DIS;
input wire SFPP10_LOS;
input wire SFPP13_ABS_13;
output wire SFPP10_TX_DIS;
output wire SFPP12_TX_DIS;
input wire SFPP12_LOS;
input wire SFPP9_LOS;
output wire SFPP13_TX_DIS;
input wire SFPP5_ABS_5;
output wire SFPP8_TX_DIS;
input wire SFPP5_LOS;
output wire TP22;
input wire FSD_DATA0;
input wire SFPP_RD0;
input wire SFPP_RD1;
input wire SFPP_RD2;
input wire SFPP_RD3;
input wire SFPP_RD11;
input wire SFPP_RD10;
input wire SFPP_RD12;
input wire SFPP_RD13;
input wire SFPP_RD4;
input wire SFPP_RD8;
input wire SFPP_RD5;
input wire SFPP_RD9;
input wire SFPP_RD7;
input wire SFPP_RD6;
input wire FTX_DATA7;
output wire SFPP_TD0;
output wire SFPP_TD1;
output wire SFPP_TD9;
output wire SFPP_TD11;
output wire SFPP_TD5;
output wire SFPP_TD13;
output wire SFPP_TD12;
output wire SFPP_TD10;
output wire SFPP_TD7;
output wire SFPP_TD6;
output wire SFPP10_SDA;
output wire SFPP10_SCL;
output wire SFPP13_SCL;
output wire SFPP12_SDA;
input wire SFPP8_LOS;
output wire SFPP13_SDA;
output wire SFPP_TD2;
output wire SFPP_TD3;
output wire SFPP_TD4;
output wire SFPP_TD8;
output wire SFPP9_TX_DIS;
output wire SFPP9_SCL;
output wire SFPP9_SDA;
output wire SFPP8_SDA;
output wire SFPP4_SCL;
output wire SFPP2_SCL;
output wire SFPP3_SCL;
output wire SFPP3_SDA;
output wire SFPP2_SDA;
output wire SFPP7_SDA;
output wire SFPP4_SDA;
output wire SFPP7_SCL;
output wire SFPP5_SCL;
output wire SFPP5_SDA;
output wire SFPP6_SDA;
output wire SFPP6_SCL;
output wire SFPP8_SCL;
output wire SFPP2_TX_DIS;
output wire SFPP3_TX_DIS;
input wire SFPP2_ABS_2;
input wire SFPP2_LOS;
input wire SFPP3_LOS;
input wire SFPP3_ABS_3;
input wire SFPP6_ABS_6;
output wire SFPP6_TX_DIS;
output wire SFPP7_TX_DIS;
input wire SFPP7_LOS;
input wire SFPP7_ABS_7;
output wire SFPP4_TX_DIS;
input wire SFPP4_LOS;
input wire SFPP6_LOS;
output wire SFPP5_TX_DIS;
input wire SFPP4_ABS_4;
output wire FMC_LPC_GTX00_P;
output wire FMC_LPC_GTX00_N;
input wire FMC_LPC_GRX00_P;
input wire FMC_LPC_GRX00_N;
input wire [3 : 1] FMC_LPC_TX;
output wire [2 : 0] FMC_LPC_RX;
input wire HP_UART_TX;
output wire HP_UART_RX;
output wire EEPROM_IIC_SCL;
output wire EEPROM_IIC_SDA;
output wire FLASH_SPI_CLK_SW;
output wire FLASH_SPI_CS;
output wire FLASH_SPI_DI;
input wire FLASH_SPI_DO;
output wire FLASH_WP_N;
output wire FLASH_HOLD;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 FLASH_SPI_IO_CLK CLK" *)
output wire FLASH_SPI_IO_CLK;
output wire DEBUG_UART_TX0;
input wire DEBUG_UART_RX0;
output wire DEBUG_UART_TX1;
input wire DEBUG_UART_RX1;
output wire LED1_ON;
output wire LED2_ON;
output wire LED3_ON;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset RST" *)
output wire reset;
output wire clk_sys;
output wire clk_125M;
output wire clk_50M;
output wire clk_250M;
output wire [319 : 0] vc_trans_data;
output wire [319 : 0] st_trans_data;
output wire trans_start;
input wire [9 : 0] phy_txd;
input wire [9 : 0] rx_comm_err;
input wire [9 : 0] rx_verify_err;
output wire [9 : 0] phy_rxd;
input wire [79 : 0] rxd_data;

  st_lc_fpga_top inst (
    .FPGA_RST_N(FPGA_RST_N),
    .MGT_REFCLK_216_P(MGT_REFCLK_216_P),
    .MGT_REFCLK_216_N(MGT_REFCLK_216_N),
    .USER_CLK_P(USER_CLK_P),
    .USER_CLK_N(USER_CLK_N),
    .FMC_LPC_TX0(FMC_LPC_TX0),
    .TP23(TP23),
    .SFPP8_ABS_8(SFPP8_ABS_8),
    .SFPP9_ABS_9(SFPP9_ABS_9),
    .SFPP12_SCL(SFPP12_SCL),
    .SFPP1_SCL(SFPP1_SCL),
    .SFPP13_LOS(SFPP13_LOS),
    .SFPP12_ABS_12(SFPP12_ABS_12),
    .SFPP0_SDA(SFPP0_SDA),
    .SFPP1_SDA(SFPP1_SDA),
    .SFPP0_SCL(SFPP0_SCL),
    .SFPP11_SCL(SFPP11_SCL),
    .SFPP1_ABS_1(SFPP1_ABS_1),
    .SFPP11_SDA(SFPP11_SDA),
    .SFPP1_LOS(SFPP1_LOS),
    .SFPP1_TX_DIS(SFPP1_TX_DIS),
    .SFPP0_TX_DIS(SFPP0_TX_DIS),
    .SFPP0_LOS(SFPP0_LOS),
    .SFPP11_LOS(SFPP11_LOS),
    .SFPP0_ABS_0(SFPP0_ABS_0),
    .SFPP11_ABS_11(SFPP11_ABS_11),
    .SFPP10_ABS_10(SFPP10_ABS_10),
    .SFPP11_TX_DIS(SFPP11_TX_DIS),
    .SFPP10_LOS(SFPP10_LOS),
    .SFPP13_ABS_13(SFPP13_ABS_13),
    .SFPP10_TX_DIS(SFPP10_TX_DIS),
    .SFPP12_TX_DIS(SFPP12_TX_DIS),
    .SFPP12_LOS(SFPP12_LOS),
    .SFPP9_LOS(SFPP9_LOS),
    .SFPP13_TX_DIS(SFPP13_TX_DIS),
    .SFPP5_ABS_5(SFPP5_ABS_5),
    .SFPP8_TX_DIS(SFPP8_TX_DIS),
    .SFPP5_LOS(SFPP5_LOS),
    .TP22(TP22),
    .FSD_DATA0(FSD_DATA0),
    .SFPP_RD0(SFPP_RD0),
    .SFPP_RD1(SFPP_RD1),
    .SFPP_RD2(SFPP_RD2),
    .SFPP_RD3(SFPP_RD3),
    .SFPP_RD11(SFPP_RD11),
    .SFPP_RD10(SFPP_RD10),
    .SFPP_RD12(SFPP_RD12),
    .SFPP_RD13(SFPP_RD13),
    .SFPP_RD4(SFPP_RD4),
    .SFPP_RD8(SFPP_RD8),
    .SFPP_RD5(SFPP_RD5),
    .SFPP_RD9(SFPP_RD9),
    .SFPP_RD7(SFPP_RD7),
    .SFPP_RD6(SFPP_RD6),
    .FTX_DATA7(FTX_DATA7),
    .SFPP_TD0(SFPP_TD0),
    .SFPP_TD1(SFPP_TD1),
    .SFPP_TD9(SFPP_TD9),
    .SFPP_TD11(SFPP_TD11),
    .SFPP_TD5(SFPP_TD5),
    .SFPP_TD13(SFPP_TD13),
    .SFPP_TD12(SFPP_TD12),
    .SFPP_TD10(SFPP_TD10),
    .SFPP_TD7(SFPP_TD7),
    .SFPP_TD6(SFPP_TD6),
    .SFPP10_SDA(SFPP10_SDA),
    .SFPP10_SCL(SFPP10_SCL),
    .SFPP13_SCL(SFPP13_SCL),
    .SFPP12_SDA(SFPP12_SDA),
    .SFPP8_LOS(SFPP8_LOS),
    .SFPP13_SDA(SFPP13_SDA),
    .SFPP_TD2(SFPP_TD2),
    .SFPP_TD3(SFPP_TD3),
    .SFPP_TD4(SFPP_TD4),
    .SFPP_TD8(SFPP_TD8),
    .SFPP9_TX_DIS(SFPP9_TX_DIS),
    .SFPP9_SCL(SFPP9_SCL),
    .SFPP9_SDA(SFPP9_SDA),
    .SFPP8_SDA(SFPP8_SDA),
    .SFPP4_SCL(SFPP4_SCL),
    .SFPP2_SCL(SFPP2_SCL),
    .SFPP3_SCL(SFPP3_SCL),
    .SFPP3_SDA(SFPP3_SDA),
    .SFPP2_SDA(SFPP2_SDA),
    .SFPP7_SDA(SFPP7_SDA),
    .SFPP4_SDA(SFPP4_SDA),
    .SFPP7_SCL(SFPP7_SCL),
    .SFPP5_SCL(SFPP5_SCL),
    .SFPP5_SDA(SFPP5_SDA),
    .SFPP6_SDA(SFPP6_SDA),
    .SFPP6_SCL(SFPP6_SCL),
    .SFPP8_SCL(SFPP8_SCL),
    .SFPP2_TX_DIS(SFPP2_TX_DIS),
    .SFPP3_TX_DIS(SFPP3_TX_DIS),
    .SFPP2_ABS_2(SFPP2_ABS_2),
    .SFPP2_LOS(SFPP2_LOS),
    .SFPP3_LOS(SFPP3_LOS),
    .SFPP3_ABS_3(SFPP3_ABS_3),
    .SFPP6_ABS_6(SFPP6_ABS_6),
    .SFPP6_TX_DIS(SFPP6_TX_DIS),
    .SFPP7_TX_DIS(SFPP7_TX_DIS),
    .SFPP7_LOS(SFPP7_LOS),
    .SFPP7_ABS_7(SFPP7_ABS_7),
    .SFPP4_TX_DIS(SFPP4_TX_DIS),
    .SFPP4_LOS(SFPP4_LOS),
    .SFPP6_LOS(SFPP6_LOS),
    .SFPP5_TX_DIS(SFPP5_TX_DIS),
    .SFPP4_ABS_4(SFPP4_ABS_4),
    .FMC_LPC_GTX00_P(FMC_LPC_GTX00_P),
    .FMC_LPC_GTX00_N(FMC_LPC_GTX00_N),
    .FMC_LPC_GRX00_P(FMC_LPC_GRX00_P),
    .FMC_LPC_GRX00_N(FMC_LPC_GRX00_N),
    .FMC_LPC_TX(FMC_LPC_TX),
    .FMC_LPC_RX(FMC_LPC_RX),
    .HP_UART_TX(HP_UART_TX),
    .HP_UART_RX(HP_UART_RX),
    .EEPROM_IIC_SCL(EEPROM_IIC_SCL),
    .EEPROM_IIC_SDA(EEPROM_IIC_SDA),
    .FLASH_SPI_CLK_SW(FLASH_SPI_CLK_SW),
    .FLASH_SPI_CS(FLASH_SPI_CS),
    .FLASH_SPI_DI(FLASH_SPI_DI),
    .FLASH_SPI_DO(FLASH_SPI_DO),
    .FLASH_WP_N(FLASH_WP_N),
    .FLASH_HOLD(FLASH_HOLD),
    .FLASH_SPI_IO_CLK(FLASH_SPI_IO_CLK),
    .DEBUG_UART_TX0(DEBUG_UART_TX0),
    .DEBUG_UART_RX0(DEBUG_UART_RX0),
    .DEBUG_UART_TX1(DEBUG_UART_TX1),
    .DEBUG_UART_RX1(DEBUG_UART_RX1),
    .LED1_ON(LED1_ON),
    .LED2_ON(LED2_ON),
    .LED3_ON(LED3_ON),
    .reset(reset),
    .clk_sys(clk_sys),
    .clk_125M(clk_125M),
    .clk_50M(clk_50M),
    .clk_250M(clk_250M),
    .vc_trans_data(vc_trans_data),
    .st_trans_data(st_trans_data),
    .trans_start(trans_start),
    .phy_txd(phy_txd),
    .rx_comm_err(rx_comm_err),
    .rx_verify_err(rx_verify_err),
    .phy_rxd(phy_rxd),
    .rxd_data(rxd_data)
  );
endmodule
