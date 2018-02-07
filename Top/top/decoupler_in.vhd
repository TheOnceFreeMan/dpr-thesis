----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:31:08 10/10/2017 
-- Design Name: 
-- Module Name:    decoupler - Behavioral 
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

entity decoupler_in is
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
end decoupler_in;

architecture Behavioral of decoupler_in is

COMPONENT gen_register IS
	GENERIC(
		size	:	INTEGER	:=	8
	);
	Port (
		clk	:	in		STD_LOGIC;
		en		:	in		STD_LOGIC;
		D		:	in		STD_LOGIC_VECTOR(size - 1 downto 0);
		Q		:	out	STD_LOGIC_VECTOR(size - 1 downto 0)
	);
END COMPONENT;

begin

RESET_BUFF: gen_register
	GENERIC MAP(
		size	=>	1
	)
	PORT MAP(
		clk	=>	clk,
		en		=>	cfg,
		D(0)	=>	s_reset,
		Q(0)	=>	r_reset
	);

CLK_ENABLE_BUFF: gen_register
	GENERIC MAP(
		size	=>	1
	)
	PORT MAP(
		clk	=>	clk,
		en		=>	cfg,
		D(0)	=>	s_clk_enable,
		Q(0)	=>	r_clk_enable
	);

CURRENT_COMMAND_BUFF: gen_register
	GENERIC MAP(
		size	=>	s_Current_Command'LENGTH
	)
	PORT MAP(
		clk	=>	clk,
		en		=>	cfg,
		D		=>	s_Current_Command,
		Q		=>	r_Current_Command
	);

I_A_BUFF: gen_register
	GENERIC MAP(
		size	=>	s_i_a'LENGTH
	)
	PORT MAP(
		clk	=>	clk,
		en		=>	cfg,
		D		=>	s_i_a,
		Q		=>	r_i_a
	);

I_B_BUFF: gen_register
	GENERIC MAP(
		size	=>	s_i_b'LENGTH
	)
	PORT MAP(
		clk	=>	clk,
		en		=>	cfg,
		D		=>	s_i_b,
		Q		=>	r_i_b
	);

ELECTRICAL_POSITION_BUFF: gen_register
	GENERIC MAP(
		size	=>	s_Electrical_Position'LENGTH
	)
	PORT MAP(
		clk	=>	clk,
		en		=>	cfg,
		D		=>	s_Electrical_Position,
		Q		=>	r_Electrical_Position
	);

FREQ_BUFF: gen_register
	GENERIC MAP(
		size	=>	s_freq'LENGTH
	)
	PORT MAP(
		clk	=>	clk,
		en		=>	cfg,
		D		=>	s_freq,
		Q		=>	r_freq
	);

end Behavioral;

