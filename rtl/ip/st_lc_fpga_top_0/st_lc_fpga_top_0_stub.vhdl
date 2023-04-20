-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.1 (win64) Build 1538259 Fri Apr  8 15:45:27 MDT 2016
-- Date        : Fri Jul 13 09:31:48 2018
-- Host        : WIN-FPGA01 running 64-bit major release  (build 7600)
-- Command     : write_vhdl -force -mode synth_stub
--               e:/projects/PT17052_KL7071_V2/hw_version_0711/fos_a7_optic_fpga/fos_a7_optic_fpga.srcs/sources_1/ip/st_lc_fpga_top_0/st_lc_fpga_top_0_stub.vhdl
-- Design      : st_lc_fpga_top_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a15tcsg325-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity st_lc_fpga_top_0 is
  Port ( 
    FPGA_RST_N : in STD_LOGIC;
    MGT_REFCLK_216_P : in STD_LOGIC;
    MGT_REFCLK_216_N : in STD_LOGIC;
    USER_CLK_P : in STD_LOGIC;
    USER_CLK_N : in STD_LOGIC;
    FMC_LPC_TX0 : in STD_LOGIC;
    TP23 : out STD_LOGIC;
    SFPP8_ABS_8 : in STD_LOGIC;
    SFPP9_ABS_9 : in STD_LOGIC;
    SFPP12_SCL : out STD_LOGIC;
    SFPP1_SCL : out STD_LOGIC;
    SFPP13_LOS : in STD_LOGIC;
    SFPP12_ABS_12 : in STD_LOGIC;
    SFPP0_SDA : out STD_LOGIC;
    SFPP1_SDA : out STD_LOGIC;
    SFPP0_SCL : out STD_LOGIC;
    SFPP11_SCL : out STD_LOGIC;
    SFPP1_ABS_1 : in STD_LOGIC;
    SFPP11_SDA : out STD_LOGIC;
    SFPP1_LOS : in STD_LOGIC;
    SFPP1_TX_DIS : out STD_LOGIC;
    SFPP0_TX_DIS : out STD_LOGIC;
    SFPP0_LOS : in STD_LOGIC;
    SFPP11_LOS : in STD_LOGIC;
    SFPP0_ABS_0 : in STD_LOGIC;
    SFPP11_ABS_11 : in STD_LOGIC;
    SFPP10_ABS_10 : in STD_LOGIC;
    SFPP11_TX_DIS : out STD_LOGIC;
    SFPP10_LOS : in STD_LOGIC;
    SFPP13_ABS_13 : in STD_LOGIC;
    SFPP10_TX_DIS : out STD_LOGIC;
    SFPP12_TX_DIS : out STD_LOGIC;
    SFPP12_LOS : in STD_LOGIC;
    SFPP9_LOS : in STD_LOGIC;
    SFPP13_TX_DIS : out STD_LOGIC;
    SFPP5_ABS_5 : in STD_LOGIC;
    SFPP8_TX_DIS : out STD_LOGIC;
    SFPP5_LOS : in STD_LOGIC;
    TP22 : out STD_LOGIC;
    FSD_DATA0 : in STD_LOGIC;
    SFPP_RD0 : in STD_LOGIC;
    SFPP_RD1 : in STD_LOGIC;
    SFPP_RD2 : in STD_LOGIC;
    SFPP_RD3 : in STD_LOGIC;
    SFPP_RD11 : in STD_LOGIC;
    SFPP_RD10 : in STD_LOGIC;
    SFPP_RD12 : in STD_LOGIC;
    SFPP_RD13 : in STD_LOGIC;
    SFPP_RD4 : in STD_LOGIC;
    SFPP_RD8 : in STD_LOGIC;
    SFPP_RD5 : in STD_LOGIC;
    SFPP_RD9 : in STD_LOGIC;
    SFPP_RD7 : in STD_LOGIC;
    SFPP_RD6 : in STD_LOGIC;
    FTX_DATA7 : in STD_LOGIC;
    SFPP_TD0 : out STD_LOGIC;
    SFPP_TD1 : out STD_LOGIC;
    SFPP_TD9 : out STD_LOGIC;
    SFPP_TD11 : out STD_LOGIC;
    SFPP_TD5 : out STD_LOGIC;
    SFPP_TD13 : out STD_LOGIC;
    SFPP_TD12 : out STD_LOGIC;
    SFPP_TD10 : out STD_LOGIC;
    SFPP_TD7 : out STD_LOGIC;
    SFPP_TD6 : out STD_LOGIC;
    SFPP10_SDA : out STD_LOGIC;
    SFPP10_SCL : out STD_LOGIC;
    SFPP13_SCL : out STD_LOGIC;
    SFPP12_SDA : out STD_LOGIC;
    SFPP8_LOS : in STD_LOGIC;
    SFPP13_SDA : out STD_LOGIC;
    SFPP_TD2 : out STD_LOGIC;
    SFPP_TD3 : out STD_LOGIC;
    SFPP_TD4 : out STD_LOGIC;
    SFPP_TD8 : out STD_LOGIC;
    SFPP9_TX_DIS : out STD_LOGIC;
    SFPP9_SCL : out STD_LOGIC;
    SFPP9_SDA : out STD_LOGIC;
    SFPP8_SDA : out STD_LOGIC;
    SFPP4_SCL : out STD_LOGIC;
    SFPP2_SCL : out STD_LOGIC;
    SFPP3_SCL : out STD_LOGIC;
    SFPP3_SDA : out STD_LOGIC;
    SFPP2_SDA : out STD_LOGIC;
    SFPP7_SDA : out STD_LOGIC;
    SFPP4_SDA : out STD_LOGIC;
    SFPP7_SCL : out STD_LOGIC;
    SFPP5_SCL : out STD_LOGIC;
    SFPP5_SDA : out STD_LOGIC;
    SFPP6_SDA : out STD_LOGIC;
    SFPP6_SCL : out STD_LOGIC;
    SFPP8_SCL : out STD_LOGIC;
    SFPP2_TX_DIS : out STD_LOGIC;
    SFPP3_TX_DIS : out STD_LOGIC;
    SFPP2_ABS_2 : in STD_LOGIC;
    SFPP2_LOS : in STD_LOGIC;
    SFPP3_LOS : in STD_LOGIC;
    SFPP3_ABS_3 : in STD_LOGIC;
    SFPP6_ABS_6 : in STD_LOGIC;
    SFPP6_TX_DIS : out STD_LOGIC;
    SFPP7_TX_DIS : out STD_LOGIC;
    SFPP7_LOS : in STD_LOGIC;
    SFPP7_ABS_7 : in STD_LOGIC;
    SFPP4_TX_DIS : out STD_LOGIC;
    SFPP4_LOS : in STD_LOGIC;
    SFPP6_LOS : in STD_LOGIC;
    SFPP5_TX_DIS : out STD_LOGIC;
    SFPP4_ABS_4 : in STD_LOGIC;
    FMC_LPC_GTX00_P : out STD_LOGIC;
    FMC_LPC_GTX00_N : out STD_LOGIC;
    FMC_LPC_GRX00_P : in STD_LOGIC;
    FMC_LPC_GRX00_N : in STD_LOGIC;
    FMC_LPC_TX : in STD_LOGIC_VECTOR ( 3 downto 1 );
    FMC_LPC_RX : out STD_LOGIC_VECTOR ( 2 downto 0 );
    HP_UART_TX : in STD_LOGIC;
    HP_UART_RX : out STD_LOGIC;
    EEPROM_IIC_SCL : out STD_LOGIC;
    EEPROM_IIC_SDA : out STD_LOGIC;
    FLASH_SPI_CLK_SW : out STD_LOGIC;
    FLASH_SPI_CS : out STD_LOGIC;
    FLASH_SPI_DI : out STD_LOGIC;
    FLASH_SPI_DO : in STD_LOGIC;
    FLASH_WP_N : out STD_LOGIC;
    FLASH_HOLD : out STD_LOGIC;
    FLASH_SPI_IO_CLK : out STD_LOGIC;
    DEBUG_UART_TX0 : out STD_LOGIC;
    DEBUG_UART_RX0 : in STD_LOGIC;
    DEBUG_UART_TX1 : out STD_LOGIC;
    DEBUG_UART_RX1 : in STD_LOGIC;
    LED1_ON : out STD_LOGIC;
    LED2_ON : out STD_LOGIC;
    LED3_ON : out STD_LOGIC;
    reset : out STD_LOGIC;
    clk_sys : out STD_LOGIC;
    clk_125M : out STD_LOGIC;
    clk_50M : out STD_LOGIC;
    clk_250M : out STD_LOGIC;
    vc_trans_data : out STD_LOGIC_VECTOR ( 319 downto 0 );
    st_trans_data : out STD_LOGIC_VECTOR ( 319 downto 0 );
    trans_start : out STD_LOGIC;
    phy_txd : in STD_LOGIC_VECTOR ( 9 downto 0 );
    rx_comm_err : in STD_LOGIC_VECTOR ( 9 downto 0 );
    rx_verify_err : in STD_LOGIC_VECTOR ( 9 downto 0 );
    phy_rxd : out STD_LOGIC_VECTOR ( 9 downto 0 );
    rxd_data : in STD_LOGIC_VECTOR ( 79 downto 0 )
  );

