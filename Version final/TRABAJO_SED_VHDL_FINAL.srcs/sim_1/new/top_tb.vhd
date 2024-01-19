----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.12.2023 12:15:57
-- Design Name: 
-- Module Name: top_tb - Behavioral
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

entity top_tb is
end top_tb;

architecture tb of top_tb is

    component TOP1
        port (Option     : in std_logic_vector (0 to 1);
              Encendido  : in std_logic;
              Monedas10  : in std_logic;
              Monedas20  : in std_logic;
              Monedas50  : in std_logic;
              Monedas100 : in std_logic;
              clk        : in std_logic;
              RESET      : in std_logic;
              LIGHT      : out std_logic_vector (3 downto 0);
              LED_AZUL   : out std_logic;
              BCD        : out std_logic_vector (6 downto 0);
              AN_control : out std_logic_vector (7 downto 0));
    end component;

    signal Option     : std_logic_vector (0 to 1);
    signal Encendido  : std_logic;
    signal Monedas10  : std_logic;
    signal Monedas20  : std_logic;
    signal Monedas50  : std_logic;
    signal Monedas100 : std_logic;
    signal clk        : std_logic;
    signal RESET      : std_logic;
    signal LIGHT      : std_logic_vector (3 downto 0);
    signal LED_AZUL   : std_logic;
    signal BCD        : std_logic_vector (6 downto 0);
    signal AN_control : std_logic_vector (7 downto 0);

begin
    process
    begin 
        clk<='0';
        wait for 25ns;
        clk<='1';
        wait for 25ns;
    end process;
    dut : TOP1
    port map (Option     => Option,
              Encendido  => Encendido,
              Monedas10  => Monedas10,
              Monedas20  => Monedas20,
              Monedas50  => Monedas50,
              Monedas100 => Monedas100,
              clk        => clk,
              RESET      => RESET,
              LIGHT      => LIGHT,
              LED_AZUL   => LED_AZUL,
              BCD        => BCD,
              AN_control => AN_control);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        Option <= (others => '0');
        Encendido <= '0';
        Monedas10 <= '0';
        Monedas20 <= '0';
        Monedas50 <= '0';
        Monedas100 <= '0';
        RESET <= '1';
        wait for 50ns;
        Encendido<='1';
        wait for 50ns;
        Option<="01";
        wait for 50ns;
        Monedas100<='1';
        
        wait for 50ns;
        Monedas50<='1';
        wait for 50ns;
        Monedas100<='0';
        Monedas50<='0';
        wait for 1500ns;
        reset<='0';
        wait for 200ns;
        reset<='1';
        wait for 50ns;
        Monedas100<='1';
        wait for 500ns;
       assert false
            report "Simulacion finalizada."
            severity failure;
    end process;

end tb;