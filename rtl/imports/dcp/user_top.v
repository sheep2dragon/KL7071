
//FPGA version
`define                     FPGA_TIME_LC                32'h20190410
`define                     FPGA_VERSION_LC             32'h10500103
`define                     ST_LC_CH_NUM                10
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
//    output                FLASH_SPI_CLK,      //Bank 0 CCLK is dedicated
    output                FLASH_SPI_CS,
    output                FLASH_SPI_DI,       //spi flash input
    input                   FLASH_SPI_DO,       //spi flash output
    output                  FLASH_WP_N,
    output                  FLASH_HOLD,         //spi flash reset_n
    output                FLASH_SPI_IO_CLK,   //fpga user io, sclk
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
wire							 clk_sys;            //100M or 125M
wire							 clk_1X;
wire							 clk_2X;
wire							 clk_10X;
wire							 reset_1X;
wire							 reset_2X;
wire							 reset_10X;

wire     [`ST_LC_CH_NUM*32-1:0]  vc_trans_data;
wire     [`ST_LC_CH_NUM*32-1:0]  st_trans_data;
wire                             trans_start;
wire     [`ST_LC_CH_NUM-1:0]     phy_txd_i;
wire     [`ST_LC_CH_NUM-1:0]     rx_comm_err;
wire     [`ST_LC_CH_NUM-1:0]     rx_verify_err;
wire     [`ST_LC_CH_NUM-1:0]     phy_rxd_i;
wire     [`ST_LC_CH_NUM*8-1:0]   rxd_data;
wire                             clk_125M;
wire                             clk_50M ;
wire                             clk_250M;
wire							 clk_com;
wire	[13:0]					 vc_high_position_energy_fething;		//1--close the optic, 0--keep the optic;
//wire     [`ST_LC_CH_NUM-1:0]     tx_wea_s;    
//wire                             tx_waddr;
//wire                             sfp_rx_end_extend;

wire     [`ST_LC_CH_NUM-1:0]     optic_temp_fault;
wire     [`ST_LC_CH_NUM-1:0]	 bridge_mode_set;

//signal for debug
wire	[31:0]					vc_data_debug;
wire	[31:0]					st_data_debug;
wire							start_debug;
//-------------------------------------------------


  //这个是调用家里dcp的ep
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
    .clk_125M                  (    clk_125M                       ),
    .clk_50M                   (    clk_50M                        ),
    .clk_250M                  (    clk_250M                       ),
    .vc_high_position_energy_fething(vc_high_position_energy_fething),
    .optic_temp_fault          (    optic_temp_fault               ),
    .bridge_mode_set		   (	bridge_mode_set				   ),
    //user interface 
    .reset                     (    reset                          ),
    .soft_reset_cmd            (    soft_reset_cmd                 ),
    .clk_sys                   (    clk_sys                        ),
	.clk_com				   (	clk_com						   ),		//Add 120MHz
    .vc_trans_data             (    vc_trans_data                  ),
    .st_trans_data             (    st_trans_data                  ),
    .trans_start               (    trans_start                    ),
    .phy_txd_i                 (    phy_txd_i                      ),
    .rx_comm_err               (    rx_comm_err                    ),
    .rx_verify_err             (    rx_verify_err                  ),
    .phy_rxd_i                 (    phy_rxd_i                      ),
    .rxd_data                  (    rxd_data                       )
    );
    
    
//这边a7放了10个通道的解码模块
//optic_encode_top#(
//    .CH_NUM(10)

//	)
//	U_optic_encode_top(  
//    .reset(reset),
//    .clk_sys(clk_125M),
//    .clk_tx(clk_50M),					//50m
//    .clk_rx(clk_250M),					//250m
//    //fault sim configuration, cmd
//    .optic_tx_comm_fault('b0),		//00:no fault 01: comm fault 10: crc fault
//    .optic_rx_comm_fault('b0),		//0: no fault 1: comm fault
//    //optic tx port
//    .tx_wea_s(tx_wea_s),
//    .tx_waddr(tx_waddr),
//    .tx_wdata(m_axis_tdata_rfifo),
//    .sfp_rx_end_extend(sfp_rx_end_extend),
//    //optic rx port

//    .rxd_data_o(rxd_data),
//    //optic
//    .optic_in(phy_rxd),
//    .optic_out(phy_txd)

//);


//assign tx_wea_s = mstream_cnt[`ST_LC_CH_NUM*2-1:`ST_LC_CH_NUM] | {mstream_cnt[`ST_LC_CH_NUM-1:1],pose_start};
//assign tx_waddr = |mstream_cnt[`ST_LC_CH_NUM*2-1:`ST_LC_CH_NUM];
//assign sfp_rx_end_extend = mstream_cnt[`ST_LC_CH_NUM*2+1];

//ila_0 u_ila_0 (
//	.clk(clk_sys), // input wire clk
//
//	.probe0(vc_trans_data[15:0]), // input wire [15:0]  probe0  
//	.probe1(st_trans_data[23:0]), // input wire [23:0]  probe1 
//	.probe2(rxd_data[7:0]) // input wire [7:0]  probe2
//);

//assign rx_verify_err[9:0] = 10'b0000000000;

// Add optical fiber ngc 
	RXHC_CLK_RST	U_RXHC_CLK_RST(
		.clk(clk_sys),
		.reset(reset),
		.clk_1X(clk_1X),
		.clk_2X(clk_2X),
		.clk_10X(clk_10X),
		.reset_1X(reset_1X),
		.reset_2X(reset_2X),
		.reset_10X(reset_10X)
	);

generate
	genvar 			u;
	for(u=0;u<=`ST_LC_CH_NUM-1;u=u+1)
	begin: 			optic_encode_top 
		RXHC_SMCtrl_top		U_optic_ngc(
			.clk_in(clk_sys),
			.reset(reset),
			.clk_1X(clk_1X),
			.clk_2X(clk_2X),
			.clk_10X(clk_10X),
			.reset_1X(reset_1X),
			.reset_2X(reset_2X),
			.reset_10X(reset_10X),
			.HB_FB_flag(bridge_mode_set[u]),
			.phy_rxd(phy_rxd_i[u]),
			.phy_txd(phy_txd_i[u]),
			.st_tran_data(st_trans_data[u*32+31:u*32]),
			.vc_tran_data(vc_trans_data[u*32+31:u*32]),
			.trans_start(trans_start),
			.temp_err_sim(optic_temp_fault[u]),
			.rx_comm_err(rx_comm_err[u]),
			.rx_verify_err(rx_verify_err[u]),
			.rxd_data(rxd_data[u*8+7:u*8])
		);
	end
endgenerate

	assign vc_data_debug = vc_trans_data[31:0];
	assign st_data_debug = st_trans_data[31:0];
	assign start_debug = trans_start;
	
ila_user_debug		U_ila_user_debug(
	.clk(clk_sys),
	.probe0({22'd0,bridge_mode_set[9:0]}),
	.probe1(st_data_debug),
	.probe2(start_debug)
);

   
endmodule 