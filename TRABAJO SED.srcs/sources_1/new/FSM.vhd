----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.11.2023 15:36:09
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity fsm is
  port (
  RESET : in std_logic;
  ENCENDIDO : in std_logic;
  Monedas: in std_logic_vector(3 downto 0);
  CLK : in std_logic;
  fsm_in : in std_logic_vector(0 to 1);
  Led : out std_logic_vector(0 TO 2);
  fsm_out : out  std_logic_vector(3 downto 0);
  count_out: in std_logic_vector(3 downto 0)
  );
end fsm;
architecture behavioral of fsm is
  type STATES is (APAGADO,ESPERA, PAGAR, ESPERA2);
  signal current_state: STATES := APAGADO;
  signal next_state: STATES;
  begin
  state_register: process (RESET, CLK)
  begin
         if reset='1' then
             current_state<=APAGADO;
         elsif clk'event and clk='1' then
             current_state<=next_state;
         end if;        
  end process;

  nextstate_decod: process (ENCENDIDO, current_state, fsm_in)
     begin
          next_state <= current_state;
          case current_state is
          when APAGADO =>
             if ENCENDIDO = '1' then
                 next_state <= ESPERA;
             end if;
          when ESPERA =>
             if fsm_in = "01" then
                next_state <= PAGAR;
             elsif fsm_in = "10" then
                next_state <= PAGAR;
             end if;
  when PAGAR =>
  case monedas is 
    when "0001" =>
        fsm_out<="0001";
     when "0010" =>
        fsm_out<="0010";
     when "0100" =>
        fsm_out<="0100";
     when "1000" =>
        fsm_out<="1000";
   end case;
  if count_out = "1010" then
  next_state <= ESPERA2;
  end if;
  when ESPERA2 =>
  led(0)<='1';
  led(0)<='0';
  led(1)<='1';
  if reset= '1' then
  led(1)<='0';
  next_state <= ESPERA;
  end if;
  when others =>
  next_state <= ESPERA;
  end case;
  end process;
end behavioral;
 