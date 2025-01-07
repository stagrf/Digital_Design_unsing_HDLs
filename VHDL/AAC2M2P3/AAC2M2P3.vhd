library ieee;
use ieee.std_logic_1164.all;

-- Entity definition
entity FSM is
   port (
      In1 : in std_logic;
      RST : in std_logic;
      CLK : in std_logic;
      Out1 : inout std_logic
   );
end FSM;

-- Architecture definition
architecture FSM_Architecture of FSM is
   -- Define states of the FSM
   type state_type is (A, B, C);
   signal current_state, next_state : state_type;  -- Current and next states

   -- Output signal based on the current state
   signal out_reg : std_logic := '0';  -- Initialize to '0'
   
begin

   -- State transition process
   State_Transition_Process: process(current_state, In1)
   begin
      -- Default output value
      out_reg <= '0';
      
      -- State transition logic
      case current_state is
         when A =>
            if (In1 = '1') then
               next_state <= B;
               out_reg <= '0';
            else
               next_state <= A;
               out_reg <= '0';
            end if;
         when B =>
            if (In1 = '0') then
               next_state <= C;
               out_reg <= '1';
            else
               next_state <= B;
               out_reg <= '0';
            end if;
         when C =>
            if (In1 = '1') then
               next_state <= A;
               out_reg <= '0';
            else
               next_state <= C;
               out_reg <= '1';
            end if;
         when others =>
            next_state <= A;
            out_reg <= '0';
      end case;
   end process State_Transition_Process;

   -- Clock and reset process
   Clock_Reset_Process: process(CLK, RST)
   begin
      if (RST = '1') then
         -- Reset to initial state (S0) and output to '0'
         current_state <= A;
         Out1 <= '0';
      elsif (CLK'event and CLK = '1') then
         -- Update the state on clock edge
         current_state <= next_state;
         Out1 <= out_reg;  -- Output the state-based signal
      end if;
   end process Clock_Reset_Process;

end FSM_Architecture;
