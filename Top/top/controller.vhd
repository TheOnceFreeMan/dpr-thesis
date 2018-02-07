----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:46:02 10/05/2017 
-- Design Name: 
-- Module Name:    bb_controller - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--	This is a black box implementation of the controllers
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controller is
	Port(
		clk						:	IN		std_logic;
		reset						:	IN		std_logic;
		clk_enable				:	IN		std_logic;
		Current_Command		:	IN		std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
		Phase_Current_A		:	IN		std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
		Phase_Current_B		:	IN		std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
		Electrical_Position	:	IN		std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
		paramCurrentControlI	:	IN		std_logic_vector(15 DOWNTO 0);  -- sfix16_En3
		paramCurrentControlP	:	IN		std_logic_vector(15 DOWNTO 0);  -- sfix16_En8
		freq						:	IN		std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
		ce_out					:	OUT	std_logic;
		Va							:	OUT	std_logic_vector(83 DOWNTO 0);  -- sfix84_En66
		Vb							:	OUT	std_logic_vector(83 DOWNTO 0);  -- sfix84_En66
		Vc							:	OUT	std_logic_vector(83 DOWNTO 0)  -- sfix84_En66
		);
end controller;

architecture Behavioral of controller is

begin


end Behavioral;

