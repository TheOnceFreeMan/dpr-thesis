----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:20:43 10/06/2017 
-- Design Name: 
-- Module Name:    top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
	Port(
		clk_i			 		:	in		STD_LOGIC;
		rst					:	in		STD_LOGIC;	-- Needs to be active-low
		controller_sel		:	in		STD_LOGIC;
		Current_Command	:	in		STD_LOGIC;
		EOC_A					:	in		STD_LOGIC;
		data_i_A				:	in		STD_LOGIC_VECTOR(7 DOWNTO 0);
		EOC_B					:	in		STD_LOGIC;
		data_i_B				:	in		STD_LOGIC_VECTOR(7 DOWNTO 0);
		quadA					:	in		STD_LOGIC;
		quadB					:	in		STD_LOGIC;
		freq					:	in		STD_LOGIC_VECTOR(15 DOWNTO 0);
		mem_dat				:	in		STD_LOGIC_VECTOR(7 DOWNTO 0);
		convst_A				:	out	STD_LOGIC;
		convst_B				:	out	STD_LOGIC;
		eeprom_sel			:	out	STD_LOGIC_VECTOR(1 DOWNTO 0);
		mem_addr				:	out	STD_LOGIC_VECTOR(18 DOWNTO 0);
		VaHigh				:	out	STD_LOGIC;
		VbHigh				:	out	STD_LOGIC;
		VcHigh				:	out	STD_LOGIC;
		VaLow				 	:	out	STD_LOGIC;
		VbLow					:	out	STD_LOGIC;
		VcLow					:	out	STD_LOGIC
	);
end top;

architecture Behavioral of top is

COMPONENT controller IS
	PORT(
		clk						:   IN		std_logic;
		reset					:   IN		std_logic;
		clk_enable				:   IN		std_logic;
		Current_Command			:   IN		std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
		i_a						:   IN		std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
		i_b						:   IN		std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
		Electrical_Position		:   IN		std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
		freq					:	IN		std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
		ce_out					:   OUT	std_logic;
		Va						:   OUT	std_logic_vector(83 DOWNTO 0);  -- sfix84_En66
		Vb						:   OUT	std_logic_vector(83 DOWNTO 0);  -- sfix84_En66
		Vc						:   OUT	std_logic_vector(83 DOWNTO 0)  -- sfix84_En66
		);
END COMPONENT controller;

ATTRIBUTE	box_type	:	STRING;
ATTRIBUTE	box_type	OF	controller:COMPONENT	IS	"user_black_box";

