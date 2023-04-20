////////////////////////////////////////////////////////
// UART RX and TX module

// The UART settings are fixed
// TX: 8-bit data, 1 stop, no-parity
// RX: 8-bit data, 1 stop, no-parity



////////////////////////////////////////////////////////
module async_transmitter_230400(
	input clk,
	input TxD_start,
	input [7:0] TxD_data,
	output TxD,
	output TxD_busy
);

// Assert TxD_start for (at least) one clock cycle to start transmission of TxD_data
// TxD_data is latched so that it doesn't have to stay valid while it is being sent

reg [3:0] TxD_state = 0;
wire TxD_ready = (TxD_state==0);
reg [7:0] TxD_shift = 0;
reg BitTick;
reg [15:0] oversampling_count = 0;
reg start_flag = 0;

always @(posedge clk) begin
    if(TxD_start) begin
        start_flag <= 1'b1;
        oversampling_count <= 'd0;
        BitTick <= 1'b0;
    end
    if(start_flag) begin
//        if(oversampling_count==5'd9) begin
//            oversampling_count <= 5'd0;
//            BitTick <= 1'b1;
//        end
//        else begin
//            oversampling_count <= oversampling_count + 1'b1;
//            BitTick <= 1'b0;
//        end
        if(oversampling_count + 36 >=  15625) begin       //230400: 230400*15625/36=100e6
            oversampling_count <= oversampling_count + 36 - 15625;
            BitTick <= 1'b1;
        end 
        else begin
            oversampling_count <= oversampling_count + 36;
            BitTick <= 1'b0;
        end
        if(TxD_state==4'b0001) begin
            start_flag <= 1'b0;
            oversampling_count <= 'd0;
            BitTick <= 1'b0;
        end
    end
end

assign TxD_busy = ~TxD_ready | TxD_start;

always @(posedge clk)
begin
	if(TxD_ready & TxD_start)
		TxD_shift <= TxD_data;
	else
	if(TxD_state[3] && BitTick)
		TxD_shift <= (TxD_shift >> 1);

	case(TxD_state)
		4'b0000: if(TxD_start) TxD_state <= 4'b0100;
		4'b0100: if(BitTick) TxD_state <= 4'b1000;  // start bit
		4'b1000: if(BitTick) TxD_state <= 4'b1001;  // bit 0
		4'b1001: if(BitTick) TxD_state <= 4'b1010;  // bit 1
		4'b1010: if(BitTick) TxD_state <= 4'b1011;  // bit 2
		4'b1011: if(BitTick) TxD_state <= 4'b1100;  // bit 3
		4'b1100: if(BitTick) TxD_state <= 4'b1101;  // bit 4
		4'b1101: if(BitTick) TxD_state <= 4'b1110;  // bit 5
		4'b1110: if(BitTick) TxD_state <= 4'b1111;  // bit 6
		4'b1111: if(BitTick) TxD_state <= 4'b0011;  // bit 7
		4'b0011: if(BitTick) TxD_state <= 4'b0001;  // stop
		default: TxD_state <= 4'b0000;
	endcase
end

assign TxD = (TxD_state<4) | (TxD_state[3] & TxD_shift[0]);  // put together the start, data and stop bits

endmodule


////////////////////////////////////////////////////////
module async_receiver_230400(
	input clk,
	input RxD,
	output reg RxD_data_ready = 0,
	output reg [7:0] RxD_data = 0  // data received, valid only (for one clock cycle) when RxD_data_ready is asserted
);

////////////////////////////////
reg [3:0] RxD_state = 0;
reg [1:0] RxD_sync = 2'b11;
reg [9:0] Filter_cnt = 200;
reg RxD_bit = 1'b1;
reg [15:0] OversamplingCount = 0;
wire sampleNow;

// synchronize RxD to our clk domain
always @(posedge clk) begin
    RxD_sync <= {RxD_sync[0], RxD};
end 

// and filter it
always @(posedge clk)
begin
	if(RxD_sync[1]==1'b1 && Filter_cnt!=200) 
	    Filter_cnt <= Filter_cnt + 1'd1;
	else if(RxD_sync[1]==1'b0 && Filter_cnt!=0) 
	    Filter_cnt <= Filter_cnt - 1'd1;
	if(Filter_cnt==200) 
	    RxD_bit <= 1'b1;
	else if(Filter_cnt==0) 
	    RxD_bit <= 1'b0;
end

// and decide when is the good time to sample the RxD line
always @(posedge clk) begin
    if(RxD_state!=0) begin
        if(OversamplingCount + 36 >=  15625) begin       //230400: 230400*15625/36=100e6
            OversamplingCount <= OversamplingCount + 36 - 15625;
        end 
        else begin
            OversamplingCount <= OversamplingCount + 36;
        end
    end
    else begin
        OversamplingCount <= 0;
    end
end
assign sampleNow = (OversamplingCount>=7794 && OversamplingCount<7830);

// now we can accumulate the RxD bits in a shift-register
always @(posedge clk)
case(RxD_state)
	4'b0000: if(~RxD_bit)  RxD_state <= 4'b0001;  // start bit found?
	4'b0001: if(sampleNow) RxD_state <= 4'b1000;  // sync start bit to sampleNow
	4'b1000: if(sampleNow) RxD_state <= 4'b1001;  // bit 0
	4'b1001: if(sampleNow) RxD_state <= 4'b1010;  // bit 1
	4'b1010: if(sampleNow) RxD_state <= 4'b1011;  // bit 2
	4'b1011: if(sampleNow) RxD_state <= 4'b1100;  // bit 3
	4'b1100: if(sampleNow) RxD_state <= 4'b1101;  // bit 4
	4'b1101: if(sampleNow) RxD_state <= 4'b1110;  // bit 5
	4'b1110: if(sampleNow) RxD_state <= 4'b1111;  // bit 6
	4'b1111: if(sampleNow) RxD_state <= 4'b0010;  // bit 7
	4'b0010: if(sampleNow) RxD_state <= 4'b0000;  // stop bit
	default: RxD_state <= 4'b0000;
endcase

always @(posedge clk) begin
    if(sampleNow && RxD_state[3]) 
        RxD_data <= {RxD_bit, RxD_data[7:1]};
end

//reg RxD_data_error = 0;
always @(posedge clk)
begin
	RxD_data_ready <= (sampleNow && RxD_state==4'b0010 && RxD_bit);  // make sure a stop bit is received
end




endmodule


