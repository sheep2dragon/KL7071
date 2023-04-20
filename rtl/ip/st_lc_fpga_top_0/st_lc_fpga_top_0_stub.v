// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.1 (win64) Build 1538259 Fri Apr  8 15:45:27 MDT 2016
// Date        : Fri Jul 13 09:31:48 2018
// Host        : WIN-FPGA01 running 64-bit major release  (build 7600)
// Command     : write_verilog -force -mode synth_stub
//               e:/projects/PT17052_KL7071_V2/hw_version_0711/fos_a7_optic_fpga/fos_a7_optic_fpga.srcs/sources_1/ip/st_lc_fpga_top_0/st_lc_fpga_top_0_stub.v
// Design      : st_lc_fpga_top_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a15tcsg325-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "st_lc_fpga_top,Vivado 2016.1" *)
module st_lc_fpga_top_0(FPGA_RST_N, MGT_REFCLK_216_P, MGT_REFCLK_216_N, USER_CLK_P, USER_CLK_N, FMC_LPC_TX0, TP23, SFPP8_ABS_8, SFPP9_ABS_9, SFPP12_SCL, SFPP1_SCL, SFPP13_LOS, SFPP12_ABS_12, SFPP0_SDA, SFPP1_SDA, SFPP0_SCL, SFPP11_SCL, SFPP1_ABS_1, SFPP11_SDA, SFPP1_LOS, SFPP1_TX_DIS, SFPP0_TX_DIS, SFPP0_LOS, SFPP11_LOS, SFPP0_ABS_0, SFPP11_ABS_11, SFPP10_ABS_10, SFPP11_TX_DIS, SFPP10_LOS, SFPP13_ABS_13, SFPP10_TX_DIS, SFPP12_TX_DIS, SFPP12_LOS, SFPP9_LOS, SFPP13_TX_DIS, SFPP5_ABS_5, SFPP8_TX_DIS, SFPP5_LOS, TP22, FSD_DATA0, SFPP_RD0, SFPP_RD1, SFPP_RD2, SFPP_RD3, SFPP_RD11, SFPP_RD10, SFPP_RD12, SFPP_RD13, SFPP_RD4, SFPP_RD8, SFPP_RD5, SFPP_RD9, SFPP_RD7, SFPP_RD6, FTX_DATA7, SFPP_TD0, SFPP_TD1, SFPP_TD9, SFPP_TD11, SFPP_TD5, SFPP_TD13, SFPP_TD12, SFPP_TD10, SFPP_TD7, SFPP_TD6, SFPP10_SDA, SFPP10_SCL, SFPP13_SCL, SFPP12_SDA, SFPP8_LOS, SFPP13_SDA, SFPP_TD2, SFPP_TD3, SFPP_TD4, SFPP_TD8, SFPP9_TX_DIS, SFPP9_SCL, SFPP9_SDA, SFPP8_SDA, SFPP4_SCL, SFPP2_SCL, SFPP3_SCL, SFPP3_SDA, SFPP2_SDA, SFPP7_SDA, SFPP4_SDA, SFPP7_SCL, SFPP5_SCL, SFPP5_SDA, SFPP6_SDA, SFPP6_SCL, SFPP8_SCL, SFPP2_TX_DIS, SFPP3_TX_DIS, SFPP2_ABS_2, SFPP2_LOS, SFPP3_LOS, SFPP3_ABS_3, SFPP6_ABS_6, SFPP6_TX_DIS, SFPP7_TX_DIS, SFPP7_LOS, SFPP7_ABS_7, SFPP4_TX_DIS, SFPP4_LOS, SFPP6_LOS, SFPP5_TX_DIS, SFPP4_ABS_4, FMC_LPC_GTX00_P, FMC_LPC_GTX00_N, FMC_LPC_GRX00_P, FMC_LPC_GRX00_N, FMC_LPC_TX, FMC_LPC_RX, HP_UART_TX, HP_UART_RX, EEPROM_IIC_SCL, EEPROM_IIC_SDA, FLASH_SPI_CLK_SW, FLASH_SPI_CS, FLASH_SPI_DI, FLASH_SPI_DO, FLASH_WP_N, FLASH_HOLD, FLASH_SPI_IO_CLK, DEBUG_UART_TX0, DEBUG_UART_RX0, DEBUG_UART_TX1, DEBUG_UART_RX1, LED1_ON, LED2_ON, LED3_ON, reset, clk_sys, clk_125M, clk_50M, clk_250M, vc_trans_data, st_trans_data, trans_start, phy_txd, rx_comm_err, rx_verify_err, phy_rxd, rxd_data)
/* synthesis syn_black_box black_box_pad_pin="FPGA_RST_N,MGT_REFCLK_216_P,MGT_REFCLK_216_N,USER_CLK_P,USER_CLK_N,FMC_LPC_TX0,TP23,SFPP8_ABS_8,SFPP9_ABS_9,SFPP12_SCL,SFPP1_SCL,SFPP13_LOS,SFPP12_ABS_12,SFPP0_SDA,SFPP1_SDA,SFPP0_SCL,SFPP11_SCL,SFPP1_ABS_1,SFPP11_SDA,SFPP1_LOS,SFPP1_TX_DIS,SFPP0_TX_DIS,SFPP0_LOS,SFPP11_LOS,SFPP0_ABS_0,SFPP11_ABS_11,SFPP10_ABS_10,SFPP11_TX_DIS,SFPP10_LOS,SFPP13_ABS_13,SFPP10_TX_DIS,SFPP12_TX_DIS,SFPP12_LOS,SFPP9_LOS,SFPP13_TX_DIS,SFPP5_ABS_5,SFPP8_TX_DIS,SFPP5_LOS,TP22,FSD_DATA0,SFPP_RD0,SFPP_RD1,SFPP_RD2,SFPP_RD3,SFPP_RD11,SFPP_RD10,SFPP_RD12,SFPP_RD13,SFPP_RD4,SFPP_RD8,SFPP_RD5,SFPP_RD9,SFPP_RD7,SFPP_RD6,FTX_DATA7,SFPP_TD0,SFPP_TD1,SFPP_TD9,SFPP_TD11,SFPP_TD5,SFPP_TD13,SFPP_TD12,SFPP_TD10,SFPP_TD7,SFPP_TD6,SFPP10_SDA,SFPP10_SCL,SFPP13_SCL,SFPP12_SDA,SFPP8_LOS,SFPP13_SDA,SFPP_TD2,SFPP_TD3,SFPP_TD4,SFPP_TD8,SFPP9_TX_DIS,SFPP9_SCL,SFPP9_SDA,SFPP8_SDA,SFPP4_SCL,SFPP2_SCL,SFPP3_SCL,SFPP3_SDA,SFPP2_SDA,SFPP7_SDA,SFPP4_SDA,SFPP7_SCL,SFPP5_SCL,SFPP5_SDA,SFPP6_SDA,SFPP6_SCL,SFPP8_SCL,SFPP2_TX_DIS,SFPP3_TX_DIS,SFPP2_ABS_2,SFPP2_LOS,SFPP3_LOS,SFPP3_ABS_3,SFPP6_ABS_6,SFPP6_TX_DIS,SFPP7_TX_DIS,SFPP7_LOS,SFPP7_ABS_7,SFPP4_TX_DIS,SFPP4_LOS,SFPP6_LOS,SFPP5_TX_DIS,SFPP4_ABS_4,FMC_LPC_GTX00_P,FMC_LPC_GTX00_N,FMC_LPC_GRX00_P,FMC_LPC_GRX00_N,FMC_LPC_TX[3:1],FMC_LPC_RX[2:0],HP_UART_TX,HP_UART_RX,EEPROM_IIC_SCL,EEPROM_IIC_SDA,FLASH_SPI_CLK_SW,FLASH_SPI_CS,FLASH_SPI_DI,FLASH_SPI_DO,FLASH_WP_N,FLASH_HOLD,FLASH_SPI_IO_CLK,DEBUG_UART_TX0,DEBUG_UART_RX0,DEBUG_UART_TX1,DEBUG_UART_RX1,LED1_ON,LED2_ON,LED3_ON,reset,clk_sys,clk_125M,clk_50M,clk_250M,vc_trans_data[319:0],st_trans_data[319:0],trans_start,phy_txd[9:0],rx_comm_err[9:0],rx_verify_err[9:0],phy_rxd[9:0],rxd_data[79:0]" */;
  input FPGA_RST_N;
  input MGT_REFCLK_216_P;
  input MGT_REFCLK_216_N;
  input USER_CLK_P;
  input USER_CLK_N;
  input FMC_LPC_TX0;
  output TP23;
  input SFPP8_ABS_8;
  input SFPP9_ABS_9;
  output SFPP12_SCL;
  output SFPP1_SCL;
  input SFPP13_LOS;
  input SFPP12_ABS_12;
  output SFPP0_SDA;
  output SFPP1_SDA;
  output SFPP0_SCL;
  output SFPP11_SCL;
  input SFPP1_ABS_1;
  output SFPP11_SDA;
  input SFPP1_LOS;
  output SFPP1_TX_DIS;
  output SFPP0_TX_DIS;
  input SFPP0_LOS;
  input SFPP11_LOS;
  input SFPP0_ABS_0;
  input SFPP11_ABS_11;
  input SFPP10_ABS_10;
  output SFPP11_TX_DIS;
  input SFPP10_LOS;
  input SFPP13_ABS_13;
  output SFPP10_TX_DIS;
  output SFPP12_TX_DIS;
  input SFPP12_LOS;
  input SFPP9_LOS;
  output SFPP13_TX_DIS;
  input SFPP5_ABS_5;
  output SFPP8_TX_DIS;
  input SFPP5_LOS;
  output TP22;
  input FSD_DATA0;
  input SFPP_RD0;
  input SFPP_RD1;
  input SFPP_RD2;
  input SFPP_RD3;
  input SFPP_RD11;
  input SFPP_RD10;
  input SFPP_RD12;
  input SFPP_RD13;
  input SFPP_RD4;
  input SFPP_RD8;
  input SFPP_RD5;
  input SFPP_RD9;
  input SFPP_RD7;
  input SFPP_RD6;
  input FTX_DATA7;
  output SFPP_TD0;
  output SFPP_TD1;
  output SFPP_TD9;
  output SFPP_TD11;
  output SFPP_TD5;
  output SFPP_TD13;
  output SFPP_TD12;
  output SFPP_TD10;
  output SFPP_TD7;
  output SFPP_TD6;
  output SFPP10_SDA;
  output SFPP10_SCL;
  output SFPP13_SCL;
  output SFPP12_SDA;
  input SFPP8_LOS;
  output SFPP13_SDA;
  output SFPP_TD2;
  output SFPP_TD3;
  output SFPP_TD4;
  output SFPP_TD8;
  output SFPP9_TX_DIS;
  output SFPP9_SCL;
  output SFPP9_SDA;
  output SFPP8_SDA;
  output SFPP4_SCL;
  output SFPP2_SCL;
  output SFPP3_SCL;
  output SFPP3_SDA;
  output SFPP2_SDA;
  output SFPP7_SDA;
  output SFPP4_SDA;
  output SFPP7_SCL;
  output SFPP5_SCL;
  output SFPP5_SDA;
  output SFPP6_SDA;
  output SFPP6_SCL;
  output SFPP8_SCL;
  output SFPP2_TX_DIS;
  output SFPP3_TX_DIS;
  input SFPP2_ABS_2;
  input SFPP2_LOS;
  input SFPP3_LOS;
  input SFPP3_ABS_3;
  input SFPP6_ABS_6;
  output SFPP6_TX_DIS;
  output SFPP7_TX_DIS;
  input SFPP7_LOS;
  input SFPP7_ABS_7;
  output SFPP4_TX_DIS;
  input SFPP4_LOS;
  input SFPP6_LOS;
  output SFPP5_TX_DIS;
  input SFPP4_ABS_4;
  output FMC_LPC_GTX00_P;
  output FMC_LPC_GTX00_N;
  input FMC_LPC_GRX00_P;
  input FMC_LPC_GRX00_N;
  input [3:1]FMC_LPC_TX;
  output [2:0]FMC_LPC_RX;
  input HP_UART_TX;
  output HP_UART_RX;
  output EEPROM_IIC_SCL;
  output EEPROM_IIC_SDA;
  output FLASH_SPI_CLK_SW;
  output FLASH_SPI_CS;
  output FLASH_SPI_DI;
  input FLASH_SPI_DO;
  output FLASH_WP_N;
  output FLASH_HOLD;
  output FLASH_SPI_IO_CLK;
  output DEBUG_UART_TX0;
  input DEBUG_UART_RX0;
  output DEBUG_UART_TX1;
  input DEBUG_UART_RX1;
  output LED1_ON;
  output LED2_ON;
  output LED3_ON;
  output reset;
  output clk_sys;
  output clk_125M;
  output clk_50M;
  output clk_250M;
  output [319:0]vc_trans_data;
  output [319:0]st_trans_data;
  output trans_start;
  input [9:0]phy_txd;
  input [9:0]rx_comm_err;
  input [9:0]rx_verify_err;
  output [9:0]phy_rxd;
  input [79:0]rxd_data;
endmodule
