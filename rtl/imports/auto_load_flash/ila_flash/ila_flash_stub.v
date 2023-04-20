// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Thu Dec 15 13:15:32 2022
// Host        : KLSHGDJS422 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top ila_flash -prefix
//               ila_flash_ ila_flash_stub.v
// Design      : ila_flash
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcsg325-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2017.4" *)
module ila_flash(clk, probe0)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[159:0]" */;
  input clk;
  input [159:0]probe0;
endmodule
