

`define                     ST_LC_CH_NUM                12
`define                     ST_LC_CH_NUM_USED           12
`define                     ARM_TYPE                    2

module user_top(
//--------------------------------------------------------------------------
//clock in and reset
    input                   FPGA_RST_N,
    input                   MGT_REFCLK_216_P,   //cdclvd1208 out0, gt bank216
    input                   MGT_REFCLK_216_N,
    input                   USER_CLK_P,         //bank14, MRCC, cdclvd1208 out2
    input                   USER_CLK_N,
    input                   FMC_LPC_TX0,        //bank15, SRCC, lvds clk tdm

//--------------------------------------------------------------------------
//i2c sfp, los, abs and tx disable, multiuse with ST optic tx & rx,los
//--------------------------------------------------------------------------
    //bank14                                //LC, blank is nouse    //ST, blank is nouse
    //bank14                                //LC, blank is nouse    //ST, blank is nouse
    output                  TP23,           //TP23
    input                   SFPP8_ABS_8,    //SFPP8_ABS_8,
    input                   SFPP9_ABS_9,    //SFPP9_ABS_9,
    output                  SFPP12_SCL,     //SFPP12_SCL,
    output                  SFPP1_SCL,      //SFPP1_SCL,            //FRX_DATA0
    input                   SFPP13_LOS,     //SFPP13_LOS,           //FRX_DATA1
    input                   SFPP12_ABS_12,  //SFPP12_ABS_12,        //FRX_DATA2
    output                  SFPP0_SDA,      //SFPP0_SDA,            //FRX_DATA3
    output                  SFPP1_SDA,      //SFPP1_SDA,            //FRX_DATA4
    output                  SFPP0_SCL,      //SFPP0_SCL,            //FRX_DATA5
    output                  SFPP11_SCL,     //SFPP11_SCL,           //FRX_DATA6
    input                   SFPP1_ABS_1,    //SFPP1_ABS_1,          //FRX_DATA7
    output                  SFPP11_SDA,     //SFPP11_SDA,
    input                   SFPP1_LOS,      //SFPP1_LOS,
    output                  SFPP1_TX_DIS,   //SFPP1_TX_DIS,
    output                  SFPP0_TX_DIS,   //SFPP0_TX_DIS,
    input                   SFPP0_LOS,      //SFPP0_LOS,
    input                   SFPP11_LOS,     //SFPP11_LOS,
    input                   SFPP0_ABS_0,    //SFPP0_ABS_0,
    input                   SFPP11_ABS_11,  //SFPP11_ABS_11,
    input                   SFPP10_ABS_10,  //SFPP10_ABS_10,        //TP24
    output                  SFPP11_TX_DIS,  //SFPP11_TX_DIS,
    input                   SFPP10_LOS,     //SFPP10_LOS,
    input                   SFPP13_ABS_13,  //SFPP13_ABS_13,
    output                  SFPP10_TX_DIS,  //SFPP10_TX_DIS,        //TP25
    output                  SFPP12_TX_DIS,  //SFPP12_TX_DIS,
    input                   SFPP12_LOS,     //SFPP12_LOS,
    input                   SFPP9_LOS,      //SFPP9_LOS,
    output                  SFPP13_TX_DIS,  //SFPP13_TX_DIS,
    input                   SFPP5_ABS_5,    //SFPP5_ABS_5,
    output                  SFPP8_TX_DIS,   //SFPP8_TX_DIS,
    input                   SFPP5_LOS,      //SFPP5_LOS,
//--------------------------------------------------------------------------
    //bank15                                //LC, blank is used     //ST, blank is nouse
    //bank15                                //LC, blank is used     //ST, blank is nouse
    output                  TP22,           //TP22,
    input                   FSD_DATA0,                              //FSD_DATA0,
    input                   SFPP_RD0,       //SFPP_RD0,             //FSD_DATA1,
    input                   SFPP_RD1,       //SFPP_RD1,             //FSD_DATA2,
    input                   SFPP_RD2,       //SFPP_RD2,             //FSD_DATA3,
    input                   SFPP_RD3,       //SFPP_RD3,             //FSD_DATA4,
    input                   SFPP_RD11,      //SFPP_RD11,            //FSD_DATA5,
    input                   SFPP_RD10,      //SFPP_RD10,            //FSD_DATA6,
    input                   SFPP_RD12,      //SFPP_RD12,            //FSD_DATA7,
    input                   SFPP_RD13,      //SFPP_RD13,            //FTX_DATA0,
    input                   SFPP_RD4,       //SFPP_RD4,             //FTX_DATA1,
    input                   SFPP_RD8,       //SFPP_RD8,             //FTX_DATA2,
    input                   SFPP_RD5,       //SFPP_RD5,             //FTX_DATA3,
    input                   SFPP_RD9,       //SFPP_RD9,             //FTX_DATA4,
    input                   SFPP_RD7,       //SFPP_RD7,             //FTX_DATA5,
    input                   SFPP_RD6,       //SFPP_RD6,             //FTX_DATA6,
    input                   FTX_DATA7,      //clk p, set as input   //FTX_DATA7,
    output                  SFPP_TD0,       //SFPP_TD0,
    output                  SFPP_TD1,       //SFPP_TD1,
    output                  SFPP_TD9,       //SFPP_TD9,
    output                  SFPP_TD11,      //SFPP_TD11,
    output                  SFPP_TD5,       //SFPP_TD5,
    output                  SFPP_TD13,      //SFPP_TD13,
    output                  SFPP_TD12,      //SFPP_TD12,
    output                  SFPP_TD10,      //SFPP_TD10,
    output                  SFPP_TD7,       //SFPP_TD7,
    output                  SFPP_TD6,       //SFPP_TD6,
    output                  SFPP10_SDA,     //SFPP10_SDA,
    output                  SFPP10_SCL,     //SFPP10_SCL,           //TP22
    output                  SFPP13_SCL,     //SFPP13_SCL,           //TP23 
    output                  SFPP12_SDA,     //SFPP12_SDA,
    input                   SFPP8_LOS,      //SFPP8_LOS,
    output                  SFPP13_SDA,     //SFPP13_SDA,
    output                  SFPP_TD2,       //SFPP_TD2,
    output                  SFPP_TD3,       //SFPP_TD3,
    output                  SFPP_TD4,       //SFPP_TD4,
    output                  SFPP_TD8,       //SFPP_TD8,
    output                  SFPP9_TX_DIS,   //SFPP9_TX_DIS,
//--------------------------------------------------------------------------
    //bank34                                //LC, blank is used     //ST, blank is nouse
    //bank34                                //LC, blank is used     //ST, blank is nouse
    output                  SFPP9_SCL,      //SFPP9_SCL,
    output                  SFPP9_SDA,      //SFPP9_SDA,
    output                  SFPP8_SDA,      //SFPP8_SDA,
    output                  SFPP4_SCL,      //SFPP4_SCL,
    output                  SFPP2_SCL,      //SFPP2_SCL,
    output                  SFPP3_SCL,      //SFPP3_SCL,
    output                  SFPP3_SDA,      //SFPP3_SDA,
    output                  SFPP2_SDA,      //SFPP2_SDA,
    output                  SFPP7_SDA,      //SFPP7_SDA,
    output                  SFPP4_SDA,      //SFPP4_SDA,
    output                  SFPP7_SCL,      //SFPP7_SCL,
    output                  SFPP5_SCL,      //SFPP5_SCL,
    output                  SFPP5_SDA,      //SFPP5_SDA,
    output                  SFPP6_SDA,      //SFPP6_SDA,
    output                  SFPP6_SCL,      //SFPP6_SCL,
    output                  SFPP8_SCL,      //SFPP8_SCL,
    output                  SFPP2_TX_DIS,   //SFPP2_TX_DIS,
    output                  SFPP3_TX_DIS,   //SFPP3_TX_DIS,
    input                   SFPP2_ABS_2,    //SFPP2_ABS_2,
    input                   SFPP2_LOS,      //SFPP2_LOS,
    input                   SFPP3_LOS,      //SFPP3_LOS,
    input                   SFPP3_ABS_3,    //SFPP3_ABS_3,
    input                   SFPP6_ABS_6,    //SFPP6_ABS_6,
    output                  SFPP6_TX_DIS,   //SFPP6_TX_DIS,
    output                  SFPP7_TX_DIS,   //SFPP7_TX_DIS,
    input                   SFPP7_LOS,      //SFPP7_LOS,
    input                   SFPP7_ABS_7,    //SFPP7_ABS_7,
    output                  SFPP4_TX_DIS,   //SFPP4_TX_DIS,
    input                   SFPP4_LOS,      //SFPP4_LOS,
    input                   SFPP6_LOS,      //SFPP6_LOS,
    output                  SFPP5_TX_DIS,   //SFPP5_TX_DIS,
    input                   SFPP4_ABS_4,    //SFPP4_ABS_4,
//backplane gt bank
    output                  FMC_LPC_GTX00_P,
    output                  FMC_LPC_GTX00_N,
    input                   FMC_LPC_GRX00_P,
    input                   FMC_LPC_GRX00_N,
//lvds tx & rx, uart with K7
    input       [3:1]       FMC_LPC_TX,         //4 ch rx from k7 board
    output      [2:0]       FMC_LPC_RX,         //3 ch tx to k7 board
    input                   HP_UART_TX,
    output                  HP_UART_RX,
//i2c eeprom
    output                  EEPROM_IIC_SCL,
    output                  EEPROM_IIC_SDA,
//spi flash w25qxxx
    output                  FLASH_SPI_CLK_SW,   //0: dedicated DCLK  1: Switch sclk to fpga user io
    output                  FLASH_SPI_CS,
    output                  FLASH_SPI_DI,       //spi flash input
    input                   FLASH_SPI_DO,       //spi flash output
    output                  FLASH_WP_N,
    output                  FLASH_HOLD,         //spi flash reset_n
    output                  FLASH_SPI_IO_CLK,   //fpga user io, sclk
//debug uart
    output                  DEBUG_UART_TX0,
    input                   DEBUG_UART_RX0,
    output                  DEBUG_UART_TX1,
    input                   DEBUG_UART_RX1,
//led
    output                  LED1_ON,
    output                  LED2_ON,
    output                  LED3_ON//,

    );
    
    
    
    
//下面的这些定义以及always是我们家里测试时，把vc、st和fc与解码模块之间互相交互的ep，到时候你那边可能和家里不太一样自己再改    
    
    
wire                             reset;
wire                             soft_reset_cmd;
wire							 clk_sys;            //100M
wire                            pll_clkin;
wire                            clk_160M;
wire                            clk_80M;
wire                            clk_40M;

wire     [`ST_LC_CH_NUM*32-1:0]  vc_trans_data;
wire     [`ST_LC_CH_NUM*32-1:0]  st_trans_data;
wire                             trans_start;
wire     [`ST_LC_CH_NUM-1:0]     phy_txd_i;
wire     [`ST_LC_CH_NUM-1:0]     rx_comm_err;
wire     [`ST_LC_CH_NUM-1:0]     rx_verify_err;
wire     [`ST_LC_CH_NUM-1:0]     phy_rxd_i;
wire     [`ST_LC_CH_NUM*8-1:0]   rxd_data;
//--------------------------------------------------
//  Add for 6 channel
wire     [`ST_LC_CH_NUM_USED*32-1:0]  vc_trans_data_i;
wire     [`ST_LC_CH_NUM_USED*32-1:0]  st_trans_data_i;
wire     [`ST_LC_CH_NUM-1:0]     phy_txd_ii;

wire     [`ST_LC_CH_NUM_USED-1:0]     rx_comm_err_i;
wire     [`ST_LC_CH_NUM_USED-1:0]     rx_verify_err_i;
wire     [`ST_LC_CH_NUM-1:0]     phy_rxd_ii;

