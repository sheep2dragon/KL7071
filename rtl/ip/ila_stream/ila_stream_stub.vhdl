-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.1 (win64) Build 1538259 Fri Apr  8 15:45:27 MDT 2016
-- Date        : Tue May 15 16:15:53 2018
-- Host        : WIN-FPGA01 running 64-bit major release  (build 7600)
-- Command     : write_vhdl -force -mode synth_stub
--               E:/projects/PT17052_KL7071_V2/new_fifo/7071_original/fos_a7_optic_fpga/fos_a7_optic_fpga.srcs/sources_1/ip/ila_stream/ila_stream_stub.vhdl
-- Design      : ila_stream
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a15tcsg325-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ila_stream is
  Port ( 
    clk : in STD_LOGIC;
    probe0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe1 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    probe2 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe3 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe4 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe5 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe6 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe7 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe8 : in STD_LOGIC_VECTOR ( 19 downto 0 );
    probe9 : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );

end ila_stream;

architecture stub of ila_stream is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe0[31:0],probe1[15:0],probe2[0:0],probe3[31:0],probe4[0:0],probe5[0:0],probe6[0:0],probe7[31:0],probe8[19:0],probe9[7:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "ila,Vivado 2016.1";
begin
end;
