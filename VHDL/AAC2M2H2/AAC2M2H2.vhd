library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FIFO8x9 is
   port(
      clk, rst       : in std_logic;                    -- Clock and reset
      RdPtrClr, WrPtrClr : in std_logic;                -- Pointer clear signals
      RdInc, WrInc   : in std_logic;                    -- Increment signals
      DataIn         : in std_logic_vector(8 downto 0); -- Input data
      DataOut        : out std_logic_vector(8 downto 0);-- Output data
      rden, wren     : in std_logic                     -- Read and write enables
   );
end entity FIFO8x9;

architecture RTL of FIFO8x9 is
   -- Signal declarations
   type fifo_array is array(7 downto 0) of std_logic_vector(8 downto 0);
   signal fifo    : fifo_array;
   signal wrptr   : unsigned(2 downto 0);
   signal rdptr   : unsigned(2 downto 0);
   signal en      : std_logic_vector(7 downto 0);
   signal dmuxout : std_logic_vector(8 downto 0);
begin

   -- Reading process
   read_proc: process (clk) begin
      if (rden = '1') then
         dmuxout <= fifo(to_integer(rdptr));
      else
         dmuxout <= (others => 'Z');
      end if;
   end process read_proc;

   -- Incrementing read pointer
   read_point_inc: process(clk, RdInc) begin
      if rising_edge(clk) then
         if (RdInc = '1') then
            rdptr <= rdptr + 1;
         end if;
      end if;
   end process read_point_inc;

   -- Clear read pointer
   clear_read_pointer: process(clk, RdPtrClr) begin
      if rising_edge(clk) then
         if (RdPtrClr = '1') then
            rdptr <= (others => '0');
         end if;
      end if;
   end process clear_read_pointer;

   -- Writing process
   write_proc: process (clk, wren) begin
      if rising_edge(clk) then
         if (wren = '1') then
            fifo(to_integer(wrptr)) <= DataIn;  -- Corrected to use wrptr instead of rdptr
         end if;
      end if;
   end process write_proc;

   -- Incrementing writing pointer
   write_point_inc: process(clk, WrInc) begin
      if rising_edge(clk) then
         if (WrInc = '1') then  -- Corrected from RdIWrIncnc to WrInc
            wrptr <= wrptr + 1;
         end if;
      end if;
   end process write_point_inc;

   -- Clear write pointer
   clear_write_pointer: process(clk, WrPtrClr) begin
      if rising_edge(clk) then
         if (WrPtrClr = '1') then
            wrptr <= (others => '0');
         end if;
      end if;
   end process clear_write_pointer;

   -- Assign DataOut
   DataOut <= dmuxout;

end architecture RTL;
