//==========================================================================
// Data				:	2017-07-02
// Author			:	Chen Biao
// Email			:	biao.chen@keliangtek.com
// purpose			:	
//--------------------------------------------------------------------------
// Revision record	:
// data			person			issue number		detail
//
//==========================================================================
`timescale 1 ns / 1 ns

module optic_encode_top#(
    parameter 				CH_NUM = 14
	)
	(    
    input 					reset,
    input 					clk_sys,
    input 					clk_tx,					//50m
    input 					clk_rx,					//250m
    //fault sim configuration, cmd
    input 		[CH_NUM*2-1:0]			optic_tx_comm_fault,		//00:no fault 01: comm fault 10: crc fault
    input 		[CH_NUM-1:0]			optic_rx_comm_fault,		//0: no fault 1: comm fault
	//optic tx port
    input  		[CH_NUM-1:0] 		tx_wea_s,
    input 					tx_waddr,
    input 		[31:0]		tx_wdata,
    input 					sfp_rx_end_extend,
    //optic rx port
    output reg 	[CH_NUM-1:0] 		rx_comm_err_o,
    output reg 	[CH_NUM-1:0] 		rx_verify_err_o,
    output reg 	[CH_NUM*8-1:0]	 	rxd_data_o,
    //optic
    input 		[CH_NUM-1:0]		optic_in,
    output  	[CH_NUM-1:0]		optic_out
	);

//-------------------------signal definition--------------------------------
//-------------------------signal definition--------------------------------
//--------------------------------------------------------------------------
//clk sys domain
reg 	[CH_NUM-1:0]				rx_comm_err_1dly;		//LC channel rx communication error, 1:err 0: normal
reg 	[CH_NUM-1:0]				rx_verify_err_1dly;		//LC channel rx verify error, 1:err 0: normal
reg 	[CH_NUM*8-1:0]				rxd_data_1dly,rxd_data_2dly,rxd_data_3dly;
wire 	[CH_NUM-1:0] 		tx_comm_fault_clk_sys;
wire 	[CH_NUM-1:0] 		tx_crc_fault_clk_sys;

//--------------------------------------------------------------------------
//clk tx domain
reg 	[3:0]				sfp_rx_end_extend_clk_tx;
reg 						trans_start;
reg 	[CH_NUM-1:0]				tx_comm_fault_1dly,tx_comm_fault_2dly;
reg 	[CH_NUM-1:0]				tx_crc_fault_1dly,tx_crc_fault_2dly;

//--------------------------------------------------------------------------
//clk rx domain
wire 	[CH_NUM-1:0]				rx_comm_err_s;
wire 	[CH_NUM-1:0]				rx_verify_err_s;
wire 	[CH_NUM*8-1:0]				rxd_data_s;

//-------------------------ipcore & module----------------------------------
//-------------------------ipcore & module----------------------------------
generate
    genvar 			u;
    for(u=0;u<=CH_NUM-1;u=u+1)
    begin:			optic_tx_multichannel
        optic_tx 		U_optic_tx(
            .reset(reset),
            .clk_sys(clk_sys),
            .clk_tx(clk_tx),					//clk 50m
            //user interface, clk sys domain
            .tx_wea(tx_wea_s[u]),
            .tx_waddr(tx_waddr),
            .tx_wdata(tx_wdata[31:0]),
        	//tx ctrl, clk tx domain
            .tx_comm_fault(tx_comm_fault_2dly[u]),			//0:no fault, 1:fault
            .tx_crc_fault(tx_crc_fault_2dly[u]),			//0:no fault, 1:fault
            .trans_start(trans_start),
            //serial data
            .phy_txd(optic_out[u])
        	);
    end
	//
    for(u=0;u<=CH_NUM-1;u=u+1)
    begin:			optic_rx_multichannel
        optic_rx 		U_optic_rx(
            .reset(reset),
            .clk_rx(clk_rx),								//clk 250m
            //debug info, clk rx domain
            .rx_comm_err(rx_comm_err_s[u]),					//LC channel rx communication error, 1:err 0: normal
            .rx_verify_err(rx_verify_err_s[u]),				//LC channel rx verify error, 1:err 0: normal
            //serial data
            .phy_rxd(optic_in[u]),
            //user interface, clk rx domain
            .rxd_data(rxd_data_s[u*8+7:u*8])
        	);
    end
endgenerate

//--------------------------------------------------------------------------
//--------------------------------------------------------------------------optic tx fault cfg, rx fault sim
generate
    genvar 			i;
//--------------------------------------------------------------------------
//tx fault cfg
    for(i=0;i<=CH_NUM-1;i=i+1)
    begin: 			tx_comm_fault_ch
        assign tx_comm_fault_clk_sys[i] = optic_tx_comm_fault[i*2];
    end
    //
    for(i=0;i<=CH_NUM-1;i=i+1)
    begin: 			tx_crc_fault_ch
        assign tx_crc_fault_clk_sys[i] = optic_tx_comm_fault[i*2+1];
    end
//rx fault sim
    for(i=0;i<=CH_NUM-1;i=i+1)
    begin: 			rxd_data_3dly_ch
        always @(posedge clk_sys)
        begin
    	    if (optic_rx_comm_fault[i]==1'b1)			//0: no fault 1: comm fault
    	    	rxd_data_3dly[i*8+7:i*8] <= 8'h00;
    	    else
    	    	rxd_data_3dly[i*8+7:i*8] <= rxd_data_2dly[i*8+7:i*8];
        end
    end
endgenerate

//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
//clk sys domain
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
always @(posedge clk_sys)
begin
	//cross clock domain
	rx_comm_err_1dly <= rx_comm_err_s;
	rx_comm_err_o <= rx_comm_err_1dly;
	rx_verify_err_1dly <= rx_verify_err_s;
	rx_verify_err_o <= rx_verify_err_1dly;
	rxd_data_1dly <= rxd_data_s;
	rxd_data_2dly <= rxd_data_1dly;
	rxd_data_o <= rxd_data_3dly;
end

//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
//clk tx domain
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
always @(posedge clk_tx)
begin
	sfp_rx_end_extend_clk_tx <= {sfp_rx_end_extend_clk_tx[2:0], sfp_rx_end_extend};
	trans_start <= sfp_rx_end_extend_clk_tx[2] & ~sfp_rx_end_extend_clk_tx[3];
	tx_comm_fault_1dly <= tx_comm_fault_clk_sys;
	tx_comm_fault_2dly <= tx_comm_fault_1dly;
	tx_crc_fault_1dly <= tx_crc_fault_clk_sys;
	tx_crc_fault_2dly <= tx_crc_fault_1dly;
end

endmodule

