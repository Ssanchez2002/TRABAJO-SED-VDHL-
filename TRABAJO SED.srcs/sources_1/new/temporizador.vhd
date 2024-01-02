----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2023 11:45:21
-- Design Name: 
-- Module Name: temporizador - Behavioral
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
use ieee.numeric_std.all;
  
entity temporizador is
generic(ClockFrequencyHz : integer);
port(
    Clk     : in std_logic;
    Reset    : in std_logic; 
    Opcion: in std_logic_vector(0 to 1);
    Temp_out: out std_logic
    );
    
end entity temporizador;
  
architecture behavioral of temporizador is
  
   
    signal Ticks : integer;
    signal temp_out1: std_logic;
    signal Segundos: integer;
    constant t1: integer:= 3;
    constant t2: integer:= 5;
begin
  
    process(Clk) is
    begin
        if rising_edge(Clk) then
            if Reset = '1' then
                Ticks   <= 0;
                Segundos <= 0;
            else
                if Ticks = 10**8 - 1 then
                    Ticks <= 0;
                    Segundos <= Segundos + 1;
                else
                    Ticks <= Ticks + 1;
                end if;
            end if;
        end if;
        if rising_edge(Clk) then
            case Opcion is
                when "01" =>
                    if Segundos=t1 then 
                        temp_out1<='1';
                    end if;
                when "10" =>
                    if Segundos=t2 then 
                        temp_out1<='1';
                    end if;
                when others =>
                    temp_out1<='0';
            end case;
        end if;
    end process;
  temp_out<=temp_out1;
end architecture;
