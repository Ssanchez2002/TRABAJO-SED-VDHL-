----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.12.2023 19:12:52
-- Design Name: 
-- Module Name: counter_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

entity counter_tb is
end counter_tb;

architecture tb of counter_tb is

    component counter
    generic (MONEDAS: positive); --Número máximo que puede contar (4 bits serían hasta 15)
        port (CLK   : in std_logic;
              reset : in std_logic;
              CE    : in std_logic;
              count : out std_logic_vector (MONEDAS-1 downto 0));
    end component;
    constant MONEDAS: positive:=4;
    signal CLK   : std_logic;
    signal reset : std_logic;
    signal CE    : std_logic;
    signal count : std_logic_vector (MONEDAS-1 downto 0);
  begin
    process
    begin 
        clk<='0';
        wait for 25ns;
        clk<='1';
        wait for 25ns;
    end process;
    dut : counter
    generic map(MONEDAS)
    port map (CLK   => CLK,
              reset => reset,
              CE    => CE,
              count => count);
    stimuli : process
    begin
        
        CE <= '0';
        reset <= '0';
        wait for 100 ns;
        reset <= '1';
        CE <= '1';
        wait for 50 ns;
        CE <= '0';
        wait for 50 ns;
        CE <= '1';
        wait for 50 ns;
        CE <= '0';
        wait for 50 ns;
        CE <= '1';
        wait for 50 ns;
        CE<='0';
        reset<='0';
        wait for 100 ns;
        reset <= '1';
        CE <= '1';
        wait for 50 ns;
        CE <= '0';
        wait for 50 ns;
        CE <= '1';
        wait for 50 ns;
        CE <= '0';
              wait for 200 ns;
         assert false
            report "Simulacion finalizada."
            severity failure;
    end process;

end tb;
