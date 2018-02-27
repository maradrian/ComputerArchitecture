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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity splitter is
    port( mPacket_in : in packet_m_type;
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
signal allRoute : bit_vector(20 downto 0);
signal resultRoute : std_logic_vector(20 downto 0);
signal finalPacket : std_logic_vector(95 downto 0);
signal direction : std_logic_vector(2 downto 0);

begin

--direction <= mPacket_in.packet(84 downto 82);
--allRoute <= to_bitvector(mPacket_in.packet(84 downto 64));

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
    
    case mPacket_in.packet(84 downto 82) is
        when "100" => --local
            sReady_out.ready <= local_ready_in.ready;
            local_mPacket_out.valid <= mPacket_in.valid;
            if local_ready_in.ready = '1' and mPacket_in.valid = '1' then
                local_mPacket_out.packet <= mPacket_in.packet(95 downto 85) & to_stdlogicvector(to_bitvector(mPacket_in.packet(84 downto 64)) rol 3) & mPacket_in.packet(63 downto 0);
                --local_mPacket_out.packet <= mPacket_in.packet(95 downto 85) & to_stdlogicvector(allRoute rol 3) & mPacket_in.packet(63 downto 0);
            end if;
        when "000" => --north
            sReady_out.ready <= north_ready_in.ready;
            north_mPacket_out.valid <= mPacket_in.valid;
            if north_ready_in.ready = '1' and mPacket_in.valid = '1' then
                north_mPacket_out.packet <= mPacket_in.packet(95 downto 85) & to_stdlogicvector(to_bitvector(mPacket_in.packet(84 downto 64)) rol 3) & mPacket_in.packet(63 downto 0);
                --north_mPacket_out.packet <= mPacket_in.packet(95 downto 85) & to_stdlogicvector(allRoute rol 3) & mPacket_in.packet(63 downto 0);
            end if;
        when "010" => --south
            sReady_out.ready <= south_ready_in.ready;
            south_mPacket_out.valid <= mPacket_in.valid;
            if south_ready_in.ready = '1' and mPacket_in.valid = '1' then
                south_mPacket_out.packet <= mPacket_in.packet(95 downto 85) & to_stdlogicvector(to_bitvector(mPacket_in.packet(84 downto 64)) rol 3) & mPacket_in.packet(63 downto 0);
                --south_mPacket_out.packet <= mPacket_in.packet(95 downto 85) & to_stdlogicvector(allRoute rol 3) & mPacket_in.packet(63 downto 0);
            end if;
        when "001" => --east
            sReady_out.ready <= east_ready_in.ready;
            east_mPacket_out.valid <= mPacket_in.valid;
            if east_ready_in.ready = '1' and mPacket_in.valid = '1' then
                east_mPacket_out.packet <= mPacket_in.packet(95 downto 85) & to_stdlogicvector(to_bitvector(mPacket_in.packet(84 downto 64)) rol 3) & mPacket_in.packet(63 downto 0);
                --east_mPacket_out.packet <= mPacket_in.packet(95 downto 85) & to_stdlogicvector(allRoute rol 3) & mPacket_in.packet(63 downto 0);
            end if;
        when "011" => --west
            sReady_out.ready <= west_ready_in.ready;
            west_mPacket_out.valid <= mPacket_in.valid;
            if west_ready_in.ready = '1' and mPacket_in.valid = '1' then
                west_mPacket_out.packet <= mPacket_in.packet(95 downto 85) & to_stdlogicvector(to_bitvector(mPacket_in.packet(84 downto 64)) rol 3) & mPacket_in.packet(63 downto 0);
                --west_mPacket_out.packet <= mPacket_in.packet(95 downto 85) & to_stdlogicvector(allRoute rol 3) & mPacket_in.packet(63 downto 0);
            end if;
        when others => 
            null;
    end case;
        
end process;

end Behavioral;
