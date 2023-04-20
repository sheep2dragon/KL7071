`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/11 13:20:28
// Design Name: 
// Module Name: flash_dri
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


module flash_dri
(
    input    i_rst_n    ,
    input    i_clk    ,    //25MHz
    
    input    [ 3:0]    i_cmd_type    ,
    input    [ 7:0]    i_flash_cmd    ,
    input    [23:0]    i_falsh_addr,
    input    [ 7:0]    i_flash_data,
    output   reg      o_wr_byte_over,
    input    [ 7:0]    i_data_num    ,
    
    output            o_op_done    ,
    
    output            o_flash_done,
    output    [ 7:0]    o_flash_data,
    
    output    o_flash_cs    ,
    output    o_flash_clk    ,
    output    o_flash_din    ,
    input    i_flash_dout
);

parameter    FLASH_IDLE        =    0    ;
parameter    FLASH_SEND_CMD    =    1    ;
parameter    FLASH_SEND_ADDR    =    2    ;
parameter    FLASH_WR_DATA    =    3    ;
parameter    FLASH_RD_DATA    =    4    ;
parameter    FLASH_END        =    5    ;

reg    [2:0]    flash_cstate    ;
reg    [2:0]    flash_nstate    ;

reg    [2:0]    r_cmd_cnt    ;
reg    [4:0]    r_addr_cnt    ;
reg    [2:0]    r_data_cnt    ;

reg            r_op_done    ;
reg            r_flash_done;
reg    [7:0]    r_flash_data;
        
reg            r_flash_cs    ;
reg            r_flash_din    ;

reg    [7:0]    r_wr_num    ;
reg    [7:0]    r_rd_num    ;

reg            r_busy        ;


reg            r_rd_valid    ;
reg    [2:0]    r_rd_cnt    ;
reg            r_wr_valid    ;
reg    [2:0]    r_wr_cnt    ;

assign    o_op_done    =    r_op_done    ;

assign    o_flash_done=    r_flash_done;
assign    o_flash_data=    r_flash_data;

assign    o_flash_cs    =    r_flash_cs    ;
assign    o_flash_clk    =    r_busy? i_clk:1'b0    ;
assign    o_flash_din    =    r_flash_din    ;

always @(negedge i_clk or negedge i_rst_n)
begin
    if(!i_rst_n)
        flash_cstate    <= FLASH_IDLE    ;
    else
        flash_cstate    <= flash_nstate    ;
end

always @(*)
begin
    case(flash_cstate)
        FLASH_IDLE:
        begin
            if(i_cmd_type[3])
                flash_nstate    <= FLASH_SEND_CMD    ;
            else
                flash_nstate    <= FLASH_IDLE        ;
        end
        FLASH_SEND_CMD:
        begin
            if(r_cmd_cnt == 'd7)
            begin
                if(i_cmd_type[2:0] == 3'b001)    //命令后不带地坿?数据
                    flash_nstate    <= FLASH_END        ;
                else if(i_cmd_type[2:0] == 3'b010)    //命令后带写数据，无地坿
                    flash_nstate    <= FLASH_WR_DATA    ;
                else if(i_cmd_type[2:0] == 3'b011)    //命令后带读数据，无地坿
                    flash_nstate    <= FLASH_RD_DATA    ;
                else if(i_cmd_type[2] == 1'b1)    //命令后带地址
                    flash_nstate    <= FLASH_SEND_ADDR    ;
                else
                    flash_nstate    <= FLASH_IDLE        ;
            end
            else
            begin
                flash_nstate    <= FLASH_SEND_CMD    ;
            end
        end
        FLASH_SEND_ADDR:
        begin
            if(r_addr_cnt == 'd23)
            begin
                if(i_cmd_type[1:0] == 2'b00)    //不带数据
                    flash_nstate    <= FLASH_END    ;
                else if(i_cmd_type[1:0] == 2'b01)    //写数捿
                    flash_nstate    <= FLASH_WR_DATA;
                else if(i_cmd_type[1:0] == 2'b10)    //读数捿
                    flash_nstate    <= FLASH_RD_DATA;
                else
                    flash_nstate    <= FLASH_IDLE    ;
            end
            else
                flash_nstate    <= FLASH_SEND_ADDR    ;
        end
        FLASH_WR_DATA:
        begin
            if(r_data_cnt == 'd7 && r_wr_num == 'd0)
                flash_nstate    <= FLASH_END    ;
            else
                flash_nstate    <= FLASH_WR_DATA;
        end
        FLASH_RD_DATA:
        begin
            if(r_data_cnt == 'd7 && r_rd_num == 'd0)
                flash_nstate    <= FLASH_END    ;
            else
                flash_nstate    <= FLASH_RD_DATA;
        end
        FLASH_END:
        begin
            flash_nstate    <= FLASH_IDLE    ;
        end
        default:
        begin
            flash_nstate    <= FLASH_IDLE    ;
        end
    endcase
end

always @(negedge i_clk or negedge i_rst_n)
begin
    if(!i_rst_n)
        r_rd_num    <= 'd0;
    else if(r_rd_cnt == 'd7)
    begin
        if(r_rd_num == 'd0)
            r_rd_num    <= 'd0;
        else
            r_rd_num    <= r_rd_num - 1'b1;
    end
    else if(flash_cstate == FLASH_SEND_CMD && i_cmd_type[3:0] == 4'b1110)
        r_rd_num    <= i_data_num    ;
end

always @(negedge i_clk or negedge i_rst_n)
begin
    if(!i_rst_n)
        r_wr_num    <= 'd0;
    else if(r_wr_cnt == 'd7)
    begin
        if(r_wr_num == 'd0)
            r_wr_num    <= 'd0;
        else
            r_wr_num    <= r_wr_num - 1'b1;
    end
    else if(flash_cstate == FLASH_SEND_CMD && ((i_cmd_type[3:0] == 4'b1101)||(i_cmd_type[3:0] == 4'b1010)))
        r_wr_num    <= i_data_num    ;
end

always @(negedge i_clk or negedge i_rst_n)
begin
    if(!i_rst_n)
        r_op_done<= 1'b0    ;
    else if(flash_cstate == FLASH_IDLE)
        r_op_done<= 1'b0    ;
    else if(flash_cstate == FLASH_END)
        r_op_done<= 1'b1    ;
end

always @(negedge i_clk or negedge i_rst_n)
begin
    if(!i_rst_n)
        r_cmd_cnt    <= 'd0    ;
    else if(flash_cstate == FLASH_SEND_CMD)
    begin
        if(r_cmd_cnt == 'd7)
            r_cmd_cnt    <= 'd0    ;
        else
            r_cmd_cnt    <= r_cmd_cnt + 1'b1;
    end
    else
        r_cmd_cnt    <= 'd0    ;
end

always @(negedge i_clk or negedge i_rst_n)
begin
    if(!i_rst_n)
        r_addr_cnt    <= 'd0    ;
    else if(flash_cstate == FLASH_SEND_ADDR)
    begin
        if(r_addr_cnt == 'd23)
            r_addr_cnt    <= 'd0    ;
        else
            r_addr_cnt    <= r_addr_cnt + 1'b1;
    end
    else
        r_addr_cnt    <= 'd0    ;
end

always @(negedge i_clk or negedge i_rst_n)
begin
    if(!i_rst_n)
        r_data_cnt    <= 'd0    ;
    else if(flash_cstate == FLASH_RD_DATA || flash_cstate == FLASH_WR_DATA)
    begin
        if(r_data_cnt == 'd7)
            r_data_cnt    <= 'd0    ;
        else
            r_data_cnt    <= r_data_cnt + 1'b1;
    end
    else
        r_data_cnt    <= 'd0    ;
end

always @(negedge i_clk or negedge i_rst_n)
begin
    if(!i_rst_n)
        o_wr_byte_over    <= 1'b0    ;
    else if(flash_cstate == FLASH_WR_DATA)
    begin
        if(r_data_cnt == 'd6)
            o_wr_byte_over    <= 1'b1    ;
        else
            o_wr_byte_over    <= 1'b0    ;
    end
    else
        o_wr_byte_over    <= 1'b0    ;
end

always @(negedge i_clk or negedge i_rst_n)
begin
    if(!i_rst_n)
        r_flash_din    <= 1'b1    ;
    else if(flash_cstate == FLASH_SEND_CMD)
        r_flash_din    <= i_flash_cmd[7 - r_cmd_cnt];
    else if(flash_cstate == FLASH_SEND_ADDR)
        r_flash_din    <= i_falsh_addr[23 - r_addr_cnt];
    else if(flash_cstate == FLASH_WR_DATA)
        r_flash_din    <= i_flash_data[7 - r_data_cnt];
    else
        r_flash_din    <= 1'b1    ;
end

always @(posedge i_clk or negedge i_rst_n)
begin
    if(!i_rst_n)
        r_flash_data    <= 'd255    ;
    else if(r_rd_valid)
        r_flash_data[7 - r_rd_cnt]    <= i_flash_dout;
    else if(flash_cstate == FLASH_IDLE)
        r_flash_data    <= 'd255    ;
end

always @(negedge i_clk or negedge i_rst_n)
begin
    if(!i_rst_n)
        r_wr_valid    <= 1'b0    ;
    else if(flash_cstate == FLASH_WR_DATA)
        r_wr_valid    <= 1'b1;
    else
        r_wr_valid    <= 1'b0;
end

always @(negedge i_clk or negedge i_rst_n)
begin
    if(!i_rst_n)
        r_wr_cnt    <= 'd0    ;
    else if(flash_cstate == FLASH_WR_DATA && r_wr_valid)
        r_wr_cnt    <= r_wr_cnt + 1'b1;
    else
        r_wr_cnt    <= 'd0    ;
end

always @(negedge i_clk or negedge i_rst_n)
begin
    if(!i_rst_n)
        r_rd_valid    <= 1'b0    ;
    else if(flash_cstate == FLASH_RD_DATA)
        r_rd_valid    <= 1'b1;
    else
        r_rd_valid    <= 1'b0;
end

always @(negedge i_clk or negedge i_rst_n)
begin
    if(!i_rst_n)
        r_rd_cnt    <= 'd0    ;
    else if(flash_cstate == FLASH_RD_DATA && r_rd_valid)
        r_rd_cnt    <= r_rd_cnt + 1'b1;
    else
        r_rd_cnt    <= 'd0    ;
end

always @(negedge i_clk or negedge i_rst_n)
begin
    if(!i_rst_n)
        r_flash_done    <= 1'b0    ;
    else if(r_rd_cnt == 'd7)
        r_flash_done    <= 1'b1    ;
    else
        r_flash_done    <= 1'b0    ;
end

always @(negedge i_clk or negedge i_rst_n)
begin
    if(!i_rst_n)
        r_flash_cs    <= 1'b1    ;
    //else if(flash_cstate == FLASH_IDLE && i_cmd_type[3] == 1'b1)
    //    r_flash_cs    <= 1'b0    ;
    else if(flash_cstate == FLASH_END)
        r_flash_cs    <= 1'b1    ;
    else if(flash_cstate == FLASH_SEND_CMD)
        r_flash_cs    <= 1'b0    ;
end

reg    [8:0]    r_num_cnt    ;

always @(negedge i_clk or negedge i_rst_n)
begin
    if(!i_rst_n)
        r_num_cnt    <= 'b0    ;
    else if(r_flash_done)
        r_num_cnt    <= r_num_cnt + 1'b1    ;
    else if(flash_cstate == FLASH_IDLE)
        r_num_cnt    <= 'b0    ;
end

always @(negedge i_clk or negedge i_rst_n)
begin
    if(!i_rst_n)
        r_busy    <= 1'b0    ;
    else if(flash_cstate == FLASH_END)
        r_busy    <= 1'b0    ;
    else if(flash_cstate == FLASH_SEND_CMD)
        r_busy    <= 1'b1    ;
end

endmodule
