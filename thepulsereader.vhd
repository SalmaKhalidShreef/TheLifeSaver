library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_unsigned.all;
   
  use ieee.std_logic_arith.all;
  
  Entity thepulsereader  is 
  port(
  analog : in bit;
  clk : in STD_LOGIC ;
  abnormalpulse,normalpulse: out bit:= '0' ;
  segment1,segment2,segment3 :out STD_LOGIC_VECTOR (0 to 6)
  );
  end thepulsereader;
  
  Architecture behaviour of thepulsereader is 
  
  signal passed15 :STD_logic; 
  signal pulse15 :integer   ;
  signal pulsefinal : integer   ;
  signal pulse :bit;
  signal prescaler : integer range 0 to 1000;
  signal seconds : integer range 0 to 15;
  signal number :integer; 
  signal unit : integer;
  signal ten :integer;
  signal hundredth :integer;
  
  

	 
  
  begin
   
  process (clk)
  
  
  begin
  
    If clk' EVENT and clk = '1' then
	 IF (prescaler < 1000) then
     prescaler <= prescaler +1;
	 ELSE 
	 prescaler <= 0;
	 seconds <= seconds +1;
	END if;
	
	IF seconds = 15 then
      seconds <= 0;
	   passed15 <= '1';
	 END if;
	 
	 pulse <=  analog;
	 if pulse ='1' then
	 pulse15 <=  pulse15 +1; 
	 end if ;
	 
	 
  
   
  if (passed15 = '1') then ---after 15 seconds
   
   
   pulsefinal <=  pulse15 * 4;
   pulse15 <= 0;
   
	passed15<='0';
  
  end if ;
  
  end if;
  
  end process;
  
  
  process (pulsefinal)
  begin
  if (pulsefinal < 120)then
    if (pulsefinal < 60)then
	 abnormalpulse <='1';
    normalpulse <='0';
	 else
	  abnormalpulse <='0';
     normalpulse <='1'; 
  end if;
   else
   normalpulse <='0'; 
   abnormalpulse <='1';
	 end if;

	 
	 
	 
	 
	 
	 number <= pulsefinal;
  
   
  
  
  if(number>=100) then
  hundredth <= (number) - (number mod (100)) ;
  else
  hundredth<=0;
  end if;
  
  if(number>=10) then
  ten <= (number mod (100)) - (number mod (10));
  else
  ten<=0;
  end if;
  
  unit <= number mod (10);
 
  
   
  
  case unit is
when 0 => segment1 <= "0000001";  -- 0
when 1 => segment1 <= "1001111" ; -- 1
when 2 => segment1 <= "0010010" ; -- 2
when 3 => segment1 <= "0000110" ; -- 3
when 4 => segment1 <= "1001100" ; -- 4
when 5 => segment1 <= "0100100" ; -- 5
when 6 => segment1 <= "0100000" ; -- 6
when 7 => segment1 <= "0001111" ; -- 7
when 8 => segment1 <= "0000000" ; -- 8
when 9 => segment1 <= "0000100" ; -- 9
when others => segment1 <= "1111110";
end case;



case ten is
when 0 => segment2 <= "0000001";  -- 0
when 10 => segment2 <= "1001111" ; -- 1
when 20 => segment2 <= "0010010" ; -- 2
when 30 => segment2 <= "0000110" ; -- 3
when 40 => segment2 <= "1001100" ; -- 4
when 50 => segment2 <= "0100100" ; -- 5
when 60 => segment2 <= "0100000" ; -- 6
when 70 => segment2 <= "0001111" ; -- 7
when 80 => segment2 <= "0000000" ; -- 8
when 90 => segment2 <= "0000100" ; -- 9
when others => segment2 <= "1111110";
end case;

case hundredth is
when 0   => segment3 <= "0000001";  -- 0
when 100 => segment3 <= "1001111" ; -- 1
when 200 => segment3 <= "0010010" ; -- 2
when 300 => segment3 <= "0000110" ; -- 3
when 400 => segment3 <= "1001100" ; -- 4
when 500 => segment3 <= "0100100" ; -- 5
when 600 => segment3 <= "0100000" ; -- 6
when 700 => segment3 <= "0001111" ; -- 7
when 800 => segment3 <= "0000000" ; -- 8
when 900 => segment3 <= "0000100" ; -- 9
when others => segment3 <= "1111110";
end case;
   
  end process;
  end behaviour;