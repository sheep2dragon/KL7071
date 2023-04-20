// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.1 (win64) Build 1538259 Fri Apr  8 15:45:27 MDT 2016
// Date        : Sat Apr 28 13:27:22 2018
// Host        : WIN-FPGA01 running 64-bit major release  (build 7600)
// Command     : write_verilog -force -mode synth_stub
//               e:/projects/PT17052_KL7071_V2/k7_a7_original/0428/a7_optic_tx/fos_a7_optic_fpga.srcs/sources_1/ip/vio_sel/vio_sel_stub.v
// Design      : vio_sel
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a15tcsg325-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "vio,Vivado 2016.1" *)
module vio_sel(clk, probe_out0)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_out0[3:0]" */;
  input clk;
  output [3:0]probe_out0;
endmodule
