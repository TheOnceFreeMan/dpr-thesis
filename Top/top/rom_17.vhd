LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE	WORK.rom_pak.ALL;

ENTITY rom_17 IS
	PORT(
		clk		:	IN	STD_LOGIC;
		addr	:	IN	STD_LOGIC_VECTOR(16 DOWNTO 0);
		d_out_1	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
		d_out_2	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END ENTITY rom_17;

ARCHITECTURE struct OF rom_17 IS

COMPONENT rom_15 IS
	GENERIC(
		f_name	:	STRING	:=	"memory.dat"
	);
	PORT(
		clk		:	IN	STD_LOGIC;
		addr	:	IN	STD_LOGIC_VECTOR(addr_w - 1 DOWNTO 0);
		d_out	:	OUT	STD_LOGIC_VECTOR(data_w - 1 DOWNTO 0)
	);
END COMPONENT rom_15;

COMPONENT gen_mux_4_1 IS
	GENERIC(
		size		:	INTEGER	:=	8
	);
	PORT(
		SEL		:	in		STD_LOGIC_VECTOR(1 DOWNTO 0);
		DATA_A	:	in		STD_LOGIC_VECTOR(size - 1 downto 0);
		DATA_B	:	in		STD_LOGIC_VECTOR(size - 1 downto 0);
		DATA_C	:	in		STD_LOGIC_VECTOR(size - 1 downto 0);
		DATA_D	:	in		STD_LOGIC_VECTOR(size - 1 downto 0);
		D_OUT		:	out 	STD_LOGIC_VECTOR(size - 1 downto 0)
	);
END COMPONENT gen_mux_4_1;

SIGNAL	DATA_A_1	:	STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	DATA_B_1	:	STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	DATA_C_1	:	STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	DATA_D_1	:	STD_LOGIC_VECTOR(31 DOWNTO 0);

SIGNAL	DATA_A_2	:	STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	DATA_B_2	:	STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	DATA_C_2	:	STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	DATA_D_2	:	STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

-- ROM 1 connections

	MUX4_1: gen_mux_4_1
		GENERIC MAP(
			size	=>	32
		)
		PORT MAP(
			SEL		=>	addr(16 DOWNTO 15),
			DATA_A	=>	DATA_A_1,
			DATA_B	=>	DATA_B_1,
			DATA_C	=>	DATA_C_1,
			DATA_D	=>	DATA_D_1,
			D_OUT	=>	d_out_1
		);

	ROM1_1: rom_15
		GENERIC MAP("mem1_a.dat")
		PORT MAP(
			clk		=>	clk,
			addr	=>	addr(14 DOWNTO 0),
			d_out	=>	DATA_A_1
		);

	ROM2_1: rom_15
		GENERIC MAP("mem1_b.dat")
		PORT MAP(
			clk		=>	clk,
			addr	=>	addr(14 DOWNTO 0),
			d_out	=>	DATA_B_1
		);

	ROM3_1: rom_15
		GENERIC MAP("mem1_c.dat")
		PORT MAP(
			clk		=>	clk,
			addr	=>	addr(14 DOWNTO 0),
			d_out	=>	DATA_C_1
		);

	ROM4_1: rom_15
		GENERIC MAP("mem1_d.dat")
		PORT MAP(
			clk		=>	clk,
			addr	=>	addr(14 DOWNTO 0),
			d_out	=>	DATA_D_1
		);

-- ROM 2 Connections

	MUX4_2: gen_mux_4_1
		GENERIC MAP(
			size	=>	32
		)
		PORT MAP(
			SEL		=>	addr(16 DOWNTO 15),
			DATA_A	=>	DATA_A_2,
			DATA_B	=>	DATA_B_2,
			DATA_C	=>	DATA_C_2,
			DATA_D	=>	DATA_D_2,
			D_OUT	=>	d_out_2
		);

	ROM1_2: rom_15
		GENERIC MAP("mem2_a.dat")
		PORT MAP(
			clk		=>	clk,
			addr	=>	addr(14 DOWNTO 0),
			d_out	=>	DATA_A_2
		);

	ROM2_2: rom_15
		GENERIC MAP("mem2_b.dat")
		PORT MAP(
			clk		=>	clk,
			addr	=>	addr(14 DOWNTO 0),
			d_out	=>	DATA_B_2
		);

	ROM3_2: rom_15
		GENERIC MAP("mem2_c.dat")
		PORT MAP(
			clk		=>	clk,
			addr	=>	addr(14 DOWNTO 0),
			d_out	=>	DATA_C_2
		);

	ROM4_2: rom_15
		GENERIC MAP("mem2_d.dat")
		PORT MAP(
			clk		=>	clk,
			addr	=>	addr(14 DOWNTO 0),
			d_out	=>	DATA_D_2
		);

END;