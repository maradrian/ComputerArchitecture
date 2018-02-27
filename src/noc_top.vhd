
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.noc_types.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity noc_top is
    
end noc_top;


architecture noc_top_arch of noc_top is
  signal clk, rst, StopSimulation : std_logic := '0'; 
  
  component clock is
    generic (
      period : time := 50 ns
      );
    port (
      stop : in  std_logic;
      clk  : out std_logic := '0'
      );
  end component;     
  
--------------Processor 0----------------  
--  component tx_gen 0
  component trafficGenerator is
    port (
        clk: in  STD_LOGIC;
        rst: in  STD_LOGIC;
        debug_next : out bus_master_type;
        debug_sig2 : out  std_logic_vector(2 downto 0);
        debug_sig : out  std_logic_vector(2 downto 0);
        slave_in : in bus_slave_type;
        master_out : out bus_master_type
        );
  end component;   

--  component rx_rcv 0
  component trafficReceiver is
    port ( clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        master_in : in bus_master_type;
        slave_out : out bus_slave_type
        );
  end component;
-----------------------------------------------

---------Processor 1-------------------------
--  component tx_gen 1
  component trafficGenerator_1 is
    port (
        clk: in  STD_LOGIC;
        rst: in  STD_LOGIC;
        debug_next : out bus_master_type;
        debug_sig2 : out  std_logic_vector(2 downto 0);
        debug_sig : out  std_logic_vector(2 downto 0);
        slave_in : in bus_slave_type;
        master_out : out bus_master_type
        );
  end component;   

--  component rx_rcv 1
  component trafficReceiver_1 is
    port ( clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        master_in : in bus_master_type;
        slave_out : out bus_slave_type
        );
  end component;
---------------------------------------------

---------Processor 2-------------------------
--  component tx_gen 2
  component trafficGenerator_2 is
    port (
        clk: in  STD_LOGIC;
        rst: in  STD_LOGIC;
        debug_next : out bus_master_type;
        debug_sig2 : out  std_logic_vector(2 downto 0);
        debug_sig : out  std_logic_vector(2 downto 0);
        slave_in : in bus_slave_type;
        master_out : out bus_master_type
        );
  end component;   

--  component rx_rcv 2
  component trafficReceiver_2 is
    port ( clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        master_in : in bus_master_type;
        slave_out : out bus_slave_type
        );
  end component;
---------------------------------------------

---------Processor 3-------------------------
--  component tx_gen 3
  component trafficGenerator_3 is
    port (
        clk: in  STD_LOGIC;
        rst: in  STD_LOGIC;
        debug_next : out bus_master_type;
        debug_sig2 : out  std_logic_vector(2 downto 0);
        debug_sig : out  std_logic_vector(2 downto 0);
        slave_in : in bus_slave_type;
        master_out : out bus_master_type
        );
  end component;   

--  component rx_rcv 3
  component trafficReceiver_3 is
    port ( clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        master_in : in bus_master_type;
        slave_out : out bus_slave_type
        );
  end component;
---------------------------------------------

---------Processor 4-------------------------
--  component tx_gen 4
  component trafficGenerator_4 is
    port (
        clk: in  STD_LOGIC;
        rst: in  STD_LOGIC;
        debug_next : out bus_master_type;
        debug_sig2 : out  std_logic_vector(2 downto 0);
        debug_sig : out  std_logic_vector(2 downto 0);
        slave_in : in bus_slave_type;
        master_out : out bus_master_type
        );
  end component;   

--  component rx_rcv 4
  component trafficReceiver_4 is
    port ( clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        master_in : in bus_master_type;
        slave_out : out bus_slave_type
        );
  end component;
---------------------------------------------

---------Processor 5-------------------------
--  component tx_gen 5
  component trafficGenerator_5 is
    port (
        clk: in  STD_LOGIC;
        rst: in  STD_LOGIC;
        debug_next : out bus_master_type;
        debug_sig2 : out  std_logic_vector(2 downto 0);
        debug_sig : out  std_logic_vector(2 downto 0);
        slave_in : in bus_slave_type;
        master_out : out bus_master_type
        );
  end component;   

--  component rx_rcv 5
  component trafficReceiver_5 is
    port ( clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        master_in : in bus_master_type;
        slave_out : out bus_slave_type
        );
  end component;
---------------------------------------------

---------Processor 6-------------------------
--  component tx_gen 6
  component trafficGenerator_6 is
    port (
        clk: in  STD_LOGIC;
        rst: in  STD_LOGIC;
        debug_next : out bus_master_type;
        debug_sig2 : out  std_logic_vector(2 downto 0);
        debug_sig : out  std_logic_vector(2 downto 0);
        slave_in : in bus_slave_type;
        master_out : out bus_master_type
        );
  end component;   

--  component rx_rcv 6
  component trafficReceiver_6 is
    port ( clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        master_in : in bus_master_type;
        slave_out : out bus_slave_type
        );
  end component;
---------------------------------------------

---------Processor 7-------------------------
--  component tx_gen 7
  component trafficGenerator_7 is
    port (
        clk: in  STD_LOGIC;
        rst: in  STD_LOGIC;
        debug_next : out bus_master_type;
        debug_sig2 : out  std_logic_vector(2 downto 0);
        debug_sig : out  std_logic_vector(2 downto 0);
        slave_in : in bus_slave_type;
        master_out : out bus_master_type
        );
  end component;   

--  component rx_rcv 7
  component trafficReceiver_7 is
    port ( clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        master_in : in bus_master_type;
        slave_out : out bus_slave_type
        );
  end component;
---------------------------------------------

---------Processor 8-------------------------
--  component tx_gen 8
  component trafficGenerator_8 is
    port (
        clk: in  STD_LOGIC;
        rst: in  STD_LOGIC;
        debug_next : out bus_master_type;
        debug_sig2 : out  std_logic_vector(2 downto 0);
        debug_sig : out  std_logic_vector(2 downto 0);
        slave_in : in bus_slave_type;
        master_out : out bus_master_type
        );
  end component;   

--  component rx_rcv 8
  component trafficReceiver_8 is
    port ( clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        master_in : in bus_master_type;
        slave_out : out bus_slave_type
        );
  end component;
---------------------------------------------

---------Processor 9-------------------------
--  component tx_gen 9
  component trafficGenerator_9 is
    port (
        clk: in  STD_LOGIC;
        rst: in  STD_LOGIC;
        debug_next : out bus_master_type;
        debug_sig2 : out  std_logic_vector(2 downto 0);
        debug_sig : out  std_logic_vector(2 downto 0);
        slave_in : in bus_slave_type;
        master_out : out bus_master_type
        );
  end component;   

--  component rx_rcv 9
  component trafficReceiver_9 is
    port ( clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        master_in : in bus_master_type;
        slave_out : out bus_slave_type
        );
  end component;
---------------------------------------------

---------Processor 10-------------------------
--  component tx_gen 10
  component trafficGenerator_10 is
    port (
        clk: in  STD_LOGIC;
        rst: in  STD_LOGIC;
        debug_next : out bus_master_type;
        debug_sig2 : out  std_logic_vector(2 downto 0);
        debug_sig : out  std_logic_vector(2 downto 0);
        slave_in : in bus_slave_type;
        master_out : out bus_master_type
        );
  end component;   

--  component rx_rcv 10
  component trafficReceiver_10 is
    port ( clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        master_in : in bus_master_type;
        slave_out : out bus_slave_type
        );
  end component;
---------------------------------------------

---------Processor 11-------------------------
--  component tx_gen 11
  component trafficGenerator_11 is
    port (
        clk: in  STD_LOGIC;
        rst: in  STD_LOGIC;
        debug_next : out bus_master_type;
        debug_sig2 : out  std_logic_vector(2 downto 0);
        debug_sig : out  std_logic_vector(2 downto 0);
        slave_in : in bus_slave_type;
        master_out : out bus_master_type
        );
  end component;   

--  component rx_rcv 11
  component trafficReceiver_11 is
    port ( clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        master_in : in bus_master_type;
        slave_out : out bus_slave_type
        );
  end component;
---------------------------------------------

---------Processor 12-------------------------
--  component tx_gen 12
  component trafficGenerator_12 is
    port (
        clk: in  STD_LOGIC;
        rst: in  STD_LOGIC;
        debug_next : out bus_master_type;
        debug_sig2 : out  std_logic_vector(2 downto 0);
        debug_sig : out  std_logic_vector(2 downto 0);
        slave_in : in bus_slave_type;
        master_out : out bus_master_type
        );
  end component;   

--  component rx_rcv 12
  component trafficReceiver_12 is
    port ( clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        master_in : in bus_master_type;
        slave_out : out bus_slave_type
        );
  end component;
---------------------------------------------

---------Processor 13-------------------------
--  component tx_gen 13
  component trafficGenerator_13 is
    port (
        clk: in  STD_LOGIC;
        rst: in  STD_LOGIC;
        debug_next : out bus_master_type;
        debug_sig2 : out  std_logic_vector(2 downto 0);
        debug_sig : out  std_logic_vector(2 downto 0);
        slave_in : in bus_slave_type;
        master_out : out bus_master_type
        );
  end component;   

