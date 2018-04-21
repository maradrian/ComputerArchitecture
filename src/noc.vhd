library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.noc_types.all;

entity noc is
 generic (M,N : integer:= 3);
 port(
  clk : in std_logic;
  reset : in std_logic;
  
  local_packet_in  : in link_m_f;
  local_ready_out : out link_m_b;
  
  local_packet_out  : out link_m_f;
  local_ready_in : in link_m_b
  );   
end noc;

architecture struct of noc is

------------------------------ NEW SIGNALS ----------------------------
signal east_packet_out_0, south_packet_out_0: packet_m_type;
signal east_ready_in_0, south_ready_in_0: packet_s_type;

signal east_packet_out_1, south_packet_out_1: packet_m_type;
signal east_ready_in_1, south_ready_in_1: packet_s_type;

signal east_packet_out_2, south_packet_out_2: packet_m_type;
signal east_ready_in_2, south_ready_in_2: packet_s_type;

signal east_packet_out_3, south_packet_out_3: packet_m_type;
signal east_ready_in_3, south_ready_in_3: packet_s_type;

signal east_packet_out_4, south_packet_out_4: packet_m_type;
signal east_ready_in_4, south_ready_in_4: packet_s_type;

signal east_packet_out_5, south_packet_out_5: packet_m_type;
signal east_ready_in_5, south_ready_in_5: packet_s_type;

signal east_packet_out_6, south_packet_out_6: packet_m_type;
signal east_ready_in_6, south_ready_in_6: packet_s_type;

signal east_packet_out_7, south_packet_out_7: packet_m_type;
signal east_ready_in_7, south_ready_in_7: packet_s_type;

signal east_packet_out_8, south_packet_out_8: packet_m_type;
signal east_ready_in_8, south_ready_in_8: packet_s_type;
------------------------------------------------------------

  component router
  port( 
  clk, rst : in std_logic;

  -- North
  router_north_packet_in : in packet_m_type;
  router_north_ready_out: out packet_s_type;
  
  -- East
  router_east_packet_out : out packet_m_type;
  router_east_ready_in: in packet_s_type;
  
  -- South
  router_south_packet_out : out packet_m_type;
  router_south_ready_in: in packet_s_type;
  
  -- West
  router_west_packet_in : in packet_m_type;
  router_west_ready_out: out packet_s_type;
  
  -- Local input
  router_local_packet_in : in packet_m_type;
  router_local_ready_out: out packet_s_type;
  
  -- Local output
  router_local_packet_out : out packet_m_type;
  router_local_ready_in: in packet_s_type
);
  end component;
  
  

begin

