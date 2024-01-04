----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.12.2023 17:33:37
-- Design Name: 
-- Module Name: Decodificador - Dataflow
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


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY decoder IS
   
PORT (
decod_in1 : IN std_logic_vector(3 DOWNTO 0);
decod_in2 : IN std_logic_vector(3 DOWNTO 0);
decod_in3 : IN std_logic_vector(3 DOWNTO 0);
led : OUT std_logic_vector(6 DOWNTO 0);
displays: out std_logic_vector(7 downto 0);
CE: in std_logic;
Clk: in std_logic
);
END ENTITY decoder;
ARCHITECTURE dataflow OF decoder IS
    
    signal reloj2: std_logic:='0';
BEGIN
    process(clk,CE)
        subtype ciclos is integer range 0 to 10**8;
        
        variable reloj: ciclos;
       
    begin
        
        if rising_edge(clk) and CE='1' then
            reloj:=reloj+1;
            if reloj=10**5-1 then
                reloj:=0;
                reloj2<=not reloj2;
            end if;
        end if;
    end process;
    process(reloj2,CE,clk)
    subtype display_encender is integer range 0 to 4;
     variable display_encendido: display_encender:=3;
    begin
    if rising_edge(reloj2) and CE='1' then
        if ce='0' then 
            display_encendido:=3;
            displays<="11111111";
        else

        CASE display_encendido is
            when 0=>
                displays<="11111011";-- como la seleccion esta negada ponemos todas las cifras a 1 menos la 3 que son los euros
                case decod_in1 is
                    WHEN "0000"=>
                        led <= "0000001";
                    WHEN "0001"=>
                        led <="1001111";
                    WHEN "0010"=>
                        led <="0010010";
                    WHEN "0011"=>
                        led <="0000110";
                    WHEN others=>
                        led <="0000001";
                end case;
            when 1=>
                displays<="11111101";
                case decod_in2 is
                    WHEN "0000"=>
                        led <="0000001";
                    WHEN "0001"=>
                        led <="1001111";
                    WHEN "0010"=>
                        led <="0010010";
                    WHEN "0011"=>
                        led <="0000110";
                    WHEN "0100"=>
                        led <="1001100";
                     WHEN "0101"=>
                        led <="0100100";
                    WHEN "0110"=>
                        led <="0100000";
                    WHEN "0111"=>
                        led <="0001111";
                    WHEN "1000"=>
                        led <="0000000";
                    WHEN "1001"=>
                        led <="0000100";
                    WHEN others=>
                        led <="0000001";
                end case;
            when 2=>
                displays<="11111110";
                led<="0000001";
            when others=>
                displays<="11111111";
                led<="1111110";
         end case;
      Display_encendido:=Display_encendido+1;
        if  Display_encendido=4 then
            Display_encendido:=0;
        end if;      
     end if;
    end if;
    end process;
   end architecture dataflow;  