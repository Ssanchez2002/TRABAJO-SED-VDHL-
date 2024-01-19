----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.12.2023 18:17:18
-- Design Name: 
-- Module Name: sync_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sync_tb is
--  Port ( );
end sync_tb;

architecture tb of sync_tb is

    component SYNCHRNZR
        port (CLK      : in std_logic;
              ASYNC_IN : in std_logic;
              SYNC_OUT : out std_logic);
    end component;

    signal CLK      : std_logic;
    signal ASYNC_IN : std_logic;
    signal SYNC_OUT : std_logic;

 begin
    process
    begin 
        clk<='0';
        wait for 25ns;
        clk<='1';
        wait for 25ns;
    end process;
    
    dut : SYNCHRNZR
    port map (CLK      => CLK,
              ASYNC_IN => ASYNC_IN,
              SYNC_OUT => SYNC_OUT);
    stimuli : process
    begin
       ASYNC_IN <= '0';
       wait for 50ns;
        async_in<='1';
        wait for 50ns;
         ASYNC_IN <= '0';
        wait for 50ns;
        async_in<='1';
         wait for 50ns;
         ASYNC_IN <= '0';
         wait for 50ns;
        async_in<='1';
        wait for 50ns;
         ASYNC_IN <= '0';
        wait for 50ns;
        async_in<='1';
         wait for 50ns;
         ASYNC_IN <= '0';
         wait for 200ns;
         assert false
            report "Simulacion finalizada."
            severity failure;
           end process;

end tb;
