-- (c) Copyright 1995-2018 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:user:st_lc_fpga_top:1.0
-- IP Revision: 2

-- The following code must appear in the VHDL architecture header.

------------- Begin Cut here for COMPONENT Declaration ------ COMP_TAG
COMPONENT st_lc_fpga_top_0
  PORT (
    FPGA_RST_N : IN STD_LOGIC;
    MGT_REFCLK_216_P : IN STD_LOGIC;
    MGT_REFCLK_216_N : IN STD_LOGIC;
    USER_CLK_P : IN STD_LOGIC;
    USER_CLK_N : IN STD_LOGIC;
    FMC_LPC_TX0 : IN STD_LOGIC;
    TP23 : OUT STD_LOGIC;
    SFPP8_ABS_8 : IN STD_LOGIC;
    SFPP9_ABS_9 : IN STD_LOGIC;
    SFPP12_SCL : OUT STD_LOGIC;
    SFPP1_SCL : OUT STD_LOGIC;
    SFPP13_LOS : IN STD_LOGIC;
    SFPP12_ABS_12 : IN STD_LOGIC;
    SFPP0_SDA : OUT STD_LOGIC;
    SFPP1_SDA : OUT STD_LOGIC;
    SFPP0_SCL : OUT STD_LOGIC;
    SFPP11_SCL : OUT STD_LOGIC;
    SFPP1_ABS_1 : IN STD_LOGIC;
    SFPP11_SDA : OUT STD_LOGIC;
    SFPP1_LOS : IN STD_LOGIC;
    SFPP1_TX_DIS : OUT STD_LOGIC;
    SFPP0_TX_DIS : OUT STD_LOGIC;
    SFPP0_LOS : IN STD_LOGIC;
    SFPP11_LOS : IN STD_LOGIC;
    SFPP0_ABS_0 : IN STD_LOGIC;
    SFPP11_ABS_11 : IN STD_LOGIC;
    SFPP10_ABS_10 : IN STD_LOGIC;
    SFPP11_TX_DIS : OUT STD_LOGIC;
    SFPP10_LOS : IN STD_LOGIC;
    SFPP13_ABS_13 : IN STD_LOGIC;
    SFPP10_TX_DIS : OUT STD_LOGIC;
    SFPP12_TX_DIS : OUT STD_LOGIC;
    SFPP12_LOS : IN STD_LOGIC;
    SFPP9_LOS : IN STD_LOGIC;
    SFPP13_TX_DIS : OUT STD_LOGIC;
    SFPP5_ABS_5 : IN STD_LOGIC;
    SFPP8_TX_DIS : OUT STD_LOGIC;
    SFPP5_LOS : IN STD_LOGIC;
    TP22 : OUT STD_LOGIC;
    FSD_DATA0 : IN STD_LOGIC;
    SFPP_RD0 : IN STD_LOGIC;
    SFPP_RD1 : IN STD_LOGIC;
    SFPP_RD2 : IN STD_LOGIC;
    SFPP_RD3 : IN STD_LOGIC;
    SFPP_RD11 : IN STD_LOGIC;
    SFPP_RD10 : IN STD_LOGIC;
    SFPP_RD12 : IN STD_LOGIC;
    SFPP_RD13 : IN STD_LOGIC;
    SFPP_RD4 : IN STD_LOGIC;
    SFPP_RD8 : IN STD_LOGIC;
    SFPP_RD5 : IN STD_LOGIC;
    SFPP_RD9 : IN STD_LOGIC;
    SFPP_RD7 : IN STD_LOGIC;
    SFPP_RD6 : IN STD_LOGIC;
    FTX_DATA7 : IN STD_LOGIC;
    SFPP_TD0 : OUT STD_LOGIC;
    SFPP_TD1 : OUT STD_LOGIC;
    SFPP_TD9 : OUT STD_LOGIC;
    SFPP_TD11 : OUT STD_LOGIC;
    SFPP_TD5 : OUT STD_LOGIC;
    SFPP_TD13 : OUT STD_LOGIC;
    SFPP_TD12 : OUT STD_LOGIC;
    SFPP_TD10 : OUT STD_LOGIC;
    SFPP_TD7 : OUT STD_LOGIC;
    SFPP_TD6 : OUT STD_LOGIC;
    SFPP10_SDA : OUT STD_LOGIC;
    SFPP10_SCL : OUT STD_LOGIC;
    SFPP13_SCL : OUT STD_LOGIC;
    SFPP12_SDA : OUT STD_LOGIC;
    SFPP8_LOS : IN STD_LOGIC;
    SFPP13_SDA : OUT STD_LOGIC;
    SFPP_TD2 : OUT STD_LOGIC;
    SFPP_TD3 : OUT STD_LOGIC;
    SFPP_TD4 : OUT STD_LOGIC;
    SFPP_TD8 : OUT STD_LOGIC;
    SFPP9_TX_DIS : OUT STD_LOGIC;
    SFPP9_SCL : OUT STD_LOGIC;
    SFPP9_SDA : OUT STD_LOGIC;
    SFPP8_SDA : OUT STD_LOGIC;
    SFPP4_SCL : OUT STD_LOGIC;
    SFPP2_SCL : OUT STD_LOGIC;
    SFPP3_SCL : OUT STD_LOGIC;
    SFPP3_SDA : OUT STD_LOGIC;
    SFPP2_SDA : OUT STD_LOGIC;
    SFPP7_SDA : OUT STD_LOGIC;
    SFPP4_SDA : OUT STD_LOGIC;
    SFPP7_SCL : OUT STD_LOGIC;
    SFPP5_SCL : OUT STD_LOGIC;
    SFPP5_SDA : OUT STD_LOGIC;
    SFPP6_SDA : OUT STD_LOGIC;
    SFPP6_SCL : OUT STD_LOGIC;
    SFPP8_SCL : OUT STD_LOGIC;
    SFPP2_TX_DIS : OUT STD_LOGIC;
    SFPP3_TX_DIS : OUT STD_LOGIC;
    SFPP2_ABS_2 : IN STD_LOGIC;
    SFPP2_LOS : IN STD_LOGIC;
    SFPP3_LOS : IN STD_LOGIC;
    SFPP3_ABS_3 : IN STD_LOGIC;
    SFPP6_ABS_6 : IN STD_LOGIC;
    SFPP6_TX_DIS : OUT STD_LOGIC;
    SFPP7_TX_DIS : OUT STD_LOGIC;
    SFPP7_LOS : IN STD_LOGIC;
    SFPP7_ABS_7 : IN STD_LOGIC;
    SFPP4_TX_DIS : OUT STD_LOGIC;
    SFPP4_LOS : IN STD_LOGIC;
    SFPP6_LOS : IN STD_LOGIC;
    SFPP5_TX_DIS : OUT STD_LOGIC;
    SFPP4_ABS_4 : IN STD_LOGIC;
    FMC_LPC_GTX00_P : OUT STD_LOGIC;
    FMC_LPC_GTX00_N : OUT STD_LOGIC;
    FMC_LPC_GRX00_P : IN STD_LOGIC;
    FMC_LPC_GRX00_N : IN STD_LOGIC;
    FMC_LPC_TX : IN STD_LOGIC_VECTOR(3 DOWNTO 1);
    FMC_LPC_RX : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    HP_UART_TX : IN STD_LOGIC;
    HP_UART_RX : OUT STD_LOGIC;
    EEPROM_IIC_SCL : OUT STD_LOGIC;
    EEPROM_IIC_SDA : OUT STD_LOGIC;
    FLASH_SPI_CLK_SW : OUT STD_LOGIC;
    FLASH_SPI_CS : OUT STD_LOGIC;
    FLASH_SPI_DI : OUT STD_LOGIC;
    FLASH_SPI_DO : IN STD_LOGIC;
    FLASH_WP_N : OUT STD_LOGIC;
    FLASH_HOLD : OUT STD_LOGIC;
    FLASH_SPI_IO_CLK : OUT STD_LOGIC;
    DEBUG_UART_TX0 : OUT STD_LOGIC;
    DEBUG_UART_RX0 : IN STD_LOGIC;
    DEBUG_UART_TX1 : OUT STD_LOGIC;
    DEBUG_UART_RX1 : IN STD_LOGIC;
    LED1_ON : OUT STD_LOGIC;
    LED2_ON : OUT STD_LOGIC;
    LED3_ON : OUT STD_LOGIC;
    reset : OUT STD_LOGIC;
    clk_sys : OUT STD_LOGIC;
    clk_125M : OUT STD_LOGIC;
    clk_50M : OUT STD_LOGIC;
    clk_250M : OUT STD_LOGIC;
    vc_trans_data : OUT STD_LOGIC_VECTOR(319 DOWNTO 0);
    st_trans_data : OUT STD_LOGIC_VECTOR(319 DOWNTO 0);
    trans_start : OUT STD_LOGIC;
    phy_txd : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    rx_comm_err : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    rx_verify_err : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    phy_rxd : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    rxd_data : IN STD_LOGIC_VECTOR(79 DOWNTO 0)
  );
