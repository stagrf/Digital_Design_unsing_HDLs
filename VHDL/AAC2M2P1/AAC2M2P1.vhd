LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity AAC2M2P1 is
    port (                  
        CP:  in std_logic;          -- Clock
        SR:  in std_logic;          -- Active low, synchronous reset
        P:   in std_logic_vector(3 downto 0);  -- Parallel input
        PE:  in std_logic;          -- Parallel Enable (Load)
        CEP: in std_logic;          -- Count enable parallel input
        CET: in std_logic;          -- Count enable trickle input
        Q:   out std_logic_vector(3 downto 0); -- Count output
        TC:  out std_logic          -- Terminal Count
    );            		
end AAC2M2P1;

architecture AAC2M2P1_a of AAC2M2P1 is
    signal NUM: unsigned(3 downto 0) := (others => '0');
begin
    process(CP, SR)
    begin
        if SR = '0' then
            NUM <= (others => '0');  -- Synchronous reset
        elsif rising_edge(CP) then
            if PE = '0' then
                NUM <= unsigned(P);  -- Load parallel input
            elsif CEP = '1' and CET = '1' then
                if NUM = "1111" then
                    NUM <= (others => '0');  -- Reset on terminal count
                else
                    NUM <= NUM + 1;         -- Increment count
                end if;
            end if;
        end if;
    end process;

    -- Assign outputs
    Q <= std_logic_vector(NUM);
    TC <= '1' when NUM = "1111" else '0'; -- Terminal count flag
end AAC2M2P1_a;
