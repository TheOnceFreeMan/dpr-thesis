Library IEEE;
use IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.all;

entity conv_encoder IS
		PORT(
			clk		:	in		STD_LOGIC;
			rst		:	in		STD_LOGIC;
			quadA		:	in		STD_LOGIC;
			quadB		:	in		STD_LOGIC;
			val		:	out	STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
END;

architecture struct of conv_encoder is

component quad_dec is
port(
	clk	:	in	STD_LOGIC;	-- Clock
	rst	:	in	STD_LOGIC;	-- Reset
	enb	:	in	STD_LOGIC;	-- Enable
	A	:	in	STD_LOGIC;	-- Quadrature A Signal
	B	:	in	STD_LOGIC;	-- Quadrature B Signal
	cen	:	out	STD_LOGIC;	-- Count Enable Output
	dir	:	out	STD_LOGIC	-- Counter Direction
	);
end component;

component counter is
	generic(
		N		:	INTEGER	:= 4;
		MAX	:	INTEGER	:=	16
	);
	port(
		clk		:	in	STD_LOGIC;
		rst		:	in	STD_LOGIC;
		enb		:	in	STD_LOGIC;
		dir		:	in	STD_LOGIC;
		count	:	buffer	STD_LOGIC_VECTOR( N-1 DOWNTO 0)
	);
end component;

signal	count_enb							:	STD_LOGIC;
signal	direction							:	STD_LOGIC;
signal	locked								:	STD_LOGIC;
signal	tmp_val								:	STD_LOGIC_VECTOR(35 DOWNTO 0);
signal	cnt_val								:	STD_LOGIC_VECTOR(15 DOWNTO 0);

CONSTANT	cnt2rad	:	UNSIGNED(19 DOWNTO 0)	:=	"00000000011001101111";

begin
			
	DECODER:quad_dec
		port map(
			clk		=>	clk,
			rst		=>	rst,
			enb		=>	'1',
			A		=>	quadA,
			B		=>	quadB,
			cen		=>	count_enb,
			dir		=>	direction
		);
		
	CNTR:counter
		generic map(
			N		=>	16,
			MAX	=>	4000
		)
		port map(
			clk		=>	count_enb,
			rst		=>	rst,
			dir		=>	direction,
			enb		=>	'1',
			count	=>	cnt_val
		);

	tmp_val	<=	std_logic_vector(cnt2rad * unsigned(cnt_val));
	val		<=	tmp_val(24 DOWNTO 9);

end;