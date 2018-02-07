Library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity quad_dec is
port(
	clk	:	in	STD_LOGIC;	-- Clock
	rst	:	in	STD_LOGIC;	-- Reset
	enb	:	in	STD_LOGIC;	-- Enable
	A	:	in	STD_LOGIC;	-- Quadrature A Signal
	B	:	in	STD_LOGIC;	-- Quadrature B Signal
	cen	:	out	STD_LOGIC;	-- Count Enable Output
	dir	:	out	STD_LOGIC	-- Counter Direction
	);
end;

architecture struct of quad_dec is

signal nQ_temp	:	STD_LOGIC_VECTOR(5 DOWNTO 0);
signal Q_temp	:	STD_LOGIC_VECTOR(5 DOWNTO 0);
signal enb_vect	:	STD_LOGIC_VECTOR(3 DOWNTO 0);

component D_FF
	port(
		clk	:	in	STD_LOGIC;
		rst	:	in	STD_LOGIC;
		pre	:	in	STD_LOGIC;
		ce	:	in	STD_LOGIC;
		D	:	in	STD_LOGIC;
		Q	:	out	STD_LOGIC;
		nQ	:	out	STD_LOGIC
	);
end component;

component XOR_gen
	generic(
		N	:	integer	:=	2
	);
	port(
		inp	:	in	STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		oup	:	out	STD_LOGIC
	);
end component;

begin

	enb_vect	<=	Q_temp(1) & Q_temp(2) & Q_temp(4) & Q_temp(5);

	D1:D_FF
		port map(
			clk	=>	clk,
			rst	=>	rst,
			pre	=>	'0',
			ce	=>	enb,
			D	=>	A,
			Q	=>	Q_temp(0),
			nQ	=>	nQ_temp(0)
		);
	
	D2:D_FF
		port map(
			clk	=>	clk,
			rst	=>	rst,
			pre	=>	'0',
			ce	=>	enb,
			D	=>	Q_temp(0),
			Q	=>	Q_temp(1),
			nQ	=>	nQ_temp(1)
		);
	
	D3:D_FF
		port map(
			clk	=>	clk,
			rst	=>	rst,
			pre	=>	'0',
			ce	=>	enb,
			D	=>	Q_temp(1),
			Q	=>	Q_temp(2),
			nQ	=>	nQ_temp(2)
		);
	
	D4:D_FF
		port map(
			clk	=>	clk,
			rst	=>	rst,
			pre	=>	'0',
			ce	=>	enb,
			D	=>	B,
			Q	=>	Q_temp(3),
			nQ	=>	nQ_temp(3)
		);
	
	D5:D_FF
		port map(
			clk	=>	clk,
			rst	=>	rst,
			pre	=>	'0',
			ce	=>	enb,
			D	=>	Q_temp(3),
			Q	=>	Q_temp(4),
			nQ	=>	nQ_temp(4)
		);
	
	D6:D_FF
		port map(
			clk	=>	clk,
			rst	=>	rst,
			pre	=>	'0',
			ce	=>	enb,
			D	=>	Q_temp(4),
			Q	=>	Q_temp(5),
			nQ	=>	nQ_temp(5)
		);
	
	COUNT_ENABLE:XOR_gen
		generic map(
			N	=>	4
		)
		port map(
			inp	=>	enb_vect,
			oup	=>	cen
		);
	
	dir	<=	Q_temp(1) XOR Q_temp(5);

end;
	