--  component rx_rcv 13
  component trafficReceiver_13 is
    port ( clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        master_in : in bus_master_type;
        slave_out : out bus_slave_type
        );
  end component;
---------------------------------------------

---------Processor 14-------------------------
--  component tx_gen 14
  component trafficGenerator_14 is
    port (
        clk: in  STD_LOGIC;
        rst: in  STD_LOGIC;
        debug_next : out bus_master_type;
        debug_sig2 : out  std_logic_vector(2 downto 0);
        debug_sig : out  std_logic_vector(2 downto 0);
        slave_in : in bus_slave_type;
        master_out : out bus_master_type
        );
  end component;   

--  component rx_rcv 14
  component trafficReceiver_14 is
    port ( clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        master_in : in bus_master_type;
        slave_out : out bus_slave_type
        );
  end component;
---------------------------------------------

---------Processor 15-------------------------
--  component tx_gen 15
  component trafficGenerator_15 is
    port (
        clk: in  STD_LOGIC;
        rst: in  STD_LOGIC;
        debug_next : out bus_master_type;
        debug_sig2 : out  std_logic_vector(2 downto 0);
        debug_sig : out  std_logic_vector(2 downto 0);
        slave_in : in bus_slave_type;
        master_out : out bus_master_type
        );
  end component;   

--  component rx_rcv 15
  component trafficReceiver_15 is
    port ( clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        master_in : in bus_master_type;
        slave_out : out bus_slave_type
        );
  end component;
---------------------------------------------

  component node
  port (
    -- Reset & Clock
    rst : in std_logic;
    clk : in std_logic;
  
    -- North Tx Packet Interface
    node_north_packet_out : out packet_m_type;
    node_north_ready_in : in packet_s_type;
  
    -- North Rx Packet Interface
    node_north_packet_in : in packet_m_type;
    node_north_ready_out : out packet_s_type;

    -- East Tx Packet Interface
    node_east_packet_out : out packet_m_type;
    node_east_ready_in : in packet_s_type;
  
    -- East Rx Packet Interface
    node_east_packet_in : in packet_m_type;
    node_east_ready_out : out packet_s_type;

    -- South Tx Packet Interface
    node_south_packet_out : out packet_m_type;
    node_south_ready_in : in packet_s_type;
  
    -- South Rx Packet Interface
    node_south_packet_in : in packet_m_type;
    node_south_ready_out : out packet_s_type;

    -- West Tx Packet Interface
    node_west_packet_out : out packet_m_type;
    node_west_ready_in : in packet_s_type;
  
    -- West Rx Packet Interface
    node_west_packet_in : in packet_m_type;
    node_west_ready_out : out packet_s_type;

    -- Local Tx Bus Interface
    node_local_bus_out : out bus_master_type;   -- router_local_packet_out : out packet_m_type;
    node_local_bus_ready_in : in bus_slave_type;     -- router_local_ready_in: in packet_s_type
    
    -- Local Rx Bus Interface
    node_local_bus_in : in bus_master_type ;     -- router_local_packet_in : in packet_m_type;
    node_local_bus_ready_out : out bus_slave_type;   -- router_local_ready_out: out packet_s_type;

    -- Route look-up table
    node_lut_addr : out std_logic_vector (3 DOWNTO 0);
    node_lut_route : in std_logic_vector (20 DOWNTO 0) );
  end component;

  component ni_lut_id_0
  port (
    dst_addr : in std_logic_vector (3 DOWNTO 0);
    route    : out std_logic_vector (20 DOWNTO 0) );
    end component;
    
  component ni_lut_id_1
  port (
    dst_addr : in std_logic_vector (3 DOWNTO 0);
    route    : out std_logic_vector (20 DOWNTO 0) );
    end component;
    
  component ni_lut_id_2
  port (
    dst_addr : in std_logic_vector (3 DOWNTO 0);
    route    : out std_logic_vector (20 DOWNTO 0) );
    end component;
    
  component ni_lut_id_3
  port (
    dst_addr : in std_logic_vector (3 DOWNTO 0);
    route    : out std_logic_vector (20 DOWNTO 0) );
    end component;
    
  component ni_lut_id_4
  port (
    dst_addr : in std_logic_vector (3 DOWNTO 0);
    route    : out std_logic_vector (20 DOWNTO 0) );
    end component;
    
  component ni_lut_id_5
  port (
    dst_addr : in std_logic_vector (3 DOWNTO 0);
    route    : out std_logic_vector (20 DOWNTO 0) );
    end component;
    
  component ni_lut_id_6
  port (
    dst_addr : in std_logic_vector (3 DOWNTO 0);
    route    : out std_logic_vector (20 DOWNTO 0) );
    end component;
    
  component ni_lut_id_7
  port (
    dst_addr : in std_logic_vector (3 DOWNTO 0);
    route    : out std_logic_vector (20 DOWNTO 0) );
    end component;
    
  component ni_lut_id_8
  port (
    dst_addr : in std_logic_vector (3 DOWNTO 0);
    route    : out std_logic_vector (20 DOWNTO 0) );
    end component;
    
  component ni_lut_id_9
  port (
    dst_addr : in std_logic_vector (3 DOWNTO 0);
    route    : out std_logic_vector (20 DOWNTO 0) );
    end component;
    
  component ni_lut_id_10
  port (
    dst_addr : in std_logic_vector (3 DOWNTO 0);
    route    : out std_logic_vector (20 DOWNTO 0) );
    end component;
    
  component ni_lut_id_11
  port (
    dst_addr : in std_logic_vector (3 DOWNTO 0);
    route    : out std_logic_vector (20 DOWNTO 0) );
    end component;
    
  component ni_lut_id_12
  port (
    dst_addr : in std_logic_vector (3 DOWNTO 0);
    route    : out std_logic_vector (20 DOWNTO 0) );
    end component;
    
  component ni_lut_id_13
  port (
    dst_addr : in std_logic_vector (3 DOWNTO 0);
    route    : out std_logic_vector (20 DOWNTO 0) );
    end component;
    
  component ni_lut_id_14
  port (
    dst_addr : in std_logic_vector (3 DOWNTO 0);
    route    : out std_logic_vector (20 DOWNTO 0) );
    end component;
    
  component ni_lut_id_15
  port (
    dst_addr : in std_logic_vector (3 DOWNTO 0);
    route    : out std_logic_vector (20 DOWNTO 0) );
  end component;

 -- Don't care about these signals (aka whatever signals)

  signal node_0_north_packet_out_node_12_south_packet_in : packet_m_type;
  signal node_0_north_ready_in_node_12_south_ready_out : packet_s_type;
  signal node_0_west_packet_out_node_3_east_packet_in    : packet_m_type;
  signal node_0_west_ready_in_node_3_east_ready_out    : packet_s_type;
  
  signal node_1_north_packet_out_node_13_south_packet_in : packet_m_type;
  signal node_1_north_ready_in_node_13_south_ready_out : packet_s_type;
  signal node_1_west_packet_out_node_0_east_packet_in    : packet_m_type;
  signal node_1_west_ready_in_node_0_east_ready_out    : packet_s_type;
  
  signal node_2_north_packet_out_node_14_south_packet_in : packet_m_type;
  signal node_2_north_ready_in_node_14_south_ready_out : packet_s_type;
  signal node_2_west_packet_out_node_1_east_packet_in    : packet_m_type;
  signal node_2_west_ready_in_node_1_east_ready_out    : packet_s_type;
  
  signal node_3_north_packet_out_node_15_south_packet_in : packet_m_type;
  signal node_3_north_ready_in_node_15_south_ready_out : packet_s_type;
  signal node_3_west_packet_out_node_2_east_packet_in    : packet_m_type;
  signal node_3_west_ready_in_node_2_east_ready_out    : packet_s_type;
  
  signal node_4_north_packet_out_node_0_south_packet_in  : packet_m_type;
  signal node_4_north_ready_in_node_0_south_ready_out  : packet_s_type;
  signal node_4_west_packet_out_node_7_east_packet_in    : packet_m_type;
  signal node_4_west_ready_in_node_7_east_ready_out    : packet_s_type;

  signal node_5_north_packet_out_node_1_south_packet_in  : packet_m_type;
  signal node_5_north_ready_in_node_1_south_ready_out  : packet_s_type;
  signal node_5_west_packet_out_node_4_east_packet_in    : packet_m_type;
  signal node_5_west_ready_in_node_4_east_ready_out    : packet_s_type;

  signal node_6_north_packet_out_node_2_south_packet_in  : packet_m_type;
  signal node_6_north_ready_in_node_2_south_ready_out  : packet_s_type;
  signal node_6_west_packet_out_node_5_east_packet_in    : packet_m_type;
  signal node_6_west_ready_in_node_5_east_ready_out    : packet_s_type;

  signal node_7_north_packet_out_node_3_south_packet_in  : packet_m_type;
  signal node_7_north_ready_in_node_3_south_ready_out  : packet_s_type;
  signal node_7_west_packet_out_node_6_east_packet_in    : packet_m_type;
  signal node_7_west_ready_in_node_6_east_ready_out    : packet_s_type;

  signal node_8_north_packet_out_node_4_south_packet_in  : packet_m_type;
  signal node_8_north_ready_in_node_4_south_ready_out  : packet_s_type;
  signal node_8_west_packet_out_node_11_east_packet_in   : packet_m_type;
  signal node_8_west_ready_in_node_11_east_ready_out   : packet_s_type;

  signal node_9_north_packet_out_node_5_south_packet_in  : packet_m_type;
  signal node_9_north_ready_in_node_5_south_ready_out  : packet_s_type;
  signal node_9_west_packet_out_node_8_east_packet_in    : packet_m_type;
  signal node_9_west_ready_in_node_8_east_ready_out    : packet_s_type;

  signal node_10_north_packet_out_node_6_south_packet_in  : packet_m_type;
  signal node_10_north_ready_in_node_6_south_ready_out  : packet_s_type;
  signal node_10_west_packet_out_node_9_east_packet_in    : packet_m_type;
  signal node_10_west_ready_in_node_9_east_ready_out    : packet_s_type;

  signal node_11_north_packet_out_node_7_south_packet_in  : packet_m_type;
  signal node_11_north_ready_in_node_7_south_ready_out  : packet_s_type;
  signal node_11_west_packet_out_node_10_east_packet_in   : packet_m_type;
  signal node_11_west_ready_in_node_10_east_ready_out    : packet_s_type;

  signal node_12_north_packet_out_node_8_south_packet_in  : packet_m_type;
  signal node_12_north_ready_in_node_8_south_ready_out  : packet_s_type;
  signal node_12_west_packet_out_node_15_east_packet_in   : packet_m_type;
  signal node_12_west_ready_in_node_15_east_ready_out   : packet_s_type;

  signal node_13_north_packet_out_node_9_south_packet_in  : packet_m_type;
  signal node_13_north_ready_in_node_9_south_ready_out  : packet_s_type;
  signal node_13_west_packet_out_node_12_east_packet_in   : packet_m_type;
  signal node_13_west_ready_in_node_12_east_ready_out   : packet_s_type;

  signal node_14_north_packet_out_node_10_south_packet_in : packet_m_type;
  signal node_14_north_ready_in_node_10_south_ready_out : packet_s_type;
  signal node_14_west_packet_out_node_13_east_packet_in   : packet_m_type;
  signal node_14_west_ready_in_node_13_east_ready_out   : packet_s_type;

  signal node_15_north_packet_out_node_11_south_packet_in : packet_m_type;
  signal node_15_north_ready_in_node_11_south_ready_out : packet_s_type;
  signal node_15_west_packet_out_node_14_east_packet_in   : packet_m_type;
  signal node_15_west_ready_in_node_14_east_ready_out   : packet_s_type;

