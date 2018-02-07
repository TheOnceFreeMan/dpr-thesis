Library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity XOR_gen is
generic(
		N	:	integer := 2
	);
port(
		inp	:	in STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		oup	:	out STD_LOGIC
	);
end;

architecture dataflow of XOR_gen is

	signal	temp	:	STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	
begin

	temp(0)	<=	inp(0);
	
	gen: for i in 1 to N-1 generate
		temp(i)	<=	temp(i-1) XOR inp(i);
	end generate;
	
	oup	<=	temp(N-1);
	
end;