LIBRARY	IEEE;
USE	IEEE.std_logic_1164.ALL;
USE	IEEE.numeric_std.ALL;
USE	work.rom_pak.ALL;

ENTITY rom_15 IS
	GENERIC(
			f_name	:	string	:=	"memory.dat"
		);
	PORT(	clk	:	IN		STD_LOGIC;
			addr	:	IN		STD_LOGIC_VECTOR(addr_w - 1 DOWNTO 0);
			d_out	:	OUT	STD_LOGIC_VECTOR(data_w - 1 DOWNTO 0)
		);
END ENTITY rom_15;

ARCHITECTURE rtl OF rom_15 IS

	CONSTANT	mem	:	mem_type	:=	init_mem(f_name);

BEGIN

	PROCESS	(clk)
	BEGIN
		IF	rising_edge(clk)	THEN
			d_out	<=	mem(to_integer(unsigned(addr)));
		END	IF;
	END	PROCESS;

END rtl;