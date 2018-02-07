----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:10:43 09/25/2017 
-- Design Name: 
-- Module Name:    ICAP_test - Behavioral 
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
library UNISIM;
use UNISIM.VComponents.all;

USE WORK.rom_pak.ALL;	--data_w should be set to 32

entity ICAP_test is
	PORT(
		CLK			:	IN		STD_LOGIC;
		CFG			:	IN		STD_LOGIC;
		SRC_SEL		:	IN		STD_LOGIC;
		DONE			:	OUT	STD_LOGIC);
end ICAP_test;

architecture Behavioral of ICAP_test is

SIGNAL	BUSY,CE	:	STD_LOGIC;
SIGNAL	I,O		:	STD_LOGIC_VECTOR(data_w - 1 DOWNTO 0);
SIGNAL	ADDRESS	:	STD_LOGIC_VECTOR(addr_w - 1 DOWNTO 0)	:=	(others	=>	'0');
SIGNAL	IS_CFG	:	STD_LOGIC;
SIGNAL	I0,I1		:	STD_LOGIC_VECTOR(data_w - 1 DOWNTO 0);

COMPONENT	rom_1 IS
	PORT(	clk	:	IN		STD_LOGIC;
			addr	:	IN		STD_LOGIC_VECTOR(addr_w - 1 DOWNTO 0);
			d_out	:	OUT	STD_LOGIC_VECTOR(data_w - 1 DOWNTO 0)
			);
END COMPONENT rom_1;

COMPONENT	rom_2 IS
	PORT(	clk	:	IN		STD_LOGIC;
			addr	:	IN		STD_LOGIC_VECTOR(addr_w - 1 DOWNTO 0);
			d_out	:	OUT	STD_LOGIC_VECTOR(data_w - 1 DOWNTO 0)
			);
END COMPONENT rom_2;

COMPONENT	gen_mux is
	Generic(
		size		:	INTEGER	:=	8
	);
	Port(
		SEL		:	in		STD_LOGIC;
		DATA_A	:	in		STD_LOGIC_VECTOR(size - 1 downto 0);
		DATA_B	:	in		STD_LOGIC_VECTOR(size - 1 downto 0);
		D_OUT		:	out 	STD_LOGIC_VECTOR(size - 1 downto 0)
	);
END	COMPONENT	gen_mux;

begin


-- ICAP_VIRTEX5: Internal Configuration Access Port
-- Virtex-5
-- Xilinx HDL Libraries Guide, version 11.2
--	Uncomment below this line to End of ICAP_VIRTEX5_inst instatiation
--	to enable ICAP
ICAP_VIRTEX5_inst : ICAP_VIRTEX5
	generic map (
		ICAP_WIDTH => "X32") -- "X8", "X16" or "X32"
	port map (
		BUSY => BUSY, -- Busy output
		O => O, -- 32-bit data output
		CE => CE, -- Clock enable input
		CLK => CLK, -- Clock input
		I => I, -- 32-bit data input
		WRITE => '0' -- Write input, 0 = write, 1 = read
	);
-- End of ICAP_VIRTEX5_inst instantiation

ROM1:	rom_1
	port map	(
		clk	=>	CLK,
		addr	=>	ADDRESS,
		d_out	=>	I0
	);
	
ROM2:	rom_2
	port map	(
		clk	=>	CLK,
		addr	=>	ADDRESS,
		d_out	=>	I1
	);

MUX: gen_mux
	generic map(data_w)
	port map (
		SEL		=>	SRC_SEL,
		DATA_A	=>	I0,
		DATA_B	=>	I1,
		D_OUT		=>	I
	);
		

PROCESS
BEGIN
	WAIT UNTIL CLK'EVENT AND CLK='1';
	IF	(CFG='1' OR IS_CFG='1')	THEN
		ADDRESS		<=	std_logic_vector(unsigned(ADDRESS) + 1);
		IF	I	=	"00000000000000000000000000001101"	THEN	-- Check if final word, ensure is same length as data_w and remove 0s to fix
			IS_CFG	<=	'0';
			DONE		<=	'1';
			CE			<=	'1';
		ELSE
			IS_CFG	<=	'1';
			DONE		<=	'0';
			CE			<=	'0';
		END	IF;
	ELSE
		CE				<=	'1';
		ADDRESS		<=	(others	=>	'0');
		IS_CFG		<=	'0';
		DONE			<=	'0';
	END	IF;
END	PROCESS;

end Behavioral;
