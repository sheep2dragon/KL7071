`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/11 13:19:54
// Design Name: 
// Module Name: flash_top
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


module flash_top
(
    input            clk,
    input            reset,
    input            sys_clk,
    
    output           flash_clk,
    
    input [1:0]      device_type,
    
    input            flash_page_byte_valid,
    input  [7:0]     flash_page_byte,
    
    input  [8:0]     flash_sector_num,
    input  [23:0]    flash_page_num,
    output [12:0]    flash_fifo_wr_data_count,

    output           fifo_full ,

    input            i_flash_data_rx_done,
    input [1:0]      load_device_select,

    output           flash_load_state_end,

    output           o_flash_cs    ,
    output           o_flash_din    ,
    input            i_flash_dout
);

localparam IDLE           = 3'b000;
localparam SECTOR_ERASE   = 3'b001;
localparam PAGE_WRITE     = 3'b010;
localparam EAR_WRITE      = 3'b011;
localparam PAGE_READ      = 3'b100;
localparam WAIT_RESTART   = 3'b101;

reg [2:0] flash_state = IDLE;

reg        [ 3:0]    r_cmd_type    ;
reg        [ 7:0]    r_flash_cmd    ;
reg        [23:0]    r_flash_addr;
reg        [ 7:0]    r_flash_wdata;
reg        [ 7:0]    r_data_num    ;

wire                 r_op_done    ;
wire                 r_flash_done;
wire       [ 7:0]    r_flash_rdata;

reg        [ 7:0]    r_cnt        ;
wire                 r_wr_byte_over;
reg                  tx_init_flag = 1'b1;
reg                  b_read_flash_id = 1'b0;
reg                  r_clk_50MHz = 1'b0;
reg                  r_clk_25MHz = 1'b0;

wire [12:0] fifo_wr_data_count;
wire [12:0] fifo_rd_data_count;
reg [8:0] flash_sector_count = 0;
reg [23:0] flash_sector_current_addr = 0;
reg [23:0] flash_sector_addr = 0;
reg [7:0] flash_page_count = 0;
reg [23:0] flash_page_addr = 0;
reg [16:0] flash_page_num_writen;
reg [2:0] bit_count = 0;
reg [8:0] byte_count = 9'd256;
wire fifo_rd_en;
wire [7:0] fifo_dout;

wire vio_flash_rd;
reg vio_flash_rd_d1;
reg flash_rd_flag = 1'b0;
wire o_flash_clk ;
wire flash_ctrl_clk;
reg ear_data;

wire icape2_start;
wire fifo_empty;
wire fifo_wr;
wire flash_data_rx_done;

reg  [3:0] wait_restart_time;

//assign vio_flash_rd = 1'b1;

//vio_0 u_vio_0 (
//  .clk(r_clk_25MHz),         // input wire clk
//  .probe_out0(vio_flash_rd)  // output wire [0 : 0] probe_out0
//);

assign flash_ctrl_clk  = ( (load_device_select == 2'b00) || (load_device_select == device_type) ) ? o_flash_clk : 1'b0;
assign fifo_wr         = (load_device_select == device_type) ? flash_page_byte_valid : 1'b0 ;
assign flash_data_rx_done = (load_device_select == device_type) ? i_flash_data_rx_done : 1'b0 ;

STARTUPE2 STARTUPE2_inst(
    .CLK(1'b0),
    .GSR(1'b0), //-- 1-bit input: Global Set/Reset input (GSR cannot be used for the port name)
    .GTS(1'b0), //-- 1-bit input: Global 3-state input (GTS cannot be used for the port name)
    .KEYCLEARB(1'b1),
    .PACK(1'b1), //-- 1-bit input: PROGRAM acknowledge input
    .USRCCLKO(flash_ctrl_clk), //-- 1-bit input: User CCLK input
    .USRCCLKTS(1'b0),
    .USRDONEO(1'b1),
    .USRDONETS(1'b1)
);

flash_fifo_8192X8 flash_fifo_8192x8_1 (
  .rst(reset),                      // input wire rst
  .wr_clk(sys_clk),                // input wire wr_clk
  .rd_clk(r_clk_25MHz),                // input wire rd_clk
  .din(flash_page_byte),                      // input wire [7 : 0] din
  .wr_en(fifo_wr),                  // input wire wr_en
  .rd_en(fifo_rd_en),                  // input wire rd_en
  .dout(fifo_dout),                    // output wire [7 : 0] dout
  .full( fifo_full ),                    // output wire full
  .empty( fifo_empty ),                  // output wire empty
  .rd_data_count(fifo_rd_data_count),  // output wire [12 : 0] rd_data_count
  .wr_data_count(fifo_wr_data_count),  // output wire [12 : 0] wr_data_count
  .wr_rst_busy(),      // output wire wr_rst_busy
  .rd_rst_busy()      // output wire rd_rst_busy
);


assign fifo_rd_en = (flash_state==PAGE_WRITE && 
                        (r_cnt==8'd2 && r_flash_done && r_flash_rdata[1] == 1'b1) || 
                        (r_wr_byte_over==1'b1 && byte_count<=255)) ? 1'b1 : 1'b0;

assign flash_fifo_wr_data_count = fifo_wr_data_count;

always @(posedge clk)
    r_clk_50MHz <= ~r_clk_50MHz;

always @(posedge r_clk_50MHz)
    r_clk_25MHz <= ~r_clk_25MHz;

assign flash_clk = r_clk_25MHz;

always @(posedge r_clk_25MHz or posedge reset) begin
    if(reset) begin
        r_cmd_type    <= 'd0;
        r_flash_cmd    <= 'd0;
        r_flash_addr<= 'd0;
        r_flash_wdata<= 'd0;
        r_data_num    <= 'd0;
        r_cnt        <= 'd0;
        b_read_flash_id <= 1'b0;
        flash_state <= IDLE;
        ear_data    <= 1'b0;
        wait_restart_time <= 4'd0;
    end
    else begin
        if(flash_state==IDLE) begin
            r_cmd_type    <= 'd0;
            r_flash_cmd    <= 'd0;
            r_flash_addr<= 'd0;
            r_flash_wdata<= 'd0;
            r_data_num    <= 'd0;
            r_cnt        <= 'd0;
            flash_page_count <= 0;
            flash_page_addr <= 0;
            flash_page_num_writen <= 0;
            flash_sector_count <= 0;
            flash_sector_addr <= 0;
            
            if(b_read_flash_id==1'b0) begin
                if(r_op_done) // && r_flash_rdata == 8'h15
                begin
                    r_cmd_type    <= 4'b0;
                    r_flash_cmd    <= 8'b0;
                    r_flash_addr<= 24'b0;
                    r_flash_wdata<= 8'b0;
                    r_data_num    <= 8'b0;
                    b_read_flash_id <= 1'b1;
                end
                else
                begin  //Read Manufacturer Device ID (90h)
                    r_cmd_type    <= 4'b1110;    //命令类型
                    r_flash_cmd    <= 8'h90;    //命令砿
                    r_flash_addr<= 24'b0;      //地址
                    r_flash_wdata<= 8'h0;    //数据
                    r_data_num    <= 8'd1;    //数据字节敿                    
                end
            end
            
            if(b_read_flash_id==1'b1 && fifo_rd_data_count>=256)
                flash_state <= EAR_WRITE;
        end
        
        if(flash_state==SECTOR_ERASE) begin
            case(r_cnt)
                'd0:    //Write Enable (06h)
                begin
                    if(r_op_done)
                    begin
                        r_cnt         <= r_cnt + 1'b1;
                        r_cmd_type    <= 4'b0;
                        r_flash_cmd    <= 8'b0;
                        r_flash_addr<= 24'b0;
                        r_flash_wdata<= 8'b0;
                        r_data_num    <= 8'b0;
                    end
                    else
                    begin
                        r_cmd_type    <= 4'b1001;    //命令类型
                        r_flash_cmd    <= 8'h06;    //命令砿
                        r_flash_addr<= flash_sector_addr;  //地址
                        r_flash_wdata<= 8'h0;    //数据
                        r_data_num    <= 8'd0;    //数据字节敿                    
                    end
                end
                'd1:    //Read Status Register-1 (05h)
                begin
                    if(r_op_done && r_flash_rdata[1] == 1'b1)    //轮询WEL位，直到WEL置位
                    begin
                        r_cnt         <= r_cnt + 1'b1;
                        r_cmd_type    <= 4'b0;
                        r_flash_cmd    <= 8'b0;
                        r_flash_addr<= 24'b0;
                        r_flash_wdata<= 8'b0;
                        r_data_num    <= 8'b0;
                    end
                    else
                    begin
                        r_cmd_type    <= 4'b1011;    //命令类型
                        r_flash_cmd    <= 8'h05;    //命令砿
                        r_flash_addr<= flash_sector_addr;  //地址
                        r_flash_wdata<= 8'h0;    //数据
                        r_data_num    <= 8'd0;    //数据字节敿                
                    end
                end
                'd2:    //Sector Erase (d8h)
                begin
                    if(r_op_done)
                    begin
                        r_cnt         <= r_cnt + 1'b1;
                        r_cmd_type    <= 4'b0;
                        r_flash_cmd    <= 8'b0;
                        r_flash_addr<= 24'b0;
                        r_flash_wdata<= 8'b0;
                        r_data_num    <= 8'b0;
                    end
                    else
                    begin
                        r_cmd_type    <= 4'b1100;    //命令类型
                        r_flash_cmd    <= 8'hd8;    //命令砿                        
                        r_flash_addr<= flash_sector_addr;      //地址
                        r_flash_wdata<= 8'h0;    //数据
                        r_data_num    <= 8'd0;    //数据字节敿                    
                    end
                end
                'd3:    //Read Status Register-1 (05h)
                begin
                    if(r_op_done && r_flash_rdata[0] == 1'b0)    //轮询BUSY位，直到BUSY复位
                    begin
                        r_cnt         <= r_cnt + 1'b1;
                        r_cmd_type    <= 4'b0;
                        r_flash_cmd    <= 8'b0;
                        r_flash_addr<= 24'b0;
                        r_flash_wdata<= 8'b0;
                        r_data_num    <= 8'b0;
                    end
                    else
                    begin
                        r_cmd_type    <= 4'b1011;    //命令类型
                        r_flash_cmd    <= 8'h05;    //命令砿
                        r_flash_addr<= flash_sector_addr;  //地址
                        r_flash_wdata<= 8'h0;    //数据
                        r_data_num    <= 8'd0;    //数据字节敿                    
                    end
                end
                'd4:    //Write Disable (04h)
                begin
                    if(r_op_done)
                    begin
                        r_cnt         <= r_cnt + 1'b1;
                        r_cmd_type    <= 4'b0;
                        r_flash_cmd    <= 8'b0;
                        r_flash_addr<= 24'b0;
                        r_flash_wdata<= 8'b0;
                        r_data_num    <= 8'b0;
                    end
                    else
                    begin
                        r_cmd_type    <= 4'b1001;    //命令类型
                        r_flash_cmd    <= 8'h04;    //命令砿
                        r_flash_addr<= flash_sector_addr;  //地址
                        r_flash_wdata<= 8'h0;    //数据
                        r_data_num    <= 8'd0;    //数据字节敿                    
                    end
                end
                'd5:    //Read Status Register-1 (05h)
                begin
                    if(r_flash_done && r_flash_rdata[1] == 1'b0)    //轮询WEL位，直到WEL复位
                    begin
                        r_cnt         <= 0;
                        r_cmd_type    <= 4'b0;
                        r_flash_cmd    <= 8'b0;
                        r_flash_addr<= 24'b0;
                        r_flash_wdata<= 8'b0;
                        r_data_num    <= 8'b0;
                        flash_sector_addr <= flash_sector_addr + 24'h010000;
                        flash_sector_count <= flash_sector_count + 1'b1;
                        flash_state <= PAGE_WRITE;
                    end
                    else
                    begin
                        r_cmd_type    <= 4'b1011;    //命令类型
                        r_flash_cmd    <= 8'h05;    //命令砿
                        r_flash_addr<= flash_sector_addr;  //地址
                        r_flash_wdata<= 8'h0;    //数据
                        r_data_num    <= 8'd0;    //数据字节敿     
                    end
                end
            endcase
        end
        
        if(flash_state==PAGE_WRITE) begin
            case(r_cnt)
                'd0:
                begin
                    if(fifo_rd_data_count>=256) begin
                        r_cnt         <= r_cnt + 1'b1;
                        byte_count <= 9'd1;
                        flash_sector_current_addr <= flash_sector_addr - 24'h010000;
                        flash_page_num_writen <= flash_page_num_writen + 1'b1;
                    end else if( (flash_data_rx_done == 1'b1) &&  (fifo_empty == 1'b1)  )begin
                        flash_state <= WAIT_RESTART;
                    end
                end
                'd1:    //Write Enable (06h)
                begin
                    if(r_op_done)
                    begin
                        r_cnt         <= r_cnt + 1'b1;
                        r_cmd_type    <= 4'b0;
                        r_flash_cmd    <= 8'b0;
                        r_flash_addr<= 24'b0;
                        r_flash_wdata<= 8'b0;
                        r_data_num    <= 8'b0;
                    end
                    else
                    begin
                        r_cmd_type    <= 4'b1001;    //命令类型
                        r_flash_cmd    <= 8'h06;    //命令砿 
                        r_flash_addr<= flash_sector_current_addr + flash_page_addr;  //地址
                        r_flash_wdata<= 8'h0;    //数据
                        r_data_num    <= 8'd0;    //数据字节敿                    
                    end
                end
                'd2:    //Read Status Register-1 (05h)
                begin
                    if(r_flash_done && r_flash_rdata[1] == 1'b1)    //轮询WEL位，直到WEL置位
                    begin
                        r_cnt         <= r_cnt + 1'b1;
                        r_cmd_type    <= 4'b0;
                        r_flash_cmd    <= 8'b0;
                        r_flash_addr<= 24'b0;
                        r_flash_wdata<= 8'b0;
                        r_data_num    <= 8'b0;
                    end
                    else
                    begin
                        r_cmd_type    <= 4'b1011;    //命令类型
                        r_flash_cmd    <= 8'h05;    //命令砿
                        r_flash_addr<= flash_sector_current_addr + flash_page_addr;  //地址
                        r_flash_wdata<= 8'h0;    //数据
                        r_data_num    <= 8'd0;    //数据字节敿                    
                    end
                end
                'd3:    //Page Program (02h)
                begin
                    if(r_op_done)
                    begin
                        r_cnt         <= r_cnt + 1'b1;
                        r_cmd_type    <= 4'b0;
                        r_flash_cmd    <= 8'b0;
                        r_flash_addr<= 24'b0;
                        r_flash_wdata<= 8'b0;
                        r_data_num    <= 8'b0;
                        tx_init_flag <= 1'b1;
                    end
                    else
                    begin
                        if(tx_init_flag==1'b1) begin
                            tx_init_flag <= 1'b0;
                            r_cmd_type    <= 4'b1101;    //命令类型
                            r_flash_cmd    <= 8'h02;    //命令砿
                            r_flash_addr<= flash_sector_current_addr + flash_page_addr;   //地址
                            r_data_num    <= 8'd255;    //数据字节敿 
                        end
                        r_flash_wdata<= fifo_dout;   //数据
                        if(r_wr_byte_over==1'b1 && byte_count<=255) begin
                            byte_count <= byte_count + 1'b1;
                        end
                    end
                end
                'd4:    //Read Status Register-1 (05h)
                begin
                    if(r_flash_done && r_flash_rdata[0] == 1'b0)    //轮询BUSY位，直到BUSY复位
                    begin
                        r_cnt         <= r_cnt + 1'b1;
                        r_cmd_type    <= 4'b0;
                        r_flash_cmd    <= 8'b0;
                        r_flash_addr<= 24'b0;
                        r_flash_wdata<= 8'b0;
                        r_data_num    <= 8'b0;
                    end
                    else
                    begin
                        r_cmd_type    <= 4'b1011;    //命令类型
                        r_flash_cmd    <= 8'h05;    //命令砿 
                        r_flash_addr<= flash_sector_current_addr + flash_page_addr; //地址
                        r_flash_wdata<= 8'h0;    //数据
                        r_data_num    <= 8'd0;    //数据字节敿                    
                    end
                end
                'd5:    //Write Disable (04h)
                begin
                    if(r_op_done)
                    begin
                        r_cnt         <= r_cnt + 1'b1;
                        r_cmd_type    <= 4'b0;
                        r_flash_cmd    <= 8'b0;
                        r_flash_addr<= 24'b0;
                        r_flash_wdata<= 8'b0;
                        r_data_num    <= 8'b0;
                    end
                    else
                    begin
                        r_cmd_type    <= 4'b1001;    //命令类型
                        r_flash_cmd    <= 8'h04;    //命令砿
                        r_flash_addr<= flash_sector_current_addr + flash_page_addr; //地址
                        r_flash_wdata<= 8'h0;    //数据
                        r_data_num    <= 8'd0;    //数据字节敿                    
                    end
                end
                'd6:    //Read Status Register-1 (05h)
                begin
                    if(r_flash_done && r_flash_rdata[1] == 1'b0)    //轮询WEL位，直到WEL复位
                    begin
                        r_cnt         <= 0;
                        r_cmd_type    <= 4'b0;
                        r_flash_cmd    <= 8'b0;
                        r_flash_addr<= 24'b0;
                        r_flash_wdata<= 8'b0;
                        r_data_num    <= 8'b0;
                        flash_page_count <= flash_page_count + 1'b1;
                        flash_page_addr <= flash_page_addr + 24'h000100;
//                        if(flash_page_count==(flash_page_num[7:0]-1) && flash_sector_count==flash_sector_num) begin
//                            if(vio_flash_rd)
//                                flash_state <= PAGE_READ;
//                            else
//                                flash_state <= WAIT_RESTART;
//                        end
//                        else 
                        if( r_flash_addr[23:0] == 24'hffff00 ) begin
                            flash_state <= EAR_WRITE;
                            ear_data    <= ~ear_data;
                            flash_page_count <= 0;
                            flash_page_addr  <= 0;
                        end
                        else if(flash_page_count==8'd255 ) begin//flash_page_count==8'd255 && flash_sector_count<flash_sector_num
                            flash_state <= SECTOR_ERASE;
                            flash_page_count <= 0;
                            flash_page_addr <= 0;
                        end
                        else if(flash_page_count<8'd255)
                            flash_state <= PAGE_WRITE;
                    end
                    else
                    begin
                        r_cmd_type    <= 4'b1011;    //命令类型
                        r_flash_cmd    <= 8'h05;    //命令砿
                        r_flash_addr<= flash_sector_current_addr + flash_page_addr;  //地址
                        r_flash_wdata<= 8'h0;    //数据
                        r_data_num    <= 8'd0;    //数据字节敿                    
                    end
                end
            endcase
        end


        if( flash_state ==EAR_WRITE )begin
            case(r_cnt)
                'd0:    //Write Enable (06h)
                begin
                    if(r_op_done)
                    begin
                        r_cnt         <= r_cnt + 1'b1;
                        r_cmd_type    <= 4'b0;
                        r_flash_cmd    <= 8'b0;
                        r_flash_addr<= 24'b0;
                        r_flash_wdata<= 8'b0;
                        r_data_num    <= 8'b0;
                    end
                    else
                    begin
                        r_cmd_type    <= 4'b1001;    //命令类型
                        r_flash_cmd    <= 8'h06;    //命令砿
                        r_flash_addr<= flash_sector_addr;  //地址
                        r_flash_wdata<= 8'h0;    //数据
                        r_data_num    <= 8'd0;    //数据字节敿                    
                    end
                end
                'd1:    //Read Status Register-1 (05h)
                begin
                    if(r_op_done && r_flash_rdata[1] == 1'b1)    //轮询WEL位，直到WEL置位
                    begin
                        r_cnt         <= r_cnt + 1'b1;
                        r_cmd_type    <= 4'b0;
                        r_flash_cmd    <= 8'b0;
                        r_flash_addr<= 24'b0;
                        r_flash_wdata<= 8'b0;
                        r_data_num    <= 8'b0;
                    end
                    else
                    begin
                        r_cmd_type    <= 4'b1011;    //命令类型
                        r_flash_cmd    <= 8'h05;    //命令砿
                        r_flash_addr<= flash_sector_addr;  //地址
                        r_flash_wdata<= 8'h0;    //数据
                        r_data_num    <= 8'd0;    //数据字节敿                
                    end
                end
                'd2:    //WR EAR (c5h)
                begin
                    if(r_op_done)
                    begin
                        r_cnt         <= r_cnt + 1'b1;
                        r_cmd_type    <= 4'b0;
                        r_flash_cmd    <= 8'b0;
                        r_flash_addr<= 24'b0;
                        r_flash_wdata<= 8'b0;
                        r_data_num    <= 8'b0;
                    end
                    else
                    begin
                        r_cmd_type    <= 4'b1010;    //命令类型
                        r_flash_cmd    <= 8'hc5;    //命令砿                        
                        r_flash_addr<= flash_sector_addr;      //地址
                        r_flash_wdata<= {7'd0,ear_data};    //数据
                        r_data_num    <= 8'd0;    //数据字节敿                    
                    end
                end
                'd3:    //Read Status Register-1 (05h)
                begin
                    if(r_op_done && r_flash_rdata[0] == 1'b0)    //轮询BUSY位，直到BUSY复位
                    begin
                        r_cnt         <= r_cnt + 1'b1;
                        r_cmd_type    <= 4'b0;
                        r_flash_cmd    <= 8'b0;
                        r_flash_addr<= 24'b0;
                        r_flash_wdata<= 8'b0;
                        r_data_num    <= 8'b0;
                    end
                    else
                    begin
                        r_cmd_type    <= 4'b1011;    //命令类型
                        r_flash_cmd    <= 8'h05;    //命令砿
                        r_flash_addr<= flash_sector_addr;  //地址
                        r_flash_wdata<= 8'h0;    //数据
                        r_data_num    <= 8'd0;    //数据字节敿                    
                    end
                end
                'd4:    //Write Disable (04h)
                begin
                    if(r_op_done)
                    begin
                        r_cnt         <= r_cnt + 1'b1;
                        r_cmd_type    <= 4'b0;
                        r_flash_cmd    <= 8'b0;
                        r_flash_addr<= 24'b0;
                        r_flash_wdata<= 8'b0;
                        r_data_num    <= 8'b0;
                    end
                    else
                    begin
                        r_cmd_type    <= 4'b1001;    //命令类型
                        r_flash_cmd    <= 8'h04;    //命令砿
                        r_flash_addr<= flash_sector_addr;  //地址
                        r_flash_wdata<= 8'h0;    //数据
                        r_data_num    <= 8'd0;    //数据字节敿                    
                    end
                end
                'd5:    //Read Status Register-1 (05h)
                begin
                    if(r_flash_done && r_flash_rdata[1] == 1'b0)    //轮询WEL位，直到WEL复位
                    begin
                        r_cnt         <= 0;
                        r_cmd_type    <= 4'b0;
                        r_flash_cmd    <= 8'b0;
                        r_flash_addr<= 24'b0;
                        r_flash_wdata<= 8'b0;
                        r_data_num    <= 8'b0;
                        flash_state <= SECTOR_ERASE;
                    end
                    else
                    begin
                        r_cmd_type    <= 4'b1011;    //命令类型
                        r_flash_cmd    <= 8'h05;    //命令砿
                        r_flash_addr<= flash_sector_addr;  //地址
                        r_flash_wdata<= 8'h0;    //数据
                        r_data_num    <= 8'd0;    //数据字节敿     
                    end
                end
            endcase
        end

//        if(flash_state==PAGE_READ) begin
//            vio_flash_rd_d1 <= vio_flash_rd;
//            if(vio_flash_rd_d1==1'b0 && vio_flash_rd==1'b1)
//                flash_rd_flag <= 1'b1;
//            if(flash_rd_flag) begin
//                if(r_op_done)
//                begin
//                    flash_rd_flag <= 1'b0;
//                    r_cnt         <= r_cnt + 1'b1;
//                    r_cmd_type    <= 4'b0;
//                    r_flash_cmd    <= 8'b0;
//                    r_flash_addr<= r_flash_addr + 24'h000100;
//                    r_flash_wdata<= 8'b0;
//                    r_data_num    <= 8'b0;
//                end
//                else
//                begin
//                    r_cmd_type    <= 4'b1110;    //命令类型
//                    r_flash_cmd    <= 8'h03;    //命令砿 
//                    r_flash_wdata<= 8'h0;    //数据
//                    r_data_num    <= 8'd255;    //数据字节敿                    
//                end
//            end
//        end
        
        if(flash_state==WAIT_RESTART) begin
            if( wait_restart_time == 4'd10   )begin
                wait_restart_time <= 4'd0;
                flash_state       <= IDLE;
            end else begin
                wait_restart_time <= wait_restart_time + 4'd1;
            end
        end
        
    end
end

assign flash_load_state_end = (flash_state==WAIT_RESTART);
    
flash_dri flash_dri_inst
(
    .i_rst_n        (~reset         ),
    .i_clk          (r_clk_25MHz    ),
    
    .i_cmd_type      (r_cmd_type        ),
    .i_flash_cmd     (r_flash_cmd    ),
    .i_falsh_addr    (r_flash_addr    ),
    .i_flash_data    (r_flash_wdata    ),
    .o_wr_byte_over  (r_wr_byte_over),
    .i_data_num      (r_data_num        ),
    
    .o_op_done       (r_op_done        ),
    
    .o_flash_done    (r_flash_done    ),
    .o_flash_data    (r_flash_rdata    ),
    
    .o_flash_cs        (o_flash_cs        ),
    .o_flash_clk    (o_flash_clk    ),
    .o_flash_din    (o_flash_din    ),
    .i_flash_dout    (i_flash_dout    )
);

assign icape2_start = flash_state==WAIT_RESTART;

//ICAP2_TEST u_ICAP2_TEST(
//     .FPGA_CLK      ( clk  ),       // 100MHz
//     .icape2_start  ( icape2_start  )
//    );



///////////////////////////////////
//vio_1 viot (
//  .clk(r_clk_25MHz),                // input wire clk
//  .probe_out0(vio_flash_rd)  // output wire [0 : 0] probe_out0
//);

//ila_flash ila_flash_1 (
//	//.clk(i_clk), // input wire clk
//	.clk(r_clk_50MHz),
//	.probe0({flash_load_state_end,flash_data_rx_done,load_device_select,b_read_flash_id,r_cnt,r_cmd_type,r_flash_cmd,r_flash_wdata,r_op_done,r_flash_done,r_flash_rdata,
//	r_wr_byte_over, o_flash_cs,o_flash_clk,o_flash_din,i_flash_dout,fifo_rd_en,fifo_dout,byte_count,
//	flash_state,fifo_rd_data_count,flash_page_num_writen,flash_page_count,flash_sector_count,
//	flash_page_num,flash_sector_num}) // input wire [159:0] probe0
//);


endmodule