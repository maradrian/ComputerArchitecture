LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.all;
USE IEEE.std_logic_unsigned.ALL;
USE work.noc_types.all;


ENTITY quad_fifo IS
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
    sReady_in_fifo_d_out   : in packet_s_type;
    
    --debug
    read : out std_logic_vector(2 downto 0);
    write : out std_logic_vector(2 downto 0);
    word1 : out std_logic_vector(95 downto 0);
    word2 : OUT std_logic_vector(95 downto 0);
    word3 : out std_logic_vector(95 downto 0);
    size : out integer);
END quad_fifo;


ARCHITECTURE quad_fifo_arch OF quad_fifo IS

  COMPONENT fifo IS
    GENERIC ( WIDTH : positive := 2);
    PORT (
      clk, rst : in std_logic;
      mPacket_in : in packet_m_type;
      mPacket_out : out packet_m_type;
      sReady_in: in packet_s_type;
      sReady_out: out packet_s_type );
  END COMPONENT;
  

BEGIN

  u_a : fifo PORT MAP (
    rst => rst,
    clk => clk,
    mPacket_in => mPacket_in_fifo_a_in,
    sReady_out => sReady_out_fifo_a_in,
    mPacket_out => mPacket_out_fifo_a_out,
    sReady_in => sReady_in_fifo_a_out );

  u_b : fifo PORT MAP (
    rst => rst,
    clk => clk,
    mPacket_in => mPacket_in_fifo_b_in,
    sReady_out => sReady_out_fifo_b_in,
    mPacket_out => mPacket_out_fifo_b_out,
    sReady_in => sReady_in_fifo_b_out );

  u_c : fifo PORT MAP (
    rst => rst,
    clk => clk,
    mPacket_in => mPacket_in_fifo_c_in,
    sReady_out => sReady_out_fifo_c_in,
    mPacket_out => mPacket_out_fifo_c_out,
    sReady_in => sReady_in_fifo_c_out);

  u_d : fifo PORT MAP (
    rst => rst,
    clk => clk,
    mPacket_in => mPacket_in_fifo_d_in,
    sReady_out => sReady_out_fifo_d_in,
    mPacket_out => mPacket_out_fifo_d_out,
    sReady_in => sReady_in_fifo_d_out );

END quad_fifo_arch;
