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

entity decoupler is
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
end decoupler;

architecture Behavioral of decoupler is

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

CE_OUT_BUFF: gen_register
	GENERIC MAP(
		size	=>	1
	)
	PORT MAP(
		clk	=>	clk,
		en		=>	cfg,
		D(0)	=>	rm_ce_out,
		Q(0)	=>	s_ce_out
	);

VA_OUT_BUFF: gen_register
	GENERIC MAP(
		size	=>	rm_Va_out'LENGTH
	)
	PORT MAP(
		clk	=>	clk,
		en		=>	cfg,
		D		=>	rm_Va_out,
		Q		=>	s_Va_out
	);

VB_OUT_BUFF: gen_register
	GENERIC MAP(
		size	=>	rm_Vb_out'LENGTH
	)
	PORT MAP(
		clk	=>	clk,
		en		=>	cfg,
		D		=>	rm_Vb_out,
		Q		=>	s_Vb_out
	);

VC_OUT_BUFF: gen_register
	GENERIC MAP(
		size	=>	rm_Vc_out'LENGTH
	)
	PORT MAP(
		clk	=>	clk,
		en		=>	cfg,
		D		=>	rm_Vc_out,
		Q		=>	s_Vc_out
	);

end Behavioral;

