LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

ENTITY RAM128_32 IS
	PORT
	(
		address	: IN STD_LOGIC_VECTOR (6 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END RAM128_32;
ARCHITECTURE RAM OF RAM128_32 IS
	type ram_type is array (0 to 127) of std_logic_vector(31 downto 0);
	signal ram_signal : ram_type;
begin
	clock_process : process (clock) is
	begin
		if (rising_edge(clock)) then
			if (wren = '1') then
				ram_signal(to_integer(unsigned(address))) <= data;
				q <= data;
			else
				q <= ram_signal(to_integer(unsigned(address)));
			end if;
		end if;
	end process;
END RAM;