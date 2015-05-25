---------------------------------
--- Sequence Detector for "1101"
---------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity SEQUENCE_DETECTOR is
port (
din:    in std_logic;
clk:    in std_logic;
rst:    in std_logic;
flag:   out std_logic
);
end SEQUENCE_DETECTOR;

architecture SEQDET of SEQUENCE_DETECTOR is
type state_type is (S0, S1, S2, S3, S4);
signal current_state, next_state: state_type;

-----------------------------------------------
-- Moore FSM, Flag Raised when "1101" Detected
-----------------------------------------------
begin
statereg: process(clk, rst)
begin
 if rst = '1' then
    current_state <= S0;
 elsif rising_edge(clk) then
    current_state <= next_state;
 end if;
end process;

C1: process(current_state, din)
begin
 case current_state is
 -- Epsilon
   when S0 =>
      if din = '1' then
         next_state <= S1;
      else
         next_state <= S0;
      end if;
      
   -- "1..."
   when S1 => 
     if din = '1' then
         next_state <= S2;
     else
         next_state <= S0;
     end if;
     
   -- "11..."
   when S2 =>
      if din = '0' then
         next_state <= S3;
      else
         next_state <= S2;
      end if;
      
   -- "110..."
   when S3 =>
       if din = '1' then
          next_state <= S4;
       else
          next_state <= S0;
       end if;
       
    -- "1101"
    when S4 =>
         if din = '1' then
            next_state <= S2;
         else
            next_state <= S0;
       end if;
    
    when others => null;
  end case;
end process;

C2: process(current_state)
begin
 if current_state = S4 then
    flag <= '1';
 else
    flag <= '0';
 end if;
end process;
     
end SEQDET;

