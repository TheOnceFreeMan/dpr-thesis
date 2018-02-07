LIBRARY	IEEE;
USE	IEEE.std_logic_1164.ALL;
USE	IEEE.numeric_std.ALL;
USE	IEEE.math_real.ALL;
USE	STD.textio.ALL;

PACKAGE	rom_pak	IS
	CONSTANT	addr_w	:	integer	:=	15;
	CONSTANT	data_w	:	integer	:=	32; -- Only 8, 16, or 32 should be used with ICAP
	CONSTANT	depth		:	integer	:=	2**addr_w;
	
	TYPE	mem_type	IS	ARRAY	(0	TO	depth - 1)	OF	std_logic_vector(data_w - 1 DOWNTO 0);
	
	IMPURE	FUNCTION	init_mem (f_name	:	string)	RETURN	mem_type;
END PACKAGE rom_pak;

PACKAGE	BODY	rom_pak	IS

	IMPURE	FUNCTION	init_mem (f_name	:	string)	RETURN	mem_type	IS
		FILE	mem_file	:	text	OPEN	read_mode	IS	f_name;
		
		VARIABLE	mem_line	:	line;
		VARIABLE	mem_bvec	:	bit_vector(data_w - 1 DOWNTO 0);
		VARIABLE	temp_mem	:	mem_type;
	BEGIN
		FOR	i	IN	mem_type'RANGE	LOOP
			READLINE(mem_file,mem_line);
			READ(mem_line,mem_bvec);
			temp_mem(i)	:=	to_stdlogicvector(mem_bvec);
		END LOOP;
		RETURN	temp_mem;
	END	FUNCTION;

END	PACKAGE	BODY	rom_pak;