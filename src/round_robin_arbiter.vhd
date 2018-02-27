library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use work.noc_types.all;

entity round_robin_arbiter is 
port( 
    --Arbiter takes clk and rst, four valid signals, ready signal, 
    clk, rst : in std_logic;
    sReady_in: in packet_s_type;
    --1st, 00
    first_valid_in : in std_logic;
    --2nd, 01
    second_valid_in : in std_logic;
    --3rd, 10
    third_valid_in : in std_logic;
    --4th, 11
    fourth_valid_in : in std_logic;
    --Arbiter passes grant signal to mux_arbiter
    grant: out std_logic_vector(2 downto 0)
);
end round_robin_arbiter;


architecture arch of round_robin_arbiter is
type state_type is (s1,s2,s3,s4);
signal state, next_state : state_type;
    
begin    
    -- Combinational
    priority: process (state, first_valid_in, second_valid_in, third_valid_in, fourth_valid_in, sReady_in.ready)
    begin
       grant <= "111";
       next_state <= state;
       case state is
         when s1 =>
           if(sReady_in.ready ='1') then
               if (first_valid_in ='1') then 
                    grant <= "000";
                    next_state <= s2;
               elsif (second_valid_in ='1') then
                    grant <= "001";
                    next_state <= s3;
               elsif (third_valid_in ='1') then
                    grant <= "010";
                    next_state <= s4;
               elsif (fourth_valid_in ='1') then
                    grant <= "011"; 
                    next_state <= s1;             
               end if;
               
           end if;
          
        when s2 =>   
          if(sReady_in.ready ='1') then   
               if (second_valid_in ='1') then
                    grant <= "001";
                    next_state <= s3;
               elsif (third_valid_in ='1') then
                    grant <= "010";
                    next_state <= s4;
               elsif (fourth_valid_in ='1') then
                    grant <= "011"; 
                    next_state <= s1; 
               elsif (first_valid_in ='1') then 
                    grant <= "000";
                    next_state <= s2;            
               end if;
           end if;
           
          when s3 =>
            if(sReady_in.ready ='1') then
               if (third_valid_in ='1') then
                    grant <= "010";
                    next_state <= s4;
               elsif (fourth_valid_in ='1') then
                    grant <= "011"; 
                    next_state <= s1; 
               elsif (first_valid_in ='1') then 
                    grant <= "000";
                    next_state <= s2; 
               elsif (second_valid_in ='1') then
                    grant <= "001";
                    next_state <= s3;           
               end if;
            end if;
              
          when s4 =>
            if(sReady_in.ready ='1') then
               if (fourth_valid_in ='1') then
                    grant <= "011"; 
                    next_state <= s1; 
                elsif (first_valid_in ='1') then 
                    grant <= "000";
                    next_state <= s2; 
                elsif (second_valid_in ='1') then
                    grant <= "001";
                    next_state <= s3;           
                elsif (third_valid_in ='1') then
                    grant <= "010";
                    next_state <= s4;
                end if;
           end if;
           
      end case;
    end process priority;
    
    
    --Update registers
    reg: process (clk, rst)
    begin  
        if (rst = '1') then   
          state <= s1;
        elsif rising_edge(clk) then  
          state <= next_state;
        end if;
    end process reg;

end arch;