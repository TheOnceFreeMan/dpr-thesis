----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:09:18 11/02/2017 
-- Design Name: 
-- Module Name:    config_state_machine - Behavioral 
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

entity config_state_machine is
    Port ( clk : in  STD_LOGIC;
			  rst	:	in	STD_LOGIC;
           sw : in  STD_LOGIC;
           done : in  STD_LOGIC;
           cfg : out  STD_LOGIC;
           src_sel : out  STD_LOGIC_VECTOR (1 downto 0));
end config_state_machine;

architecture Behavioral of config_state_machine is

TYPE states IS (S0,S1,S2,S3,S4);

SIGNAL	CS		:	states	:=	S0;
SIGNAL	NXS	:	states;

begin

combinational: PROCESS (CS,done,sw)
BEGIN
	CASE CS IS
		WHEN S0	=>
			src_sel	<=	"01";
			cfg		<=	'1';
			NXS		<=	S1;
		WHEN S1	=>
			cfg	<=	'0';
			IF done = '1' THEN
				NXS	<=	S2;
			ELSE
				NXS	<=	S1;
			END IF;
		WHEN S2	=>
			IF sw = '1' THEN
				src_sel	<=	"10";
				cfg		<=	'1';
				NXS		<=	S3;
			ELSE
				NXS		<=	S2;
			END IF;
		WHEN S3	=>
			cfg	<=	'0';
			IF done = '1' THEN
				NXS	<=	S4;
			ELSE
				NXS	<= S3;
			END IF;
		WHEN S4	=>
			IF sw = '0' THEN
				src_sel	<=	"01";
				cfg		<=	'1';
				NXS		<=	S1;
			ELSE
				NXS		<=	S4;
			END IF;
--		WHEN OTHERS	=>	NXS	<=	S0;
		END CASE;
END PROCESS;

PROCESS
BEGIN
	WAIT UNTIL clk'EVENT AND clk = '1';
	IF	rst = '0' THEN
		CS	<=	S0;
	ELSE
		CS	<=	NXS;
	END IF;
END PROCESS;

end Behavioral;