router0: router PORT MAP(
  clk => clk, rst => reset,
    router_north_packet_in => south_packet_out_6,
    router_north_ready_out => south_ready_in_6,
    router_east_packet_out => east_packet_out_0,
    router_east_ready_in => east_ready_in_0,
    router_south_packet_out => south_packet_out_0,
    router_south_ready_in => south_ready_in_0,
    router_west_packet_in => east_packet_out_2,
    router_west_ready_out => east_ready_in_2,
    router_local_packet_in => local_packet_in(0)(0),
    router_local_ready_out => local_ready_out(0)(0),
    router_local_packet_out => local_packet_out(0)(0),
    router_local_ready_in => local_ready_in(0)(0)
  );


  router1: router PORT MAP(
  clk => clk, rst => reset,
    router_north_packet_in => south_packet_out_7,
    router_north_ready_out => south_ready_in_7,
    router_east_packet_out => east_packet_out_1,
    router_east_ready_in => east_ready_in_1,
    router_south_packet_out => south_packet_out_1,
    router_south_ready_in => south_ready_in_1,
    router_west_packet_in => east_packet_out_0,
    router_west_ready_out => east_ready_in_0,
    router_local_packet_in => local_packet_in(0)(1),
    router_local_ready_out => local_ready_out(0)(1),
    router_local_packet_out => local_packet_out(0)(1),
    router_local_ready_in => local_ready_in(0)(1)
  );


  router2: router PORT MAP(
  clk => clk, rst => reset,
    router_north_packet_in => south_packet_out_8,
    router_north_ready_out => south_ready_in_8,
    router_east_packet_out => east_packet_out_2,
    router_east_ready_in => east_ready_in_2,
    router_south_packet_out => south_packet_out_2,
    router_south_ready_in => south_ready_in_2,
    router_west_packet_in => east_packet_out_1,
    router_west_ready_out => east_ready_in_1,
    router_local_packet_in => local_packet_in(0)(2),
    router_local_ready_out => local_ready_out(0)(2),
    router_local_packet_out => local_packet_out(0)(2),
    router_local_ready_in => local_ready_in(0)(2)
  );


  router3: router PORT MAP(
  clk => clk, rst => reset,
    router_north_packet_in => south_packet_out_0,
    router_north_ready_out => south_ready_in_0,
    router_east_packet_out => east_packet_out_3,
    router_east_ready_in => east_ready_in_3,
    router_south_packet_out => south_packet_out_3,
    router_south_ready_in => south_ready_in_3,
    router_west_packet_in => east_packet_out_5,
    router_west_ready_out => east_ready_in_5,
    router_local_packet_in => local_packet_in(1)(0),
    router_local_ready_out => local_ready_out(1)(0),
    router_local_packet_out => local_packet_out(1)(0),
    router_local_ready_in => local_ready_in(1)(0)
  );


  router4: router PORT MAP(
  clk => clk, rst => reset,
    router_north_packet_in => south_packet_out_1,
    router_north_ready_out => south_ready_in_1,
    router_east_packet_out => east_packet_out_4,
    router_east_ready_in => east_ready_in_4,
    router_south_packet_out => south_packet_out_4,
    router_south_ready_in => south_ready_in_4,
    router_west_packet_in => east_packet_out_3,
    router_west_ready_out => east_ready_in_3,
    router_local_packet_in => local_packet_in(1)(1),
    router_local_ready_out => local_ready_out(1)(1),
    router_local_packet_out => local_packet_out(1)(1),
    router_local_ready_in => local_ready_in(1)(1)
  );


  router5: router PORT MAP(
  clk => clk, rst => reset,
    router_north_packet_in => south_packet_out_2,
    router_north_ready_out => south_ready_in_2,
    router_east_packet_out => east_packet_out_5,
    router_east_ready_in => east_ready_in_5,
    router_south_packet_out => south_packet_out_5,
    router_south_ready_in => south_ready_in_5,
    router_west_packet_in => east_packet_out_4,
    router_west_ready_out => east_ready_in_4,
    router_local_packet_in => local_packet_in(1)(2),
    router_local_ready_out => local_ready_out(1)(2),
    router_local_packet_out => local_packet_out(1)(2),
    router_local_ready_in => local_ready_in(1)(2)
  );


  router6: router PORT MAP(
  clk => clk, rst => reset,
    router_north_packet_in => south_packet_out_3,
    router_north_ready_out => south_ready_in_3,
    router_east_packet_out => east_packet_out_6,
    router_east_ready_in => east_ready_in_6,
    router_south_packet_out => south_packet_out_6,
    router_south_ready_in => south_ready_in_6,
    router_west_packet_in => east_packet_out_8,
    router_west_ready_out => east_ready_in_8,
    router_local_packet_in => local_packet_in(2)(0),
    router_local_ready_out => local_ready_out(2)(0),
    router_local_packet_out => local_packet_out(2)(0),
    router_local_ready_in => local_ready_in(2)(0)
  );


  router7: router PORT MAP(
  clk => clk, rst => reset,
    router_north_packet_in => south_packet_out_4,
    router_north_ready_out => south_ready_in_4,
    router_east_packet_out => east_packet_out_7,
    router_east_ready_in => east_ready_in_7,
    router_south_packet_out => south_packet_out_7,
    router_south_ready_in => south_ready_in_7,
    router_west_packet_in => east_packet_out_6,
    router_west_ready_out => east_ready_in_6,
    router_local_packet_in => local_packet_in(2)(1),
    router_local_ready_out => local_ready_out(2)(1),
    router_local_packet_out => local_packet_out(2)(1),
    router_local_ready_in => local_ready_in(2)(1)
  );


  router8: router PORT MAP(
  clk => clk, rst => reset,
    router_north_packet_in => south_packet_out_5,
    router_north_ready_out => south_ready_in_5,
    router_east_packet_out => east_packet_out_8,
    router_east_ready_in => east_ready_in_8,
    router_south_packet_out => south_packet_out_8,
    router_south_ready_in => south_ready_in_8,
    router_west_packet_in => east_packet_out_7,
    router_west_ready_out => east_ready_in_7,
    router_local_packet_in => local_packet_in(2)(2),
    router_local_ready_out => local_ready_out(2)(2),
    router_local_packet_out => local_packet_out(2)(2),
    router_local_ready_in => local_ready_in(2)(2)
  );

  
end struct;