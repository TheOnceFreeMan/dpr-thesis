----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:28:26 10/06/2017 
-- Design Name: 
-- Module Name:    gen_triangle_generator - Behavioral 
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

entity gen_triangle_generator is
	Generic(
		LIMIT	:	integer range 0 to 255	:=	50
	);
	Port(
		clk : in  STD_LOGIC;
		rst : in  STD_LOGIC;
		cnt : out  STD_LOGIC_VECTOR (7 downto 0)
	);
end gen_triangle_generator;

architecture Behavioral of gen_triangle_generator is

SIGNAL	tmp_cnt	:	signed(7 DOWNTO 0)	:=	(others => '0');
SIGNAL	dir		:	STD_LOGIC	:=	'0';

begin

	PROCESS (clk,rst)
	BEGIN

		IF rst='0' THEN
			cnt		<=	(others => '0');
			tmp_cnt	<=	(others => '0');
		ELSIF clk = '1' AND clk'EVENT THEN

			IF tmp_cnt >= to_signed(LIMIT - 1,8) THEN
				dir	<=	'1';
			ELSIF tmp_cnt = to_signed(1,8) THEN
				dir	<=	'0';
			END IF;

			IF dir = '0' THEN
				tmp_cnt	<=	tmp_cnt + 1;
			ELSE
				tmp_cnt	<= tmp_cnt - 1;
			END IF;
			cnt	<=	std_logic_vector(tmp_cnt);
		END IF;

	END PROCESS;

end Behavioral;

