----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.12.2023 10:20:15
-- Design Name: 
-- Module Name: decoder_tb - Behavioral
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

entity decoder_tb is
end decoder_tb;

architecture tb of decoder_tb is

    component decoder
    generic(
  DISPLAY: positive; --Displays de 7 segmentos disponibles
  SEGMENTOS: positive; --segmentos del BCD
  MONEDAS: positive --Número de bits necesarios para representar el valor, en nuestro caso será 4 
  --porque el mayor número que necesitamos representar es 9
);
        port (decod_in1 : in std_logic_vector (MONEDAS-1 downto 0);
              decod_in2 : in std_logic_vector (MONEDAS-1 downto 0);
              decod_in3 : in std_logic_vector (MONEDAS-1 downto 0);
              led       : out std_logic_vector (SEGMENTOS-1 downto 0);
              displays  : out std_logic_vector (DISPLAY-1 downto 0);
              CE        : in std_logic;
              Clk       : in std_logic);
    end component;
    constant DISPLAY: positive:=8;
    constant SEGMENTOS: positive:=7;
    constant MONEDAS: positive:=4;
    signal decod_in1 : std_logic_vector (3 downto 0);
    signal decod_in2 : std_logic_vector (MONEDAS-1 downto 0);
    signal decod_in3 : std_logic_vector (MONEDAS-1 downto 0);
    signal led       : std_logic_vector (SEGMENTOS-1 downto 0);
    signal displays  : std_logic_vector (DISPLAY-1 downto 0);
    signal CE        : std_logic;
    signal Clk       : std_logic;

begin
    process
    begin 
        clk<='0';
        wait for 25ns;
        clk<='1';
        wait for 25ns;
    end process;
    dut : decoder
    generic map(DISPLAY,SEGMENTOS,MONEDAS)
    port map (decod_in1 => decod_in1,
              decod_in2 => decod_in2,
              decod_in3 => decod_in3,
              led       => led,
              displays  => displays,
              CE        => CE,
              Clk       => Clk);

    stimuli : process
    begin
        
        decod_in1 <= (others => '0');
        decod_in2 <= (others => '0');
        decod_in3 <= (others => '0');
        CE <= '0';
        wait for 50ns;
        decod_in1<="0001";
        decod_in2<="0010";
        decod_in3<="0011";
        wait for 50ns;
         CE <= '1';
         decod_in1<="0001";
        decod_in2<="0010";
        decod_in3<="0011";
        wait for 700ns;
        ce<='0';
        wait for 100ns;
         ce<='1';
         wait for 500ns;
        -- EDIT Add stimuli here
        assert false
            report "Simulacion finalizada."
            severity failure;
    end process;

end tb;