COMPONENT sense_test IS
	PORT(
		clk		:	IN		STD_LOGIC;
		rst		:	IN		STD_LOGIC;
		EOC		:	IN		STD_LOGIC;
		data_i	:	IN		STD_LOGIC_VECTOR(7 DOWNTO 0);
		convst	:	OUT	STD_LOGIC;
		data_o	:	OUT	STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT sense_test;

COMPONENT conv_encoder IS
		PORT(
			clk		:	in		STD_LOGIC;
			rst		:	in		STD_LOGIC;
			quadA		:	in		STD_LOGIC;
			quadB		:	in		STD_LOGIC;
			val		:	out	STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
END COMPONENT conv_encoder;

COMPONENT PWMGenerator_v3 IS
  PORT(
		Va			:	IN		std_logic_vector(83 DOWNTO 0);  -- sfix84_En66
		Vb			:	IN		std_logic_vector(83 DOWNTO 0);  -- sfix84_En66
		Vc			:	IN		std_logic_vector(83 DOWNTO 0);  -- sfix84_En66
		Counter	:	IN		std_logic_vector(7 DOWNTO 0);  -- uint8
		Vahigh	:	OUT	std_logic;
		Vbhigh	:	OUT	std_logic;
		Vchigh	:	OUT	std_logic;
		Valow		:	OUT	std_logic;
		Vblow		:	OUT	std_logic;
		Vclow		:	OUT	std_logic
		);
END COMPONENT PWMGenerator_v3;

COMPONENT gen_triangle_generator is
	Generic(
		LIMIT	:	integer range 0 to 255	:=	50
	);
	Port(
		clk : in  STD_LOGIC;
		rst : in  STD_LOGIC;
		cnt : out  STD_LOGIC_VECTOR (7 downto 0)
	);
END COMPONENT gen_triangle_generator;

COMPONENT ICAP_EEPROM IS
	PORT(
		clk		:	IN		STD_LOGIC;
		cfg		:	IN		STD_LOGIC;
		d_in		:	IN		STD_LOGIC_VECTOR (7 DOWNTO 0);
		busy		:	OUT	STD_LOGIC;
		done		:	OUT	STD_LOGIC;
		addr		:	OUT	STD_LOGIC_VECTOR (18 DOWNTO 0)
	);
END COMPONENT ICAP_EEPROM;

COMPONENT decoupler_in IS
	PORT(
		clk							:	IN		STD_LOGIC;
		cfg							:	IN		STD_LOGIC;
		s_reset						:	IN		STD_LOGIC;
		s_clk_enable				:	IN		STD_LOGIC;
		s_Current_Command			:	IN		STD_LOGIC_VECTOR(15 DOWNTO 0);
		s_i_a							:	IN		STD_LOGIC_VECTOR(15 DOWNTO 0);
		s_i_b							:	IN		STD_LOGIC_VECTOR(15 DOWNTO 0);
		s_Electrical_Position	:	IN		STD_LOGIC_VECTOR(15 DOWNTO 0);
		s_freq						:	IN		STD_LOGIC_VECTOR(15 DOWNTO 0);
		r_reset						:	OUT	STD_LOGIC;
		r_clk_enable				:	OUT	STD_LOGIC;
		r_Current_Command			:	OUT	STD_LOGIC_VECTOR(15 DOWNTO 0);
		r_i_a							:	OUT	STD_LOGIC_VECTOR(15 DOWNTO 0);
		r_i_b							:	OUT	STD_LOGIC_VECTOR(15 DOWNTO 0);
		r_Electrical_Position	:	OUT	STD_LOGIC_VECTOR(15 DOWNTO 0);
		r_freq						:	OUT	STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT decoupler_in;

COMPONENT decoupler IS
	Port (
		clk			:	in		STD_LOGIC;
		cfg			:	in		STD_LOGIC;
		rm_ce_out	:	in		STD_LOGIC;
		rm_Va_out	:	in		STD_LOGIC_VECTOR (83 downto 0);
		rm_Vb_out	:	in		STD_LOGIC_VECTOR (83 downto 0);
		rm_Vc_out	:	in		STD_LOGIC_VECTOR (83 downto 0);
		s_ce_out		:	out	STD_LOGIC;
		s_Va_out		:	out	STD_LOGIC_VECTOR (83 downto 0);
		s_Vb_out		:	out	STD_LOGIC_VECTOR (83 downto 0);
		s_Vc_out		:	out	STD_LOGIC_VECTOR (83 downto 0)
	);
END COMPONENT decoupler;

-- Currently set to generate a 20 kHz clock with a 50% duty
-- cycle
COMPONENT clock_div_200 IS
	PORT(
		clk_i	:	in		STD_LOGIC;
		rst	:	in		STD_LOGIC;
		clk_s	:	out	STD_LOGIC
	);
END COMPONENT clock_div_200;

COMPONENT icap_clk IS
	PORT(
		CLKIN_IN				:	in		std_logic;
		RST_IN				:	in		std_logic;
		CLKIN_IBUFG_OUT	:	out	std_logic;
		CLK0_OUT				:	out	std_logic;
		CLK2X_OUT			:	out	std_logic;
		LOCKED_OUT			:	out	std_logic
	);
END COMPONENT icap_clk;

COMPONENT config_state_machine IS
	PORT(
		clk		:	in		STD_LOGIC;
		rst		:	in		STD_LOGIC;
		sw			:	in		STD_LOGIC;
		done		:	in		STD_LOGIC;
		cfg		:	out	STD_LOGIC;
		src_sel	:	out	STD_LOGIC_VECTOR (1 downto 0)
	);
END COMPONENT config_state_machine;

SIGNAL	Va,Vb,Vc	:	STD_LOGIC_VECTOR(83 DOWNTO 0);
SIGNAL	cnt		:	STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	done		:	STD_LOGIC;
SIGNAL	ce_out	:	STD_LOGIC;

SIGNAL	busy		:	STD_LOGIC;
SIGNAL	cfg		:	STD_LOGIC;

SIGNAL	tmp_Va		:	STD_LOGIC_VECTOR(83 DOWNTO 0);
SIGNAL	tmp_Vb		:	STD_LOGIC_VECTOR(83 DOWNTO 0);
SIGNAL	tmp_Vc		:	STD_LOGIC_VECTOR(83 DOWNTO 0);
SIGNAL	tmp_ce_out	:	STD_LOGIC;
SIGNAL	clk			:	STD_LOGIC;
SIGNAL	clk_icap		:	STD_LOGIC;
SIGNAL	clk_int		:	STD_LOGIC;

SIGNAL	clk_ibufg_out	:	STD_LOGIC;
SIGNAL	locked			:	STD_LOGIC;
SIGNAL	r_clk_enable	:	STD_LOGIC;
SIGNAL	r_rst				:	STD_LOGIC;

SIGNAL	s_i_a							:	STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	s_i_b							:	STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	s_Electrical_Position	:	STD_LOGIC_VECTOR(15 DOWNTO 0);

SIGNAL	r_Phase_Current_A			:	STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	r_Phase_Current_B			:	STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	r_Electrical_Position	:	STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	r_Current_Command			:	STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	r_freq						:	STD_LOGIC_VECTOR(15 DOWNTO 0);

begin

RECONFIG_PART: controller
	PORT MAP(
		clk						=>	clk,
		reset						=>	r_rst,
		clk_enable				=>	r_clk_enable,
		Current_Command		=>	r_Current_Command,
		i_a						=>	r_Phase_Current_A,
		i_b						=>	r_Phase_Current_B,
		Electrical_Position	=>	r_Electrical_Position,
		freq						=>	freq,
		ce_out					=>	tmp_ce_out,
		Va							=>	tmp_Va,
		Vb							=>	tmp_Vb,
		Vc							=>	tmp_Vc
		);

DECOUPLE_IN: decoupler_in
	PORT MAP(
		clk							=>	clk,
		cfg							=>	NOT(busy),
		s_reset						=>	rst,
		s_clk_enable				=>	'1',
		s_Current_Command(0)		=>	Current_Command,
		s_Current_Command(1)		=>	'0',
		s_Current_Command(2)		=>	'0',
		s_Current_Command(3)		=>	'0',
		s_Current_Command(4)		=>	'0',
		s_Current_Command(5)		=>	'0',
		s_Current_Command(6)		=>	'0',
		s_Current_Command(7)		=>	'0',
		s_Current_Command(8)		=>	'0',
		s_Current_Command(9)		=>	'0',
		s_Current_Command(10)	=>	'0',
		s_Current_Command(11)	=>	'0',
		s_Current_Command(12)	=>	'0',
		s_Current_Command(13)	=>	'0',
		s_Current_Command(14)	=>	'0',
		s_Current_Command(15)	=>	'0',
		s_i_a							=>	s_i_a,
		s_i_b							=>	s_i_b,
		s_Electrical_Position	=>	s_Electrical_Position,
		s_freq						=>	freq,
		r_reset						=>	r_rst,
		r_clk_enable				=>	r_clk_enable,
		r_Current_Command			=>	r_Current_Command,
		r_i_a							=>	r_Phase_Current_A,
		r_i_b							=>	r_Phase_Current_B,
		r_Electrical_Position	=>	r_Electrical_Position,
		r_freq						=>	r_freq
	);

DECOUPLE: decoupler
	PORT MAP(
		clk			=>	clk,
		cfg			=>	NOT(busy),
		rm_ce_out	=>	tmp_ce_out,
		rm_Va_out	=>	tmp_Va,
		rm_Vb_out	=>	tmp_Vb,
		rm_Vc_out	=>	tmp_Vc,
		s_ce_out		=>	ce_out,
		s_Va_out		=>	Va,
		s_Vb_out		=>	Vb,
		s_Vc_out		=>	Vc
	);

ICAP_CONTR: ICAP_EEPROM
	PORT MAP(
		clk	=>	clk_icap,
		cfg	=>	cfg,
		d_in	=>	mem_dat,
		busy	=>	busy,
		done	=>	done,
		addr	=>	mem_addr
	);

TRI_GEN: gen_triangle_generator
	PORT MAP(
		clk	=>	clk,
		rst	=>	rst,
		cnt	=>	cnt
	);

PWM_GEN:	PWMGenerator_v3
  PORT MAP(
		Va			=>	Va,
		Vb			=>	Vb,
		Vc			=>	Vc,
		Counter	=>	cnt,
		Vahigh	=>	VaHigh,
		Vbhigh	=>	VbHigh,
		Vchigh	=>	VcHigh,
		Valow		=>	VaLow,
		Vblow		=>	VbLow,
		Vclow		=>	VcLow
		);

CLK_FIX:	clock_div_200
	PORT MAP(
		clk_i	=>	clk_int,
		rst	=>	rst,
		clk_s	=>	clk
	);

ICAP_CLK_COMP: icap_clk
	PORT MAP(
		CLKIN_IN				=>	clk_i,
		RST_IN				=>	rst,
		CLKIN_IBUFG_OUT	=>	clk_ibufg_out,
		CLK0_OUT				=>	clk_icap,
		CLK2X_OUT			=>	clk_int,
		LOCKED_OUT			=>	locked
	);

CURR_SENSE_A: sense_test
	PORT MAP(
		clk		=>	clk_icap,
		rst		=>	rst,
		EOC		=>	EOC_A,
		data_i	=>	data_i_A,
		convst	=>	convst_A,
		data_o	=>	s_i_a
	);

CURR_SENSE_B: sense_test
	PORT MAP(
		clk		=>	clk_icap,
		rst		=>	rst,
		EOC		=>	EOC_B,
		data_i	=>	data_i_B,
		convst	=>	convst_B,
		data_o	=>	s_i_b
	);

ELEC_POS: conv_encoder
	PORT MAP(
		clk	=>	clk_icap,
		rst	=>	rst,
		quadA	=>	quadA,
		quadB	=>	quadB,
		val	=>	s_Electrical_Position
	);

CONFIG_STATE:config_state_machine
	PORT MAP(
		clk		=>	clk_icap,
		rst		=>	rst,
		sw			=>	controller_sel,
		done		=>	done,
		cfg		=>	cfg,
		src_sel	=>	eeprom_sel
	);

end Behavioral;
