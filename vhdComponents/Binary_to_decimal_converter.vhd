LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;

ENTITY Binary_to_decimal_converter IS
  PORT (
 Bin_num: in std_logic_vector(7 downto 0);
  		Unit: out std_logic_vector(3 downto 0);
  		Decimal: out std_logic_vector(3 downto 0)  
    );
END Binary_to_decimal_converter;

ARCHITECTURE comport OF Binary_to_decimal_converter IS

signal num_int: integer:=0;
signal u,z: integer:=0;
BEGIN

	num_int<=conv_integer(bin_num);
	z<=num_int / 10;
	u<=num_int rem 10;
	process(u)
	begin
		case u is
		when 0 => unit <= x"0";
		when 1 => unit <= x"1";
		when 2 => unit <= x"2";
		when 3 => unit <= x"3";
		when 4 => unit <= x"4";
		when 5 => unit <= x"5";
		when 6 => unit <= x"6";
		when 7 => unit <= x"7";
		when 8 => unit <= x"8";
		when 9 => unit <= x"9";
		when others => unit <=x"f";
		end case;
	end process;
	process(z)
	begin
		case z is
		when 0 => Decimal <= x"0";
		when 1 => Decimal <= x"1";
		when 2 => Decimal <= x"2";
		when 3 => Decimal <= x"3";
		when 4 => Decimal <= x"4";
		when 5 => Decimal <= x"5";
		when 6 => Decimal <= x"6";
		when 7 => Decimal <= x"7";
		when 8 => Decimal <= x"8";
		when 9 => Decimal <= x"9";
		when others => Decimal <=x"f";
		end case;
	end process;
		 

	
END comport;
