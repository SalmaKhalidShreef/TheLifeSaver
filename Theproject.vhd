library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
Entity Theproject is 

port(
  temp_in : in bit := '0';
  analog_in : in bit := '0' ;
  clock : in STD_LOGIC ;
 
  seg1: out STD_LOGIC_VECTOR (0  to 6);
  seg2 :out STD_LOGIC_VECTOR (0 to 6);
  seg3 :out STD_LOGIC_VECTOR(0  to 6);
   
  abnormal :out bit;
  normal : out bit
	);
	
	end Theproject;
ARCHITECTURE behaviour of Theproject is

  signal c_out : STD_LOGIC;
  signal abnormal_temp : bit;
  signal abnormalalarm : bit;
  signal normal_temp :bit;
  signal normalalarm :bit;
  signal ab :bit;
  signal no :bit;

 component  thepulsereader 
 
  port(analog : in bit;
          clk : in STD_LOGIC ;
      
        abnormalpulse,normalpulse : out bit ;
		  
		  
		  segment1,segment2,segment3 :out STD_LOGIC_VECTOR (0 to 6)
		  );		 
		  
 end component;
 
 
 component clk_gen 
   
  port ( clk: in std_logic;
  clock_out: out std_logic);

 

end component;
 
  
 begin 
 
  
	
   
 
 process(c_out)
 
  begin
  if  c_out'event and  c_out = '1' then 
  
  if temp_in = '1'then 
  abnormal_temp <= '1';
  normal_temp <= '0';
  
   else
  abnormal_temp <= '0';
  normal_temp <= '1';
  
  end if ;
  

  
  end if;
  
    
 
  
 end process;
 
   pulse: thepulsereader port map (analog_in,  c_out , abnormalalarm, normalalarm  ,seg1, seg2,seg3);
	
	clocky: clk_gen port map (clock,c_out);
 
   ab <= abnormalalarm or abnormal_temp  ;
   no <=  normalalarm and normal_temp  ;
   abnormal <= ab;
   normal <= no;
 

 
  end behaviour;