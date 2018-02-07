----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:18:42 11/01/2017 
-- Design Name: 
-- Module Name:    ICAP_EEPROM - Behavioral 
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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
LIBRARY UNISIM;
USE UNISIM.VComponents.ALL;

entity ICAP_EEPROM is
	Port(
		clk		:	in		STD_LOGIC;
		cfg		:	in		STD_LOGIC;
		d_in		:	in		STD_LOGIC_VECTOR (7 DOWNTO 0);
		busy		:	OUT	STD_LOGIC;
		done		:	out	STD_LOGIC;
		addr		:	out	STD_LOGIC_VECTOR (18 DOWNTO 0)
	);
end ICAP_EEPROM;

architecture Behavioral of ICAP_EEPROM is

COMPONENT eeprom_interface IS
	PORT(
		clk	:	IN		STD_LOGIC;
		enb	:	IN		STD_LOGIC;
		d_in	:	IN		STD_LOGIC_VECTOR (7 DOWNTO 0);
		valid	:	OUT	STD_LOGIC;
		done	:	OUT	STD_LOGIC;
		addr	:	OUT	STD_LOGIC_VECTOR (18 DOWNTO 0);
		d_out	:	OUT	STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	dn		:	STD_LOGIC;
SIGNAL	enb	:	STD_LOGIC;
SIGNAL	BSY	:	STD_LOGIC;
SIGNAL	O		:	STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL	CE		:	STD_LOGIC;
SIGNAL	I		:	STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL	is_cfg	:	STD_LOGIC;

begin

-- ICAP_VIRTEX5: Internal Configuration Access Port
-- Virtex-5
-- Xilinx HDL Libraries Guide, version 11.2
--	Uncomment below this line to End of ICAP_VIRTEX5_inst instatiation
--	to enable ICAP
ICAP_VIRTEX5_inst : ICAP_VIRTEX5
	generic map (ICAP_WIDTH => "X8") -- "X8", "X16" or "X32"
	port map (
		BUSY => BSY, -- Busy output
		O => O, -- Data output
		CE => CE, -- Clock enable input
		CLK => clk, -- Clock input
		I => I, -- Data input
		WRITE => '0' -- Write input, 0 = write, 1 = read
	);
-- End of ICAP_VIRTEX5_inst instantiation

EEPROM_INT: eeprom_interface
	PORT MAP(
		clk	=>	clk,
		enb	=>	enb,
		d_in	=>	d_in,
		valid	=>	CE,
		done	=>	dn,
		addr	=>	addr,
		d_out(0)	=>	I(7),
		d_out(1)	=>	I(6),
		d_out(2)	=>	I(5),
		d_out(3)	=>	I(4),
		d_out(4)	=>	I(3),
		d_out(5)	=>	I(2),
		d_out(6)	=>	I(1),
		d_out(7)	=>	I(0)
	);

PROCESS
BEGIN
	WAIT UNTIL clk'EVENT AND clk = '1';
	IF cfg = '1' OR is_cfg = '1' THEN
		IF dn = '1' THEN
			is_cfg	<=	'0';
			done		<=	'1';
			busy		<=	'0';
			enb		<=	'0';
		ELSE
			is_cfg	<=	'1';
			busy		<=	'1';
			done		<=	'0';
			enb		<=	'1';
		END IF;
	ELSE
		enb		<=	'0';
		busy		<=	'0';
		is_cfg	<=	'0';
		done		<=	'0';
	END IF;
END PROCESS;

end Behavioral;
