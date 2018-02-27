
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.noc_types.all;
use ieee.numeric_std.all;
use Ieee.std_logic_unsigned.all;


entity ni is
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
end ni;


architecture ni_arch of ni is

  component TX_NI is
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
    route_out   : in std_logic_vector (20 DOWNTO 0) ); -- Routing information, 21-bit
  end component;
  
component handshake_bus 
  port (
    clk: in  STD_LOGIC;
    rst: in  STD_LOGIC;
    master_in : in bus_master_type;
    master_out : out bus_master_type;
    slave_in : in bus_slave_type;
    slave_out : out bus_slave_type
   );
  end component;


  component handshake_packet 
  port ( clk, rst : in std_logic;        
      master_in : in packet_m_type;
      master_out : out packet_m_type;
      slave_in : in packet_s_type;
      slave_out : out packet_s_type
  );
  end component;
  
  component RX_NI is
  port (
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    -- *** BUS        
    slave_i : in bus_slave_type;
    master_o : out bus_master_type;
    -- *** Packet 
    m_packet_i : in packet_m_type;
    s_packet_o : out packet_s_type );
  end component;

signal data_inFrom_TX_ni, data_outTo_RX_ni : packet_m_type;
signal slave_outTo_TX_ni, slave_inFrom_RX_ni : packet_s_type;
signal slaveTx_toBus, slave_outTo_RX_ni : bus_slave_type;
signal bus_toTX_ni, data_inFrom_RX_ni: bus_master_type;


  begin

    u1 : TX_NI port map (
      clk => clk,
      rst => rst,
      slave_NI_out => slaveTx_toBus,
      master_NI_in => bus_toTX_ni,
      m_packet => data_inFrom_TX_ni,
      s_packet => slave_outTo_TX_ni,
      dst_addr_in => dst_addr,
      route_out => route );

    u2 : RX_NI port map (
      clk => clk,
      rst => rst,          
      slave_i => slave_outTo_RX_ni,
      master_o => data_inFrom_RX_ni,  
      m_packet_i => data_outTo_RX_ni,
      s_packet_o => slave_inFrom_RX_ni );
      
    u3 : handshake_bus port map( --T_Generator --> TX_ni
        clk => clk,
        rst => rst,
        slave_in => slaveTx_toBus,
        master_in => master_NI_in,
        slave_out => slave_NI_out,
        master_out => bus_toTX_ni
    );
    
    u_3 : handshake_bus port map( --RX_ni --> T_Receiver
        clk => clk,
        rst => rst,
        slave_in => slave_i,
        master_in => data_inFrom_RX_ni,
        slave_out => slave_outTo_RX_ni,
        master_out => master_o
    );
        
    u4 : handshake_packet port map ( -- TX_ni --> router
        clk => clk,
        rst => rst,
        master_in => data_inFrom_TX_ni,
        master_out => m_packet,
        slave_in => s_packet,
        slave_out => slave_outTo_TX_ni
    );
      
    u_4 : handshake_packet port map ( --router --> RX_ni
        clk => clk,
        rst => rst,
        master_in => m_packet_i,
        master_out => data_outTo_RX_ni,
        slave_in => slave_inFrom_RX_ni,
        slave_out => s_packet_o
    );

end ni_arch;

