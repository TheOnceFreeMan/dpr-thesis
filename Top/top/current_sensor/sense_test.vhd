Library IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY sense_test IS
	PORT(
		clk		:	IN		STD_LOGIC;
		rst		:	IN		STD_LOGIC;
		EOC		:	IN		STD_LOGIC;
		data_i	:	IN		STD_LOGIC_VECTOR(7 DOWNTO 0);
		convst	:	OUT	STD_LOGIC;
		data_o	:	OUT	STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END sense_test;

ARCHITECTURE struct OF sense_test IS

SIGNAL	temp			:	UNSIGNED( 7 DOWNTO 0 );
SIGNAL	convst_tmp	:	STD_LOGIC;
SIGNAL	convst_store:	STD_LOGIC_VECTOR( 2 DOWNTO 0 );
SIGNAL	data_o_tmp	:	STD_LOGIC_VECTOR( 17 DOWNTO 0);

CONSTANT	CONV_FACTOR	:	UNSIGNED( 9 DOWNTO 0 )	:=	"0001111101";
CONSTANT	OFFSET		:	UNSIGNED( 17 DOWNTO 0 )	:=	"000011111010000000";

COMPONENT reg is
	Port(
		clk	:	in		STD_LOGIC;
		rst	:	in		STD_LOGIC;
		enb	:	in		STD_LOGIC;
		D		:	in		STD_LOGIC_VECTOR (15 downto 0);
		Q		:	out	STD_LOGIC_VECTOR (15 downto 0)
	);
END COMPONENT;

BEGIN

PROCESS
BEGIN
	WAIT UNTIL clk'EVENT AND clk = '1';
	IF	rst = '0' THEN
		convst_tmp	<=	'1';
	ELSE
		IF convst_tmp = '0' THEN
			convst_tmp	<=	'1';
		ELSE
			convst_tmp	<=	'0';
		END IF;
	END IF;
END PROCESS;

PROCESS (rst, EOC, data_i)
BEGIN
	IF rst = '0' THEN
		temp	<=	(others => '0');
	ELSE
		IF EOC = '0' THEN
			temp	<=	unsigned(data_i);
		END IF;
	END IF;
END PROCESS;

data_o_tmp	<=	std_logic_vector(temp * CONV_FACTOR - OFFSET);

REGIS: reg
	PORT MAP(
		clk	=>	clk,
		rst	=>	rst,
		enb	=>	EOC,
		D		=>	data_o_tmp(17 DOWNTO 2),
		Q		=>	data_o
	);

convst_store	<=	(convst_store(convst_store'HIGH - 1 DOWNTO 0) & convst_tmp) WHEN clk'EVENT AND clk = '1';
convst	<=	convst_store(convst_store'HIGH);

END struct;