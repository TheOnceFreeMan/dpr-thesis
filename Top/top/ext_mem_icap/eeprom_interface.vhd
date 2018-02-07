----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:52:38 10/26/2017 
-- Design Name: 
-- Module Name:    eeprom_interface - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY eeprom_interface IS
	PORT(
		clk	:	IN		STD_LOGIC;
		enb	:	IN		STD_LOGIC;
		d_in	:	IN		STD_LOGIC_VECTOR (7 DOWNTO 0);
		valid	:	OUT	STD_LOGIC;
		done	:	OUT	STD_LOGIC;
		addr	:	OUT	STD_LOGIC_VECTOR (18 DOWNTO 0);
		d_out	:	OUT	STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
END eeprom_interface;

architecture Behavioral of eeprom_interface is

TYPE states	IS	(S0,S1,S2,S3,S4,S5,S6);

SIGNAL	temp_addr	:	UNSIGNED(18 DOWNTO 0)	:=	(others => '0');
SIGNAL	CS				:	states						:=	S0;
SIGNAL	NXS			:	states;
SIGNAL	eof			:	STD_LOGIC					:=	'0';

begin

addr	<=	std_logic_vector(temp_addr);
d_out	<=	d_in;
done	<=	eof;

EEPROM_READ:PROCESS
BEGIN
	WAIT UNTIL clk'EVENT AND clk = '1';
	IF enb = '1' AND eof = '0' THEN
		temp_addr <= temp_addr + 1;
	ELSE
		temp_addr	<=	(others => '0');
	END IF;
END PROCESS;

PROCESS (enb, eof, temp_addr)
BEGIN
	IF enb = '1' AND eof = '0' THEN
		IF temp_addr = "0000000000000000000" THEN
			valid	<=	'0';
		ELSE
			valid	<=	'1';
		END IF;
	ELSE
		valid	<=	'0';
	END IF;
END PROCESS;

EOF_DETECT:PROCESS (enb, eof, d_in, CS)
BEGIN
	CASE CS IS
		WHEN S0	=>
			IF d_in = "00000000" THEN
				NXS	<=	S1;
			ELSE
				NXS	<=	S4;
			END IF;
			eof	<=	'0';
		WHEN S1	=>
			IF d_in = "00000000" THEN
				NXS	<=	S2;
			ELSE
				NXS	<=	S5;
			END IF;
			eof	<=	'0';
		WHEN S2	=>
			IF d_in = "00000000" THEN
				NXS	<=	S3;
			ELSE
				NXS	<=	S6;
			END IF;
			eof	<=	'0';
		WHEN S3	=>
			IF d_in = "00001101" THEN
				eof	<=	'1';
			ELSE
				eof	<=	'0';
			END IF;
			NXS	<=	S0;
		WHEN S4	=>
			NXS	<=	S5;
			eof	<=	'0';
		WHEN S5	=>
			NXS	<=	S6;
			eof	<=	'0';
		WHEN OTHERS	=>
			NXS	<=	S0;
			eof	<=	'0';
	END CASE;
END PROCESS;

PROCESS
BEGIN
	WAIT UNTIL clk'EVENT AND clk = '1';
	IF enb = '1' AND eof = '0' THEN
		CS	<=	NXS;
	ELSE
		CS	<=	S0;
	END IF;
END PROCESS;

end Behavioral;

