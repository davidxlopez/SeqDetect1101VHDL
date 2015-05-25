------------------------------------------
-- Sequence Detector Testbench for "1101"
------------------------------------------ 
library IEEE;
use IEEE.std_logic_1164.all;

entity TB_SEQUENCE_DETECTOR is
end TB_SEQUENCE_DETECTOR;

architecture TESTBENCH of TB_SEQUENCE_DETECTOR is
component SEQUENCE_DETECTOR is
port (
din     : in std_logic;
clk     : in std_logic;
rst     : in std_logic;
flag    : out std_logic
);
end component;

signal	 din     : std_logic;
signal	 rst     : std_logic := '0';
signal	 flag    : std_logic;
signal	 clk     : std_logic := '0';

constant clk_period : time := 10ns;

type state_type is (S0, S1, S2, S3, S4);
signal current_state    : state_type;
signal next_state       : state_type;

begin
DUT: SEQUENCE_DETECTOR
port map (
din => din,
clk => clk,
rst => rst,
flag => flag
);

clk_process: process
begin
  clk <= '0';
  wait for clk_period/2;
  clk <= '1';
  wait for clk_period/2;
end process;

din <= '0',
 '1' after 10ns,
 '0' after 20ns,
 '1' after 30ns,
 '0' after 40ns,
 '0' after 50ns,
 '1' after 60ns,
 '1' after 70ns,
 '0' after 80ns,
 '1' after 90ns,   -- Raise Flag
 '0' after 100ns,
 '0' after 110ns,
 '0' after 120ns,
 '1' after 130ns,
 '0' after 140ns,
 '1' after 150ns,
 '1' after 160ns,
 '0' after 170ns,
 '1' after 180ns,  -- Raise Flag
 '0' after 190ns,
 '1' after 200ns,
 '0' after 210ns,
 '0' after 220ns,
 '1' after 230ns,
 '0' after 240ns,
 '1' after 250ns,
 '0' after 260ns,
 '1' after 270ns,
 '0' after 280ns,
 '1' after 290ns,
 '0' after 300ns; 
     
end TESTBENCH;

