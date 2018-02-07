Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real."**";

entity counter is
generic(
	N		:	INTEGER	:=	4;
	MAX	:	INTEGER	:=	16
	);
port(
	clk		:	in			STD_LOGIC;
	rst		:	in			STD_LOGIC;
	enb		:	in			STD_LOGIC;
	dir		:	in			STD_LOGIC;
	count		:	buffer	STD_LOGIC_VECTOR( N-1 DOWNTO 0)
	);
end;

architecture behav of counter is

signal temp	:	SIGNED( N-1 DOWNTO 0);

begin

	count	<=	STD_LOGIC_VECTOR(temp);

	process (clk) is
	begin
		if clk'event AND clk = '1' then
			if rst = '0' then
				temp	<=	(others => '0');
			elsif enb = '1' AND dir = '0' then
				if temp <= to_signed(0,temp'length) then
					temp <= to_signed(MAX,temp'length);
				else
					temp <= temp - 1;
				end if;
			elsif enb = '1' AND dir = '1' then
				if temp >= to_signed(MAX,temp'length) then
					temp <= to_signed(0,temp'length);
				else
					temp <= temp + 1;
				end if;
			end if;
		end if;
	end process;

end;