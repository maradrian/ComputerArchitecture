----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/17/2018 08:54:55 PM
-- Design Name: 
-- Module Name: splitter_top - Behavioral
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

entity splitter_top is
    port( 
          clk, rst : in std_logic;
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
end splitter_top;

architecture Behavioral of splitter_top is

component splitter
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
          west_ready_in: in packet_s_type
);
end component;

  COMPONENT fifo IS
    GENERIC ( WIDTH : positive := 2 );
    PORT (
      clk, rst : in std_logic;
      mPacket_in : in packet_m_type;
      mPacket_out : out packet_m_type;
      sReady_in: in packet_s_type;
      sReady_out: out packet_s_type );
  END COMPONENT;
  
  signal packet_inFromFifo : packet_m_type;
  signal ready_outToFifo : packet_s_type;
  
begin
split : splitter
	port map(
	    mPacket_in => packet_inFromFifo,
        sReady_out => ready_outToFifo,
        --Local output
        local_mPacket_out => local_mPacket_out,
        local_ready_in => local_ready_in,
        --North output
        north_mPacket_out => north_mPacket_out,
        north_ready_in => north_ready_in,
        --East output
        east_mPacket_out => east_mPacket_out,
        east_ready_in => east_ready_in,
        --South output
        south_mPacket_out => south_mPacket_out,
        south_ready_in.ready => south_ready_in.ready,
        --West output
        west_mPacket_out => west_mPacket_out,
        west_ready_in => west_ready_in
);

ib : fifo
port map(
    rst => rst,
    clk => clk,
    mPacket_in => mPacket_in,
    sReady_out => sReady_out,
    mPacket_out => packet_inFromFifo,
    sReady_in => ready_outToFifo 
    );

end Behavioral;
