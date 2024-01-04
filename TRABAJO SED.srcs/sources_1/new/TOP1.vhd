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
 
 Monedas10: in std_logic;
 Monedas20: in std_logic;
 Monedas50: in std_logic;
 Monedas100: in std_logic;
 clk, RESET: in std_logic;
 LIGHT : out std_logic_vector(3 downto 0);
 LED_AZUL: out std_logic;
 BCD: out std_logic_vector(6 downto 0);
 AN_control: out std_logic_vector(7 downto 0)
 );
end TOP1;
architecture estructural of TOP1 is
Component EDGEDTCTR
port(CLK : in std_logic;
 SYNC_IN : in std_logic;
 EDGE : out std_logic
 );
 end component;
 Component SYNCHRNZR
 port(CLK : in std_logic;
 ASYNC_IN : in std_logic;
 SYNC_OUT : out std_logic
 );
 end component;
 Component counter
 port(CLK, reset, CE: in std_logic;
    signal count: out std_logic_vector(3 downto 0)
    );
 end component;
 Component decoder
 PORT (
decod_in1 : IN std_logic_vector(3 DOWNTO 0);
decod_in2 : IN std_logic_vector(3 DOWNTO 0);
decod_in3 : IN std_logic_vector(3 DOWNTO 0);
led : OUT std_logic_vector(6 DOWNTO 0);
displays: out std_logic_vector(7 downto 0);
CE: in std_logic;
Clk: in std_logic
);
 end component;
 Component temporizador
 port(
    Clk     : in std_logic;
    CE : in std_logic;
    Reset    : in std_logic; 
    Opcion: in std_logic_vector(0 to 1);
    Temp_out: out std_logic
    );
 end component;
 component fsm
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
 end component;
 Component Dinero
 Port ( 
    Dinero_in_10: in std_logic_vector(3 downto 0);
    Dinero_in_20: in std_logic_vector(3 downto 0);
    Dinero_in_50: in std_logic_vector(3 downto 0);
    Dinero_in_100: in std_logic_vector(3 downto 0);
    
    CE: in std_logic;
    CLK: in std_logic;
    Dinero_out: out std_logic;
    Dinero_euros: out std_logic_vector(3 downto 0);
    Dinero_centimos1: out std_logic_vector(3 downto 0);
    Dinero_centimos2: out std_logic_vector(3 downto 0);
    RESET: in std_logic
);
 end component;
--signal led1:std_logic_vector(6 downto 0);
signal sync10: std_logic;
signal edgecount10: std_logic;
signal count_out10: std_logic_vector(0 to 3);
signal sync20: std_logic;
signal edgecount20: std_logic;
signal count_out20: std_logic_vector(0 to 3);
signal sync50: std_logic;
signal edgecount50: std_logic;
signal count_out50: std_logic_vector(0 to 3);
signal sync100: std_logic;
signal edgecount100: std_logic;
signal count_out100: std_logic_vector(0 to 3);
signal ce_contador: std_logic;
signal ce_temporizador: std_logic;
signal ce_display: std_logic;
signal temp_out1: std_logic;
signal dinero_out: std_logic;
signal Dinero_contar1: std_logic_vector(3 downto 0);
signal Dinero_contar2: std_logic_vector(3 downto 0);
signal Dinero_contar3: std_logic_vector(3 downto 0);

begin

sincronizador1: SYNCHRNZR port map(
clk=>clk,
 ASYNC_IN=>monedas10,
 SYNC_OUT=>sync10
);
detectorflancos1: EDGEDTCTR port map(
CLK=>clk,
 SYNC_IN=>sync10,
 EDGE=>edgecount10
);
contador1: counter port map(
CLK=>clk,
reset=>reset,
CE=>edgecount10,
count=>count_out10
);
sincronizador2: SYNCHRNZR port map(
clk=>clk,
 ASYNC_IN=>monedas20,
 SYNC_OUT=>sync20
);
detectorflancos2: EDGEDTCTR port map(
CLK=>clk,
 SYNC_IN=>sync20,
 EDGE=>edgecount20
);
contador2: counter port map(
CLK=>clk,
reset=>reset,
CE=>edgecount20,
count=>count_out20
);
sincronizador3: SYNCHRNZR port map(
clk=>clk,
 ASYNC_IN=>monedas50,
 SYNC_OUT=>sync50
);
detectorflancos3: EDGEDTCTR port map(
CLK=>clk,
 SYNC_IN=>sync50,
 EDGE=>edgecount50
);
contador3: counter port map(
CLK=>clk,
reset=>reset,
CE=>edgecount50,
count=>count_out50
);
sincronizador4: SYNCHRNZR port map(
clk=>clk,
 ASYNC_IN=>monedas100,
 SYNC_OUT=>sync100
);
detectorflancos4: EDGEDTCTR port map(
CLK=>clk,
 SYNC_IN=>sync100,
 EDGE=>edgecount100
);
contador4: counter port map(
CLK=>clk,
reset=>reset,
CE=>edgecount100,
count=>count_out100
);

maquina_estados: fsm port map(
RESET=>reset,
ENCENDIDO=>encendido,
CLK=>clk,
fsm_in=>option,
Led=>light,
fsm_out_contador=>ce_contador,
fsm_out_temporizador=>ce_temporizador,
fsm_out_display=>ce_display,
temp_out=>temp_out1,
dinero_out=>dinero_out,
LED_AZUL=>LED_AZUL
);
Dinero1: dinero port map(
Dinero_in_10=>count_out10,
Dinero_in_20=>count_out20,
Dinero_in_50=>count_out50,
Dinero_in_100=>count_out100,

CE=>ce_contador,
Clk=>clk,
Dinero_out=>dinero_out,
Dinero_euros=>dinero_contar1,
Dinero_centimos1=>dinero_contar2,
Dinero_centimos2=>dinero_contar3,
reset=>reset
);
decoder1: decoder port map(
decod_in1=>dinero_contar1,
decod_in2=>dinero_contar2,
decod_in3=>dinero_contar3,
led=>bcd,
displays=>AN_control,
CE=>ce_display,
Clk=>clk
);
temporizador1: temporizador port map(
Clk=>clk,
Reset=>reset,
Opcion=>option,
Temp_out=>temp_out1,
CE=>ce_temporizador
);
end estructural;