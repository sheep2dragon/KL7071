-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.1 (win64) Build 1538259 Fri Apr  8 15:45:27 MDT 2016
-- Date        : Wed Apr 18 14:31:19 2018
-- Host        : WIN-FPGA01 running 64-bit major release  (build 7600)
-- Command     : write_vhdl -force -mode synth_stub
--               e:/projects/PT17052_KL7071_V2/k7_a7_original/080417_ila/fos_a7_optic_fpga/fos_a7_optic_fpga.srcs/sources_1/ip/ila_optic_tx/ila_optic_tx_stub.vhdl
-- Design      : ila_optic_tx
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a15tcsg325-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ila_optic_tx is
  Port ( 
    clk : in STD_LOGIC;
    probe0 : in STD_LOGIC_VECTOR ( 13 downto 0 )
  );

end ila_optic_tx;

architecture stub of ila_optic_tx is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe0[13:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "ila,Vivado 2016.1";
begin
end;
