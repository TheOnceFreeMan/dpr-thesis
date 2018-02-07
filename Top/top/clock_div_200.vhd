----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:41:06 10/10/2017 
-- Design Name: 
-- Module Name:    clock_fix - Behavioral 
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

ENTITY clock_div_200 IS
	PORT(
		clk_i	:	in		STD_LOGIC;
		rst	:	in		STD_LOGIC;
		clk_s	:	out	STD_LOGIC
	);
END clock_div_200;

architecture Behavioral of clock_div_200 is

SIGNAL	cycles	:	INTEGER RANGE 0 TO 2499	:=	0;
SIGNAL	t_clk		:	STD_LOGIC;

begin

	PROCESS (rst,clk_i)
	BEGIN

		IF rst = '0' THEN
			cycles	<=	0;
			t_clk		<=	'0';
		ELSIF clk_i'EVENT AND clk_i='1' THEN
			IF cycles = 2499 THEN
				t_clk		<=	NOT(t_clk);
				cycles	<=	0;
			ELSE
				cycles	<=	cycles + 1;
			END IF;
		END IF;
		
	END PROCESS;

	clk_s	<=	t_clk;

end Behavioral;