END COMPONENT;
-- COMP_TAG_END ------ End COMPONENT Declaration ------------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
your_instance_name : st_lc_fpga_top_0
  PORT MAP (
    FPGA_RST_N => FPGA_RST_N,
    MGT_REFCLK_216_P => MGT_REFCLK_216_P,
    MGT_REFCLK_216_N => MGT_REFCLK_216_N,
    USER_CLK_P => USER_CLK_P,
    USER_CLK_N => USER_CLK_N,
    FMC_LPC_TX0 => FMC_LPC_TX0,
    TP23 => TP23,
    SFPP8_ABS_8 => SFPP8_ABS_8,
    SFPP9_ABS_9 => SFPP9_ABS_9,
    SFPP12_SCL => SFPP12_SCL,
    SFPP1_SCL => SFPP1_SCL,
    SFPP13_LOS => SFPP13_LOS,
    SFPP12_ABS_12 => SFPP12_ABS_12,
    SFPP0_SDA => SFPP0_SDA,
    SFPP1_SDA => SFPP1_SDA,
    SFPP0_SCL => SFPP0_SCL,
    SFPP11_SCL => SFPP11_SCL,
    SFPP1_ABS_1 => SFPP1_ABS_1,
    SFPP11_SDA => SFPP11_SDA,
    SFPP1_LOS => SFPP1_LOS,
    SFPP1_TX_DIS => SFPP1_TX_DIS,
    SFPP0_TX_DIS => SFPP0_TX_DIS,
    SFPP0_LOS => SFPP0_LOS,
    SFPP11_LOS => SFPP11_LOS,
    SFPP0_ABS_0 => SFPP0_ABS_0,
    SFPP11_ABS_11 => SFPP11_ABS_11,
    SFPP10_ABS_10 => SFPP10_ABS_10,
    SFPP11_TX_DIS => SFPP11_TX_DIS,
    SFPP10_LOS => SFPP10_LOS,
    SFPP13_ABS_13 => SFPP13_ABS_13,
    SFPP10_TX_DIS => SFPP10_TX_DIS,
    SFPP12_TX_DIS => SFPP12_TX_DIS,
    SFPP12_LOS => SFPP12_LOS,
    SFPP9_LOS => SFPP9_LOS,
    SFPP13_TX_DIS => SFPP13_TX_DIS,
    SFPP5_ABS_5 => SFPP5_ABS_5,
    SFPP8_TX_DIS => SFPP8_TX_DIS,
    SFPP5_LOS => SFPP5_LOS,
    TP22 => TP22,
    FSD_DATA0 => FSD_DATA0,
    SFPP_RD0 => SFPP_RD0,
    SFPP_RD1 => SFPP_RD1,
    SFPP_RD2 => SFPP_RD2,
    SFPP_RD3 => SFPP_RD3,
    SFPP_RD11 => SFPP_RD11,
    SFPP_RD10 => SFPP_RD10,
    SFPP_RD12 => SFPP_RD12,
    SFPP_RD13 => SFPP_RD13,
    SFPP_RD4 => SFPP_RD4,
    SFPP_RD8 => SFPP_RD8,
    SFPP_RD5 => SFPP_RD5,
    SFPP_RD9 => SFPP_RD9,
    SFPP_RD7 => SFPP_RD7,
    SFPP_RD6 => SFPP_RD6,
    FTX_DATA7 => FTX_DATA7,
    SFPP_TD0 => SFPP_TD0,
    SFPP_TD1 => SFPP_TD1,
    SFPP_TD9 => SFPP_TD9,
    SFPP_TD11 => SFPP_TD11,
    SFPP_TD5 => SFPP_TD5,
    SFPP_TD13 => SFPP_TD13,
    SFPP_TD12 => SFPP_TD12,
    SFPP_TD10 => SFPP_TD10,
    SFPP_TD7 => SFPP_TD7,
    SFPP_TD6 => SFPP_TD6,
    SFPP10_SDA => SFPP10_SDA,
    SFPP10_SCL => SFPP10_SCL,
    SFPP13_SCL => SFPP13_SCL,
    SFPP12_SDA => SFPP12_SDA,
    SFPP8_LOS => SFPP8_LOS,
    SFPP13_SDA => SFPP13_SDA,
    SFPP_TD2 => SFPP_TD2,
    SFPP_TD3 => SFPP_TD3,
    SFPP_TD4 => SFPP_TD4,
    SFPP_TD8 => SFPP_TD8,
    SFPP9_TX_DIS => SFPP9_TX_DIS,
    SFPP9_SCL => SFPP9_SCL,
    SFPP9_SDA => SFPP9_SDA,
    SFPP8_SDA => SFPP8_SDA,
    SFPP4_SCL => SFPP4_SCL,
    SFPP2_SCL => SFPP2_SCL,
    SFPP3_SCL => SFPP3_SCL,
    SFPP3_SDA => SFPP3_SDA,
    SFPP2_SDA => SFPP2_SDA,
    SFPP7_SDA => SFPP7_SDA,
    SFPP4_SDA => SFPP4_SDA,
    SFPP7_SCL => SFPP7_SCL,
    SFPP5_SCL => SFPP5_SCL,
    SFPP5_SDA => SFPP5_SDA,
    SFPP6_SDA => SFPP6_SDA,
    SFPP6_SCL => SFPP6_SCL,
    SFPP8_SCL => SFPP8_SCL,
    SFPP2_TX_DIS => SFPP2_TX_DIS,
    SFPP3_TX_DIS => SFPP3_TX_DIS,
    SFPP2_ABS_2 => SFPP2_ABS_2,
    SFPP2_LOS => SFPP2_LOS,
    SFPP3_LOS => SFPP3_LOS,
    SFPP3_ABS_3 => SFPP3_ABS_3,
    SFPP6_ABS_6 => SFPP6_ABS_6,
    SFPP6_TX_DIS => SFPP6_TX_DIS,
    SFPP7_TX_DIS => SFPP7_TX_DIS,
    SFPP7_LOS => SFPP7_LOS,
    SFPP7_ABS_7 => SFPP7_ABS_7,
    SFPP4_TX_DIS => SFPP4_TX_DIS,
    SFPP4_LOS => SFPP4_LOS,
    SFPP6_LOS => SFPP6_LOS,
    SFPP5_TX_DIS => SFPP5_TX_DIS,
    SFPP4_ABS_4 => SFPP4_ABS_4,
    FMC_LPC_GTX00_P => FMC_LPC_GTX00_P,
    FMC_LPC_GTX00_N => FMC_LPC_GTX00_N,
    FMC_LPC_GRX00_P => FMC_LPC_GRX00_P,
    FMC_LPC_GRX00_N => FMC_LPC_GRX00_N,
    FMC_LPC_TX => FMC_LPC_TX,
    FMC_LPC_RX => FMC_LPC_RX,
    HP_UART_TX => HP_UART_TX,
    HP_UART_RX => HP_UART_RX,
    EEPROM_IIC_SCL => EEPROM_IIC_SCL,
    EEPROM_IIC_SDA => EEPROM_IIC_SDA,
    FLASH_SPI_CLK_SW => FLASH_SPI_CLK_SW,
    FLASH_SPI_CS => FLASH_SPI_CS,
    FLASH_SPI_DI => FLASH_SPI_DI,
    FLASH_SPI_DO => FLASH_SPI_DO,
    FLASH_WP_N => FLASH_WP_N,
    FLASH_HOLD => FLASH_HOLD,
    FLASH_SPI_IO_CLK => FLASH_SPI_IO_CLK,
    DEBUG_UART_TX0 => DEBUG_UART_TX0,
    DEBUG_UART_RX0 => DEBUG_UART_RX0,
    DEBUG_UART_TX1 => DEBUG_UART_TX1,
    DEBUG_UART_RX1 => DEBUG_UART_RX1,
    LED1_ON => LED1_ON,
    LED2_ON => LED2_ON,
    LED3_ON => LED3_ON,
    reset => reset,
    clk_sys => clk_sys,
    clk_125M => clk_125M,
    clk_50M => clk_50M,
    clk_250M => clk_250M,
    vc_trans_data => vc_trans_data,
    st_trans_data => st_trans_data,
    trans_start => trans_start,
    phy_txd => phy_txd,
    rx_comm_err => rx_comm_err,
    rx_verify_err => rx_verify_err,
    phy_rxd => phy_rxd,
    rxd_data => rxd_data
  );
-- INST_TAG_END ------ End INSTANTIATION Template ---------

-- You must compile the wrapper file st_lc_fpga_top_0.vhd when simulating
-- the core, st_lc_fpga_top_0. When compiling the wrapper file, be sure to
-- reference the VHDL simulation library.

