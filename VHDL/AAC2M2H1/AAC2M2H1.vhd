LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ALU IS
PORT( Op_code : IN STD_LOGIC_VECTOR( 2 DOWNTO 0 );
A, B : IN STD_LOGIC_VECTOR( 31 DOWNTO 0 );
Y : OUT STD_LOGIC_VECTOR( 31 DOWNTO 0 ) );
END ALU;

ARCHITECTURE ALU_ARCH OF ALU IS 

begin
	with Op_code select 
		Y <= A when "000",
		     A + B when "001",
		     A - B when "010",
		     A and B when "011",
		     A or B when "100",
		     STD_LOGIC_VECTOR(unsigned(A) + 1) when "101",
		     STD_LOGIC_VECTOR(unsigned(A) - 1) when "110",
		     B when others ;
END ARCHITECTURE; 