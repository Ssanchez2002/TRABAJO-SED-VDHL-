----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.12.2023 18:54:13
-- Design Name: 
-- Module Name: GESTION - structural
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

entity GESTION is
PORT ( 
 Option : IN std_logic_vector(1 downto 0);
 Encendido : in std_logic;
 Monedas: in std_logic_vector(3 downto 0);
 clk, RESET: in std_logic;
 Led : out std_logic_vector(2 downto 0);
 BCD: out std_logic_vector(6 downto 0)
 );
end GESTION;
architecture estructural of GESTION is
Component fsm
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
end component;
 component counter
port(
    CLK, reset, CE: in std_logic;
    signal count_out: out std_logic_vector(3 downto 0);
    monedas: in std_logic_vector(3 downto 0)
    );
 end component;
 component decoder
PORT (
decod_in : IN std_logic_vector(3 DOWNTO 0);
led : OUT std_logic_vector(6 DOWNTO 0)
);
 end component;
signal fsm_out: std_logic_vector(3 downto 0);
signal count_out: std_logic_vector(3 downto 0);

begin
fsm1: fsm port map(
 RESET=>reset,
 ENCENDIDO=>encendido,
 Monedas=>monedas,
 clk=>clk,
 fsm_in=>option,
 led=>led,
 fsm_out=>fsm_out,
 count_out=>count_out
);
counter1: counter port map(
CLK=>clk,
reset=>reset,
count_out=>count_out,
monedas=>fsm_out,
ce=>encendido
);
decoder1: decoder port map(
decod_in=>count_out,
led=>bcd
);

end estructural;
