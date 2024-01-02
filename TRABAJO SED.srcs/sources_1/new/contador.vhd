----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.12.2023 17:32:17
-- Design Name: 
-- Module Name: contador - Behavioral
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
port(
    CLK, reset, CE: in std_logic;
    signal count_out: out std_logic_vector(3 downto 0);
    monedas: in std_logic_vector(3 downto 0)
    );
end counter;

architecture Behavioral of counter is

begin
    process (CLK, reset)
    variable count2: unsigned (count_out'range):=(others=>'0');
    begin
        if reset='0' then
        count2:= "0000";
        else if rising_edge(CLK) then
        --
        case monedas is
            when "0001" =>
                if CE='1' then
                count2:= count2+1; --Introducimos la moneda de 10cent
                end if;
            when "0010" =>
                if CE='1' then
                count2:= count2+2; --Introducimos la moneda de 20cents
                end if;
            when "0100" =>
                if CE='1' then
                count2:= count2+5; --Introducimos la moneda de 50cents
                end if;
            when "1000" =>
                if CE='1' then
                count2:= count2+10; --Introducimos la moneda de 1 euro
                end if;
            when others =>
                count2:=count2;
         end case;
         end if;
         end if;
         count_out<=std_logic_vector(count2);
    end process;
end Behavioral;
