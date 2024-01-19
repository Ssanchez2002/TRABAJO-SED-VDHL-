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

entity TOP1 is
GENERIC(
MONEDAS: positive:=4; --Número de bits necesarios para representar el valor, en nuestro caso será 4 
  --porque el mayor número que necesitamos representar es 9
DISPLAY: positive:=8; --Displays de 7 segmentos disponibles
SEGMENTOS: positive:=7; --segmentos del BCD
ESTADOS: positive:=4;--número de estados totales representados en los leds
OPCIONES: positive:=2 --Opciones de productos disponibles
);
PORT ( 
 Option : IN std_logic_vector(0 to OPCIONES-1); --Entrada de seleccion de las opciones
 Encendido : in std_logic; --Interruptor de encendido
 Monedas10: in std_logic; --Entrada de monedas de 10cents
 Monedas20: in std_logic; --Entrada de monedas de 20cents
 Monedas50: in std_logic; --Entrada de monedas de 50cents
 Monedas100: in std_logic; --Entrada de monedas de 1euro
 clk, RESET: in std_logic; --Señal de reset y de reloj
 LIGHT : out std_logic_vector(ESTADOS-1 downto 0); --Leds que marcan el estado en el que se encuentra
 LED_AZUL: out std_logic; --Led indicativo de que ha terminado el temporizador y se puede recoger el producto en el estado final
 BCD: out std_logic_vector(SEGMENTOS-1 downto 0); --Segmentos del BCD
 AN_control: out std_logic_vector(DISPLAY-1 downto 0)--Selección de los distintos displays
 );
end TOP1;
architecture estructural of TOP1 is
--DECLARACIÓN DE LAS ENTIDADES NECESARIAS

--GENERADOR DE PULSOS
Component EDGEDTCTR
port(CLK : in std_logic; 
 SYNC_IN : in std_logic;
 EDGE : out std_logic
 );
 end component;
 signal edgecount10: std_logic; --Salida del generador de pulsos correspondiente a las monedas de 10cents
 signal edgecount20: std_logic; --Salida del generador de pulsos correspondiente a las monedas de 20cents
 signal edgecount50: std_logic; --Salida del generador de pulsos correspondiente a las monedas de 50cents
 signal edgecount100: std_logic; --Salida del generador de pulsos correspondiente a las monedas de 1euro
 
 --SINCRONIZADOR
 Component SYNCHRNZR
 port(CLK : in std_logic;
 ASYNC_IN : in std_logic;
 SYNC_OUT : out std_logic
 );
 end component;
 signal sync10: std_logic; --Salida del sincronizador correspondiente a las monedas de 10cents
 signal sync20: std_logic; --Salida del sincronizador correspondiente a las monedas de 20cents
 signal sync50: std_logic; --Salida del sincronizador correspondiente a las monedas de 50cents
 signal sync100: std_logic; --Salida del sincronizador correspondiente a las monedas de 1euro
 
 --CONTADOR
 Component counter
 generic (MONEDAS: positive);
 port(CLK, reset, CE: in std_logic;
    signal count: out std_logic_vector(3 downto 0)
    );
 end component;
signal count_out10: std_logic_vector(0 to MONEDAS-1); --Salida del número de monedas de 10cents
signal count_out20: std_logic_vector(0 to MONEDAS-1); --Salida del número de monedas de 10cents
signal count_out50: std_logic_vector(0 to MONEDAS-1); --Salida del número de monedas de 10cents
signal count_out100: std_logic_vector(0 to MONEDAS-1); --Salida del número de monedas de 10cents

--DECODIFICADOR
 Component decoder
 generic(
  DISPLAY: positive; --Displays de 7 segmentos disponibles
  SEGMENTOS: positive; --segmentos del BCD
  MONEDAS: positive --Número de bits necesarios para representar el valor, en nuestro caso será 4 
  --porque el mayor número que necesitamos representar es 9
);
 PORT (
decod_in1 : IN std_logic_vector(MONEDAS-1 DOWNTO 0);
decod_in2 : IN std_logic_vector(MONEDAS-1 DOWNTO 0);
decod_in3 : IN std_logic_vector(MONEDAS-1 DOWNTO 0);
led : OUT std_logic_vector(SEGMENTOS-1 DOWNTO 0);
displays: out std_logic_vector(DISPLAY-1 downto 0);
CE: in std_logic;
Clk: in std_logic
);
 end component;
 signal ce_display: std_logic; --Entrada que activa la entidad
 
 --TEMPORIZADOR
 Component temporizador
 generic(
OPCIONES: positive --Opciones de productos disponibles
);
 port(
    Clk     : in std_logic;
    CE : in std_logic;
    Reset    : in std_logic; 
    Opcion: in std_logic_vector(0 to OPCIONES-1);
    Temp_out: out std_logic
    );
 end component;
 signal ce_temporizador: std_logic; --Entrada que activa la entidad
 signal temp_out1: std_logic; --Salida que indica que ha finalizado el temporizador
 
 --MÁQUINA DE ESTADOS
 component fsm 
 generic(
  ESTADOS: positive;--número de estados totales representados en los leds
  OPCIONES: positive --Opciones de productos disponibles
  );
 port (
  RESET : in std_logic;
  ENCENDIDO : in std_logic;
  CLK : in std_logic;
  fsm_in : in std_logic_vector(0 to OPCIONES-1);
  Led : out std_logic_vector(0 TO ESTADOS-1);
  LED_AZUL: out std_logic;
  fsm_out_contador : out  std_logic;
  fsm_out_temporizador : out  std_logic;
  temp_out: in std_logic;
  dinero_out: in std_logic;
  fsm_out_display: out std_logic
  );
 end component;
 
 --ENTIDAD ENCARGADA DE TRADUCIR EL NÚMERO DE MONEDAS A SU VALOR
 Component Dinero
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
 end component;
signal ce_contador: std_logic; --Entrada que activa la entidad
signal dinero_out: std_logic; --Salida que indica que se ha alcanzado el precio del producto
signal Dinero_contar1: std_logic_vector(MONEDAS-1 downto 0); --Salida del valor de los euros
signal Dinero_contar2: std_logic_vector(MONEDAS-1 downto 0); --Salida del valor de las decenas de centimos
signal Dinero_contar3: std_logic_vector(MONEDAS-1 downto 0); --Salida del valor de las unidades de centimos (siempre 0)

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
contador1: counter 
generic map(MONEDAS)
port map(
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
contador2: counter
generic map(MONEDAS)
port map(
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
contador3: counter 
generic map(MONEDAS)
port map(
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
contador4: counter 
generic map(MONEDAS)
port map(
CLK=>clk,
reset=>reset,
CE=>edgecount100,
count=>count_out100
);

maquina_estados: fsm
generic map(ESTADOS,OPCIONES)
port map(
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
Dinero1: dinero
generic map(MONEDAS)
port map(
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
decoder1: decoder 
generic map(DISPLAY,SEGMENTOS,MONEDAS)
port map(
decod_in1=>dinero_contar1,
decod_in2=>dinero_contar2,
decod_in3=>dinero_contar3,
led=>bcd,
displays=>AN_control,
CE=>ce_display,
Clk=>clk
);
temporizador1: temporizador 
generic map(OPCIONES)
port map(
Clk=>clk,
Reset=>reset,
Opcion=>option,
Temp_out=>temp_out1,
CE=>ce_temporizador
);
end estructural;