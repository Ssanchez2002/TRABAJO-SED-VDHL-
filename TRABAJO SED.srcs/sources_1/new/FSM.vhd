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
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;
entity fsm is
  port (
  RESET : in std_logic;
  ENCENDIDO : in std_logic;
  CLK : in std_logic;
  fsm_in : in std_logic_vector(0 to 1);
  Led : out std_logic_vector(0 TO 3);
  LED_AZUL: out std_logic;
  fsm_out_contador : out  std_logic;
  fsm_out_temporizador : out  std_logic;
  temp_out: in std_logic;
  dinero_out: in std_logic;
  fsm_out_display: out std_logic
  );
end fsm;

architecture behavioral of fsm is
  type STATES is (APAGADO,ESPERA, PAGAR, ESPERA2, LISTO);
  signal current_state: STATES := APAGADO;
  signal next_state: STATES;
   begin
  
  state_register: process (RESET, CLK)
  begin
         if reset='0' then
             current_state<=APAGADO;
            
         elsif clk'event and clk='1' then
             if Encendido='1' then
             current_state<=next_state;
             else 
             current_state<=apagado;
             end if;
         end if;        
  end process;

  nextstate_decod: process (ENCENDIDO, current_state,fsm_in)
     begin
     next_state<=current_state;
     LED_AZUL <= '0';
         case current_state is
          when APAGADO =>
             fsm_out_display<='0';
             fsm_out_contador<='0';
             fsm_out_temporizador<='0';
             if ENCENDIDO = '1' then
                 next_state <= ESPERA;
             else 
                next_state<=apagado;
             end if;
          when ESPERA =>
              fsm_out_display<='0';
             fsm_out_contador<='0';
             fsm_out_temporizador<='0';
             led(3)<='0';
             led(2)<='0';
             led(1)<='1';
             led(0)<='0';
             LED_AZUL <= '0';
             if Encendido='0' then
                next_state<=apagado;
             elsif fsm_in = "01" then
               
                next_state <= PAGAR;
             elsif fsm_in = "10" then
                next_state <= PAGAR;
                
             else 
                next_state<=ESPERA;
             end if;
  when PAGAR =>
             led(3)<='0';
             led(2)<='1';
             led(1)<='0';
             led(0)<='0';
             LED_AZUL <= '0';
                fsm_out_contador<='1';
                fsm_out_display<='1';
  if Encendido='0' then
                next_state<=apagado;
  elsif Encendido= '1' and Dinero_out= '1' then 
                next_state<=espera2;
                fsm_out_contador<='0';
                fsm_out_display<='1';
  else
    next_state<=pagar;
  end if;
  when ESPERA2 =>
             led(3)<='1';
             led(2)<='0';
             led(1)<='0';
             led(0)<='0';
             LED_AZUL <= '0';
   fsm_out_temporizador<='1';
   fsm_out_contador<='0';
   fsm_out_display<='1';

   
  if temp_out = '1'  then
  next_state <= ESPERA;
  end if;
  if reset= '0' then
  next_state <= ESPERA;
  end if;
  
  when LISTO =>
             led(3)<='0';
             led(2)<='0';
             led(1)<='0';
             led(0)<='0';  
             LED_AZUL <= '1';
  
  if reset= '0' or fsm_in = "01" or fsm_in = "10" then
  next_state <= ESPERA;
  else
  next_state<= LISTO;
  end if;
  when others =>
  next_state <= ESPERA;
  end case;
  end process;
 output_decod: process (current_state)
 begin
 LED <= (OTHERS => '0');
 LED_AZUL <= '0';
 case current_state is
    when APAGADO =>  
             led(3)<='0';
             led(2)<='0';
             led(1)<='0';
             led(0)<='1';
             LED_AZUL <= '0';  
    when ESPERA =>  
             led(3)<='0';
             led(2)<='0';
             led(1)<='1';
             led(0)<='0';
             LED_AZUL <= '0'; 
    when PAGAR =>  
             led(3)<='0';
             led(2)<='1';
             led(1)<='0';
             led(0)<='0';
             LED_AZUL <= '0';
    when ESPERA2 =>  
             led(3)<='1';
             led(2)<='0';
             led(1)<='0';
             led(0)<='0';
             LED_AZUL <= '0'; 
    when LISTO =>  
             led(3)<='0';
             led(2)<='0';
             led(1)<='0';
             led(0)<='0';
             LED_AZUL <= '1';            
  end case;
  end process;          
 end behavioral;
 