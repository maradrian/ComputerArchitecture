----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/05/2018 03:13:09 PM
-- Design Name: 
-- Module Name: RX_NI - Behavioral
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

entity RX_NI is
port (
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    -- *** BUS        
    slave_i : in bus_slave_type;
    master_o : out bus_master_type;
    -- *** Packet 
    m_packet_i : in packet_m_type;
    s_packet_o : out packet_s_type
     );
end RX_NI;

architecture Behavioral of RX_NI is

begin

s_packet_o.ready <= slave_i.ready;
master_o.valid <= m_packet_i.valid;
master_o.addr <= m_packet_i.packet(63 downto 32);
master_o.data <= m_packet_i.packet(31 downto 0);


end Behavioral;
