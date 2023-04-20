// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Wed Jul 25 16:47:41 2018
// Host        : lenovo-PC running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               E:/fpga/kl_mwl/fos_a7_12_ch/fos_a7_optic_fpga.srcs/sources_1/ip/ila_uart/ila_uart_stub.v
// Design      : ila_uart
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a15tcsg325-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2017.4" *)
module ila_uart(clk, probe0, probe1, probe2, probe3)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[4:0],probe1[7:0],probe2[7:0],probe3[1:0]" */;
  input clk;
  input [4:0]probe0;
  input [7:0]probe1;
  input [7:0]probe2;
  input [1:0]probe3;
endmodule
