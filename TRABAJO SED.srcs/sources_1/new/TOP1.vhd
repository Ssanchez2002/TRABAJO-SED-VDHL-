----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.11.2023 16:21:32
-- Design Name: 
-- Module Name: TOP1 - Behavioral
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

entity TOP1 is
PORT ( 
 Option : IN std_logic_vector(0 to 1);
 Encendido : in std_logic;
 Monedas: in std_logic_vector(3 downto 0);
 clk, RESET: in std_logic;
 LIGHT : out std_logic_vector(2 downto 0);
 BCD: out std_logic_vector(6 downto 0)
 );
end TOP1;
architecture estructural of TOP1 is
Component EDGEDTCTR
port(CLK : in std_logic;
 EDGE_IN : in std_logic_vector(0 to 1);
 EDGE_OUT : out std_logic_vector(0 to 1)
 );
 end component;
 Component SYNCHRNZR
 port(CLK : in std_logic;
 SYNC_IN : in std_logic_vector(0 to 1);
 SYNC_OUT : out std_logic_vector(0 to 1)
 );
 end component;
 component GESTION
 PORT ( 
 Option : IN std_logic_vector(1 downto 0);
 Encendido : in std_logic;
 Monedas: in std_logic_vector(3 downto 0);
 clk, RESET: in std_logic;
 Led : out std_logic_vector(2 downto 0);
 BCD: out std_logic_vector(6 downto 0)
 );
 end component;
--signal led1:std_logic_vector(6 downto 0);
signal sync: std_logic_vector(0 to 1);
signal edgecount: std_logic_vector(0 to 1);
begin

sincronizador1: SYNCHRNZR port map(
clk=>clk,
 SYNC_IN=>option,
 SYNC_OUT=>sync
);
detectorflancos: EDGEDTCTR port map(
CLK=>clk,
 EDGE_in=>sync,
 EDGE_out=>edgecount
);
gestion1: GESTION port map(
option=>edgecount,
encendido=>encendido,
monedas=>monedas,
clk=>clk,
reset=>reset,
led=>LIGHT,
BCD=>bcd
 );
end estructural;