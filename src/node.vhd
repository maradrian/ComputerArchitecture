----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/18/2018 10:51:22 AM
-- Design Name: 
-- Module Name: node - Behavioral
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
use Ieee.std_logic_unsigned.all;


entity node is
port (
  -- Reset & Clock
  rst : in STD_LOGIC;
  clk : in STD_LOGIC;
  
  -- North Tx Packet Interface
  node_north_packet_out : out packet_m_type;    -- router_north_packet_out : out packet_m_type;
  node_north_ready_in : in packet_s_type;       -- router_north_ready_in: in packet_s_type;
  
  -- North Rx Packet Interface
  node_north_packet_in : in packet_m_type;      -- router_north_packet_in : in packet_m_type;
  node_north_ready_out : out packet_s_type;     -- router_north_ready_out: out packet_s_type;

  -- East Tx Packet Interface
  node_east_packet_out : out packet_m_type;     -- router_east_packet_out : out packet_m_type;
  node_east_ready_in : in packet_s_type;        -- router_east_ready_in: in packet_s_type;
  
  -- East Rx Packet Interface
  node_east_packet_in : in packet_m_type;       -- router_east_packet_in : in packet_m_type;
  node_east_ready_out : out packet_s_type;      -- router_east_ready_out: out packet_s_type;

  -- South Tx Packet Interface
  node_south_packet_out : out packet_m_type;    -- router_south_packet_out : out packet_m_type;
  node_south_ready_in : in packet_s_type;       -- router_south_ready_in: in packet_s_type;
  
  -- South Rx Packet Interface             
  node_south_packet_in : in packet_m_type;      -- router_south_packet_in : in packet_m_type;
  node_south_ready_out : out packet_s_type;     -- router_south_ready_out: out packet_s_type;

  -- West Tx Packet Interface
  node_west_packet_out : out packet_m_type;     -- router_west_packet_out : out packet_m_type;
  node_west_ready_in : in packet_s_type;        -- router_west_ready_in: in packet_s_type;
  
  -- West Rx Packet Interface
  node_west_packet_in : in packet_m_type;       -- router_west_packet_in : in packet_m_type;
  node_west_ready_out : out packet_s_type;      -- router_west_ready_out: out packet_s_type;
  
  
  
  
  -- Local Tx Bus Interface
  node_local_bus_out : out bus_master_type;   -- router_local_packet_out : out packet_m_type;
  node_local_bus_ready_in : in bus_slave_type;     -- router_local_ready_in: in packet_s_type

  -- Local Rx Bus Interface
  node_local_bus_in : in bus_master_type ;     -- router_local_packet_in : in packet_m_type;
  node_local_bus_ready_out : out bus_slave_type;   -- router_local_ready_out: out packet_s_type;

  -- Route look-up table
  node_lut_addr : out std_logic_vector (3 DOWNTO 0);     -- Destination address, 4-bit
  node_lut_route : in std_logic_vector (20 DOWNTO 0) );  -- Routing information, 21-bit
end node;


architecture node_arch of node is

    signal node_local_packet_out, node_local_packet_in : packet_m_type;
    signal node_local_ready_in, node_local_ready_out: packet_s_type;

component router
port( 
  clk, rst : in std_logic;

  -- North input
  router_north_packet_in : in packet_m_type;
  router_north_ready_out: out packet_s_type;
  -- North output
  router_north_packet_out : out packet_m_type;
  router_north_ready_in: in packet_s_type;

  -- East input
  router_east_packet_in : in packet_m_type;
  router_east_ready_out: out packet_s_type;
  -- East output
  router_east_packet_out : out packet_m_type;
  router_east_ready_in: in packet_s_type;

  -- South input
  router_south_packet_in : in packet_m_type;
  router_south_ready_out: out packet_s_type;
  -- South output
  router_south_packet_out : out packet_m_type;
  router_south_ready_in: in packet_s_type;

  -- West input
  router_west_packet_in : in packet_m_type;
  router_west_ready_out: out packet_s_type;
  -- West output
  router_west_packet_out : out packet_m_type;
  router_west_ready_in: in packet_s_type;
  
  -- Local input
  router_local_packet_in : in packet_m_type;
  router_local_ready_out: out packet_s_type;
  -- Local output
  router_local_packet_out : out packet_m_type;
  router_local_ready_in: in packet_s_type
);
end component;

component ni
port (
  clk : in STD_LOGIC;
  rst : in STD_LOGIC;

  -- Tx bus interface
  slave_NI_out : out bus_slave_type;
  master_NI_in : in bus_master_type;

  -- Tx packet interface
  m_packet : out packet_m_type;
  s_packet : in packet_s_type;

  -- Tx look_up table
  dst_addr : out std_logic_vector (3 DOWNTO 0);     -- Destination address, 4-bit
  route : in std_logic_vector (20 DOWNTO 0);    -- Routing information, 21-bit

  -- Rx bus interface
  slave_i  : in bus_slave_type;
  master_o : out bus_master_type;

  -- Rx packet interface
  m_packet_i : in packet_m_type;
  s_packet_o : out packet_s_type );
end component;

begin

dut2 : router
port map( 
  clk => clk,
  rst => rst,

  -- North input
  router_north_packet_in => node_north_packet_in,
  router_north_ready_out => node_north_ready_out,
  -- North output
  router_north_packet_out => node_north_packet_out,
  router_north_ready_in => node_north_ready_in,

  -- East input
  router_east_packet_in => node_east_packet_in,
  router_east_ready_out => node_east_ready_out,
  -- East output
  router_east_packet_out => node_east_packet_out,
  router_east_ready_in => node_east_ready_in,
  
  -- South input
  router_south_packet_in => node_south_packet_in,
  router_south_ready_out => node_south_ready_out,
  -- South output
  router_south_packet_out => node_south_packet_out,
  router_south_ready_in => node_south_ready_in,

  -- West input
  router_west_packet_in => node_west_packet_in,
  router_west_ready_out => node_west_ready_out,

  -- West output
  router_west_packet_out => node_west_packet_out,
  router_west_ready_in => node_west_ready_in,

  -- Local input
  router_local_packet_in => node_local_packet_in,
  router_local_ready_out => node_local_ready_out,
  -- Local output
  router_local_packet_out => node_local_packet_out,
  router_local_ready_in => node_local_ready_in
);

NI_x: ni
port map(
  clk => clk,
  rst => rst,

  -- Tx bus interface
  slave_NI_out => node_local_bus_ready_out, --node_local_bus_ready_in, -- : out bus_slave_type;
  master_NI_in => node_local_bus_in, --node_local_bus_out, -- : in bus_master_type;

  -- Tx packet interface
  m_packet => node_local_packet_in, -- : out packet_m_type;
  s_packet => node_local_ready_out,-- : in packet_s_type;

  -- Tx look_up table
  dst_addr => node_lut_addr,
  route => node_lut_route,

  -- Rx bus interface
  slave_i => node_local_bus_ready_in, -- : in bus_slave_type;
  master_o => node_local_bus_out, -- : out bus_master_type;

  -- Rx packet interface
  m_packet_i => node_local_packet_out, -- : in packet_m_type;
  s_packet_o => node_local_ready_in --: out packet_s_type 
);

end node_arch;