----------------------------Checked:

  signal node_0_east_packet_out_node_1_west_packet_in    : packet_m_type;
  signal node_0_east_ready_in_node_1_west_ready_out    : packet_s_type;
  signal node_0_south_packet_out_node_4_north_packet_in  : packet_m_type;
  signal node_0_south_ready_in_node_4_north_ready_out  : packet_s_type;

  signal node_1_east_packet_out_node_2_west_packet_in    : packet_m_type;
  signal node_1_east_ready_in_node_2_west_ready_out    : packet_s_type;
  signal node_1_south_packet_out_node_5_north_packet_in  : packet_m_type;
  signal node_1_south_ready_in_node_5_north_ready_out  : packet_s_type;

  signal node_2_east_packet_out_node_3_west_packet_in    : packet_m_type;
  signal node_2_east_ready_in_node_3_west_ready_out    : packet_s_type;
  signal node_2_south_packet_out_node_6_north_packet_in  : packet_m_type;
  signal node_2_south_ready_in_node_6_north_ready_out  : packet_s_type;

  signal node_3_east_packet_out_node_0_west_packet_in    : packet_m_type;
  signal node_3_east_ready_in_node_0_west_ready_out    : packet_s_type;
  signal node_3_south_packet_out_node_7_north_packet_in  : packet_m_type;
  signal node_3_south_ready_in_node_7_north_ready_out  : packet_s_type;

  signal node_4_east_packet_out_node_5_west_packet_in    : packet_m_type;
  signal node_4_east_ready_in_node_5_west_ready_out    : packet_s_type;
  signal node_4_south_packet_out_node_8_north_packet_in  : packet_m_type;
  signal node_4_south_ready_in_node_8_north_ready_out  : packet_s_type;

  signal node_5_east_packet_out_node_6_west_packet_in    : packet_m_type;
  signal node_5_east_ready_in_node_6_west_ready_out    : packet_s_type;
  signal node_5_south_packet_out_node_9_north_packet_in  : packet_m_type;
  signal node_5_south_ready_in_node_9_north_ready_out  : packet_s_type;
  
  signal node_6_east_packet_out_node_7_west_packet_in    : packet_m_type;
  signal node_6_east_ready_in_node_7_west_ready_out    : packet_s_type;
  signal node_6_south_packet_out_node_10_north_packet_in : packet_m_type;
  signal node_6_south_ready_in_node_10_north_ready_out : packet_s_type;

  signal node_7_east_packet_out_node_4_west_packet_in    : packet_m_type;
  signal node_7_east_ready_in_node_4_west_ready_out    : packet_s_type;
  signal node_7_south_packet_out_node_11_north_packet_in : packet_m_type;
  signal node_7_south_ready_in_node_11_north_ready_out : packet_s_type;
  
  signal node_8_east_packet_out_node_9_west_packet_in    : packet_m_type;
  signal node_8_east_ready_in_node_9_west_ready_out    : packet_s_type;
  signal node_8_south_packet_out_node_12_north_packet_in : packet_m_type;
  signal node_8_south_ready_in_node_12_north_ready_out : packet_s_type;
 
  signal node_9_east_packet_out_node_10_west_packet_in   : packet_m_type;
  signal node_9_east_ready_in_node_10_west_ready_out   : packet_s_type;
  signal node_9_south_packet_out_node_13_north_packet_in : packet_m_type;
  signal node_9_south_ready_in_node_13_north_ready_out : packet_s_type;
  
  signal node_10_east_packet_out_node_11_west_packet_in   : packet_m_type;
  signal node_10_east_ready_in_node_11_west_ready_out   : packet_s_type;
  signal node_10_south_packet_out_node_14_north_packet_in : packet_m_type;
  signal node_10_south_ready_in_node_14_north_ready_out : packet_s_type; 
 
  signal node_11_east_packet_out_node_8_west_packet_in    : packet_m_type;
  signal node_11_east_ready_in_node_8_west_ready_out    : packet_s_type;
  signal node_11_south_packet_out_node_15_north_packet_in : packet_m_type;
  signal node_11_south_ready_in_node_15_north_ready_out : packet_s_type;

  signal node_12_east_packet_out_node_13_west_packet_in   : packet_m_type;
  signal node_12_east_ready_in_node_13_west_ready_out   : packet_s_type;
  signal node_12_south_packet_out_node_0_north_packet_in  : packet_m_type;
  signal node_12_south_ready_in_node_0_north_ready_out  : packet_s_type;

  signal node_13_east_packet_out_node_14_west_packet_in   : packet_m_type;
  signal node_13_east_ready_in_node_14_west_ready_out   : packet_s_type;
  signal node_13_south_packet_out_node_1_north_packet_in  : packet_m_type;
  signal node_13_south_ready_in_node_1_north_ready_out  : packet_s_type;
  
  signal node_14_east_packet_out_node_15_west_packet_in   : packet_m_type;
  signal node_14_east_ready_in_node_15_west_ready_out   : packet_s_type;
  signal node_14_south_packet_out_node_2_north_packet_in  : packet_m_type;
  signal node_14_south_ready_in_node_2_north_ready_out  : packet_s_type;

  signal node_15_east_packet_out_node_12_west_packet_in   : packet_m_type;
  signal node_15_east_ready_in_node_12_west_ready_out   : packet_s_type;
  signal node_15_south_packet_out_node_3_north_packet_in  : packet_m_type;
  signal node_15_south_ready_in_node_3_north_ready_out  : packet_s_type;

