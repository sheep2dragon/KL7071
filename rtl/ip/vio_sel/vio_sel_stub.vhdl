-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.1 (win64) Build 1538259 Fri Apr  8 15:45:27 MDT 2016
-- Date        : Sat Apr 28 13:27:22 2018
-- Host        : WIN-FPGA01 running 64-bit major release  (build 7600)
-- Command     : write_vhdl -force -mode synth_stub
--               e:/projects/PT17052_KL7071_V2/k7_a7_original/0428/a7_optic_tx/fos_a7_optic_fpga.srcs/sources_1/ip/vio_sel/vio_sel_stub.vhdl
-- Design      : vio_sel
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a15tcsg325-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vio_sel is
  Port ( 
    clk : in STD_LOGIC;
    probe_out0 : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );

end vio_sel;

architecture stub of vio_sel is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe_out0[3:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "vio,Vivado 2016.1";
begin
end;
