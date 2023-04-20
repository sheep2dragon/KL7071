-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
-- Date        : Sat Feb 25 14:27:55 2023
-- Host        : KLSHGDJS422 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               E:/nanwang_kl7071_xuji/KL7071_20230223/fos_a7_optic_fpga_100M_no/prj/fos_a7_optic_fpga/fos_a7_optic_fpga.srcs/sources_1/ip/ila_fault_debug/ila_fault_debug_stub.vhdl
-- Design      : ila_fault_debug
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a15tcsg325-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ila_fault_debug is
  Port ( 
    clk : in STD_LOGIC;
    probe0 : in STD_LOGIC_VECTOR ( 189 downto 0 )
  );

end ila_fault_debug;

architecture stub of ila_fault_debug is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe0[189:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "ila,Vivado 2017.4";
begin
end;
