----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:07:48 09/26/2017 
-- Design Name: 
-- Module Name:    counter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
	Generic(
		size	:	INTEGER	:=	8
	);
	Port(	
		clk : in  STD_LOGIC;
		rst : in  STD_LOGIC;
		enb : in  STD_LOGIC;
		cnt : out  STD_LOGIC_VECTOR(size - 1 DOWNTO 0)
	);
end counter;

architecture Behavioral of counter is

SIGNAL	t_cnt	:	UNSIGNED(size - 1 DOWNTO 0) := (others => '0');

begin

PROCESS
BEGIN
	WAIT UNTIL clk'EVENT AND clk = '1';
	IF	enb	=	'0'	THEN
		IF rst	=	'1'	THEN
			t_cnt	<=	(others	=>	'0');
		ELSE
			t_cnt	<=	t_cnt	+	1;
		END	IF;
	END	IF;
	cnt	<=	std_logic_vector(t_cnt);

END	PROCESS;

end Behavioral;

