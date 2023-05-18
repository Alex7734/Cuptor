library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

entity Temperature_Selector is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           up  : in  STD_LOGIC;
           down : in  STD_LOGIC;
           temp : out STD_LOGIC_VECTOR(7 downto 0);
           temp_Selection : out STD_LOGIC_VECTOR(2 downto 0)
         );
end Temperature_Selector;

architecture Behavioral of Temperature_Selector is
begin

    process(clk, rst, up, down)
        variable counter : std_logic_vector(2 downto 0) := "000";
        variable temp_sel : std_logic_vector(7 downto 0) := "01100100";
    begin
        if rst = '1' then
            counter := "000";
            temp_sel := "01100100";
        elsif rising_edge(clk) then
            if up = '1' then 
                counter := counter + 1;
            elsif down = '1' then
                counter := counter - 1;
            end if;

            case counter is
                when "000" =>
                    temp_sel := "01100100"; -- temperature 100
                when "001" =>
                    temp_sel := "01110011"; -- temperature 115
                when "010" =>
                    temp_sel := "10000010"; -- temperature 130
                when "011" =>
                    temp_sel := "10010001"; -- temperature 145
                when "100" =>
                    temp_sel := "10100000"; -- temperature 160
                when "101" =>
                    temp_sel := "10101111"; -- temperature 175
                when "110" =>
                    temp_sel := "10110110"; -- temperature 190
                when "111" =>
                    temp_sel := "10111100"; -- temperature 200
                when others =>
                    temp_sel := "01100100"; -- default value
            end case;
        end if;

        temp <= temp_sel;
        temp_Selection <= counter;
    end process;

end Behavioral;
