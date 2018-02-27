library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use work.noc_types.all;

entity mux_arbiter is 
port( 
    clk, rst : in std_logic;

    grant : in std_logic_vector(2 downto 0);
    
    -- Mux 1st in, 00
    first_mPacket_in : in packet_m_type;
    first_sReady_out: out packet_s_type;

    -- Mux 2nd in, 01
    second_mPacket_in : in packet_m_type;
    second_sReady_out: out packet_s_type;

    -- Mux 3rd in, 10
    third_mPacket_in : in packet_m_type;
    third_sReady_out: out packet_s_type;

    -- Mux 4th in, 11
    fourth_mPacket_in : in packet_m_type;
    fourth_sReady_out: out packet_s_type;

    -- Mux out  
    mPacket_out : out packet_m_type;    
    sReady_in: in packet_s_type
);
end mux_arbiter;

architecture mux_arbiter_arch of mux_arbiter is
begin 
  
  --Grant signal evaluation
  grant_eval: process(grant, sReady_in.ready,
                      first_mPacket_in.valid, first_mPacket_in.packet,
                      second_mPacket_in.valid, second_mPacket_in.packet,
                      third_mPacket_in.valid, third_mPacket_in.packet,
                      fourth_mPacket_in.valid, fourth_mPacket_in.packet)
    begin  

      first_sReady_out.ready <= '0';
      second_sReady_out.ready <= '0';
      third_sReady_out.ready <= '0';
      fourth_sReady_out.ready <= '0';

      if grant="000" then
        mPacket_out.valid <= first_mPacket_in.valid;
        mPacket_out.packet <= first_mPacket_in.packet;
        first_sReady_out.ready <= sReady_in.ready;

      elsif grant="001" then
        mPacket_out.valid <= second_mPacket_in.valid;
        mPacket_out.packet <= second_mPacket_in.packet;
        second_sReady_out.ready <= sReady_in.ready;
       
      elsif grant="010" then
        mPacket_out.valid <= third_mPacket_in.valid;
        mPacket_out.packet <= third_mPacket_in.packet;
        third_sReady_out.ready <= sReady_in.ready;
        
      elsif grant="011" then
        mPacket_out.valid <= fourth_mPacket_in.valid;
        mPacket_out.packet <= fourth_mPacket_in.packet;
        fourth_sReady_out.ready <= sReady_in.ready;
        
      elsif grant="111" then
        mPacket_out.valid <= '0';
        mPacket_out.packet <= (others =>'0');
      end if;
        
    end process grant_eval;

end mux_arbiter_arch;