---------------------------Others

  signal node_0_local_packet_out : bus_master_type;
  signal node_0_local_ready_in : bus_slave_type;
  signal node_0_local_packet_in : bus_master_type;
  signal node_0_local_ready_out : bus_slave_type;
  
  signal node_1_local_packet_out : bus_master_type;
  signal node_1_local_ready_in : bus_slave_type;
  signal node_1_local_packet_in : bus_master_type;
  signal node_1_local_ready_out : bus_slave_type;
  
  signal node_2_local_packet_out : bus_master_type;
  signal node_2_local_ready_in : bus_slave_type;
  signal node_2_local_packet_in : bus_master_type;
  signal node_2_local_ready_out : bus_slave_type;
  
  signal node_3_local_packet_out : bus_master_type;
  signal node_3_local_ready_in : bus_slave_type;
  signal node_3_local_packet_in : bus_master_type;
  signal node_3_local_ready_out : bus_slave_type;

  signal node_4_local_packet_out : bus_master_type;
  signal node_4_local_ready_in : bus_slave_type;
  signal node_4_local_packet_in : bus_master_type;
  signal node_4_local_ready_out : bus_slave_type;

  signal node_5_local_packet_out : bus_master_type;
  signal node_5_local_ready_in : bus_slave_type;
  signal node_5_local_packet_in : bus_master_type;
  signal node_5_local_ready_out : bus_slave_type;

  signal node_6_local_packet_out : bus_master_type;
  signal node_6_local_ready_in : bus_slave_type;
  signal node_6_local_packet_in : bus_master_type;
  signal node_6_local_ready_out : bus_slave_type;
  
  signal node_7_local_packet_out : bus_master_type;
  signal node_7_local_ready_in : bus_slave_type;
  signal node_7_local_packet_in : bus_master_type;
  signal node_7_local_ready_out : bus_slave_type;

  signal node_8_local_packet_out : bus_master_type;
  signal node_8_local_ready_in : bus_slave_type;
  signal node_8_local_packet_in : bus_master_type;
  signal node_8_local_ready_out : bus_slave_type;

  signal node_9_local_packet_out : bus_master_type;
  signal node_9_local_ready_in : bus_slave_type;
  signal node_9_local_packet_in : bus_master_type;
  signal node_9_local_ready_out : bus_slave_type;
  
  signal node_10_local_packet_out : bus_master_type;
  signal node_10_local_ready_in : bus_slave_type;
  signal node_10_local_packet_in : bus_master_type;
  signal node_10_local_ready_out : bus_slave_type;
  
  signal node_11_local_packet_out : bus_master_type;
  signal node_11_local_ready_in : bus_slave_type;
  signal node_11_local_packet_in : bus_master_type;
  signal node_11_local_ready_out : bus_slave_type;
  
  signal node_12_local_packet_out : bus_master_type;
  signal node_12_local_ready_in : bus_slave_type;
  signal node_12_local_packet_in : bus_master_type;
  signal node_12_local_ready_out : bus_slave_type;
  
  signal node_13_local_packet_out : bus_master_type;
  signal node_13_local_ready_in : bus_slave_type;
  signal node_13_local_packet_in : bus_master_type;
  signal node_13_local_ready_out : bus_slave_type;
  
  signal node_14_local_packet_out : bus_master_type;
  signal node_14_local_ready_in : bus_slave_type;
  signal node_14_local_packet_in : bus_master_type;
  signal node_14_local_ready_out : bus_slave_type;

  signal node_15_local_packet_out : bus_master_type;
  signal node_15_local_ready_in : bus_slave_type;
  signal node_15_local_packet_in : bus_master_type;
  signal node_15_local_ready_out : bus_slave_type;
  
  signal ni_lut_id_0_dst_addr : std_logic_vector (3 DOWNTO 0);
  signal ni_lut_id_0_route    : std_logic_vector (20 DOWNTO 0);

  signal ni_lut_id_1_dst_addr : std_logic_vector (3 DOWNTO 0);
  signal ni_lut_id_1_route    : std_logic_vector (20 DOWNTO 0);

  signal ni_lut_id_2_dst_addr : std_logic_vector (3 DOWNTO 0);
  signal ni_lut_id_2_route    : std_logic_vector (20 DOWNTO 0);

  signal ni_lut_id_3_dst_addr : std_logic_vector (3 DOWNTO 0);
  signal ni_lut_id_3_route    : std_logic_vector (20 DOWNTO 0);

  signal ni_lut_id_4_dst_addr : std_logic_vector (3 DOWNTO 0);
  signal ni_lut_id_4_route    : std_logic_vector (20 DOWNTO 0);

  signal ni_lut_id_5_dst_addr : std_logic_vector (3 DOWNTO 0);
  signal ni_lut_id_5_route    : std_logic_vector (20 DOWNTO 0);

  signal ni_lut_id_6_dst_addr : std_logic_vector (3 DOWNTO 0);
  signal ni_lut_id_6_route    : std_logic_vector (20 DOWNTO 0);

  signal ni_lut_id_7_dst_addr : std_logic_vector (3 DOWNTO 0);
  signal ni_lut_id_7_route    : std_logic_vector (20 DOWNTO 0);

  signal ni_lut_id_8_dst_addr : std_logic_vector (3 DOWNTO 0);
  signal ni_lut_id_8_route    : std_logic_vector (20 DOWNTO 0);

  signal ni_lut_id_9_dst_addr : std_logic_vector (3 DOWNTO 0);
  signal ni_lut_id_9_route    : std_logic_vector (20 DOWNTO 0);

  signal ni_lut_id_10_dst_addr : std_logic_vector (3 DOWNTO 0);
  signal ni_lut_id_10_route    : std_logic_vector (20 DOWNTO 0);

  signal ni_lut_id_11_dst_addr : std_logic_vector (3 DOWNTO 0);
  signal ni_lut_id_11_route    : std_logic_vector (20 DOWNTO 0);

  signal ni_lut_id_12_dst_addr : std_logic_vector (3 DOWNTO 0);
  signal ni_lut_id_12_route    : std_logic_vector (20 DOWNTO 0);

  signal ni_lut_id_13_dst_addr : std_logic_vector (3 DOWNTO 0);
  signal ni_lut_id_13_route    : std_logic_vector (20 DOWNTO 0);

  signal ni_lut_id_14_dst_addr : std_logic_vector (3 DOWNTO 0);
  signal ni_lut_id_14_route    : std_logic_vector (20 DOWNTO 0);

  signal ni_lut_id_15_dst_addr : std_logic_vector (3 DOWNTO 0);
  signal ni_lut_id_15_route    : std_logic_vector (20 DOWNTO 0);

begin

  clock_0 : clock port map ( clk => clk, stop => StopSimulation );
  
  --Processor 0
  tx_0 : trafficGenerator port map (
    clk => clk,
    rst => rst,
    slave_in => node_0_local_ready_out,
    master_out => node_0_local_packet_in
  );
  
  rx_0 : trafficReceiver port map (
    clk => clk,
    rst => rst,
    master_in => node_0_local_packet_out,
    slave_out => node_0_local_ready_in
  ); 
  
  --Processor 1
  tx_1 : trafficGenerator_1 port map (
    clk => clk,
    rst => rst,
    slave_in => node_1_local_ready_out,
    master_out => node_1_local_packet_in
  );
  
  rx_1 : trafficReceiver_1 port map (
    clk => clk,
    rst => rst,
    master_in => node_1_local_packet_out,
    slave_out => node_1_local_ready_in
  ); 
  
    --Processor 2
  tx_2 : trafficGenerator_2 port map (
    clk => clk,
    rst => rst,
    slave_in => node_2_local_ready_out,
    master_out => node_2_local_packet_in
  );
  
  rx_2 : trafficReceiver_2 port map (
    clk => clk,
    rst => rst,
    master_in => node_2_local_packet_out,
    slave_out => node_2_local_ready_in
  ); 
  
      --Processor 3
tx_3 : trafficGenerator_3 port map (
  clk => clk,
  rst => rst,
  slave_in => node_3_local_ready_out,
  master_out => node_3_local_packet_in
);

rx_3 : trafficReceiver_3 port map (
  clk => clk,
  rst => rst,
  master_in => node_3_local_packet_out,
  slave_out => node_3_local_ready_in
); 

    --Processor 4
  tx_4 : trafficGenerator_4 port map (
    clk => clk,
    rst => rst,
    slave_in => node_4_local_ready_out,
    master_out => node_4_local_packet_in
  );
  
  rx_4 : trafficReceiver_4 port map (
    clk => clk,
    rst => rst,
    master_in => node_4_local_packet_out,
    slave_out => node_4_local_ready_in
  ); 
  
      --Processor 2
tx_5 : trafficGenerator_5 port map (
  clk => clk,
  rst => rst,
  slave_in => node_5_local_ready_out,
  master_out => node_5_local_packet_in
);

rx_5 : trafficReceiver_5 port map (
  clk => clk,
  rst => rst,
  master_in => node_5_local_packet_out,
  slave_out => node_5_local_ready_in
); 

    --Processor 6
  tx_6 : trafficGenerator_6 port map (
    clk => clk,
    rst => rst,
    slave_in => node_6_local_ready_out,
    master_out => node_6_local_packet_in
  );
  
  rx_6 : trafficReceiver_6 port map (
    clk => clk,
    rst => rst,
    master_in => node_6_local_packet_out,
    slave_out => node_6_local_ready_in
  ); 
  
      --Processor 7
tx_7 : trafficGenerator_7 port map (
  clk => clk,
  rst => rst,
  slave_in => node_7_local_ready_out,
  master_out => node_7_local_packet_in
);

