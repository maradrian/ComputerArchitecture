----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/04/2018 11:17:03 AM
-- Design Name: 
-- Module Name: NI - Behavioral
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
Use Ieee.std_logic_unsigned.all;

entity TX_NI is
    Port (
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
 -- *** BUS        
    slave_NI_out : out bus_slave_type;
    master_NI_in : in bus_master_type;
 -- *** Packet 
    m_packet : out packet_m_type;
    s_packet : in packet_s_type;

--  Look-up table
    dst_addr_in : out std_logic_vector (3 DOWNTO 0);     -- Destination address, 4-bit
    route_out   : in std_logic_vector (20 DOWNTO 0)    -- Routing information, 21-bit
     );
end TX_NI;

architecture Behavioral of TX_NI is
    signal route : std_logic_vector(20 downto 0);
    signal packet_NI : std_logic_vector(95 downto 0);
    signal valid_NI : std_logic;
         
begin

  dst_addr_in <= master_NI_in.addr(31 downto 28);
  route <= route_out;

m_packet.packet <= "00000000000" & route & master_NI_in.addr & (master_NI_in.data); 
m_packet.valid <= master_NI_in.valid;
slave_NI_out.ready <= s_packet.ready;

end Behavioral;
