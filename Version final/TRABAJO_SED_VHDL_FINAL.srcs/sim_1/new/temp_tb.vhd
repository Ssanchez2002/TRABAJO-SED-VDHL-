----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.12.2023 19:49:53
-- Design Name: 
-- Module Name: temp_tb - Behavioral
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

entity temp_tb is
end temp_tb;

architecture tb of temp_tb is

    component temporizador
    generic(
OPCIONES: positive --Opciones de productos disponibles
);
        port (Clk      : in std_logic;
              Reset    : in std_logic;
              Opcion   : in std_logic_vector (0 to OPCIONES-1);
              Temp_out : out std_logic;
              CE       : in std_logic);
    end component;
    constant OPCIONES: positive:=2;
    signal Clk      : std_logic;
    signal Reset    : std_logic;
    signal Opcion   : std_logic_vector (0 to OPCIONES-1);
    signal Temp_out : std_logic;
    signal CE       : std_logic;

begin
    process
    begin 
        clk<='0';
        wait for 25ns;
        clk<='1';
        wait for 25ns;
    end process;
    dut : temporizador
    generic map(OPCIONES)
    port map (Clk      => Clk,
              Reset    => Reset,
              Opcion   => Opcion,
              Temp_out => Temp_out,
              CE       => CE);

    stimuli : process
    begin
        
        Reset <= '0';
        Opcion <= (others => '0');
        CE <= '0';
        wait for 50ns;
        CE<='1';
        reset<='1';
        Opcion<="01";
        wait for 500ns;
        reset<='0';
        wait for 10ns;
        reset<='1';
        Opcion<="10";
        wait for 600ns;
        
    assert false
            report "Simulacion finalizada."
            severity failure;
    end process;

end tb;