rx_7 : trafficReceiver_7 port map (
  clk => clk,
  rst => rst,
  master_in => node_7_local_packet_out,
  slave_out => node_7_local_ready_in
); 

    --Processor 8
  tx_8 : trafficGenerator_8 port map (
    clk => clk,
    rst => rst,
    slave_in => node_8_local_ready_out,
    master_out => node_8_local_packet_in
  );
  
  rx_8 : trafficReceiver_8 port map (
    clk => clk,
    rst => rst,
    master_in => node_8_local_packet_out,
    slave_out => node_8_local_ready_in
  ); 
  
      --Processor 9
tx_9 : trafficGenerator_9 port map (
  clk => clk,
  rst => rst,
  slave_in => node_9_local_ready_out,
  master_out => node_9_local_packet_in
);

rx_9 : trafficReceiver_9 port map (
  clk => clk,
  rst => rst,
  master_in => node_9_local_packet_out,
  slave_out => node_9_local_ready_in
); 

    --Processor 10
  tx_10 : trafficGenerator_10 port map (
    clk => clk,
    rst => rst,
    slave_in => node_10_local_ready_out,
    master_out => node_10_local_packet_in
  );
  
  rx_10 : trafficReceiver_10 port map (
    clk => clk,
    rst => rst,
    master_in => node_10_local_packet_out,
    slave_out => node_10_local_ready_in
  ); 
  
      --Processor 11
tx_11 : trafficGenerator_11 port map (
  clk => clk,
  rst => rst,
  slave_in => node_11_local_ready_out,
  master_out => node_11_local_packet_in
);

rx_11 : trafficReceiver_11 port map (
  clk => clk,
  rst => rst,
  master_in => node_11_local_packet_out,
  slave_out => node_11_local_ready_in
); 

    --Processor 12
  tx_12 : trafficGenerator_12 port map (
    clk => clk,
    rst => rst,
    slave_in => node_12_local_ready_out,
    master_out => node_12_local_packet_in
  );
  
  rx_12 : trafficReceiver_12 port map (
    clk => clk,
    rst => rst,
    master_in => node_12_local_packet_out,
    slave_out => node_12_local_ready_in
  ); 
  
      --Processor 13
tx_13 : trafficGenerator_13 port map (
  clk => clk,
  rst => rst,
  slave_in => node_13_local_ready_out,
  master_out => node_13_local_packet_in
);

rx_13 : trafficReceiver_13 port map (
  clk => clk,
  rst => rst,
  master_in => node_13_local_packet_out,
  slave_out => node_13_local_ready_in
); 

    --Processor 14
  tx_14 : trafficGenerator_14 port map (
    clk => clk,
    rst => rst,
    slave_in => node_14_local_ready_out,
    master_out => node_14_local_packet_in
  );
  
  rx_14 : trafficReceiver_14 port map (
    clk => clk,
    rst => rst,
    master_in => node_14_local_packet_out,
    slave_out => node_14_local_ready_in
  ); 
  
      --Processor 15
tx_15 : trafficGenerator_15 port map (
  clk => clk,
  rst => rst,
  slave_in => node_15_local_ready_out,
  master_out => node_15_local_packet_in
);

