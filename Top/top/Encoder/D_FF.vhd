Library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity D_FF IS
port(
	clk	:	in	STD_LOGIC;
	rst	:	in	STD_LOGIC;
	pre	:	in	STD_LOGIC;
	ce	:	in	STD_LOGIC;
	D	:	in	STD_LOGIC;
	Q	:	out	STD_LOGIC;
	nQ	:	out	STD_LOGIC
	);
end;

architecture behavioral of D_FF is
begin
	process (clk) is
	begin
		if (clk'event AND clk = '1') then
			if rst = '0' then
				Q	<=	'0';
				nQ	<=	'1';
			elsif pre = '1' then
				Q	<=	'1';
				nQ	<=	'0';
			elsif ce = '1' then
				Q	<=	D;
				nQ	<=	NOT D;
			end if;
		end if;
	end process;
end;