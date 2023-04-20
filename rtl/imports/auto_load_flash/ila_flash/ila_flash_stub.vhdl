-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
-- Date        : Thu Dec 15 13:15:32 2022
-- Host        : KLSHGDJS422 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top ila_flash -prefix
--               ila_flash_ ila_flash_stub.vhdl
-- Design      : ila_flash
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcsg325-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ila_flash is
  Port ( 
    clk : in STD_LOGIC;
    probe0 : in STD_LOGIC_VECTOR ( 159 downto 0 )
  );

end ila_flash;

architecture stub of ila_flash is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe0[159:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "ila,Vivado 2017.4";
begin
end;