wire     [`ST_LC_CH_NUM_USED*8-1:0]   rxd_data_i;

wire     [`ST_LC_CH_NUM_USED-1:0]     phy_txd_iii;
wire     [`ST_LC_CH_NUM_USED-1:0]     phy_rxd_iii;


wire		[`ST_LC_CH_NUM_USED-1:0]		optic_temp_fault_i;
wire		[`ST_LC_CH_NUM_USED-1:0]		bridge_mode_set_i;
//--------------------------------------------------
wire                             clk_125M;
wire                             clk_50M ;
wire                             clk_250M;

wire        clk240m;
wire        clk120m;

wire     [13:0]  optic_temp_fault;
wire     [13:0]	 bridge_mode_set;

//signal for debug
wire	[31:0]					vc_data_debug;
wire	[31:0]					st_data_debug;
wire							start_debug;

wire    [11:0] lost_voltage_a7;
wire    [11:0] temp_fault_valid;
wire    [11:0] tx_direct_comm_fault_clk_sys;
wire    [11:0] tx_cross_comm_fault_clk_sys;
wire    [11:0] rx_direct_comm_fault_clk_sys;
wire    [11:0] rx_cross_comm_fault_clk_sys;


wire     [31:0]  probe_in0;
wire     [31:0]	 probe_in1;
wire     [31:0]	 probe_out0;
wire     [31:0]	 probe_out1;
wire     [0:0]	 probe_out2;
reg probe_out2_d1;
reg probe_out2_d2;
reg probe_out2_ce;
//-------------------------------------------------
//  10 ch tie to 6 ch
//assign vc_trans_data_i = vc_trans_data[`ST_LC_CH_NUM_SIX*32-1:0];
//assign st_trans_data_i = st_trans_data[`ST_LC_CH_NUM_SIX*32-1:0];

