----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/09/2018 10:30:26 AM
-- Design Name: 
-- Module Name: handshake_packet - Behavioral
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

entity handshake_packet is
  Port ( clk, rst : in std_logic;        
         master_in : in packet_m_type;
         master_out : out packet_m_type;
         slave_in : in packet_s_type;
         slave_out : out packet_s_type
  );
end handshake_packet;

architecture Behavioral of handshake_packet is
    signal reg0_packet, nextMux_packet : std_logic_vector(95 downto 0) := (others => '0');
    signal reg0_valid, nextMux_valid : std_logic := '0';
    
    signal enable_reg : std_logic;
begin

CL:  process(enable_reg, reg0_packet, reg0_valid, master_in.packet, master_in.valid)
  begin
  --  nextMux_data <= master_in.data;
  --  nextMux_addr <= master_in.addr;
   -- nextMux_valid <= master_in.valid;
    
    --slave_out.ready <= enable_reg;
    case enable_reg is
        when '0' =>
            -- if ready_in (delayed) is not ready, we have to store the data.
            nextMux_packet <= reg0_packet;
            nextMux_valid <= reg0_valid;
        when '1' =>
            -- if the slave is ready, transfer directly.
            nextMux_packet <= master_in.packet;
            nextMux_valid <= master_in.valid;
        when others => 
            null;
        end case;
end process;
    
reg0: process(clk, rst)
begin
    if (rst = '1') then
        master_out.packet <= (others => '0');
        master_out.valid <= '0';
        
        enable_reg <= '1';
        slave_out.ready <= '1'; -- '1';
        
        --nextMux_data <= (others => '0');
      --  nextMux_addr <= (others => '0');
      --  nextMux_valid <= '0';
    elsif rising_edge(clk) then
        -- this is based on the ready_in, but delayed with one clock cycle.
        if (enable_reg = '1') then
            reg0_packet <= master_in.packet;
            reg0_valid <= master_in.valid; 
       -- else
      --      reg0_data <= reg0_data;    
       --     reg0_addr <= reg0_addr;    
       --     reg0_valid <= reg0_valid; 
        end if;
        -- this updates the output, which is purely based on the ready in.
        if (slave_in.ready = '1') then    
            master_out.packet <= nextMux_packet;
            master_out.valid <= nextMux_valid;
       -- else
       --     nextMux_data <= nextMux_data;
       --     nextMux_addr <= nextMux_addr;
      --      nextMux_valid <= nextMux_valid;
        end if;
        -- this enable signal is always updated, to ensure correct transfer of data
        --slave_out.ready <= enable_reg;
        slave_out.ready <= slave_in.ready;
        enable_reg <= slave_in.ready;
    end if;
end process;

end Behavioral;
