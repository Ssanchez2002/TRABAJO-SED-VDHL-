----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.12.2023 18:42:50
-- Design Name: 
-- Module Name: edgedetector_tb - Behavioral
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

entity edgedetector_tb is
end edgedetector_tb;

architecture tb of edgedetector_tb is
    component SYNCHRNZR
        port (CLK      : in std_logic;
              ASYNC_IN : in std_logic;
              SYNC_OUT : out std_logic);
    end component;
    component EDGEDTCTR
        port (CLK     : in std_logic;
              SYNC_IN : in std_logic;
              EDGE    : out std_logic);
    end component;
 

    signal CLK      : std_logic;
    signal ASYNC_IN : std_logic;
    signal SYNC_OUT : std_logic;
    signal EDGE    : std_logic;

  begin
    process
    begin 
        clk<='0';
        wait for 25ns;
        clk<='1';
        wait for 25ns;
    end process;
    dut1 : SYNCHRNZR
    port map (CLK      => CLK,
              ASYNC_IN => ASYNC_IN,
              SYNC_OUT => SYNC_OUT);
    dut2 : EDGEDTCTR
    port map (CLK     => CLK,
              SYNC_IN => SYNC_OUT,
              EDGE    => EDGE);

    process
    begin
       ASYNC_IN <= '0';
       wait for 50ns;
        async_in<='1';
        wait for 50ns;
         ASYNC_IN <= '0';
         wait for 400ns;
        async_in<='1';
        wait for 50ns;
         ASYNC_IN <= '0';
         wait for 400ns;
 assert false
            report "Simulacion finalizada."
            severity failure;
    end process;

end tb;