----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:07:46 09/27/2017 
-- Design Name: 
-- Module Name:    gen_register - Behavioral 
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

entity gen_register is
	GENERIC(
		size	:	INTEGER	:=	8
	);
	Port (
		clk	:	in		STD_LOGIC;
		en		:	in		STD_LOGIC;
		D		:	in		STD_LOGIC_VECTOR(size - 1 downto 0);
		Q		:	out	STD_LOGIC_VECTOR(size - 1 downto 0)
	);
end gen_register;

architecture Behavioral of gen_register is

begin

PROCESS
BEGIN
	WAIT UNTIL clk'EVENT AND clk='1';
	IF	en='1' THEN
		Q	<=	D;
	END IF;
END	PROCESS;

end Behavioral;

