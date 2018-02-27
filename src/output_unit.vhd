LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.all;
USE IEEE.std_logic_unsigned.ALL;
USE work.noc_types.all;


ENTITY output_unit IS
PORT ( 
  clk, rst : in std_logic;

  -- FIFO 1st in, 00
  first_fifo_mPacket_in : in packet_m_type;
  first_fifo_sReady_out: out packet_s_type;

  -- FIFO 2nd in, 01
  second_fifo_mPacket_in : in packet_m_type;
  second_fifo_sReady_out: out packet_s_type;

  -- FIFO 3rd in, 10
  third_fifo_mPacket_in : in packet_m_type;
  third_fifo_sReady_out: out packet_s_type;

  -- FIFO 4th in, 11
  fourth_fifo_mPacket_in : in packet_m_type;
  fourth_fifo_sReady_out: out packet_s_type;

  -- Mux out
  mux_mPacket_out : out packet_m_type;    
  mux_sReady_in: in packet_s_type );
END output_unit;

ARCHITECTURE output_unit_arch OF output_unit IS

  COMPONENT quad_fifo IS
  PORT (
    rst : in std_logic;
    clk : in std_logic;

    -- Packet 1st in, 00
    mPacket_in_fifo_a_in : in packet_m_type;
    sReady_out_fifo_a_in : out packet_s_type;
    
    -- Packet 2nd in, 01
    mPacket_in_fifo_b_in : in packet_m_type;
    sReady_out_fifo_b_in : out packet_s_type;
    
    -- Packet 3rd in, 10
    mPacket_in_fifo_c_in : in packet_m_type;
    sReady_out_fifo_c_in : out packet_s_type;
    
    -- Packet 4th in, 11
    mPacket_in_fifo_d_in : in packet_m_type;
    sReady_out_fifo_d_in : out packet_s_type;


    -- Packet 1st out, 00
    mPacket_out_fifo_a_out : out packet_m_type;    
    sReady_in_fifo_a_out   : in packet_s_type;

    -- Packet 2nd out, 01
    mPacket_out_fifo_b_out : out packet_m_type;    
    sReady_in_fifo_b_out   : in packet_s_type;

    -- Packet 3rd out, 10
    mPacket_out_fifo_c_out : out packet_m_type;    
    sReady_in_fifo_c_out   : in packet_s_type;

    -- Packet 4th out, 11
    mPacket_out_fifo_d_out : out packet_m_type;    
    sReady_in_fifo_d_out   : in packet_s_type );
  END COMPONENT;

  COMPONENT arbiter is
  PORT ( 
    clk_arbiter, rst_arbiter : in std_logic;
    
    -- Packet 1st in, 00
    first_mPacket_in_arbiter : in packet_m_type;
    first_sReady_out_arbiter: out packet_s_type;
    
    -- Packet 2nd in, 01
    second_mPacket_in_arbiter : in packet_m_type;
    second_sReady_out_arbiter : out packet_s_type;
    
    -- Packet 3rd in, 10
    third_mPacket_in_arbiter : in packet_m_type;
    third_sReady_out_arbiter : out packet_s_type;
    
    -- Packet 4th in, 11
    fourth_mPacket_in_arbiter : in packet_m_type;
    fourth_sReady_out_arbiter : out packet_s_type;
    
    -- Packet out  
    mPacket_out_arbiter : out packet_m_type;    
    sReady_in_arbiter : in packet_s_type );
  END COMPONENT;
  
  SIGNAL mPacket_out_fifo_a_out_first_mPacket_in_arbiter : packet_m_type;
  SIGNAL sReady_in_fifo_a_out_first_sReady_out_arbiter : packet_s_type;

  SIGNAL mPacket_out_fifo_b_out_second_mPacket_in_arbiter : packet_m_type;
  SIGNAL sReady_in_fifo_b_out_second_sReady_out_arbiter : packet_s_type;

  SIGNAL mPacket_out_fifo_c_out_third_mPacket_in_arbiter : packet_m_type;
  SIGNAL sReady_in_fifo_c_out_third_sReady_out_arbiter : packet_s_type;

  SIGNAL mPacket_out_fifo_d_out_fourth_mPacket_in_arbiter : packet_m_type;
  SIGNAL sReady_in_fifo_d_out_fourth_sReady_out_arbiter : packet_s_type;

BEGIN

  u1 : quad_fifo  PORT MAP (
    rst => rst,
    clk => clk,

    -- Packet 1st in, 00
    mPacket_in_fifo_a_in => first_fifo_mPacket_in,
    sReady_out_fifo_a_in => first_fifo_sReady_out,
    
    -- Packet 2nd in, 01
    mPacket_in_fifo_b_in => second_fifo_mPacket_in,
    sReady_out_fifo_b_in => second_fifo_sReady_out,
    
    -- Packet 3rd in, 10
    mPacket_in_fifo_c_in => third_fifo_mPacket_in,
    sReady_out_fifo_c_in => third_fifo_sReady_out,
    
    -- Packet 4th in, 11
    mPacket_in_fifo_d_in => fourth_fifo_mPacket_in,
    sReady_out_fifo_d_in => fourth_fifo_sReady_out,

    -- Packet 1st out, 00
    mPacket_out_fifo_a_out => mPacket_out_fifo_a_out_first_mPacket_in_arbiter,
    sReady_in_fifo_a_out => sReady_in_fifo_a_out_first_sReady_out_arbiter,

    -- Packet 2nd out, 01
    mPacket_out_fifo_b_out => mPacket_out_fifo_b_out_second_mPacket_in_arbiter,
    sReady_in_fifo_b_out => sReady_in_fifo_b_out_second_sReady_out_arbiter,

    -- Packet 3rd out, 10
    mPacket_out_fifo_c_out => mPacket_out_fifo_c_out_third_mPacket_in_arbiter,
    sReady_in_fifo_c_out => sReady_in_fifo_c_out_third_sReady_out_arbiter,

    -- Packet 4th out, 11
    mPacket_out_fifo_d_out => mPacket_out_fifo_d_out_fourth_mPacket_in_arbiter,
    sReady_in_fifo_d_out => sReady_in_fifo_d_out_fourth_sReady_out_arbiter );

  u2 : arbiter PORT MAP ( 
    clk_arbiter => clk,
    rst_arbiter => rst,
    
    -- Packet 1st in, 00
    first_mPacket_in_arbiter => mPacket_out_fifo_a_out_first_mPacket_in_arbiter,
    first_sReady_out_arbiter => sReady_in_fifo_a_out_first_sReady_out_arbiter,
    
    -- Packet 2nd in, 01
    second_mPacket_in_arbiter => mPacket_out_fifo_b_out_second_mPacket_in_arbiter,
    second_sReady_out_arbiter => sReady_in_fifo_b_out_second_sReady_out_arbiter,
    
    -- Packet 3rd in, 10
    third_mPacket_in_arbiter => mPacket_out_fifo_c_out_third_mPacket_in_arbiter,
    third_sReady_out_arbiter => sReady_in_fifo_c_out_third_sReady_out_arbiter,
    
    -- Packet 4th in, 11
    fourth_mPacket_in_arbiter => mPacket_out_fifo_d_out_fourth_mPacket_in_arbiter,
    fourth_sReady_out_arbiter => sReady_in_fifo_d_out_fourth_sReady_out_arbiter,
    
    -- Packet out  
    mPacket_out_arbiter => mux_mPacket_out,
    sReady_in_arbiter => mux_sReady_in );

END output_unit_arch;
