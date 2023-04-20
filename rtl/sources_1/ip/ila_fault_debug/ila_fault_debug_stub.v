// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Sat Feb 25 14:27:55 2023
// Host        : KLSHGDJS422 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               E:/nanwang_kl7071_xuji/KL7071_20230223/fos_a7_optic_fpga_100M_no/prj/fos_a7_optic_fpga/fos_a7_optic_fpga.srcs/sources_1/ip/ila_fault_debug/ila_fault_debug_stub.v
// Design      : ila_fault_debug
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a15tcsg325-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2017.4" *)
module ila_fault_debug(clk, probe0)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[189:0]" */;
  input clk;
  input [189:0]probe0;
endmodule
