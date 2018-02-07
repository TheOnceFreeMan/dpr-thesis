library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gen_mux_4_1 is
	Generic(
		size		:	INTEGER	:=	8
	);
	Port(
		SEL		:	in		STD_LOGIC_VECTOR( 1 DOWNTO 0);
		DATA_A	:	in		STD_LOGIC_VECTOR(size - 1 downto 0);
		DATA_B	:	in		STD_LOGIC_VECTOR(size - 1 downto 0);
		DATA_C	:	in		STD_LOGIC_VECTOR(size - 1 DOWNTO 0);
		DATA_D	:	in		STD_LOGIC_VECTOR(size - 1 DOWNTO 0);
		D_OUT		:	out 	STD_LOGIC_VECTOR(size - 1 downto 0)
	);
end gen_mux_4_1;

architecture Behavioral of gen_mux_4_1 is

begin

PROCESS (SEL,DATA_A,DATA_B,DATA_C,DATA_D)
BEGIN

	CASE SEL IS
		WHEN "00"	=>	D_OUT	<=	DATA_A;
		WHEN "01"	=>	D_OUT	<=	DATA_B;
		WHEN "10"	=>	D_OUT	<=	DATA_C;
		WHEN OTHERS	=>	D_OUT	<=	DATA_D;
	END CASE;
	
END PROCESS;

end Behavioral;