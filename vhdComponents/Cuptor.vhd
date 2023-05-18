library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Cuptor is
    Port (
        clk          : in  STD_LOGIC;
        rst          : in  STD_LOGIC;
        start        : in  STD_LOGIC;
        sel          : in  STD_LOGIC_VECTOR(2 downto 0);
        preheating   : out STD_LOGIC;
        insertFood   : out STD_LOGIC;
        ck           : out STD_LOGIC;
        counter5_out : out STD_LOGIC_VECTOR(2 downto 0);
        counter30_out: out STD_LOGIC_VECTOR(4 downto 0)
    );
end Cuptor;

architecture Behavioral of Cuptor is
    type state_type is (IDLE, PRE_HEATING, INSERT_FOOD, COOKING);
    signal state, next_state : state_type;
    signal max_count : std_logic_vector(3 downto 0) := "0101";
    signal counter5 : std_logic_vector(2 downto 0) := "101";
    signal counter30 : std_logic_vector(4 downto 0) := "11110";
    signal cook : std_logic := '0';
    signal donePreheat : std_logic := '0';
    signal counterPreheat : std_logic_vector(3 downto 0) := "0000";
begin

    -- Next state logic
    NEXT_STATE_LOGIC: process(state, start, counter30, counter5, donePreheat, sel)
    begin
        next_state <= state;
        case state is
            when IDLE =>
                if start = '1' then
                    next_state <= PRE_HEATING;
                end if;
            when PRE_HEATING =>
                if donePreheat = '1' then
                    next_state <= INSERT_FOOD;
                end if;
            when INSERT_FOOD =>
                if start = '1' then
                    next_state <= COOKING;
                elsif counter5 = "000" then
                    next_state <= IDLE;
                end if;
            when COOKING =>
                if counter30 = "00000" then
                    next_state <= IDLE;
                end if;
        end case;
    end process;

    -- Output logic for each state
    OUTPUT_LOGIC: process(clk, rst)
    begin

        if rst = '1' then
            state <= IDLE;
            counter5 <= "101";
            counter30 <= "11110";
            max_count <= "0101";
            cook <= '0';
            preheating <= '0';
            insertFood <= '0';
            counterPreheat <= "0000";
            donePreheat <= '0';
        elsif rising_edge(clk) then
            state <= next_state;
            case state is
                when IDLE =>
                    preheating <= '0';
                    insertFood <= '0';
                    cook <= '0';
                    counter5 <= "101";
                    counter30 <= "11110";
                    donePreheat <= '0';

	                case sel is
		                when "000" =>
		                    max_count <= "0101"; -- 5 seconds
		                when "001" =>
		                    max_count <= "0110"; -- 6 seconds
		                when "010" =>
		                    max_count <= "0111"; -- 7 seconds
		                when "011" =>
		                    max_count <= "1000"; -- 8 seconds
		                when "100" =>
		                    max_count <= "1001"; -- 9 seconds
		                when "101" =>
		                    max_count <= "1010"; -- 10 seconds
		                when "110" =>
		                    max_count <= "1011"; -- 11 seconds
		                when "111" =>
		                    max_count <= "1100"; -- 12 seconds
		                when others =>
		                    max_count <= "0101"; -- 5 seconds
	                end case;
                    
                when PRE_HEATING =>
                    preheating <= '1';
                    insertFood <= '0';
                    if counterPreheat = max_count then
                        donePreheat <= '1';
                        counterPreheat <= "0000";
                    else
                        counterPreheat <= counterPreheat + 1;
                    end if;
                    
                when INSERT_FOOD =>
                    donePreheat <= '0';
                    preheating <= '0';
                    insertFood <= '1';
                    if counter5 /= "000" then
                        counter5 <= counter5 - 1;
                    end if;
                    
                when COOKING =>
                    preheating <= '0';
                    insertFood <= '0';
                    cook <= '1';
                    if counter30 /= "00000" then
                        counter30 <= counter30 - 1;
                    end if;
            end case;
        end if;
    end process;

    counter5_out <= counter5;
    counter30_out <= counter30;
    ck <= cook;
end Behavioral;
