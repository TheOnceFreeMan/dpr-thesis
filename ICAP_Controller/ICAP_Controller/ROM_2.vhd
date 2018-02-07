-- To change size of depth of ROM or data size, edit rom_pak.vhd package

LIBRARY	IEEE;
USE	IEEE.std_logic_1164.ALL;
USE	IEEE.numeric_std.ALL;
USE	work.rom_pak_2.ALL;

ENTITY rom_2 IS
	PORT(	clk	:	IN		STD_LOGIC;
			addr	:	IN		STD_LOGIC_VECTOR(addr_w - 1 DOWNTO 0);
			d_out	:	OUT	STD_LOGIC_VECTOR(data_w - 1 DOWNTO 0)
			);
END ENTITY rom_2;

ARCHITECTURE rtl OF rom_2 IS

	CONSTANT	mem	:	mem_type	:=	init_mem;

BEGIN

	PROCESS	(clk)
	BEGIN
		IF	rising_edge(clk)	THEN
			d_out	<=	mem(to_integer(unsigned(addr)));
		END	IF;
	END	PROCESS;

END rtl;