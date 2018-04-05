----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/10/2018 01:09:36 PM
-- Design Name: 
-- Module Name: splitter - Behavioral
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
use work.noc_types.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity splitter is
    port( 
          mPacket_in : in packet_m_type;
          sReady_out: out packet_s_type;
          --Local output
          local_mPacket_out : out packet_m_type;
          local_ready_in: in packet_s_type;
          --North output
          north_mPacket_out : out packet_m_type;
          north_ready_in: in packet_s_type;
          --South output
          south_mPacket_out : out packet_m_type;
          south_ready_in: in packet_s_type;
          --East output
          east_mPacket_out : out packet_m_type;
          east_ready_in: in packet_s_type;
          --West output
          west_mPacket_out : out packet_m_type;
          west_ready_in: in packet_s_type);
end splitter;

architecture Behavioral of splitter is
begin

route: process(mPacket_in, local_ready_in, north_ready_in, east_ready_in, south_ready_in, west_ready_in)
begin
    local_mPacket_out.valid <= '0';
    north_mPacket_out.valid <= '0';
    east_mPacket_out.valid <= '0';
    south_mPacket_out.valid <= '0';
    west_mPacket_out.valid <= '0';
    
    local_mPacket_out.packet <= (others => '0');
    north_mPacket_out.packet <= (others => '0');
    east_mPacket_out.packet <= (others => '0');
    south_mPacket_out.packet <= (others => '0');
    west_mPacket_out.packet <= (others => '0');
    
    case mPacket_in.packet(73 downto 72) is
        when "11" => --local
            sReady_out.ready <= local_ready_in.ready;
            local_mPacket_out.valid <= mPacket_in.valid;
            if local_ready_in.ready = '1' and mPacket_in.valid = '1' then
                local_mPacket_out.packet <= mPacket_in.packet(95 downto 74) & to_stdlogicvector(to_bitvector(mPacket_in.packet(73 downto 64)) rol 2) & mPacket_in.packet(63 downto 0);
            end if;
        when "01" => --south
            sReady_out.ready <= south_ready_in.ready;
            south_mPacket_out.valid <= mPacket_in.valid;
            if south_ready_in.ready = '1' and mPacket_in.valid = '1' then
                south_mPacket_out.packet <= mPacket_in.packet(95 downto 74) & to_stdlogicvector(to_bitvector(mPacket_in.packet(73 downto 64)) rol 2) & mPacket_in.packet(63 downto 0);
            end if;
        when "10" => --east
            sReady_out.ready <= east_ready_in.ready;
            east_mPacket_out.valid <= mPacket_in.valid;
            if east_ready_in.ready = '1' and mPacket_in.valid = '1' then
                east_mPacket_out.packet <= mPacket_in.packet(95 downto 74) & to_stdlogicvector(to_bitvector(mPacket_in.packet(73 downto 64)) rol 2) & mPacket_in.packet(63 downto 0);
            end if;
        when others =>
        --north + west  
            null;
    end case;     
end process;

end Behavioral;