end st_lc_fpga_top_0;

architecture stub of st_lc_fpga_top_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "FPGA_RST_N,MGT_REFCLK_216_P,MGT_REFCLK_216_N,USER_CLK_P,USER_CLK_N,FMC_LPC_TX0,TP23,SFPP8_ABS_8,SFPP9_ABS_9,SFPP12_SCL,SFPP1_SCL,SFPP13_LOS,SFPP12_ABS_12,SFPP0_SDA,SFPP1_SDA,SFPP0_SCL,SFPP11_SCL,SFPP1_ABS_1,SFPP11_SDA,SFPP1_LOS,SFPP1_TX_DIS,SFPP0_TX_DIS,SFPP0_LOS,SFPP11_LOS,SFPP0_ABS_0,SFPP11_ABS_11,SFPP10_ABS_10,SFPP11_TX_DIS,SFPP10_LOS,SFPP13_ABS_13,SFPP10_TX_DIS,SFPP12_TX_DIS,SFPP12_LOS,SFPP9_LOS,SFPP13_TX_DIS,SFPP5_ABS_5,SFPP8_TX_DIS,SFPP5_LOS,TP22,FSD_DATA0,SFPP_RD0,SFPP_RD1,SFPP_RD2,SFPP_RD3,SFPP_RD11,SFPP_RD10,SFPP_RD12,SFPP_RD13,SFPP_RD4,SFPP_RD8,SFPP_RD5,SFPP_RD9,SFPP_RD7,SFPP_RD6,FTX_DATA7,SFPP_TD0,SFPP_TD1,SFPP_TD9,SFPP_TD11,SFPP_TD5,SFPP_TD13,SFPP_TD12,SFPP_TD10,SFPP_TD7,SFPP_TD6,SFPP10_SDA,SFPP10_SCL,SFPP13_SCL,SFPP12_SDA,SFPP8_LOS,SFPP13_SDA,SFPP_TD2,SFPP_TD3,SFPP_TD4,SFPP_TD8,SFPP9_TX_DIS,SFPP9_SCL,SFPP9_SDA,SFPP8_SDA,SFPP4_SCL,SFPP2_SCL,SFPP3_SCL,SFPP3_SDA,SFPP2_SDA,SFPP7_SDA,SFPP4_SDA,SFPP7_SCL,SFPP5_SCL,SFPP5_SDA,SFPP6_SDA,SFPP6_SCL,SFPP8_SCL,SFPP2_TX_DIS,SFPP3_TX_DIS,SFPP2_ABS_2,SFPP2_LOS,SFPP3_LOS,SFPP3_ABS_3,SFPP6_ABS_6,SFPP6_TX_DIS,SFPP7_TX_DIS,SFPP7_LOS,SFPP7_ABS_7,SFPP4_TX_DIS,SFPP4_LOS,SFPP6_LOS,SFPP5_TX_DIS,SFPP4_ABS_4,FMC_LPC_GTX00_P,FMC_LPC_GTX00_N,FMC_LPC_GRX00_P,FMC_LPC_GRX00_N,FMC_LPC_TX[3:1],FMC_LPC_RX[2:0],HP_UART_TX,HP_UART_RX,EEPROM_IIC_SCL,EEPROM_IIC_SDA,FLASH_SPI_CLK_SW,FLASH_SPI_CS,FLASH_SPI_DI,FLASH_SPI_DO,FLASH_WP_N,FLASH_HOLD,FLASH_SPI_IO_CLK,DEBUG_UART_TX0,DEBUG_UART_RX0,DEBUG_UART_TX1,DEBUG_UART_RX1,LED1_ON,LED2_ON,LED3_ON,reset,clk_sys,clk_125M,clk_50M,clk_250M,vc_trans_data[319:0],st_trans_data[319:0],trans_start,phy_txd[9:0],rx_comm_err[9:0],rx_verify_err[9:0],phy_rxd[9:0],rxd_data[79:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "st_lc_fpga_top,Vivado 2016.1";
begin
end;
