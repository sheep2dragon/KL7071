//==========================================================================
// Data				:	2017-07-30
// Author			:	Chen Biao
// Email			:	biao.chen@keliangtek.com
// purpose			:	KL7071 v2.0 K7 fpga top
//--------------------------------------------------------------------------
// Revision record	:
// data			person			issue number		detail
//
//==========================================================================
`timescale 1 ns / 1 ps

//FPGA version
`define						FPGA_TIME_LC				32'h20230225
`define						FPGA_VERSION_LC				32'h10500104
`define						ST_LC_CH_NUM				12

module st_lc_fpga_top(
//--------------------------------------------------------------------------
//clock in and reset
    input 					FPGA_RST_N,
    input 					MGT_REFCLK_216_P,	//cdclvd1208 out0, gt bank216
    input 					MGT_REFCLK_216_N,
    input 					USER_CLK_P,			//bank14, MRCC, cdclvd1208 out2
    input 					USER_CLK_N,
    input 					FMC_LPC_TX0,		//bank15, SRCC, lvds clk tdm
//--------------------------------------------------------------------------
//i2c sfp, los, abs and tx disable, multiuse with ST optic tx & rx,los
//--------------------------------------------------------------------------
	//bank14								//LC, blank is nouse	//ST, blank is nouse
	//bank14								//LC, blank is nouse	//ST, blank is nouse
    output  				TP23,			//TP23
    input 					SFPP8_ABS_8,    //SFPP8_ABS_8,
    input 					SFPP9_ABS_9,    //SFPP9_ABS_9,
    output 					SFPP12_SCL,     //SFPP12_SCL,
    output 					SFPP1_SCL,		//SFPP1_SCL,			//FRX_DATA0
    input 					SFPP13_LOS,		//SFPP13_LOS,			//FRX_DATA1
    input 					SFPP12_ABS_12,	//SFPP12_ABS_12,		//FRX_DATA2
    output 					SFPP0_SDA,		//SFPP0_SDA,			//FRX_DATA3
    output 					SFPP1_SDA,		//SFPP1_SDA,			//FRX_DATA4
    output 					SFPP0_SCL,		//SFPP0_SCL,			//FRX_DATA5
    output 					SFPP11_SCL,		//SFPP11_SCL,			//FRX_DATA6
    input 					SFPP1_ABS_1,	//SFPP1_ABS_1,			//FRX_DATA7
    output 					SFPP11_SDA,     //SFPP11_SDA,
    input 					SFPP1_LOS,      //SFPP1_LOS,
    output  				SFPP1_TX_DIS,   //SFPP1_TX_DIS,
    output  				SFPP0_TX_DIS,   //SFPP0_TX_DIS,
    input 					SFPP0_LOS,      //SFPP0_LOS,
    input 					SFPP11_LOS,     //SFPP11_LOS,
    input 					SFPP0_ABS_0,    //SFPP0_ABS_0,
    input 					SFPP11_ABS_11,  //SFPP11_ABS_11,
    input 					SFPP10_ABS_10,	//SFPP10_ABS_10,		//TP24
    output  				SFPP11_TX_DIS,  //SFPP11_TX_DIS,
    input 					SFPP10_LOS,     //SFPP10_LOS,
    input 					SFPP13_ABS_13,  //SFPP13_ABS_13,
    output  				SFPP10_TX_DIS,	//SFPP10_TX_DIS,		//TP25
    output  				SFPP12_TX_DIS,  //SFPP12_TX_DIS,
    input 					SFPP12_LOS,     //SFPP12_LOS,
    input 					SFPP9_LOS,      //SFPP9_LOS,
    output  				SFPP13_TX_DIS,  //SFPP13_TX_DIS,
    input 					SFPP5_ABS_5,    //SFPP5_ABS_5,
    output  				SFPP8_TX_DIS,   //SFPP8_TX_DIS,
    input 					SFPP5_LOS,      //SFPP5_LOS,
//--------------------------------------------------------------------------
	//bank15								//LC, blank is used		//ST, blank is nouse
	//bank15								//LC, blank is used		//ST, blank is nouse
    output  				TP22,			//TP22,
    input 					FSD_DATA0,								//FSD_DATA0,
    input 					SFPP_RD0,		//SFPP_RD0,				//FSD_DATA1,
    input 					SFPP_RD1,		//SFPP_RD1,				//FSD_DATA2,
    input 					SFPP_RD2,		//SFPP_RD2,				//FSD_DATA3,
    input 					SFPP_RD3,		//SFPP_RD3,				//FSD_DATA4,
    input 					SFPP_RD11,		//SFPP_RD11,			//FSD_DATA5,
    input 					SFPP_RD10,		//SFPP_RD10,			//FSD_DATA6,
    input 					SFPP_RD12,		//SFPP_RD12,			//FSD_DATA7,
    input 					SFPP_RD13,		//SFPP_RD13,			//FTX_DATA0,
    input 					SFPP_RD4,		//SFPP_RD4,				//FTX_DATA1,
    input 					SFPP_RD8,		//SFPP_RD8,				//FTX_DATA2,
    input 					SFPP_RD5,		//SFPP_RD5,				//FTX_DATA3,
    input 					SFPP_RD9,		//SFPP_RD9,				//FTX_DATA4,
    input 					SFPP_RD7,		//SFPP_RD7,				//FTX_DATA5,
    input 					SFPP_RD6,		//SFPP_RD6,				//FTX_DATA6,
    input 					FTX_DATA7,		//clk p, set as input	//FTX_DATA7,
    output 					SFPP_TD0,       //SFPP_TD0,
    output 					SFPP_TD1,       //SFPP_TD1,
    output 					SFPP_TD9,       //SFPP_TD9,
    output 					SFPP_TD11,      //SFPP_TD11,
    output 					SFPP_TD5,       //SFPP_TD5,
    output 					SFPP_TD13,      //SFPP_TD13,
    output 					SFPP_TD12,      //SFPP_TD12,
    output 					SFPP_TD10,      //SFPP_TD10,
    output 					SFPP_TD7,       //SFPP_TD7,
    output 					SFPP_TD6,       //SFPP_TD6,
    output 					SFPP10_SDA,     //SFPP10_SDA,
    output 					SFPP10_SCL,     //SFPP10_SCL, 			//TP22
    output 					SFPP13_SCL,     //SFPP13_SCL,			//TP23 
    output 					SFPP12_SDA,     //SFPP12_SDA,
    input 					SFPP8_LOS,      //SFPP8_LOS,
    output 					SFPP13_SDA,     //SFPP13_SDA,
    output 					SFPP_TD2,       //SFPP_TD2,
    output 					SFPP_TD3,       //SFPP_TD3,
    output 					SFPP_TD4,       //SFPP_TD4,
    output 					SFPP_TD8,       //SFPP_TD8,
    output  				SFPP9_TX_DIS,   //SFPP9_TX_DIS,
//--------------------------------------------------------------------------
	//bank34								//LC, blank is used		//ST, blank is nouse
	//bank34								//LC, blank is used		//ST, blank is nouse
    output  				SFPP9_SCL,		//SFPP9_SCL,
    output 					SFPP9_SDA,     	//SFPP9_SDA,
    output 					SFPP8_SDA,     	//SFPP8_SDA,
    output  				SFPP4_SCL,		//SFPP4_SCL,
    output  				SFPP2_SCL,      //SFPP2_SCL,
    output  				SFPP3_SCL,      //SFPP3_SCL,
    output 					SFPP3_SDA,     	//SFPP3_SDA,
    output 					SFPP2_SDA,     	//SFPP2_SDA,
    output 					SFPP7_SDA,     	//SFPP7_SDA,
    output 					SFPP4_SDA,     	//SFPP4_SDA,
    output  				SFPP7_SCL,      //SFPP7_SCL,
    output  				SFPP5_SCL,      //SFPP5_SCL,
    output 					SFPP5_SDA,     	//SFPP5_SDA,
    output 					SFPP6_SDA,     	//SFPP6_SDA,
    output  				SFPP6_SCL,		//SFPP6_SCL,
    output  				SFPP8_SCL,      //SFPP8_SCL,
    output  				SFPP2_TX_DIS,   //SFPP2_TX_DIS,
    output  				SFPP3_TX_DIS,   //SFPP3_TX_DIS,
    input 					SFPP2_ABS_2,    //SFPP2_ABS_2,
    input 					SFPP2_LOS,      //SFPP2_LOS,
    input 					SFPP3_LOS,      //SFPP3_LOS,
    input 					SFPP3_ABS_3,    //SFPP3_ABS_3,
    input 					SFPP6_ABS_6,    //SFPP6_ABS_6,
    output  				SFPP6_TX_DIS,   //SFPP6_TX_DIS,
    output  				SFPP7_TX_DIS,   //SFPP7_TX_DIS,
    input 					SFPP7_LOS,      //SFPP7_LOS,
    input 					SFPP7_ABS_7,    //SFPP7_ABS_7,
    output  				SFPP4_TX_DIS,   //SFPP4_TX_DIS,
    input 					SFPP4_LOS,      //SFPP4_LOS,
    input 					SFPP6_LOS,      //SFPP6_LOS,
    output  				SFPP5_TX_DIS,   //SFPP5_TX_DIS,
    input 					SFPP4_ABS_4,    //SFPP4_ABS_4,
//backplane gt bank
    output 		  			FMC_LPC_GTX00_P,
    output 					FMC_LPC_GTX00_N,
    input 					FMC_LPC_GRX00_P,
    input 					FMC_LPC_GRX00_N,
//lvds tx & rx, uart with K7
    input 		[3:1]  		FMC_LPC_TX,			//4 ch rx from k7 board
    output   	[2:0]		FMC_LPC_RX,			//3 ch tx to k7 board
    input 					HP_UART_TX,
    output 					HP_UART_RX,
//i2c eeprom
    output 					EEPROM_IIC_SCL,
    output 					EEPROM_IIC_SDA,
//spi flash w25qxxx
    output    				FLASH_SPI_CLK_SW,	//0: dedicated DCLK  1: Switch sclk to fpga user io
    output   			    FLASH_SPI_CS,
    output  				FLASH_SPI_DI,		//spi flash input
    input 					FLASH_SPI_DO,		//spi flash output
    output  				FLASH_WP_N,
    output  				FLASH_HOLD,			//spi flash reset_n
    output  				FLASH_SPI_IO_CLK,	//fpga user io, sclk
//debug uart
    output  				DEBUG_UART_TX0,
    input 					DEBUG_UART_RX0,
    output  				DEBUG_UART_TX1,
    input 					DEBUG_UART_RX1,
//led
    output  				LED1_ON,
    output  				LED2_ON,
    output  				LED3_ON,
    
//
    output reg  [11:0] lost_voltage_a7,
    output reg	[11:0] temp_fault_valid,
    output      [11:0] tx_direct_comm_fault_clk_sys,
    output      [11:0] tx_cross_comm_fault_clk_sys,
    output      [11:0] rx_direct_comm_fault_clk_sys,
    output      [11:0] rx_cross_comm_fault_clk_sys,
    
//add dcp netlist

    output                 pll_clkin,
    input   			   clk_sys,
    output [`ST_LC_CH_NUM-1:0]    optic_temp_fault,
    output [`ST_LC_CH_NUM-1:0]    bridge_mode_set,
    
//protocol tx
    output  				reset,
    output                  soft_reset_cmd,
//interface to ngc    
    output  	[`ST_LC_CH_NUM*32-1:0]	vc_trans_data,
    output  	[`ST_LC_CH_NUM*32-1:0]	st_trans_data,
(*mark_debug = "true"*) output  		trans_start,
    input   	[`ST_LC_CH_NUM-1:0]		phy_txd_i,
//protocol rx
    input   	[`ST_LC_CH_NUM-1:0]		rx_comm_err,
    input   	[`ST_LC_CH_NUM-1:0]		rx_verify_err,
    output  	[`ST_LC_CH_NUM-1:0]		phy_rxd_i,
    input   	[`ST_LC_CH_NUM*8-1:0]	rxd_data
	);

localparam 					PORT_NUM 		= 1;
localparam 					CH_NUM 			= 14;
localparam 					SYS_CLK_FREQ 	= 100;				//Clock frequency Unit: MHz
localparam 					AURORA_TX_PERIOD 	= 50;			//unit us
localparam 					AURORA_TX_CNT_WIDTH = 11;			//for count width of sfp tx period

parameter					T100MS = SYS_CLK_FREQ*100*1000;	//100ms
parameter					T10MS = SYS_CLK_FREQ*10*1000;	//10ms
//-------------------------signal definition--------------------------------
//-------------------------signal definition--------------------------------
reg	[CH_NUM-1:0]			optic_temp_fault_1dly;
reg	[CH_NUM*24-1:0]			optic_temp_cnt;

wire 						clk_aurora;					//125m
wire 						clk_125m;
wire 						clk_50m;
wire 						clk_250m;
wire 						user_clk_100m;
wire 						user_clk_125m;
wire 						pll_rst_n;
wire 						reset_i;
wire 						gt_reset;
wire 						fpga_led;
wire 						fpga_led_local;
wire 	[13:0]				optic_in;
wire 	[13:0]				optic_out;
wire 	[13:0]				sfpp_los;
wire 	[13:0]				sfpp_abs;
wire  	[PORT_NUM*32-1:0]   		m_axis_tdata_rfifo;
wire  	[PORT_NUM-1:0]      		m_axis_tvalid_rfifo;
wire  	[PORT_NUM-1:0]      		m_axis_tlast_rfifo;
wire 	[PORT_NUM*32-1:0]   		s_axis_tdata_tfifo;
wire 	[PORT_NUM-1:0]      		s_axis_tvalid_tfifo;
wire 	[PORT_NUM-1:0]      		s_axis_tlast_tfifo;
wire 	[PORT_NUM-1:0]				s_axis_tready_tfifo;
wire 	[PORT_NUM-1:0]       		frame_err;
wire 	[PORT_NUM-1:0]       		hard_err;
wire 	[PORT_NUM-1:0]       		soft_err;
wire 	[PORT_NUM-1:0]       		lane_up;
wire 	[PORT_NUM-1:0]       		channel_up;
wire 	[PORT_NUM-1:0]       		crc_pass_fail_n;
wire 	[PORT_NUM-1:0]       		crc_valid;
wire 	[PORT_NUM-1:0]				tx_resetdone_out;
wire 	[PORT_NUM-1:0]				rx_resetdone_out;
wire 	[PORT_NUM-1:0]				pll_not_locked_out;
wire 	[PORT_NUM-1:0]				link_reset_out;
wire 	[10:0]				        serdes_state;
wire                               spi_flash_switch;                   //0: traffic data  1:spi flash download
wire 	[CH_NUM*2-1:0]			    optic_tx_comm_fault_i;	//00:no fault 01: comm fault 10: crc fault
wire 	[CH_NUM-1:0]				optic_rx_comm_fault_i;	//0: no fault 1: comm fault
wire 						        sfp_rx_end_extend;
wire 	[CH_NUM-1:0] 				rx_comm_err_o;
wire 	[CH_NUM-1:0] 				rx_verify_err_o;
wire 	[CH_NUM*8-1:0]	 			rxd_data_o;

wire    [CH_NUM*32-1:0]				vc_trans_data_i;
wire    [CH_NUM*32-1:0]				st_trans_data_i;
wire                                lvds_clk;
reg                                 FLASH_SPI_DO_d0;
wire    [3:0]                       spi_interface_o;


wire    [CH_NUM-1:0]                phy_txd_in;
wire    [CH_NUM-1:0]                phy_rxd_in;
wire    [CH_NUM-1:0]                phy_rxd;
wire    [CH_NUM-1:0]                phy_txd;
wire    [CH_NUM*4-1:0]              optic_tx_comm_fault;
wire    [CH_NUM*4-1:0]              optic_rx_comm_fault;
wire    [CH_NUM-1:0]                vc_high_position_energy_fething;
//aurora start end
wire                                a7_aurora_rx_start;
wire                                a7_aurora_rx_end;
wire                                a7_aurora_tx_start;
wire                                a7_aurora_tx_end;

wire [11:0] tx_direct_crc_fault_clk_sys;
wire [11:0] tx_corss_crc_fault_clk_sys;

wire [11:0] rx_direct_crc_fault_clk_sys;
wire [11:0] rx_corss_crc_fault_clk_sys;

//-------------------------------------------------------------------------- one channel data for debug
wire clk_sys_reset;


//--------------------------------------------------------------------------
//from physical order to FPGA logic order
//14 channels sfp, physical order,bottom to top		1 /0 /11/10/12/13/9/8/5/4/6/7/3/2
//FPGA logic requird order							13/12/11/10/9 /8 /7/6/5/4/3/2/1/0
//--------------------------------------------------------------------------
//sfp rx signal
assign sfpp_los[13:0] = {SFPP1_LOS,SFPP0_LOS,SFPP11_LOS,SFPP10_LOS,SFPP12_LOS,SFPP13_LOS,SFPP9_LOS,
						SFPP8_LOS,SFPP5_LOS,SFPP4_LOS,SFPP6_LOS,SFPP7_LOS,SFPP3_LOS,SFPP2_LOS};
assign sfpp_abs[13:0] = {SFPP1_ABS_1,SFPP0_ABS_0,SFPP11_ABS_11,SFPP10_ABS_10,SFPP12_ABS_12,SFPP13_ABS_13,SFPP9_ABS_9,
						SFPP8_ABS_8,SFPP5_ABS_5,SFPP4_ABS_4,SFPP6_ABS_6,SFPP7_ABS_7,SFPP3_ABS_3,SFPP2_ABS_2};
assign optic_in[13:0] = {SFPP_RD1,SFPP_RD0,SFPP_RD11,SFPP_RD10,SFPP_RD12,SFPP_RD13,SFPP_RD9,
							SFPP_RD8,SFPP_RD5,SFPP_RD4,SFPP_RD6,SFPP_RD7,SFPP_RD3,SFPP_RD2};
//--------------------------------------------------------------------------
//sfp tx signal
assign {SFPP1_TX_DIS,SFPP0_TX_DIS,SFPP11_TX_DIS,SFPP10_TX_DIS,SFPP12_TX_DIS,SFPP13_TX_DIS,SFPP9_TX_DIS,
					SFPP8_TX_DIS,SFPP5_TX_DIS,SFPP4_TX_DIS,SFPP6_TX_DIS,SFPP7_TX_DIS,SFPP3_TX_DIS,SFPP2_TX_DIS} = {14{1'b0}};
assign {SFPP1_SCL,SFPP0_SCL,SFPP11_SCL,SFPP10_SCL,SFPP12_SCL,SFPP13_SCL,SFPP9_SCL,
					SFPP8_SCL,SFPP5_SCL,SFPP4_SCL,SFPP6_SCL,SFPP7_SCL,SFPP3_SCL,SFPP2_SCL} = {14{1'b1}};
assign {SFPP1_SDA,SFPP0_SDA,SFPP11_SDA,SFPP10_SDA,SFPP12_SDA,SFPP13_SDA,SFPP9_SDA,
					SFPP8_SDA,SFPP5_SDA,SFPP4_SDA,SFPP6_SDA,SFPP7_SDA,SFPP3_SDA,SFPP2_SDA} = {14{1'b1}};
assign {SFPP_TD1,SFPP_TD0,SFPP_TD11,SFPP_TD10,SFPP_TD12,SFPP_TD13,SFPP_TD9,
		SFPP_TD8,SFPP_TD5,SFPP_TD4,SFPP_TD6,SFPP_TD7,SFPP_TD3,SFPP_TD2} = optic_out[13:0];
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------

//---------------------------------------------------------------------------------

assign phy_txd_in[`ST_LC_CH_NUM-1:0] =  phy_txd_i[`ST_LC_CH_NUM-1:0] ; 
assign phy_rxd_i[`ST_LC_CH_NUM-1:0] = phy_rxd_in[`ST_LC_CH_NUM-1:0];


//assign  =    
IBUF #(
      .IBUF_LOW_PWR("FALSE"),  // Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards 
      .IOSTANDARD("DEFAULT")  // Specify the input I/O standard
   ) lvds_ibuf (
      .O(lvds_clk),           // Buffer output
      .I(FMC_LPC_TX0)       // Buffer input (connect directly to top-level port)
   );

//--------------------------------------------------------------------------
//e2prom
assign EEPROM_IIC_SCL = 1'b1;
assign EEPROM_IIC_SDA = 1'b1;
//--------------------------------------------------------------------------
//debug uart
assign DEBUG_UART_TX0 = 1'b1;
assign DEBUG_UART_TX1 = 1'b1;
//--------------------------------------------------------------------------
//led and test point
assign LED2_ON = fpga_led_local;
assign LED3_ON = reset;
assign trans_start = sfp_rx_end_extend;
//Total 14 channel
assign optic_out = phy_txd[13:0];
assign phy_rxd = optic_in[13:0];
assign rxd_data_o = {16'd0, rxd_data[`ST_LC_CH_NUM*8-1:0]};
assign rx_comm_err_o = {2'd0, rx_comm_err[`ST_LC_CH_NUM-1:0]};
assign rx_verify_err_o = {2'd0, rx_verify_err[`ST_LC_CH_NUM-1:0]};

assign vc_trans_data = vc_trans_data_i[`ST_LC_CH_NUM*32-1:0];
assign st_trans_data = st_trans_data_i[`ST_LC_CH_NUM*32-1:0];
//-------------------------ipcore & module----------------------------------
//-------------------------ipcore & module----------------------------------
IBUF	sys_reset_n_ibuf (.O(pll_rst_n), .I(FPGA_RST_N));

assign reset = clk_sys_reset | soft_reset_cmd;

IBUFGDS #(
    .DIFF_TERM    ("FALSE"),
    .IBUF_LOW_PWR ("FALSE")
    )
   u_ibufg_sys_clk
     (
      .I  (USER_CLK_P),
      .IB (USER_CLK_N),
      .O  (clk_aurora)
      );

wire clk_aurora_reset;
rst_ctrl_high 		U_rst_ctrl_high(
//clk & rst
    .clk_sys(clk_aurora),
    .locked(pll_rst_n),
    .fpga_rst(clk_aurora_reset)
	);

rst_ctrl_high   U_rst_ctrl_high_1(
//clk & rst
    .clk_sys(clk_sys),
    .locked(pll_rst_n),
    .fpga_rst(clk_sys_reset)
	);
	

rst_ctrl_high_gt 	U_rst_ctrl_high_gt(
//clk & rst
    .clk_sys(clk_aurora),
    .locked(pll_rst_n),
    .fpga_rst(gt_reset)
	);

assign pll_clkin = clk_aurora;


led					U_led_125m(
    .clk_sys(clk_sys),//clk_125m
    .reset(1'b0),
    .fpga_led(fpga_led_local)
	);



wire load_data_valid;
wire [7:0] load_data;

 flash_update u_flash_update(
      .clk125m            (   clk_aurora        ),//input
      .rst                (   clk_aurora_reset  ),//input
      .sys_clk            (   clk_sys            ),//input
    
      .fifo_full          (                     ),//output
      .load_data_valid    ( load_data_valid     ),//input
      .load_data          ( load_data           ),//input[7:0]
      
      .flash_data_rx_done   ( FMC_LPC_TX[3]       ),//input
      .load_device_select   ( 2'b10               ),//input[1:0]
      .flash_load_state_end ( FMC_LPC_RX[0]       ),//output

      .flash_cs         (   FLASH_SPI_CS       ),//output
      .flash_di         (   FLASH_SPI_DI       ),//output
      .flash_spi_clk_sw (   FLASH_SPI_CLK_SW   ),//output
      .flash_wp_n       (   FLASH_WP_N         ),//output
      .flash_hold       (   FLASH_HOLD         ),//output
      .flash_do         (   FLASH_SPI_DO       ) //input

    );



aurora_8b10b_gtp_support		U_serdes_bank0_user0(
    //GT AXI TX Interface
    .s_axi_tx_tdata(s_axis_tdata_tfifo),
    .s_axi_tx_tkeep(4'hF),
    .s_axi_tx_tvalid(s_axis_tvalid_tfifo),
    .s_axi_tx_tlast(s_axis_tlast_tfifo),
    .s_axi_tx_tready(s_axis_tready_tfifo),
    //GT AXI RX Interface
    .m_axi_rx_tdata(m_axis_tdata_rfifo),
    .m_axi_rx_tkeep(),
    .m_axi_rx_tvalid(m_axis_tvalid_rfifo),
    .m_axi_rx_tlast(m_axis_tlast_rfifo),
    // GT Serial I/O
    .rxp(FMC_LPC_GRX00_P),
    .rxn(FMC_LPC_GRX00_N),
    .txp(FMC_LPC_GTX00_P),
    .txn(FMC_LPC_GTX00_N),
    // GT Reference Clock Interface 
    .gt_refclk1_p(MGT_REFCLK_216_P),
    .gt_refclk1_n(MGT_REFCLK_216_N),
    // Error Detection Interface
    .frame_err(frame_err),
    .hard_err(hard_err),
    .soft_err(soft_err),
    // Status
    .lane_up(lane_up),
    .channel_up(channel_up),
    //CRC output status signals
    .crc_pass_fail_n(crc_pass_fail_n),
    .crc_valid(crc_valid),
    // System Interface
    .user_clk_out(clk_125m),
    .gt_reset(gt_reset),				//reset the transceivers after power on. Debounced using init clk, at least 6 init clk
    .reset(clk_aurora_reset),						//reset the aurora 8B/10B core, active high, at least 6 user clk
    .loopback(3'd0),
    .init_clk_i(clk_aurora),
    .tx_resetdone_out(tx_resetdone_out),
    .rx_resetdone_out(rx_resetdone_out),
    .link_reset_out(link_reset_out),	//clk init domain, sync to user clk
    .sys_reset_out(),					//unused when shared logic in core
    //DRP Ports
    .drpclk_in(clk_aurora),
    .pll_not_locked_out(pll_not_locked_out)		//unknow clk domain, sync to user clk
	);

aurora_app_s#(
    .PORT_NUM(PORT_NUM),
    .CH_NUM(CH_NUM),
    .SYS_CLK_FREQ(SYS_CLK_FREQ),					//Clock frequency Unit: MHz
    .AURORA_TX_PERIOD(AURORA_TX_PERIOD),			//unit us
    .AURORA_TX_CNT_WIDTH(AURORA_TX_CNT_WIDTH)		//for count width of sfp tx period
	)
	U_aurora_app_s(    
    .reset(clk_sys_reset),
    .clk_sys(clk_sys),
    .clk_125m(clk_125m),
    //initial information
    .i_channel_up(channel_up),
	//optic tx port
    .vc_trans_data(vc_trans_data_i),
    .st_trans_data(st_trans_data_i),
    .sfp_rx_end_extend(sfp_rx_end_extend),
    //optic rx port
    .rxd_data_o(rxd_data_o),
    //
    .a7_aurora_rx_start(a7_aurora_rx_start),
    .a7_aurora_rx_end(a7_aurora_rx_end),
    .a7_aurora_tx_start(a7_aurora_tx_start),
    .a7_aurora_tx_end(a7_aurora_tx_end),
	//backplane aurora axis rx from k7 fpga, clk 200m domain
    .m_axis_tdata_rfifo(m_axis_tdata_rfifo),
    .m_axis_tvalid_rfifo(m_axis_tvalid_rfifo),
    .m_axis_tlast_rfifo(m_axis_tlast_rfifo),
	//backplane aurora axis tx to k7 fpga, clk 200m domain
    .s_axis_tdata_tfifo(s_axis_tdata_tfifo),
    .s_axis_tvalid_tfifo(s_axis_tvalid_tfifo),
    .s_axis_tlast_tfifo(s_axis_tlast_tfifo),
    .s_axis_tready_tfifo(s_axis_tready_tfifo)
	);


wire [CH_NUM-1:0] optic_temp_fault_w;
uart_app_s#(
    .CH_NUM(CH_NUM)	//optic board channel 0-13
)
	U_uart_app_s(
    .reset(clk_sys_reset),
    .clk_sys(clk_sys),
    .fpga_led(fpga_led),
    //auto load en
    .auto_load_en ( FMC_LPC_TX[1] ),
    .data_to_load_valid ( load_data_valid  ),//output
    .data_to_load (  load_data   ),//output[7:0]
    //initial information
    .fpga_version_optic(`FPGA_VERSION_LC),
    .fpga_time_optic(`FPGA_TIME_LC),
    .sfp_abs(sfpp_abs[13:0]),						//sfp absent, inverse at k7 fpga, original is 0:present  1:absent
    .sfp_los(sfpp_los[13:0]),						//sfp rx los, inverse at k7 fpga, original is 0:normal 1:los
    .rx_comm_err(rx_comm_err_o),					//LC channel rx communication error, 1:err 0: normal
    .rx_verify_err(rx_verify_err_o),				//LC channel rx verify error, 1:err 0: normal
    .serdes_state(11'd0),
	//reset cmd
    .soft_reset_cmd(soft_reset_cmd),
    //spi flash switch
    .spi_flash_switch(spi_flash_switch),            //0: traffic data  1:spi flash download
    //fault sim configuration, cmd
    .optic_tx_comm_fault(optic_tx_comm_fault),
    .optic_rx_comm_fault(optic_rx_comm_fault),
    .optic_temp_fault(optic_temp_fault_w),
    .bridge_mode_set(bridge_mode_set),
    //high position energy fething
    .vc_high_position_energy_fething(vc_high_position_energy_fething),
	//uart interface
    .a7_led( fpga_led_local ),
    .com_232_rx(FMC_LPC_TX[2]),
    .com_232_tx(FMC_LPC_RX[1])
	);
	
	always @(posedge clk_sys)
	begin
		optic_temp_fault_1dly <= optic_temp_fault_w;
	end

reg [`ST_LC_CH_NUM-1:0] lost_voltage_k7;
reg [23:0] lost_voltage_count [`ST_LC_CH_NUM-1:0];

always @(posedge clk_sys)
begin
    lost_voltage_k7 <= vc_high_position_energy_fething[`ST_LC_CH_NUM:0];
end

generate
genvar 			u;

	for(u=0;u<=`ST_LC_CH_NUM-1;u=u+1)
	begin:			lost_voltage_cnt
		always @(posedge clk_sys)
		begin
		    if(reset)
		        lost_voltage_count[u] <= 0;
		    else begin
		        if(lost_voltage_k7[u]==1'b1) begin
		            if(lost_voltage_count[u]<T10MS)
		                lost_voltage_count[u] <= lost_voltage_count[u] + 1'b1;
		        end
		        else
		            lost_voltage_count[u] <= 0;
		    end
		end
    end
    
	for(u=0;u<=`ST_LC_CH_NUM-1;u=u+1)
    begin:            lost_voltage_logic
        always @(posedge clk_sys)
        begin
            if(reset)
                lost_voltage_a7[u] <= 1'b1;
            else begin
                if(lost_voltage_k7[u]==1'b0)
                    lost_voltage_a7[u] <= 1'b0;
                else if(lost_voltage_count[u]>=T10MS)
                    lost_voltage_a7[u] <= 1'b1;
                else
                    lost_voltage_a7[u] <= lost_voltage_a7[u];
            end
        end
    end

	for(u=0;u<=`ST_LC_CH_NUM-1;u=u+1)
	begin:			temp_fault_cnt
		always @(posedge clk_sys)
		begin
			if(optic_temp_cnt[u*24+23:u*24]>=T100MS)
				optic_temp_cnt[u*24+23:u*24] <= 24'd0;
			else if(optic_temp_fault_w[u]==1'b1 && optic_temp_fault_1dly[u]==1'b0)
				optic_temp_cnt[u*24+23:u*24] <= 24'd1;
			else if(optic_temp_cnt[u*24+23:u*24]>24'd0)
				optic_temp_cnt[u*24+23:u*24] <= optic_temp_cnt[u*24+23:u*24] + 1'b1;
			else ;
		end
	end

	for(u=0;u<=`ST_LC_CH_NUM-1;u=u+1)
	begin:			temp_fault_valid_ch
		always @(posedge clk_sys)
		begin
			if(optic_temp_fault_w[u]==1'b0)
				temp_fault_valid[u] <= 1'b0;
			else if(optic_temp_cnt[u*24+23:u*24]>=T100MS)
				temp_fault_valid[u] <= 1'b1;
			else ;
		end
	end
	
	
endgenerate

//tx com fault simulation
assign phy_txd[`ST_LC_CH_NUM-1:0] = phy_txd_in[`ST_LC_CH_NUM-1:0];
assign phy_rxd_in[`ST_LC_CH_NUM-1:0] = phy_rxd[`ST_LC_CH_NUM-1:0];

generate
    genvar 			i;
//--------------------------------------------------------------------------
//tx fault cfg
    for(i=0;i<=`ST_LC_CH_NUM-1;i=i+1)
    begin: 			tx_direct_comm_fault_ch
        assign tx_direct_comm_fault_clk_sys[i] = optic_tx_comm_fault[i*4];
        assign tx_direct_crc_fault_clk_sys[i] = optic_tx_comm_fault[i*4+1];
        assign tx_cross_comm_fault_clk_sys[i] = optic_tx_comm_fault[i*4+2];
        assign tx_corss_crc_fault_clk_sys[i] = optic_tx_comm_fault[i*4+3];
        assign rx_direct_comm_fault_clk_sys[i] = optic_rx_comm_fault[i*4];
        assign rx_direct_crc_fault_clk_sys[i] = optic_rx_comm_fault[i*4+1];
        assign rx_cross_comm_fault_clk_sys[i] = optic_rx_comm_fault[i*4+2];
        assign rx_corss_crc_fault_clk_sys[i] = optic_rx_comm_fault[i*4+3];
    end
   
endgenerate


assign optic_temp_fault = optic_temp_fault_w[`ST_LC_CH_NUM-1:0] | vc_high_position_energy_fething[`ST_LC_CH_NUM-1:0];

///////////////////////////////////////////////////////////
//ila_0 ila (
//	.clk(clk_sys), // input wire clk
//	.probe0({phy_txd[11:0],phy_rxd_in[11:0],tx_comm_fault_clk_sys[5:0],rx_comm_fault_clk_sys[5:0]}) // input wire [29:0] probe0
//);

endmodule
