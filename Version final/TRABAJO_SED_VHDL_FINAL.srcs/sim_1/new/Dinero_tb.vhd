----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.12.2023 19:33:47
-- Design Name: 
-- Module Name: Dinero_tb - Behavioral
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

entity Dinero_tb is
end Dinero_tb;

architecture tb of Dinero_tb is

    component DINERO
    generic(
 MONEDAS: positive --Número de bits necesarios para representar el valor, en nuestro caso será 4 
  --porque el mayor número que necesitamos representar es 9
);
        port (Dinero_in_10     : in std_logic_vector (MONEDAS-1 downto 0);
              Dinero_in_20     : in std_logic_vector (MONEDAS-1 downto 0);
              Dinero_in_50     : in std_logic_vector (MONEDAS-1 downto 0);
              Dinero_in_100    : in std_logic_vector (MONEDAS-1 downto 0);
              CE               : in std_logic;
              CLK              : in std_logic;
              Dinero_out       : out std_logic;
              Dinero_euros     : out std_logic_vector (MONEDAS-1 downto 0);
              Dinero_centimos1 : out std_logic_vector (MONEDAS-1 downto 0);
              Dinero_centimos2 : out std_logic_vector (MONEDAS-1 downto 0);
              RESET            : in std_logic);
    end component;
    constant MONEDAS: positive:=4;
    signal Dinero_in_10     : std_logic_vector (MONEDAS-1 downto 0);
    signal Dinero_in_20     : std_logic_vector (MONEDAS-1 downto 0);
    signal Dinero_in_50     : std_logic_vector (MONEDAS-1 downto 0);
    signal Dinero_in_100    : std_logic_vector (MONEDAS-1 downto 0);
    signal CE               : std_logic;
    signal CLK              : std_logic;
    signal Dinero_out       : std_logic;
    signal Dinero_euros     : std_logic_vector (MONEDAS-1 downto 0);
    signal Dinero_centimos1 : std_logic_vector (MONEDAS-1 downto 0);
    signal Dinero_centimos2 : std_logic_vector (MONEDAS-1 downto 0);
    signal RESET            : std_logic;

begin
    process
    begin 
        clk<='0';
        wait for 25ns;
        clk<='1';
        wait for 25ns;
    end process;
    dut : DINERO
    generic map(MONEDAS)
    port map (Dinero_in_10     => Dinero_in_10,
              Dinero_in_20     => Dinero_in_20,
              Dinero_in_50     => Dinero_in_50,
              Dinero_in_100    => Dinero_in_100,
              CE               => CE,
              CLK              => CLK,
              Dinero_out       => Dinero_out,
              Dinero_euros     => Dinero_euros,
              Dinero_centimos1 => Dinero_centimos1,
              Dinero_centimos2 => Dinero_centimos2,
              RESET            => RESET);

    stimuli : process
    begin
        
        Dinero_in_10 <= (others => '0');
        Dinero_in_20 <= (others => '0');
        Dinero_in_50 <= (others => '0');
        Dinero_in_100 <= (others => '0');
        CE <= '0';
        RESET <= '0';
        wait for 100 ns;
        reset<='1';
        Ce<='1';
        Dinero_in_10<="0001";
        wait for 40ns;
        Dinero_in_20<="0001";
        wait for 50ns;
        Dinero_in_50<="0001";
        wait for 40ns;
        Dinero_in_100<="0001";
        wait for 40ns;
        reset<='0';
        Dinero_in_10<="0000";
        Dinero_in_20<="0000";
        Dinero_in_50<="0000";
        Dinero_in_100<="0000";
        wait for 40ns;
        reset<='1';
        Dinero_in_100<="0010";
        wait for 300ns;
        assert false
            report "Simulacion finalizada."
            severity failure;
        end process;

end tb;
