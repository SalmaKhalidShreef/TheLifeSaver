library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clk_gen is
port ( clk: in std_logic;
clock_out: out std_logic);
end clk_gen;

architecture Behavioral of clk_gen is

signal count: integer:=1;
signal tmp : std_logic := '0';
  
begin
  
process(clk)
begin

if(clk'event and clk='1') then
count <=count+1;
if (count = 25000) then
tmp <= NOT tmp;
count <= 1;
end if;
end if;

clock_out <= tmp;
end process;
   

end Behavioral;