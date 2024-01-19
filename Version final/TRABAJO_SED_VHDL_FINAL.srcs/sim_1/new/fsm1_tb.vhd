----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.12.2023 10:39:02
-- Design Name: 
-- Module Name: fsm1_tb - Behavioral
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

entity fsm_tb is
end fsm_tb;

architecture tb of fsm_tb is

    component fsm
    generic(
  ESTADOS: positive;--número de estados totales representados en los leds
  OPCIONES: positive --Opciones de productos disponibles
  );
        port (RESET                : in std_logic;
              ENCENDIDO            : in std_logic;
              CLK                  : in std_logic;
              fsm_in               : in std_logic_vector (0 to OPCIONES-1);
              Led                  : out std_logic_vector (0 to ESTADOS-1);
              LED_AZUL             : out std_logic;
              fsm_out_contador     : out std_logic;
              fsm_out_temporizador : out std_logic;
              temp_out             : in std_logic;
              dinero_out           : in std_logic;
              fsm_out_display      : out std_logic);
    end component;
    constant ESTADOS:positive:=4;
    constant OPCIONES:positive:=2;
    signal RESET                : std_logic;
    signal ENCENDIDO            : std_logic;
    signal CLK                  : std_logic;
    signal fsm_in               : std_logic_vector (0 to OPCIONES-1);
    signal Led                  : std_logic_vector (0 to ESTADOS-1);
    signal LED_AZUL             : std_logic;
    signal fsm_out_contador     : std_logic;
    signal fsm_out_temporizador : std_logic;
    signal temp_out             : std_logic;
    signal dinero_out           : std_logic;
    signal fsm_out_display      : std_logic;

begin
    process
    begin 
        clk<='0';
        wait for 25ns;
        clk<='1';
        wait for 25ns;
    end process;
    dut : fsm
    generic map(ESTADOS, OPCIONES)
    port map (RESET                => RESET,
              ENCENDIDO            => ENCENDIDO,
              CLK                  => CLK,
              fsm_in               => fsm_in,
              Led                  => Led,
              LED_AZUL             => LED_AZUL,
              fsm_out_contador     => fsm_out_contador,
              fsm_out_temporizador => fsm_out_temporizador,
              temp_out             => temp_out,
              dinero_out           => dinero_out,
              fsm_out_display      => fsm_out_display);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        RESET <= '0';
        ENCENDIDO <= '0';
        fsm_in <= (others => '0');
        temp_out <= '0';
        dinero_out <= '0';
        wait for 50ns;
         RESET <= '1';
         wait for 50ns;
         RESET <= '0';
         wait for 50ns;
         RESET <= '1';
         wait for 50ns;
        ENCENDIDO <= '1';
        wait for 50ns;
        fsm_in <="01";
        wait for 50ns;
        dinero_out<='1';
        wait for 50ns;
        RESET <= '0';
        dinero_out<='0';
         wait for 50ns;
         RESET <= '1';
         wait for 100ns;
         dinero_out<='1';
         wait for 100ns;
         temp_out<='1';
         wait for 100ns;
         reset<='0';
         wait for 100ns;
        assert false
            report "Simulacion finalizada."
            severity failure;
    end process;

end tb;
