----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2023 13:26:30
-- Design Name: 
-- Module Name: DINERO - Behavioral
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

USE ieee.std_logic_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DINERO is
generic(
 MONEDAS: positive --Número de bits necesarios para representar el valor, en nuestro caso será 4 
  --porque el mayor número que necesitamos representar es 9
);
Port ( 
    Dinero_in_10: in std_logic_vector(MONEDAS-1 downto 0);
    Dinero_in_20: in std_logic_vector(MONEDAS-1 downto 0);
    Dinero_in_50: in std_logic_vector(MONEDAS-1 downto 0);
    Dinero_in_100: in std_logic_vector(MONEDAS-1 downto 0);
    CE: in std_logic;
    CLK: in std_logic;
    Dinero_out: out std_logic;
    Dinero_euros: out std_logic_vector(MONEDAS-1 downto 0);
    Dinero_centimos1: out std_logic_vector(MONEDAS-1 downto 0);
    Dinero_centimos2: out std_logic_vector(MONEDAS-1 downto 0);
    RESET: in std_logic
);
end DINERO;

architecture Behavioral of DINERO is

begin

process (Dinero_in_10,clk,Dinero_in_20,Dinero_in_50,Dinero_in_100)
subtype dinero is integer range 0 to 10;
variable Cuenta_euros: dinero:=0;
variable Cuenta_cents1: dinero:=0;
variable Cuenta_cents2: std_logic_vector(0 to MONEDAS-1);
variable Dinero_out1: std_logic;
    begin
    
        if reset='0'  then
        Cuenta_euros:= 0;
        Cuenta_cents1:= 0;
        Cuenta_cents2:= "0000";
        Dinero_out1:='0';
            else if rising_edge(CLK) then
                if CE='1' then
                        Cuenta_cents1:=to_integer(unsigned(Dinero_in_10))+2*to_integer(unsigned(Dinero_in_20))+5*to_integer(unsigned(Dinero_in_50));
                        Cuenta_euros:=to_integer(unsigned(Dinero_in_100));
                        if Cuenta_cents1>9 then
                            Cuenta_euros:=Cuenta_euros+1;
                            Cuenta_cents1:=Cuenta_cents1-10;
                        end if;
                        if (Cuenta_euros=1 and Cuenta_cents1>=2) then
                            Cuenta_euros:=Cuenta_euros-1;
                            Cuenta_cents1:=Cuenta_cents1-2;
                            Dinero_out1:='1';
                        else if Cuenta_euros>=2 then
                            Cuenta_euros:=Cuenta_euros-1;
                                   case Cuenta_cents1 is
                                        when 0=>
                                            Cuenta_euros:=Cuenta_euros-1;
                                            Cuenta_cents1:=8;
                                            Dinero_out1:='1';
                                        when 1=>
                                            Cuenta_euros:=Cuenta_euros-1;
                                            Cuenta_cents1:=9;
                                            Dinero_out1:='1';
                                        when others=>
                                            Cuenta_cents1:=Cuenta_cents1-2;
                                            Dinero_out1:='1';
                                    end case;
                                end if;
                               
                        end if;
                end if;
            end if;
         end if;
         Dinero_centimos2<="0000";
         Dinero_centimos1<=std_logic_vector(to_unsigned(Cuenta_cents1,Dinero_centimos1'length));
         Dinero_euros<=std_logic_vector(to_unsigned(Cuenta_euros,Dinero_euros'length));
         Dinero_out<=Dinero_out1;
    end process;

end Behavioral;
