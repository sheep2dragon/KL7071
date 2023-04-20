//-----------------------------------------------------------------------------
// Copyright (C) 2009 OutputLogic.com 
// This source file may be used and distributed without restriction 
// provided that this copyright statement is not removed from the file 
// and that any derivative work contains the original copyright notice 
// and the associated disclaimer. 
// 
// THIS SOURCE FILE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS 
// OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED	
// WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE. 
//-----------------------------------------------------------------------------
// CRC module for data[7:0] ,   crc[15:0]=1+x^5+x^12+x^16;
//-----------------------------------------------------------------------------
//6 clk, result out

`define		CRC_IDLE			2'b00
`define		CRC_START			2'b01
`define		CRC_OK				2'b10

module crc_tx(
    input 					clk,
    input 					sclr,
    input 	   [7:0] 		data_in,
    input 					crc_en,
    output reg [15:0] 		data_out,
    output reg 				data_ok
  );

//-------------------------signal definition--------------------------------
//-------------------------signal definition--------------------------------
reg 	[1:0]				state;
reg 	[2:0]				cnt;
reg 	[15:0]				data_reg;
reg 	[7:0]				data_in_reg;

//-------------------------ipcore & module----------------------------------
//-------------------------ipcore & module----------------------------------
//crc state
always @(posedge clk)
begin
	if (sclr==1'b1)
		state <= `CRC_IDLE;
 	else if (state==`CRC_IDLE && crc_en==1'b1)
 		state <= `CRC_START;
 	else if (state==`CRC_START && cnt[2:0]>=3'd5)
 		state <= `CRC_OK;
 	else if (state==`CRC_OK)
		state <= `CRC_IDLE;
	else ;
end

always @(posedge clk)
begin
	if (sclr==1'b1)
		data_in_reg[7:0] <= 8'd0;
 	else if (state==`CRC_IDLE && crc_en==1'b1)
		data_in_reg[7:0] <= data_in[7:0];
	else ;
end

always @(posedge clk)
begin
	if (sclr==1'b1)
		cnt[2:0] <= 3'd0;
 	else if (state==`CRC_IDLE && crc_en==1'b1)
		cnt[2:0] <= 3'd1;
	else if (state==`CRC_START && cnt[2:0]>=3'd6)
		cnt[2:0] <= 3'd0;
	else if (state==`CRC_START && cnt[2:0]>3'd0)
		cnt[2:0] <= cnt[2:0] + 3'd1;
	else ;
end

always @(posedge clk)
begin
	if (sclr==1'b1)
		{data_ok, data_out[15:0]} <= {1'b0, 16'hFFFF};
 	else if (state==`CRC_OK)
		{data_ok, data_out[15:0]} <= {1'b1, data_reg[15:0]};
	else
		{data_ok, data_out[15:0]} <= {1'b0, data_out[15:0]};
end

always @(posedge clk)
begin
	if (sclr==1'b1)
		data_reg[15:0] <= 16'd0;
	else if (state==`CRC_START)
		begin
			case (cnt[2:0])
				3'd1:
					begin
						data_reg[0]  <= data_out[8] 	^ data_out[12];
						data_reg[1]  <= data_out[9] 	^ data_out[13];
						data_reg[2]  <= data_out[10] 	^ data_out[14];
						data_reg[3]  <= data_out[11] 	^ data_out[15];
						data_reg[4]  <= data_out[12] 	^ data_in_reg[4];
						data_reg[5]  <= data_out[8] 	^ data_out[12];
						data_reg[6]  <= data_out[9] 	^ data_out[13];
						data_reg[7]  <= data_out[10] 	^ data_out[14];
						data_reg[8]  <= data_out[0] 	^ data_out[11];
						data_reg[9]  <= data_out[1] 	^ data_out[12];
						data_reg[10] <= data_out[2] 	^ data_out[13];
						data_reg[11] <= data_out[3] 	^ data_out[14];
						data_reg[12] <= data_out[4] 	^ data_out[8];
						data_reg[13] <= data_out[5] 	^ data_out[9];
						data_reg[14] <= data_out[6] 	^ data_out[10];
						data_reg[15] <= data_out[7] 	^ data_out[11];
					end
				3'd2:
					begin
						data_reg[0]  <= data_reg[0]  	^ data_in_reg[0];
						data_reg[1]  <= data_reg[1]  	^ data_in_reg[1];
						data_reg[2]  <= data_reg[2]  	^ data_in_reg[2];
						data_reg[3]  <= data_reg[3]  	^ data_in_reg[3];
						data_reg[4]  <= data_reg[4];
						data_reg[5]  <= data_reg[5]  	^ data_out[13];
						data_reg[6]  <= data_reg[6]  	^ data_out[14];
						data_reg[7]  <= data_reg[7]  	^ data_out[15];
						data_reg[8]  <= data_reg[8]  	^ data_out[15];
						data_reg[9]  <= data_reg[9]  	^ data_in_reg[4];
						data_reg[10] <= data_reg[10] 	^ data_in_reg[5];
						data_reg[11] <= data_reg[11] 	^ data_in_reg[6];
						data_reg[12] <= data_reg[12] 	^ data_out[12];
						data_reg[13] <= data_reg[13] 	^ data_out[13];
						data_reg[14] <= data_reg[14] 	^ data_out[14];
						data_reg[15] <= data_reg[15] 	^ data_out[15];
					end
				3'd3:
					begin
						data_reg[0]  <= data_reg[0] 	^ data_in_reg[4];
						data_reg[1]  <= data_reg[1] 	^ data_in_reg[5];
						data_reg[2]  <= data_reg[2] 	^ data_in_reg[6];
						data_reg[3]  <= data_reg[3] 	^ data_in_reg[7];
						data_reg[4]  <= data_reg[4];
						data_reg[5]  <= data_reg[5] 	^ data_in_reg[0];
						data_reg[6]  <= data_reg[6] 	^ data_in_reg[1];
						data_reg[7]  <= data_reg[7] 	^ data_in_reg[2];
						data_reg[8]  <= data_reg[8] 	^ data_in_reg[3];
						data_reg[9]  <= data_reg[9];
						data_reg[10] <= data_reg[10];
						data_reg[11] <= data_reg[11];
						data_reg[12] <= data_reg[12] 	^ data_out[15];
						data_reg[13] <= data_reg[13] 	^ data_in_reg[1];
						data_reg[14] <= data_reg[14] 	^ data_in_reg[2];
						data_reg[15] <= data_reg[15] 	^ data_in_reg[3];
					end
				3'd4:
					begin
						data_reg[0]  <= data_reg[0];
						data_reg[1]  <= data_reg[1];
						data_reg[2]  <= data_reg[2];
						data_reg[3]  <= data_reg[3];
						data_reg[4]  <= data_reg[4];
						data_reg[5]  <= data_reg[5] 	^ data_in_reg[4];
						data_reg[6]  <= data_reg[6] 	^ data_in_reg[5];
						data_reg[7]  <= data_reg[7] 	^ data_in_reg[6];
						data_reg[8]  <= data_reg[8] 	^ data_in_reg[7];
						data_reg[9]  <= data_reg[9];
						data_reg[10] <= data_reg[10];
						data_reg[11] <= data_reg[11];
						data_reg[12] <= data_reg[12] 	^ data_in_reg[0];
						data_reg[13] <= data_reg[13] 	^ data_in_reg[5];
						data_reg[14] <= data_reg[14] 	^ data_in_reg[6];
						data_reg[15] <= data_reg[15] 	^ data_in_reg[7];
					end
				3'd5:
					begin
						data_reg[0]  <= data_reg[0];
						data_reg[1]  <= data_reg[1];
						data_reg[2]  <= data_reg[2];
						data_reg[3]  <= data_reg[3];
						data_reg[4]  <= data_reg[4];
						data_reg[5]  <= data_reg[5] 	^ data_in_reg[5];
						data_reg[6]  <= data_reg[6] 	^ data_in_reg[6];
						data_reg[7]  <= data_reg[7] 	^ data_in_reg[7];
						data_reg[8]  <= data_reg[8];
						data_reg[9]  <= data_reg[9];
						data_reg[10] <= data_reg[10];
						data_reg[11] <= data_reg[11];
						data_reg[12] <= data_reg[12] 	^ data_in_reg[4] ^ data_in_reg[7];
						data_reg[13] <= data_reg[13];
						data_reg[14] <= data_reg[14];
						data_reg[15] <= data_reg[15];
					end
				default : ;
			endcase
		end
	else ;
end

endmodule
