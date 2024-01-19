----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2023 12:49:51
-- Design Name: 
-- Module Name: counter - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;


entity counter is
    generic (MONEDAS: positive); --Número máximo que puede contar (4 bits serían hasta 15)
port(
    CLK, reset, CE: in std_logic; --Señales de reloj, reset y chip enable
    signal count: out std_logic_vector(3 downto 0) --Señal de salida que muestra el número de monedas introducidas
    );
end counter;

architecture Behavioral of counter is

begin
    process (CLK, reset)
    variable count2: unsigned (count'range):=(others=>'0');
    begin
        if reset='0' then
        count2:= "0000";
        else if rising_edge(CLK) then
            if CE='1' then
             count2:= count2+1;
            end if;
         end if;
         end if;
         count<=std_logic_vector(count2);
    end process;
end Behavioral;
