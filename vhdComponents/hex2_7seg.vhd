LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY hex2_7seg IS
  PORT (
  	hex_in : in std_logic_vector(3 downto 0);
  	a_b_c_d_e_f_g : out std_logic_vector(6 downto 0)
    );
END hex2_7seg;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF hex2_7seg IS

BEGIN

a_b_c_d_e_f_g <=   "0000001" when hex_in = x"0" else
                   "1001111" when hex_in = x"1" else
                   "0010010" when hex_in = x"2" else
                   "0000110" when hex_in = x"3" else
                   "1001100" when hex_in = x"4" else
                   "0100100" when hex_in = x"5" else
                   "0100000" when hex_in = x"6" else
                   "0001111" when hex_in = x"7" else
                   "0000000" when hex_in = x"8" else
                   "0000100" when hex_in = x"9" else
                   "0001000" when hex_in = x"A" else
                   "1100000" when hex_in = x"B" else
                   "0110000" when hex_in = x"C" else
                   "1000010" when hex_in = x"D" else 
                   "0110000" when hex_in = x"E" else
                   "0111000" when hex_in = x"F" else
                   "1111111";

END TypeArchitecture;