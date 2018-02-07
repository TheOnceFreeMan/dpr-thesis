----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:41:12 09/29/2017 
-- Design Name: 
-- Module Name:    gen_mux - Behavioral 
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

entity gen_mux is
	Generic(
		size		:	INTEGER	:=	8
	);
	Port(
		SEL		:	in		STD_LOGIC;
		DATA_A	:	in		STD_LOGIC_VECTOR(size - 1 downto 0);
		DATA_B	:	in		STD_LOGIC_VECTOR(size - 1 downto 0);
		D_OUT		:	out 	STD_LOGIC_VECTOR(size - 1 downto 0)
	);
end gen_mux;

architecture Behavioral of gen_mux is

begin

D_OUT	<=	DATA_A WHEN SEL='0' ELSE DATA_B;

end Behavioral;