assign vc_trans_data_i[`ST_LC_CH_NUM_USED*32-1 : 32] = vc_trans_data[`ST_LC_CH_NUM_USED*32-1:32];
assign st_trans_data_i[`ST_LC_CH_NUM_USED*32-1 : 32] = st_trans_data[`ST_LC_CH_NUM_USED*32-1:32];

assign vc_trans_data_i[32-1 : 0] = (probe_out2[0]==1'b1) ? probe_out0 : vc_trans_data[32-1:0];
assign st_trans_data_i[32-1 : 0] = (probe_out2[0]==1'b1) ? probe_out1 : st_trans_data[32-1:0];

assign rx_comm_err[`ST_LC_CH_NUM-1:0] = rx_comm_err_i[`ST_LC_CH_NUM_USED-1:0];
assign rx_verify_err[`ST_LC_CH_NUM-1:0] =rx_verify_err_i[`ST_LC_CH_NUM_USED-1:0];
assign rxd_data[`ST_LC_CH_NUM*8-1:0] = rxd_data_i[`ST_LC_CH_NUM_USED*8-1:0];
assign phy_rxd_ii = phy_rxd_i[`ST_LC_CH_NUM-1:0];
assign phy_txd_i[`ST_LC_CH_NUM-1:0] = phy_txd_ii[`ST_LC_CH_NUM-1:0];
assign optic_temp_fault_i = optic_temp_fault[`ST_LC_CH_NUM_USED-1:0];
assign bridge_mode_set_i = bridge_mode_set[`ST_LC_CH_NUM_USED-1:0];


  //调用科梁网表模块
st_lc_fpga_top  st_lc_fpga_top(
    .FPGA_RST_N                (    FPGA_RST_N                     ),
    .MGT_REFCLK_216_P          (    MGT_REFCLK_216_P               ),
    .MGT_REFCLK_216_N          (    MGT_REFCLK_216_N               ),
    .USER_CLK_P                (    USER_CLK_P                     ),
    .USER_CLK_N                (    USER_CLK_N                     ),
    .FMC_LPC_TX0               (    FMC_LPC_TX0                    ),
    .TP23                      (    TP23                           ),
    .SFPP8_ABS_8               (    SFPP8_ABS_8                    ),
    .SFPP9_ABS_9               (    SFPP9_ABS_9                    ),
    .SFPP12_SCL                (    SFPP12_SCL                     ),
    .SFPP1_SCL                 (    SFPP1_SCL                      ),
    .SFPP13_LOS                (    SFPP13_LOS                     ),
    .SFPP12_ABS_12             (    SFPP12_ABS_12                  ),
    .SFPP0_SDA                 (    SFPP0_SDA                      ),
    .SFPP1_SDA                 (    SFPP1_SDA                      ),
    .SFPP0_SCL                 (    SFPP0_SCL                      ),
    .SFPP11_SCL                (    SFPP11_SCL                     ),
    .SFPP1_ABS_1               (    SFPP1_ABS_1                    ),
    .SFPP11_SDA                (    SFPP11_SDA                     ),
    .SFPP1_LOS                 (    SFPP1_LOS                      ),
    .SFPP1_TX_DIS              (    SFPP1_TX_DIS                   ),
    .SFPP0_TX_DIS              (    SFPP0_TX_DIS                   ),
    .SFPP0_LOS                 (    SFPP0_LOS                      ),
    .SFPP11_LOS                (    SFPP11_LOS                     ),
    .SFPP0_ABS_0               (    SFPP0_ABS_0                    ),
    .SFPP11_ABS_11             (    SFPP11_ABS_11                  ),
    .SFPP10_ABS_10             (    SFPP10_ABS_10                  ),
    .SFPP11_TX_DIS             (    SFPP11_TX_DIS                  ),
    .SFPP10_LOS                (    SFPP10_LOS                     ),
    .SFPP13_ABS_13             (    SFPP13_ABS_13                  ),
    .SFPP10_TX_DIS             (    SFPP10_TX_DIS                  ),
    .SFPP12_TX_DIS             (    SFPP12_TX_DIS                  ),
    .SFPP12_LOS                (    SFPP12_LOS                     ),
    .SFPP9_LOS                 (    SFPP9_LOS                      ),
    .SFPP13_TX_DIS             (    SFPP13_TX_DIS                  ),
    .SFPP5_ABS_5               (    SFPP5_ABS_5                    ),
    .SFPP8_TX_DIS              (    SFPP8_TX_DIS                   ),
    .SFPP5_LOS                 (    SFPP5_LOS                      ),
    .TP22                      (    TP22                           ),
    .FSD_DATA0                 (    FSD_DATA0                      ),
    .SFPP_RD0                  (    SFPP_RD0                       ),
    .SFPP_RD1                  (    SFPP_RD1                       ),
    .SFPP_RD2                  (    SFPP_RD2                       ),
    .SFPP_RD3                  (    SFPP_RD3                       ),
    .SFPP_RD11                 (    SFPP_RD11                      ),
    .SFPP_RD10                 (    SFPP_RD10                      ),
    .SFPP_RD12                 (    SFPP_RD12                      ),
    .SFPP_RD13                 (    SFPP_RD13                      ),
    .SFPP_RD4                  (    SFPP_RD4                       ),
    .SFPP_RD8                  (    SFPP_RD8                       ),
    .SFPP_RD5                  (    SFPP_RD5                       ),
    .SFPP_RD9                  (    SFPP_RD9                       ),
    .SFPP_RD7                  (    SFPP_RD7                       ),
    .SFPP_RD6                  (    SFPP_RD6                       ),
    .FTX_DATA7                 (    FTX_DATA7                      ),
    .SFPP_TD0                  (    SFPP_TD0                       ),
    .SFPP_TD1                  (    SFPP_TD1                       ),
    .SFPP_TD9                  (    SFPP_TD9                       ),
    .SFPP_TD11                 (    SFPP_TD11                      ),
    .SFPP_TD5                  (    SFPP_TD5                       ),
    .SFPP_TD13                 (    SFPP_TD13                      ),
    .SFPP_TD12                 (    SFPP_TD12                      ),
    .SFPP_TD10                 (    SFPP_TD10                      ),
    .SFPP_TD7                  (    SFPP_TD7                       ),
    .SFPP_TD6                  (    SFPP_TD6                       ),
    .SFPP10_SDA                (    SFPP10_SDA                     ),
    .SFPP10_SCL                (    SFPP10_SCL                     ),
    .SFPP13_SCL                (    SFPP13_SCL                     ),
    .SFPP12_SDA                (    SFPP12_SDA                     ),
    .SFPP8_LOS                 (    SFPP8_LOS                      ),
    .SFPP13_SDA                (    SFPP13_SDA                     ),
    .SFPP_TD2                  (    SFPP_TD2                       ),
    .SFPP_TD3                  (    SFPP_TD3                       ),
    .SFPP_TD4                  (    SFPP_TD4                       ),
    .SFPP_TD8                  (    SFPP_TD8                       ),
    .SFPP9_TX_DIS              (    SFPP9_TX_DIS                   ),
    .SFPP9_SCL                 (    SFPP9_SCL                      ),
    .SFPP9_SDA                 (    SFPP9_SDA                      ),
    .SFPP8_SDA                 (    SFPP8_SDA                      ),
    .SFPP4_SCL                 (    SFPP4_SCL                      ),
    .SFPP2_SCL                 (    SFPP2_SCL                      ),
    .SFPP3_SCL                 (    SFPP3_SCL                      ),
    .SFPP3_SDA                 (    SFPP3_SDA                      ),
    .SFPP2_SDA                 (    SFPP2_SDA                      ),
    .SFPP7_SDA                 (    SFPP7_SDA                      ),
    .SFPP4_SDA                 (    SFPP4_SDA                      ),
    .SFPP7_SCL                 (    SFPP7_SCL                      ),
    .SFPP5_SCL                 (    SFPP5_SCL                      ),
    .SFPP5_SDA                 (    SFPP5_SDA                      ),
    .SFPP6_SDA                 (    SFPP6_SDA                      ),
    .SFPP6_SCL                 (    SFPP6_SCL                      ),
    .SFPP8_SCL                 (    SFPP8_SCL                      ),
    .SFPP2_TX_DIS              (    SFPP2_TX_DIS                   ),
    .SFPP3_TX_DIS              (    SFPP3_TX_DIS                   ),
    .SFPP2_ABS_2               (    SFPP2_ABS_2                    ),
    .SFPP2_LOS                 (    SFPP2_LOS                      ),
    .SFPP3_LOS                 (    SFPP3_LOS                      ),
    .SFPP3_ABS_3               (    SFPP3_ABS_3                    ),
    .SFPP6_ABS_6               (    SFPP6_ABS_6                    ),
    .SFPP6_TX_DIS              (    SFPP6_TX_DIS                   ),
    .SFPP7_TX_DIS              (    SFPP7_TX_DIS                   ),
    .SFPP7_LOS                 (    SFPP7_LOS                      ),
    .SFPP7_ABS_7               (    SFPP7_ABS_7                    ),
    .SFPP4_TX_DIS              (    SFPP4_TX_DIS                   ),
    .SFPP4_LOS                 (    SFPP4_LOS                      ),
    .SFPP6_LOS                 (    SFPP6_LOS                      ),
    .SFPP5_TX_DIS              (    SFPP5_TX_DIS                   ),
    .SFPP4_ABS_4               (    SFPP4_ABS_4                    ),
    .FMC_LPC_GTX00_P           (    FMC_LPC_GTX00_P                ),
    .FMC_LPC_GTX00_N           (    FMC_LPC_GTX00_N                ),
    .FMC_LPC_GRX00_P           (    FMC_LPC_GRX00_P                ),
    .FMC_LPC_GRX00_N           (    FMC_LPC_GRX00_N                ),
    .FMC_LPC_TX                (    FMC_LPC_TX                     ),
    .FMC_LPC_RX                (    FMC_LPC_RX                     ),
    .HP_UART_TX                (    HP_UART_TX                     ),
    .HP_UART_RX                (    HP_UART_RX                     ),
    .EEPROM_IIC_SCL            (    EEPROM_IIC_SCL                 ),
    .EEPROM_IIC_SDA            (    EEPROM_IIC_SDA                 ),
    .FLASH_SPI_CLK_SW          (    FLASH_SPI_CLK_SW               ),
    .FLASH_SPI_CS              (    FLASH_SPI_CS                   ),
    .FLASH_SPI_DI              (    FLASH_SPI_DI                   ),
    .FLASH_SPI_DO              (    FLASH_SPI_DO                   ),
    .FLASH_WP_N                (    FLASH_WP_N                     ),
    .FLASH_HOLD                (    FLASH_HOLD                     ),
    .FLASH_SPI_IO_CLK          (    FLASH_SPI_IO_CLK               ),
    .DEBUG_UART_TX0            (    DEBUG_UART_TX0                 ),
    .DEBUG_UART_RX0            (    DEBUG_UART_RX0                 ),
    .DEBUG_UART_TX1            (    DEBUG_UART_TX1                 ),
    .DEBUG_UART_RX1            (    DEBUG_UART_RX1                 ),
    .LED1_ON                   (    LED1_ON                        ),
    .LED2_ON                   (    LED2_ON                        ),
    .LED3_ON                   (    LED3_ON                        ),
   //以上为FPGA管脚接口，不允许更改
   
   //光纤通信故障判断信号
    .lost_voltage_a7                (   lost_voltage_a7                ),//output[11:0] 失电
    .temp_fault_valid               (   temp_fault_valid               ),//output[11:0] 温度故障
    .tx_direct_comm_fault_clk_sys   (   tx_direct_comm_fault_clk_sys   ),//上行直连故障
    .tx_cross_comm_fault_clk_sys    (   tx_cross_comm_fault_clk_sys    ),//上行交叉故障
    .rx_direct_comm_fault_clk_sys   (   rx_direct_comm_fault_clk_sys   ),//下行直连故障
    .rx_cross_comm_fault_clk_sys    (   rx_cross_comm_fault_clk_sys    ),//下行交叉故障
   
   //以下为科梁网表与控制器厂家网表接口 
    .pll_clkin                 (    pll_clkin                      ),   //锁相环模块输入时钟：125MHz
    .clk_sys                   (    clk_sys                        ),   //科梁网表模块工作时钟：100MHz
    .optic_temp_fault          (    optic_temp_fault               ),   //子模块过温故障
    .bridge_mode_set		   (	bridge_mode_set				   ),   //子模块全桥-半桥设置
    .reset                     (    reset                          ),   //全局上电复位
    .soft_reset_cmd            (    soft_reset_cmd                 ),   //软复位
    .vc_trans_data             (    vc_trans_data                  ),   //子模块电压数据
    .st_trans_data             (    st_trans_data                  ),   //子模块状态数据
    .trans_start               (    trans_start                    ),   //数据发送标识
    .phy_txd_i                 (    phy_txd_i                      ),   //串行数据发送接口
    .rx_comm_err               (    rx_comm_err                    ),   //接收通信故障
    .rx_verify_err             (    rx_verify_err                  ),   //接收校验故障
    .phy_rxd_i                 (    phy_rxd_i                      ),   //串行数据接收接口
    .rxd_data                  (    rxd_data                       )    //子模块FC数据
    );
    
clk_wiz_125m 	U_clk_wiz_125m
(
    // Clock in ports
    .clk_in1(pll_clkin),
    // Clock out ports
    .clk_out1(clk_160M),
    .clk_out2(clk_80M),
    .clk_out3(clk_sys), //clk_sys信号命名不允许变动；clk_sys频率需为100MHz，不运行存在设计偏差
    .clk_out4(clk_40M), 
    .locked()
);

wire [11:0] phy_txd_in;
wire [11:0] phy_rxd_in;

generate
genvar u;
//tx com fault simulation
if( `ARM_TYPE == 1 )begin
	for(u=0;u<=6-1;u=u+1)
	begin:			phy_txd_ch
		assign phy_txd_ii[u] = (lost_voltage_a7[u]==1'b0) ? ((tx_direct_comm_fault_clk_sys[u]==1'b0) ? ((temp_fault_valid[u]==1'b0) ? phy_txd_in[u] : 1'b0) : 1'b0) : 1'b0;
		assign phy_txd_ii[6+u] = (lost_voltage_a7[u]==1'b0) ? ((tx_cross_comm_fault_clk_sys[u]==1'b0) ? ((temp_fault_valid[u]==1'b0) ? phy_txd_in[6+u] : 1'b0) : 1'b0) : 1'b0;
	end
	for(u=0;u<=6-1;u=u+1)
	begin:			phy_rxd_ch
		assign phy_rxd_in[u] = (lost_voltage_a7[u]==1'b0) ? ((rx_direct_comm_fault_clk_sys[u]==1'b0) ? phy_rxd_ii[u] : 1'b0) : 1'b0;
		assign phy_rxd_in[6+u] = (lost_voltage_a7[u]==1'b0) ? ((rx_cross_comm_fault_clk_sys[u]==1'b0) ? phy_rxd_ii[6+u] : 1'b0) : 1'b0;
	end
end else begin
    if( `ARM_TYPE == 2   )begin
        for(u=0;u<=10-1;u=u+1)
        begin:			phy_txd_ch
            assign phy_txd_ii[u] = (lost_voltage_a7[u]==1'b0) ? ((tx_direct_comm_fault_clk_sys[u]==1'b0) ? ((temp_fault_valid[u]==1'b0) ? phy_txd_in[u] : 1'b0) : 1'b0) : 1'b0;
        end
        for(u=0;u<=10-1;u=u+1)
        begin:			phy_rxd_ch
            assign phy_rxd_in[u] = (lost_voltage_a7[u]==1'b0) ? ((rx_direct_comm_fault_clk_sys[u]==1'b0) ? phy_rxd_ii[u] : 1'b0) : 1'b0;
        end
	end else begin
        for(u=0;u<=12-1;u=u+1)
        begin:            phy_txd_ch
            assign phy_txd_ii[u] =  1'b0;
        end
        for(u=0;u<=12-1;u=u+1)
        begin:            phy_rxd_ch
            assign phy_rxd_in[u] =  1'b0;
        end
	end
end
endgenerate


//-------------------调用阀控厂家网表文件----------------------------------------------------------------

generate
	genvar 			k;
	for(k=0;k<=10-1;k=k+1)
	begin: 			optic_encode 
    RT_LAB_comm_with_MC u_RT_LAB_comm_with_MC(
        .reset_r 		    (  reset |  lost_voltage_a7[k]  ),// input    :in	std_logic;	
        .clk_sys_r          (  clk_sys  ),// input      :in     std_logic;                ----100M杈撳叆
        .rx_comm_err        (  rx_comm_err_i[k]       ),// output        :out    std_logic;               --涓哄疄鏃剁殑涓嬭閫氳鏁呴殰
        .rx_verify_err      (  rx_verify_err_i[k]     ), // output     :out    std_logic;        
        .phy_rxd            (  phy_rxd_in[k]          ), // input     :in    std_logic;               ----鎺ユ敹闃?鎺т俊鍙?
        .rxd_data           (  rxd_data_i[k*8+7:k*8]  ), // output[7:0]      :out    std_logic_vector(7 downto 0);
        
        .reset_t            (  reset  | lost_voltage_a7[k]  ), //  input     :   in    std_logic;    
        .clk_sys_t          (  clk_sys  ), //  input      :in     std_logic;                           ----100M杈撳叆
        .vc_tran_data       (  vc_trans_data_i[k*32+31:k*32]  ), //  input[31:0]    :in     std_logic_vector(31 downto 0);      ----32浣嶇數瀹圭數鍘?
        .st_tran_data       (  st_trans_data_i[k*32+31:k*32]  ), //  input[31:0]    :in     std_logic_vector(31 downto 0);     ----32浣嶇姸鎬?
        .trans_start        (  trans_start            ), //  input     :in     std_logic;                            ----鍙戦?佸惎鍔?
        .phy_txd            (  phy_txd_in[k]          ), //  output    :out std_logic;                            ----鍙戦?佺粰闃?鎺т俊鍙?
        .optic_temp_fault   (  optic_temp_fault_i[k]  ), //   input    :in  std_logic;                            ----娓╁害鏁呴殰妯℃嫙
        
        .RYTX               (   	), //   output    :out  std_logic;
        .RYRX               (  1'b0      ), //   input    :in  std_logic;
        .clk_sys_RY         (  clk_40M   ) //   input  :in  std_logic                             ----40M杈撳叆
    );
	end
endgenerate

//-------------------------------------------------------------------------------------------------------------

    wire [31:0] st_1;
    wire [31:0] st_2;
    wire [31:0] st_3;
    wire [31:0] st_4;
    wire [31:0] st_5;
    wire [31:0] st_6;
    wire [31:0] st_7;
    wire [31:0] st_8;
    wire [31:0] st_9;
    wire [31:0] st_10;
    
    
    wire [31:0] vc_1;
    wire [31:0] vc_2;
    wire [31:0] vc_3;
    wire [31:0] vc_4;
    wire [31:0] vc_5;
    wire [31:0] vc_6;
    wire [31:0] vc_7;
    wire [31:0] vc_8;
    wire [31:0] vc_9;
    wire [31:0] vc_10;
    
    
    wire [7:0] rxd_data_1;
    
    wire        txd_1;   
    wire        txd_2;    
    wire        txd_3;   
    wire        txd_4; 
    wire        txd_5; 
    wire        txd_6;
    wire        txd_7;
    wire        txd_8;
    wire        txd_9;
    wire        txd_10; 
 
    wire        rxd_1;   
    wire        rxd_2;    
    wire        rxd_3;   
    wire        rxd_4; 
    wire        rxd_5; 
    wire        rxd_6;  
    wire        rxd_7;
    wire        rxd_8;
    
    wire [7:0] rx_data_1;
    wire [7:0] rx_data_2; 
    wire [7:0] rx_data_3;
    wire [7:0] rx_data_4; 
    
    assign rx_data_1 = rxd_data_i[7:0];
    assign rx_data_2 = rxd_data_i[15:8];
    assign rx_data_3 = rxd_data_i[23:16];
    assign rx_data_4 = rxd_data_i[31:24];   
    
    assign st_1 = st_trans_data_i[31:0];
    assign st_2 = st_trans_data_i[63:32];
    assign st_3 = st_trans_data_i[95:64];
    assign st_4 = st_trans_data_i[127:96];
    assign st_5 = st_trans_data_i[159:128];
    assign st_6 = st_trans_data_i[191:160];
    assign st_7 = st_trans_data_i[223:192];
    assign st_8 = st_trans_data_i[255:224];
    assign st_9 = st_trans_data_i[287:256];
    assign st_10 = st_trans_data_i[319:288];
  
    assign vc_1 = vc_trans_data_i[31:0];
    assign vc_2 = vc_trans_data_i[63:32];
    assign vc_3 = vc_trans_data_i[95:64];
    assign vc_4 = vc_trans_data_i[127:96];
    assign vc_5 = vc_trans_data_i[159:128];
    assign vc_6 = vc_trans_data_i[191:160];
    assign vc_7 = vc_trans_data_i[223:192];    
    assign vc_8 = vc_trans_data_i[255:224];  
    assign vc_9 = vc_trans_data_i[287:256];  
    assign vc_10 = vc_trans_data_i[319:288];
    
    wire [15:0] vc_1_1;
    wire [19:0] st_1_1;
    wire        temp_fault_1;
    wire        bypass_1;
    wire        rx_comm_err_1;
    wire        bridge_mode_set_1;
  
    wire [15:0] vc_1_2;
    wire [19:0] st_1_2;
    wire        temp_fault_2;
    wire        bypass_2;
    wire        rx_comm_err_2;
    wire        bridge_mode_set_2;
  
    wire [15:0] vc_1_3;
    wire [19:0] st_1_3;
    wire        temp_fault_3;
    wire        bypass_3;
    wire        rx_comm_err_3;
    wire        bridge_mode_set_3; 
    
    wire [15:0] vc_1_4;
    wire [15:0] vc_1_5;
    wire [15:0] vc_1_6;
    wire [15:0] vc_1_7;
    wire [15:0] vc_1_8;
    wire [15:0] vc_1_9;
    wire [15:0] vc_1_10;
    
    
    assign vc_1_1 = vc_1[15:0];
    assign st_1_1 = st_1[19:0]; 
    assign temp_fault_1 = optic_temp_fault_i[0];
    assign bypass_1 =  rx_data_1[4];
    assign rx_comm_err_1 = rx_comm_err_i[0];
    assign bridge_mode_set_1 = bridge_mode_set_i[0];
 
    assign vc_1_2 = vc_2[15:0];
    assign st_1_2 = st_2[19:0]; 
    assign temp_fault_2 = optic_temp_fault_i[1];
    assign bypass_2 =  rx_data_2[4];
    assign rx_comm_err_2 = rx_comm_err_i[1];
    assign bridge_mode_set_2 = bridge_mode_set_i[1];
 
    assign vc_1_3 = vc_3[15:0];
    assign st_1_3 = st_3[19:0]; 
    assign temp_fault_3 = optic_temp_fault_i[2];
    assign bypass_3 =  rx_data_3[4];
    assign rx_comm_err_3 = rx_comm_err_i[2];
    assign bridge_mode_set_3 = bridge_mode_set_i[2];
 
    assign vc_1_4 = vc_4[15:0];
    assign vc_1_5 = vc_5[15:0];
    assign vc_1_6 = vc_6[15:0];
    assign vc_1_7 = vc_7[15:0];
    assign vc_1_8 = vc_8[15:0];
    assign vc_1_9 = vc_9[15:0];
    assign vc_1_10 = vc_10[15:0];
 
    assign txd_1 = phy_txd_ii[0];
    assign txd_2 = phy_txd_ii[1]; 
    assign txd_3 = phy_txd_ii[2];
    assign txd_4 = phy_txd_ii[3];
    assign txd_5 = phy_txd_ii[4];
    assign txd_6 = phy_txd_ii[5]; 
    assign txd_7 = phy_txd_ii[6]; 
    assign txd_8 = phy_txd_ii[7]; 
    assign txd_9 = phy_txd_ii[8]; 
    
    assign rxd_1 = phy_rxd_ii[0];      
    assign rxd_2 = phy_rxd_ii[1];   
    assign rxd_3 = phy_rxd_ii[2];   
    assign rxd_4 = phy_rxd_ii[3];   
    assign rxd_5 = phy_rxd_ii[4];   
    assign rxd_6 = phy_rxd_ii[5];
    assign rxd_7 = phy_rxd_ii[6];
    assign rxd_8 = phy_rxd_ii[7];
    
    assign rxd_data_1 = rxd_data_i[7:0];           


    wire [14:0] result;
    
    design_1_wrapper u_design_1_wrapper
       ( .A_0   ( vc_1_4[14:0]  ),//input[14:0]
         .B_0   ( vc_1_5[14:0]  ),//input[14:0]
         .CE_0  ( 1'b1  ),//input
         .CLK_0 ( clk_sys  ),//input
         .S_0   ( result  )//output[14:0]
        );
    
    
    
    

//ila_fault_debug u_ila_fault_debug (
//	.clk(clk_sys), // input wire clk

//	.probe0({rx_direct_comm_fault_clk_sys[9:0],tx_direct_comm_fault_clk_sys[9:0],temp_fault_valid[9:0],vc_1_10,vc_1_9,vc_1_8,vc_1_7,vc_1_6,vc_1_5,vc_1_4,vc_1_3,vc_1_2,vc_1_1}) // input wire [149:0] probe0
//);

ila_fault_debug u_ila_fault_debug (
	.clk(clk_sys), // input wire clk

	.probe0({result,temp_fault_valid[9:0],vc_1_10,vc_1_9,vc_1_8,vc_1_7,vc_1_6,vc_1_5,vc_1_4,vc_1_3,vc_1_2,vc_1_1}) // input wire [149:0] probe0
);


 assign probe_in0 = {probe_out2[0], 3'd0 , rxd_data_i[15:0] , rx_verify_err_i[`ST_LC_CH_NUM_USED-1:0] , rx_comm_err_i[`ST_LC_CH_NUM_USED-1:0]};
 assign probe_in1 = {st_trans_data_i[15:0], vc_trans_data_i[15:0]};


endmodule 