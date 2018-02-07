----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:45:50 11/01/2017 
-- Design Name: 
-- Module Name:    register - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg is
	Port(
		clk	:	in		STD_LOGIC;
		rst	:	in		STD_LOGIC;
		enb	:	in		STD_LOGIC;
		D		:	in		STD_LOGIC_VECTOR (15 downto 0);
		Q		:	out	STD_LOGIC_VECTOR (15 downto 0)
	);
end reg;

architecture Behavioral of reg is

begin


PROCESS (clk,rst,D)
BEGIN
	IF rst = '0' THEN
		Q	<=	(others => '0');
	ELSIF clk'EVENT AND clk = '1'  AND enb = '0' THEN
		Q	<=	D;
	END IF;
END PROCESS;

end Behavioral;

