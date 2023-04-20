
library	IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
--use work.COMPONENTLIB.ALL;

entity RT_LAB_comm_with_MC is
port(
	reset_r 		         :in	std_logic;	
	clk_sys_r 	             :in 	std_logic;				----100M输入
	rx_comm_err        		 :out	std_logic;			   --为实时的下行通讯故障
	rx_verify_err        	 :out	std_logic;		
	phy_rxd 		         :in	std_logic;               ----接收�?控信�?
	rxd_data         		 :out	std_logic_vector(7 downto 0);
	
	reset_t 		         :in	std_logic;	
	clk_sys_t 	             :in 	std_logic;	       				----100M输入
	vc_tran_data        	 :in	 std_logic_vector(31 downto 0);  	----32位电容电�?
	st_tran_data        	 :in	 std_logic_vector(31 downto 0);     ----32位状�?
	trans_start        	 	 :in	 std_logic;							----发�?�启�?
	phy_txd 		         :out std_logic;							----发�?�给�?控信�?
	optic_temp_fault 		 :in  std_logic;							----温度故障模拟
	
	RYTX		 	 		:out  std_logic;
	RYRX		 	 		:in  std_logic;
	clk_sys_RY              :in  std_logic 							----40M输入
	);
end entity;

architecture BEHAVIOR of RT_LAB_comm_with_MC is
begin
 
end architecture;