rx_15 : trafficReceiver_15 port map (
  clk => clk,
  rst => rst,
  master_in => node_15_local_packet_out,
  slave_out => node_15_local_ready_in
); 
  ------------------------


  node_0 : node port map ( --Done
    rst => rst,
    clk => clk,
  
    node_north_packet_out => node_0_north_packet_out_node_12_south_packet_in, --whatever
    node_north_ready_in => node_0_north_ready_in_node_12_south_ready_out, --whatever
  
    node_north_packet_in => node_12_south_packet_out_node_0_north_packet_in, 
    node_north_ready_out => node_12_south_ready_in_node_0_north_ready_out, 

    node_east_packet_out  => node_0_east_packet_out_node_1_west_packet_in,
    node_east_ready_in  => node_0_east_ready_in_node_1_west_ready_out,
  
    node_east_packet_in  => node_1_west_packet_out_node_0_east_packet_in, --whatever
    node_east_ready_out  => node_1_west_ready_in_node_0_east_ready_out, --whatever

    node_south_packet_out => node_0_south_packet_out_node_4_north_packet_in, 
    node_south_ready_in => node_0_south_ready_in_node_4_north_ready_out, 
  
    node_south_packet_in => node_4_north_packet_out_node_0_south_packet_in, --whatever
    node_south_ready_out => node_4_north_ready_in_node_0_south_ready_out, --whatever

    node_west_packet_out  => node_0_west_packet_out_node_3_east_packet_in, --whatever
    node_west_ready_in  => node_0_west_ready_in_node_3_east_ready_out, --whatever
  
    node_west_packet_in  => node_3_east_packet_out_node_0_west_packet_in,
    node_west_ready_out  => node_3_east_ready_in_node_0_west_ready_out,

    node_local_bus_out => node_0_local_packet_out,
    node_local_bus_ready_in => node_0_local_ready_in,

    node_local_bus_in => node_0_local_packet_in,
    node_local_bus_ready_out => node_0_local_ready_out,

    node_lut_addr     => ni_lut_id_0_dst_addr,
    node_lut_route    => ni_lut_id_0_route
  );

  node_1 : node port map (
    rst => rst,
    clk => clk,
  
    node_north_packet_out => node_1_north_packet_out_node_13_south_packet_in, --whatever
    node_north_ready_in => node_1_north_ready_in_node_13_south_ready_out, --whatever
  
    node_north_packet_in => node_13_south_packet_out_node_1_north_packet_in,
    node_north_ready_out => node_13_south_ready_in_node_1_north_ready_out,

    node_east_packet_out  => node_1_east_packet_out_node_2_west_packet_in,
    node_east_ready_in  => node_1_east_ready_in_node_2_west_ready_out,
  
    node_east_packet_in  => node_2_west_packet_out_node_1_east_packet_in, --whatever
    node_east_ready_out  => node_2_west_ready_in_node_1_east_ready_out, --whatever

    node_south_packet_out => node_1_south_packet_out_node_5_north_packet_in, 
    node_south_ready_in => node_1_south_ready_in_node_5_north_ready_out,
  
    node_south_packet_in => node_5_north_packet_out_node_1_south_packet_in, --whatever
    node_south_ready_out => node_5_north_ready_in_node_1_south_ready_out, --whatever

    node_west_packet_out  => node_1_west_packet_out_node_0_east_packet_in, --whatever
    node_west_ready_in  => node_1_west_ready_in_node_0_east_ready_out, --whatever
  
    node_west_packet_in  => node_0_east_packet_out_node_1_west_packet_in,
    node_west_ready_out  => node_0_east_ready_in_node_1_west_ready_out,

    node_local_bus_out => node_1_local_packet_out,
    node_local_bus_ready_in => node_1_local_ready_in,
    
    node_local_bus_in => node_1_local_packet_in,
    node_local_bus_ready_out => node_1_local_ready_out,

    node_lut_addr     => ni_lut_id_1_dst_addr,
    node_lut_route    => ni_lut_id_1_route
  );

  node_2 : node port map (
    rst => rst,
    clk => clk,
  
    node_north_packet_out => node_2_north_packet_out_node_14_south_packet_in, --whatever
    node_north_ready_in => node_2_north_ready_in_node_14_south_ready_out, --whatever
  
    node_north_packet_in => node_14_south_packet_out_node_2_north_packet_in,
    node_north_ready_out => node_14_south_ready_in_node_2_north_ready_out,

    node_east_packet_out  => node_2_east_packet_out_node_3_west_packet_in,
    node_east_ready_in  => node_2_east_ready_in_node_3_west_ready_out,
  
    node_east_packet_in  => node_3_west_packet_out_node_2_east_packet_in, --whatever
    node_east_ready_out  => node_3_west_ready_in_node_2_east_ready_out, --whatever

    node_south_packet_out => node_2_south_packet_out_node_6_north_packet_in,
    node_south_ready_in => node_2_south_ready_in_node_6_north_ready_out,
  
    node_south_packet_in => node_6_north_packet_out_node_2_south_packet_in, --whatever
    node_south_ready_out => node_6_north_ready_in_node_2_south_ready_out, --whatever

    node_west_packet_out  => node_2_west_packet_out_node_1_east_packet_in, --whatever
    node_west_ready_in  => node_2_west_ready_in_node_1_east_ready_out, --whatever
  
    node_west_packet_in  => node_1_east_packet_out_node_2_west_packet_in,
    node_west_ready_out  => node_1_east_ready_in_node_2_west_ready_out,

    node_local_bus_out => node_2_local_packet_out,
    node_local_bus_ready_in => node_2_local_ready_in,
    
    node_local_bus_in => node_2_local_packet_in,
    node_local_bus_ready_out => node_2_local_ready_out,

    node_lut_addr     => ni_lut_id_2_dst_addr,
    node_lut_route    => ni_lut_id_2_route
  );

  node_3 : node port map (
    rst => rst,
    clk => clk,
  
    node_north_packet_out => node_3_north_packet_out_node_15_south_packet_in, --whatever
    node_north_ready_in => node_3_north_ready_in_node_15_south_ready_out, --whatever
  
    node_north_packet_in => node_15_south_packet_out_node_3_north_packet_in,
    node_north_ready_out => node_15_south_ready_in_node_3_north_ready_out,

    node_east_packet_out  => node_3_east_packet_out_node_0_west_packet_in,
    node_east_ready_in  => node_3_east_ready_in_node_0_west_ready_out,
  
    node_east_packet_in  => node_0_west_packet_out_node_3_east_packet_in, --whatever
    node_east_ready_out  => node_0_west_ready_in_node_3_east_ready_out, --whatever

    node_south_packet_out => node_3_south_packet_out_node_7_north_packet_in,
    node_south_ready_in => node_3_south_ready_in_node_7_north_ready_out,
  
    node_south_packet_in => node_7_north_packet_out_node_3_south_packet_in, --whatever
    node_south_ready_out => node_7_north_ready_in_node_3_south_ready_out, --whatever

    node_west_packet_out  => node_3_west_packet_out_node_2_east_packet_in, --whatever
    node_west_ready_in  => node_3_west_ready_in_node_2_east_ready_out, --whatever
  
    node_west_packet_in  => node_2_east_packet_out_node_3_west_packet_in,
    node_west_ready_out  => node_2_east_ready_in_node_3_west_ready_out,

    node_local_bus_out => node_3_local_packet_out,
    node_local_bus_ready_in => node_3_local_ready_in,
    
    node_local_bus_in => node_3_local_packet_in,
    node_local_bus_ready_out => node_3_local_ready_out,

    node_lut_addr     => ni_lut_id_3_dst_addr,
    node_lut_route    => ni_lut_id_3_route
  );

  node_4 : node port map (
    rst => rst,
    clk => clk,
  
    node_north_packet_out => node_4_north_packet_out_node_0_south_packet_in, --whatever
    node_north_ready_in => node_4_north_ready_in_node_0_south_ready_out, --whatever
  
    node_north_packet_in => node_0_south_packet_out_node_4_north_packet_in,
    node_north_ready_out => node_0_south_ready_in_node_4_north_ready_out,

    node_east_packet_out  => node_4_east_packet_out_node_5_west_packet_in,
    node_east_ready_in  => node_4_east_ready_in_node_5_west_ready_out,
  
    node_east_packet_in  => node_5_west_packet_out_node_4_east_packet_in, --whatever
    node_east_ready_out  => node_5_west_ready_in_node_4_east_ready_out, --whatever

    node_south_packet_out => node_4_south_packet_out_node_8_north_packet_in,
    node_south_ready_in => node_4_south_ready_in_node_8_north_ready_out,
  
    node_south_packet_in => node_8_north_packet_out_node_4_south_packet_in, --whatever
    node_south_ready_out => node_8_north_ready_in_node_4_south_ready_out, --whatever

    node_west_packet_out  => node_4_west_packet_out_node_7_east_packet_in, --whatever
    node_west_ready_in  => node_4_west_ready_in_node_7_east_ready_out, --whatever
  
    node_west_packet_in  => node_7_east_packet_out_node_4_west_packet_in,
    node_west_ready_out  => node_7_east_ready_in_node_4_west_ready_out,

    node_local_bus_out => node_4_local_packet_out,
    node_local_bus_ready_in => node_4_local_ready_in,
    
    node_local_bus_in => node_4_local_packet_in,
    node_local_bus_ready_out => node_4_local_ready_out,

    node_lut_addr     => ni_lut_id_4_dst_addr,
    node_lut_route    => ni_lut_id_4_route
  );

  node_5 : node port map (
    rst => rst,
    clk => clk,
  
    node_north_packet_out => node_5_north_packet_out_node_1_south_packet_in, --whatever
    node_north_ready_in => node_5_north_ready_in_node_1_south_ready_out, --whatever
  
    node_north_packet_in => node_1_south_packet_out_node_5_north_packet_in,
    node_north_ready_out => node_1_south_ready_in_node_5_north_ready_out,

    node_east_packet_out  => node_5_east_packet_out_node_6_west_packet_in,
    node_east_ready_in  => node_5_east_ready_in_node_6_west_ready_out,
  
    node_east_packet_in  => node_6_west_packet_out_node_5_east_packet_in, --whatever
    node_east_ready_out  => node_6_west_ready_in_node_5_east_ready_out, --whatever

    node_south_packet_out => node_5_south_packet_out_node_9_north_packet_in,
    node_south_ready_in => node_5_south_ready_in_node_9_north_ready_out,
  
    node_south_packet_in => node_9_north_packet_out_node_5_south_packet_in, --whatever
    node_south_ready_out => node_9_north_ready_in_node_5_south_ready_out, --whatever

    node_west_packet_out  => node_5_west_packet_out_node_4_east_packet_in, --whatever
    node_west_ready_in  => node_5_west_ready_in_node_4_east_ready_out, --whatever
  
    node_west_packet_in  => node_4_east_packet_out_node_5_west_packet_in,
    node_west_ready_out  => node_4_east_ready_in_node_5_west_ready_out,

    node_local_bus_out => node_5_local_packet_out,
    node_local_bus_ready_in => node_5_local_ready_in,

    node_local_bus_in => node_5_local_packet_in,
    node_local_bus_ready_out => node_5_local_ready_out,

    node_lut_addr     => ni_lut_id_5_dst_addr,
    node_lut_route    => ni_lut_id_5_route
  );

  node_6 : node port map (
    rst => rst,
    clk => clk,
  
    node_north_packet_out => node_6_north_packet_out_node_2_south_packet_in, --whatever
    node_north_ready_in => node_6_north_ready_in_node_2_south_ready_out, --whatever
  
    node_north_packet_in => node_2_south_packet_out_node_6_north_packet_in,
    node_north_ready_out => node_2_south_ready_in_node_6_north_ready_out,

    node_east_packet_out  => node_6_east_packet_out_node_7_west_packet_in,
    node_east_ready_in  => node_6_east_ready_in_node_7_west_ready_out,
  
    node_east_packet_in  => node_7_west_packet_out_node_6_east_packet_in, --whatever
    node_east_ready_out  => node_7_west_ready_in_node_6_east_ready_out, --whatever

    node_south_packet_out => node_6_south_packet_out_node_10_north_packet_in,
    node_south_ready_in => node_6_south_ready_in_node_10_north_ready_out,
  
    node_south_packet_in => node_10_north_packet_out_node_6_south_packet_in, --whatever
    node_south_ready_out => node_10_north_ready_in_node_6_south_ready_out, --whatever

    node_west_packet_out  => node_6_west_packet_out_node_5_east_packet_in, --whatever
    node_west_ready_in  => node_6_west_ready_in_node_5_east_ready_out, --whatever
  
    node_west_packet_in  => node_5_east_packet_out_node_6_west_packet_in,
    node_west_ready_out  => node_5_east_ready_in_node_6_west_ready_out,

    node_local_bus_out => node_6_local_packet_out,
    node_local_bus_ready_in => node_6_local_ready_in,

    node_local_bus_in => node_6_local_packet_in,
    node_local_bus_ready_out => node_6_local_ready_out,

    node_lut_addr     => ni_lut_id_6_dst_addr,
    node_lut_route    => ni_lut_id_6_route
  );

  node_7 : node port map (
    rst => rst,
    clk => clk,
  
    node_north_packet_out => node_7_north_packet_out_node_3_south_packet_in, --whatever
    node_north_ready_in => node_7_north_ready_in_node_3_south_ready_out, --whatever
  
    node_north_packet_in => node_3_south_packet_out_node_7_north_packet_in,
    node_north_ready_out => node_3_south_ready_in_node_7_north_ready_out,

    node_east_packet_out  => node_7_east_packet_out_node_4_west_packet_in,
    node_east_ready_in  => node_7_east_ready_in_node_4_west_ready_out,
  
    node_east_packet_in  => node_4_west_packet_out_node_7_east_packet_in, --whatever
    node_east_ready_out  => node_4_west_ready_in_node_7_east_ready_out, --whatever

    node_south_packet_out => node_7_south_packet_out_node_11_north_packet_in,
    node_south_ready_in => node_7_south_ready_in_node_11_north_ready_out,
  
    node_south_packet_in => node_11_north_packet_out_node_7_south_packet_in, --whatever
    node_south_ready_out => node_11_north_ready_in_node_7_south_ready_out, --whatever

    node_west_packet_out  => node_7_west_packet_out_node_6_east_packet_in, --whatever
    node_west_ready_in  => node_7_west_ready_in_node_6_east_ready_out, --whatever
  
    node_west_packet_in  => node_6_east_packet_out_node_7_west_packet_in,
    node_west_ready_out  => node_6_east_ready_in_node_7_west_ready_out,

    node_local_bus_out => node_7_local_packet_out,
    node_local_bus_ready_in => node_7_local_ready_in,
    
    node_local_bus_in => node_7_local_packet_in,
    node_local_bus_ready_out => node_7_local_ready_out,

    node_lut_addr     => ni_lut_id_7_dst_addr,
    node_lut_route    => ni_lut_id_7_route
  );

  node_8 : node port map (
    rst => rst,
    clk => clk,
  
    node_north_packet_out => node_8_north_packet_out_node_4_south_packet_in, --whatever
    node_north_ready_in => node_8_north_ready_in_node_4_south_ready_out, --whatever
  
    node_north_packet_in => node_4_south_packet_out_node_8_north_packet_in,
    node_north_ready_out => node_4_south_ready_in_node_8_north_ready_out,

    node_east_packet_out  => node_8_east_packet_out_node_9_west_packet_in,
    node_east_ready_in  => node_8_east_ready_in_node_9_west_ready_out,
  
    node_east_packet_in  => node_9_west_packet_out_node_8_east_packet_in, --whatever
    node_east_ready_out  => node_9_west_ready_in_node_8_east_ready_out, --whatever

    node_south_packet_out => node_8_south_packet_out_node_12_north_packet_in,
    node_south_ready_in => node_8_south_ready_in_node_12_north_ready_out,
  
    node_south_packet_in => node_12_north_packet_out_node_8_south_packet_in, --whatever
    node_south_ready_out => node_12_north_ready_in_node_8_south_ready_out, --whatever

    node_west_packet_out  => node_8_west_packet_out_node_11_east_packet_in, --whatever
    node_west_ready_in  => node_8_west_ready_in_node_11_east_ready_out, --whatever
  
    node_west_packet_in  => node_11_east_packet_out_node_8_west_packet_in,
    node_west_ready_out  => node_11_east_ready_in_node_8_west_ready_out,

    node_local_bus_out => node_8_local_packet_out,
    node_local_bus_ready_in => node_8_local_ready_in,
    
    node_local_bus_in => node_8_local_packet_in,
    node_local_bus_ready_out => node_8_local_ready_out,

    node_lut_addr     => ni_lut_id_8_dst_addr,
    node_lut_route    => ni_lut_id_8_route
  );

  node_9 : node port map (
    rst => rst,
    clk => clk,
  
    node_north_packet_out => node_9_north_packet_out_node_5_south_packet_in, --whatever
    node_north_ready_in => node_9_north_ready_in_node_5_south_ready_out, --whatever
  
    node_north_packet_in => node_5_south_packet_out_node_9_north_packet_in,
    node_north_ready_out => node_5_south_ready_in_node_9_north_ready_out,

    node_east_packet_out  => node_9_east_packet_out_node_10_west_packet_in,
    node_east_ready_in  => node_9_east_ready_in_node_10_west_ready_out,
  
    node_east_packet_in  => node_10_west_packet_out_node_9_east_packet_in, --whatever
    node_east_ready_out  => node_10_west_ready_in_node_9_east_ready_out, --whatever

    node_south_packet_out => node_9_south_packet_out_node_13_north_packet_in,
    node_south_ready_in => node_9_south_ready_in_node_13_north_ready_out,
  
    node_south_packet_in => node_13_north_packet_out_node_9_south_packet_in, --whatever
    node_south_ready_out => node_13_north_ready_in_node_9_south_ready_out, --whatever

    node_west_packet_out  => node_9_west_packet_out_node_8_east_packet_in, --whatever
    node_west_ready_in  => node_9_west_ready_in_node_8_east_ready_out, --whatever
  
    node_west_packet_in  => node_8_east_packet_out_node_9_west_packet_in,
    node_west_ready_out  => node_8_east_ready_in_node_9_west_ready_out,

    node_local_bus_out => node_9_local_packet_out,
    node_local_bus_ready_in => node_9_local_ready_in,
    
    node_local_bus_in => node_9_local_packet_in,
    node_local_bus_ready_out => node_9_local_ready_out,

    node_lut_addr     => ni_lut_id_9_dst_addr,
    node_lut_route    => ni_lut_id_9_route
  );

  node_10 : node port map (
    rst => rst,
    clk => clk,
  
    node_north_packet_out => node_10_north_packet_out_node_6_south_packet_in, --whatever
    node_north_ready_in => node_10_north_ready_in_node_6_south_ready_out, --whatever
  
    node_north_packet_in => node_6_south_packet_out_node_10_north_packet_in,
    node_north_ready_out => node_6_south_ready_in_node_10_north_ready_out,

    node_east_packet_out  => node_10_east_packet_out_node_11_west_packet_in,
    node_east_ready_in  => node_10_east_ready_in_node_11_west_ready_out,
  
    node_east_packet_in  => node_11_west_packet_out_node_10_east_packet_in, --whatever
    node_east_ready_out  => node_11_west_ready_in_node_10_east_ready_out, --whatever

    node_south_packet_out => node_10_south_packet_out_node_14_north_packet_in,
    node_south_ready_in => node_10_south_ready_in_node_14_north_ready_out,
  
    node_south_packet_in => node_14_north_packet_out_node_10_south_packet_in, --whatever
    node_south_ready_out => node_14_north_ready_in_node_10_south_ready_out, --whatever

    node_west_packet_out  => node_10_west_packet_out_node_9_east_packet_in, --whatever
    node_west_ready_in  => node_10_west_ready_in_node_9_east_ready_out, --whatever
  
    node_west_packet_in  => node_9_east_packet_out_node_10_west_packet_in,
    node_west_ready_out  => node_9_east_ready_in_node_10_west_ready_out,

    node_local_bus_out => node_10_local_packet_out,
    node_local_bus_ready_in => node_10_local_ready_in,
    
    node_local_bus_in => node_10_local_packet_in,
    node_local_bus_ready_out => node_10_local_ready_out,

    node_lut_addr     => ni_lut_id_10_dst_addr,
    node_lut_route    => ni_lut_id_10_route
  );

  node_11 : node port map (
    rst => rst,
    clk => clk,
  
    node_north_packet_out => node_11_north_packet_out_node_7_south_packet_in, --whatever
    node_north_ready_in => node_11_north_ready_in_node_7_south_ready_out, --whatever
  
    node_north_packet_in => node_7_south_packet_out_node_11_north_packet_in,
    node_north_ready_out => node_7_south_ready_in_node_11_north_ready_out,

    node_east_packet_out  => node_11_east_packet_out_node_8_west_packet_in,
    node_east_ready_in  => node_11_east_ready_in_node_8_west_ready_out,
  
    node_east_packet_in  => node_8_west_packet_out_node_11_east_packet_in, --whatever
    node_east_ready_out  => node_8_west_ready_in_node_11_east_ready_out, --whatever

    node_south_packet_out => node_11_south_packet_out_node_15_north_packet_in,
    node_south_ready_in => node_11_south_ready_in_node_15_north_ready_out,
  
    node_south_packet_in => node_15_north_packet_out_node_11_south_packet_in, --whatever
    node_south_ready_out => node_15_north_ready_in_node_11_south_ready_out, --whatever

    node_west_packet_out  => node_11_west_packet_out_node_10_east_packet_in, --whatever
    node_west_ready_in  => node_11_west_ready_in_node_10_east_ready_out, --whatever
  
    node_west_packet_in  => node_10_east_packet_out_node_11_west_packet_in,
    node_west_ready_out  => node_10_east_ready_in_node_11_west_ready_out,

    node_local_bus_out => node_11_local_packet_out,
    node_local_bus_ready_in => node_11_local_ready_in,
    
    node_local_bus_in => node_11_local_packet_in,
    node_local_bus_ready_out => node_11_local_ready_out,

    node_lut_addr     => ni_lut_id_11_dst_addr,
    node_lut_route    => ni_lut_id_11_route
  );

  node_12 : node port map (
    rst => rst,
    clk => clk,
  
    node_north_packet_out => node_12_north_packet_out_node_8_south_packet_in, --whatever
    node_north_ready_in => node_12_north_ready_in_node_8_south_ready_out, --whatever
  
    node_north_packet_in => node_8_south_packet_out_node_12_north_packet_in,
    node_north_ready_out => node_8_south_ready_in_node_12_north_ready_out,

    node_east_packet_out  => node_12_east_packet_out_node_13_west_packet_in,
    node_east_ready_in  => node_12_east_ready_in_node_13_west_ready_out,
  
    node_east_packet_in  => node_13_west_packet_out_node_12_east_packet_in, --whatever
    node_east_ready_out  => node_13_west_ready_in_node_12_east_ready_out, --whatever

    node_south_packet_out => node_12_south_packet_out_node_0_north_packet_in,
    node_south_ready_in => node_12_south_ready_in_node_0_north_ready_out,
  
    node_south_packet_in => node_0_north_packet_out_node_12_south_packet_in, --whatever
    node_south_ready_out => node_0_north_ready_in_node_12_south_ready_out, --whatever

    node_west_packet_out  => node_12_west_packet_out_node_15_east_packet_in, --whatever
    node_west_ready_in  => node_12_west_ready_in_node_15_east_ready_out, --whatever
  
    node_west_packet_in  => node_15_east_packet_out_node_12_west_packet_in,
    node_west_ready_out  => node_15_east_ready_in_node_12_west_ready_out,

    node_local_bus_out => node_12_local_packet_out,
    node_local_bus_ready_in => node_12_local_ready_in,

    node_local_bus_in => node_12_local_packet_in,
    node_local_bus_ready_out => node_12_local_ready_out,

    node_lut_addr     => ni_lut_id_12_dst_addr,
    node_lut_route    => ni_lut_id_12_route
  );

  node_13 : node port map (
    rst => rst,
    clk => clk,
  
    node_north_packet_out => node_13_north_packet_out_node_9_south_packet_in, --whatever
    node_north_ready_in => node_13_north_ready_in_node_9_south_ready_out, --whatever
  
    node_north_packet_in => node_9_south_packet_out_node_13_north_packet_in,
    node_north_ready_out => node_9_south_ready_in_node_13_north_ready_out,

    node_east_packet_out  => node_13_east_packet_out_node_14_west_packet_in,
    node_east_ready_in  => node_13_east_ready_in_node_14_west_ready_out,
  
    node_east_packet_in  => node_14_west_packet_out_node_13_east_packet_in, --whatever
    node_east_ready_out  => node_14_west_ready_in_node_13_east_ready_out, --whatever

    node_south_packet_out => node_13_south_packet_out_node_1_north_packet_in,
    node_south_ready_in => node_13_south_ready_in_node_1_north_ready_out,
  
    node_south_packet_in => node_1_north_packet_out_node_13_south_packet_in, --whatever
    node_south_ready_out => node_1_north_ready_in_node_13_south_ready_out, --whatever

    node_west_packet_out  => node_13_west_packet_out_node_12_east_packet_in, --whatever
    node_west_ready_in  => node_13_west_ready_in_node_12_east_ready_out, --whatever
  
    node_west_packet_in  => node_12_east_packet_out_node_13_west_packet_in,
    node_west_ready_out  => node_12_east_ready_in_node_13_west_ready_out,

    node_local_bus_out => node_13_local_packet_out,
    node_local_bus_ready_in => node_13_local_ready_in,
    
    node_local_bus_in => node_13_local_packet_in,
    node_local_bus_ready_out => node_13_local_ready_out,

    node_lut_addr     => ni_lut_id_13_dst_addr,
    node_lut_route    => ni_lut_id_13_route
  );

  node_14 : node port map (
    rst => rst,
    clk => clk,
  
    node_north_packet_out => node_14_north_packet_out_node_10_south_packet_in, --whatever
    node_north_ready_in => node_14_north_ready_in_node_10_south_ready_out, --whatever
  
    node_north_packet_in => node_10_south_packet_out_node_14_north_packet_in,
    node_north_ready_out => node_10_south_ready_in_node_14_north_ready_out,

    node_east_packet_out  => node_14_east_packet_out_node_15_west_packet_in,
    node_east_ready_in  => node_14_east_ready_in_node_15_west_ready_out,
  
    node_east_packet_in  => node_15_west_packet_out_node_14_east_packet_in, --whatever
    node_east_ready_out  => node_15_west_ready_in_node_14_east_ready_out, --whatever

    node_south_packet_out => node_14_south_packet_out_node_2_north_packet_in,
    node_south_ready_in => node_14_south_ready_in_node_2_north_ready_out,
  
    node_south_packet_in => node_2_north_packet_out_node_14_south_packet_in, --whatever
    node_south_ready_out => node_2_north_ready_in_node_14_south_ready_out, --whatever

    node_west_packet_out  => node_14_west_packet_out_node_13_east_packet_in, --whatever
    node_west_ready_in  => node_14_west_ready_in_node_13_east_ready_out, --whatever
  
    node_west_packet_in  => node_13_east_packet_out_node_14_west_packet_in,
    node_west_ready_out  => node_13_east_ready_in_node_14_west_ready_out,

    node_local_bus_out => node_14_local_packet_out,
    node_local_bus_ready_in => node_14_local_ready_in,

    node_local_bus_in => node_14_local_packet_in,
    node_local_bus_ready_out => node_14_local_ready_out,

    node_lut_addr     => ni_lut_id_14_dst_addr,
    node_lut_route    => ni_lut_id_14_route
  );

  node_15 : node port map (
    rst => rst,
    clk => clk,
  
    node_north_packet_out => node_15_north_packet_out_node_11_south_packet_in, --whatever
    node_north_ready_in => node_15_north_ready_in_node_11_south_ready_out, --whatever
  
    node_north_packet_in => node_11_south_packet_out_node_15_north_packet_in,
    node_north_ready_out => node_11_south_ready_in_node_15_north_ready_out,

    node_east_packet_out  => node_15_east_packet_out_node_12_west_packet_in, 
    node_east_ready_in  => node_15_east_ready_in_node_12_west_ready_out,
  
    node_east_packet_in  => node_12_west_packet_out_node_15_east_packet_in, --whatever
    node_east_ready_out  => node_12_west_ready_in_node_15_east_ready_out, --whatever

    node_south_packet_out => node_15_south_packet_out_node_3_north_packet_in,
    node_south_ready_in => node_15_south_ready_in_node_3_north_ready_out,
  
    node_south_packet_in => node_3_north_packet_out_node_15_south_packet_in, --whatever
    node_south_ready_out => node_3_north_ready_in_node_15_south_ready_out, --whatever

    node_west_packet_out  => node_15_west_packet_out_node_14_east_packet_in, --whatever
    node_west_ready_in  => node_15_west_ready_in_node_14_east_ready_out, --whatever
  
    node_west_packet_in  => node_14_east_packet_out_node_15_west_packet_in,
    node_west_ready_out  => node_14_east_ready_in_node_15_west_ready_out,

    node_local_bus_out => node_15_local_packet_out,
    node_local_bus_ready_in => node_15_local_ready_in,

    node_local_bus_in => node_15_local_packet_in,
    node_local_bus_ready_out => node_15_local_ready_out,

    node_lut_addr     => ni_lut_id_15_dst_addr,
    node_lut_route    => ni_lut_id_15_route
  );

  lut_0 : ni_lut_id_0 port map (
    dst_addr => ni_lut_id_0_dst_addr,
    route => ni_lut_id_0_route );
    
  lut_1 : ni_lut_id_1 port map (
    dst_addr => ni_lut_id_1_dst_addr,
    route => ni_lut_id_1_route );
    
  lut_2 : ni_lut_id_2 port map (
    dst_addr => ni_lut_id_2_dst_addr,
    route => ni_lut_id_2_route );
    
  lut_3 : ni_lut_id_3 port map (
    dst_addr => ni_lut_id_3_dst_addr,
    route => ni_lut_id_3_route );
    
  lut_4 : ni_lut_id_4 port map (
    dst_addr => ni_lut_id_4_dst_addr,
    route => ni_lut_id_4_route );
    
  lut_5 : ni_lut_id_5 port map (
    dst_addr => ni_lut_id_5_dst_addr,
    route => ni_lut_id_5_route );
    
  lut_6 : ni_lut_id_6 port map (
    dst_addr => ni_lut_id_6_dst_addr,
    route => ni_lut_id_6_route );
    
  lut_7 : ni_lut_id_7 port map (
    dst_addr => ni_lut_id_7_dst_addr,
    route => ni_lut_id_7_route );
    
  lut_8 : ni_lut_id_8 port map (
    dst_addr => ni_lut_id_8_dst_addr,
    route => ni_lut_id_8_route );
    
  lut_9 : ni_lut_id_9 port map (
    dst_addr => ni_lut_id_9_dst_addr,
    route => ni_lut_id_9_route );
    
  lut_10 : ni_lut_id_10 port map (
    dst_addr => ni_lut_id_10_dst_addr,
    route => ni_lut_id_10_route );
    
  lut_11 : ni_lut_id_11 port map (
    dst_addr => ni_lut_id_11_dst_addr,
    route => ni_lut_id_11_route );
    
  lut_12 : ni_lut_id_12 port map (
    dst_addr => ni_lut_id_12_dst_addr,
    route => ni_lut_id_12_route );
    
  lut_13 : ni_lut_id_13 port map (
    dst_addr => ni_lut_id_13_dst_addr,
    route => ni_lut_id_13_route );
    
  lut_14 : ni_lut_id_14 port map (
    dst_addr => ni_lut_id_14_dst_addr,
    route => ni_lut_id_14_route );
    
  lut_15 : ni_lut_id_15 port map (
    dst_addr => ni_lut_id_15_dst_addr,
    route => ni_lut_id_15_route );
    
    -------------------------------TESTBENCH-------------------------------
    rst <= '1', '0' after 50ns;
    
    start_logic: process is
    begin
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        wait until rst = '0' and rising_edge(clk);
        StopSimulation <= '1';
        --wait until rst = '0' and rising_edge(clk);
    end process;
  
    seq: process(clk, rst)
    begin
        if (rst = '1') then
        elsif rising_edge(clk) then
             
        end if;
    end process;
    
end noc_top_arch;
