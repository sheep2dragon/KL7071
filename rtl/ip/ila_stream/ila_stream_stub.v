// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.1 (win64) Build 1538259 Fri Apr  8 15:45:27 MDT 2016
// Date        : Tue May 15 16:15:53 2018
// Host        : WIN-FPGA01 running 64-bit major release  (build 7600)
// Command     : write_verilog -force -mode synth_stub
//               E:/projects/PT17052_KL7071_V2/new_fifo/7071_original/fos_a7_optic_fpga/fos_a7_optic_fpga.srcs/sources_1/ip/ila_stream/ila_stream_stub.v
// Design      : ila_stream
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a15tcsg325-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2016.1" *)
module ila_stream(clk, probe0, probe1, probe2, probe3, probe4, probe5, probe6, probe7, probe8, probe9)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[31:0],probe1[15:0],probe2[0:0],probe3[31:0],probe4[0:0],probe5[0:0],probe6[0:0],probe7[31:0],probe8[19:0],probe9[7:0]" */;
  input clk;
  input [31:0]probe0;
  input [15:0]probe1;
  input [0:0]probe2;
  input [31:0]probe3;
  input [0:0]probe4;
  input [0:0]probe5;
  input [0:0]probe6;
  input [31:0]probe7;
  input [19:0]probe8;
  input [7:0]probe9;
endmodule
