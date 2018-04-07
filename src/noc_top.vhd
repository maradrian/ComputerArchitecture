library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.noc_types.all;

entity noc_top is
 generic (PACKET_WIDTH : integer:= 96);
 port(
  clk : in std_logic;
  rst : in std_logic;
  
  --Router 0
  --Local packet/valid IN + Local ready OUT 
  local_packet_in_0: in std_logic_vector(PACKET_WIDTH-1 downto 0);
  local_valid_in_0: in std_logic;
  local_ready_out_0: out std_logic;
  
  --Local packet/valid OUT + Local ready IN 
  local_packet_out_0: out std_logic_vector(PACKET_WIDTH-1 downto 0);
  local_valid_out_0: out std_logic;
  local_ready_in_0: in std_logic;
  ------------------------------------------------------------------
  
  --Router 1
  --Local packet/valid IN + Local ready OUT 
  local_packet_in_1: in std_logic_vector(PACKET_WIDTH-1 downto 0);
  local_valid_in_1: in std_logic;
  local_ready_out_1: out std_logic;
  
  --Local packet/valid OUT + Local ready IN 
  local_packet_out_1: out std_logic_vector(PACKET_WIDTH-1 downto 0);
  local_valid_out_1: out std_logic;
  local_ready_in_1: in std_logic;
  ------------------------------------------------------------------

  --Router 2
  --Local packet/valid IN + Local ready OUT 
  local_packet_in_2: in std_logic_vector(PACKET_WIDTH-1 downto 0);
  local_valid_in_2: in std_logic;
  local_ready_out_2: out std_logic;
  
  --Local packet/valid OUT + Local ready IN 
  local_packet_out_2: out std_logic_vector(PACKET_WIDTH-1 downto 0);
  local_valid_out_2: out std_logic;
  local_ready_in_2: in std_logic;
  ------------------------------------------------------------------
  
  --Router 3
  --Local packet/valid IN + Local ready OUT 
  local_packet_in_3: in std_logic_vector(PACKET_WIDTH-1 downto 0);
  local_valid_in_3: in std_logic;
  local_ready_out_3: out std_logic;
    
  --Local packet/valid OUT + Local ready IN 
  local_packet_out_3: out std_logic_vector(PACKET_WIDTH-1 downto 0);
  local_valid_out_3: out std_logic;
  local_ready_in_3: in std_logic;
  ------------------------------------------------------------------
  
  --Router 4
  --Local packet/valid IN + Local ready OUT 
  local_packet_in_4: in std_logic_vector(PACKET_WIDTH-1 downto 0);
  local_valid_in_4: in std_logic;
  local_ready_out_4: out std_logic;
    
  --Local packet/valid OUT + Local ready IN 
  local_packet_out_4: out std_logic_vector(PACKET_WIDTH-1 downto 0);
  local_valid_out_4: out std_logic;
  local_ready_in_4: in std_logic;
  ------------------------------------------------------------------
  
  --Router 5
  --Local packet/valid IN + Local ready OUT 
  local_packet_in_5: in std_logic_vector(PACKET_WIDTH-1 downto 0);
  local_valid_in_5: in std_logic;
  local_ready_out_5: out std_logic;
    
  --Local packet/valid OUT + Local ready IN 
  local_packet_out_5: out std_logic_vector(PACKET_WIDTH-1 downto 0);
  local_valid_out_5: out std_logic;
  local_ready_in_5: in std_logic;
  ------------------------------------------------------------------
  
  --Router 6
  --Local packet/valid IN + Local ready OUT 
  local_packet_in_6: in std_logic_vector(PACKET_WIDTH-1 downto 0);
  local_valid_in_6: in std_logic;
  local_ready_out_6: out std_logic;
    
  --Local packet/valid OUT + Local ready IN 
  local_packet_out_6: out std_logic_vector(PACKET_WIDTH-1 downto 0);
  local_valid_out_6: out std_logic;
  local_ready_in_6: in std_logic;
  ------------------------------------------------------------------
  
  --Router 7
  --Local packet/valid IN + Local ready OUT 
  local_packet_in_7: in std_logic_vector(PACKET_WIDTH-1 downto 0);
  local_valid_in_7: in std_logic;
  local_ready_out_7: out std_logic;
    
  --Local packet/valid OUT + Local ready IN 
  local_packet_out_7: out std_logic_vector(PACKET_WIDTH-1 downto 0);
  local_valid_out_7: out std_logic;
  local_ready_in_7: in std_logic;
  ------------------------------------------------------------------
    
  --Router 8
  --Local packet/valid IN + Local ready OUT 
  local_packet_in_8: in std_logic_vector(PACKET_WIDTH-1 downto 0);
  local_valid_in_8: in std_logic;
  local_ready_out_8: out std_logic;
    
  --Local packet/valid OUT + Local ready IN 
  local_packet_out_8: out std_logic_vector(PACKET_WIDTH-1 downto 0);
  local_valid_out_8: out std_logic;
  local_ready_in_8: in std_logic
  ------------------------------------------------------------------
  );   
end noc_top;

architecture noc_top_arch of noc_top is

component noc
 port(
  clk : in std_logic;
  reset : in std_logic;
  
  local_packet_in  : in link_m_f;
  local_ready_out : out link_m_b;
  
  local_packet_out  : out link_m_f;
  local_ready_in : in link_m_b
  );   
end component;

--All Local packet/valid IN + Local ready OUT
signal local_packet_in_array: link_m_f;
signal local_ready_out_array: link_m_b;
--All Local packet/valid OUT + Local ready IN
signal local_packet_out_array: link_m_f;
signal local_ready_in_array: link_m_b;

begin

--Router 0                       
local_packet_in_array(0)(0).packet <= local_packet_in_0;
local_packet_in_array(0)(0).valid <= local_valid_in_0;
local_ready_out_0 <= local_ready_out_array(0)(0).ready;

local_packet_out_0 <= local_packet_out_array(0)(0).packet;
local_valid_out_0 <= local_packet_out_array(0)(0).valid;
local_ready_in_array(0)(0).ready <= local_ready_in_0;

--Router 1
local_packet_in_array(0)(1).packet <= local_packet_in_1;
local_packet_in_array(0)(1).valid <= local_valid_in_1;
local_ready_out_1 <= local_ready_out_array(0)(1).ready;

local_packet_out_1 <= local_packet_out_array(0)(1).packet;
local_valid_out_1 <= local_packet_out_array(0)(1).valid;
local_ready_in_array(0)(1).ready <= local_ready_in_1;

--Router 2
local_packet_in_array(0)(2).packet <= local_packet_in_2;
local_packet_in_array(0)(2).valid <= local_valid_in_2;
local_ready_out_2 <= local_ready_out_array(0)(2).ready;

local_packet_out_2 <= local_packet_out_array(0)(2).packet;
local_valid_out_2 <= local_packet_out_array(0)(2).valid;
local_ready_in_array(0)(2).ready <= local_ready_in_2;

--Router 3
local_packet_in_array(1)(0).packet <= local_packet_in_3;
local_packet_in_array(1)(0).valid <= local_valid_in_3;
local_ready_out_3 <= local_ready_out_array(1)(0).ready;

local_packet_out_3 <= local_packet_out_array(1)(0).packet;
local_valid_out_3 <= local_packet_out_array(1)(0).valid;
local_ready_in_array(1)(0).ready <= local_ready_in_3;

--Router 4
local_packet_in_array(1)(1).packet <= local_packet_in_4;
local_packet_in_array(1)(1).valid <= local_valid_in_4;
local_ready_out_4 <= local_ready_out_array(1)(1).ready;

local_packet_out_4 <= local_packet_out_array(1)(1).packet;
local_valid_out_4 <= local_packet_out_array(1)(1).valid;
local_ready_in_array(1)(1).ready <= local_ready_in_4;

--Router 5
local_packet_in_array(1)(2).packet <= local_packet_in_5;
local_packet_in_array(1)(2).valid <= local_valid_in_5;
local_ready_out_5 <= local_ready_out_array(1)(2).ready;

local_packet_out_5 <= local_packet_out_array(1)(2).packet;
local_valid_out_5 <= local_packet_out_array(1)(2).valid;
local_ready_in_array(1)(2).ready <= local_ready_in_5;

--Router 6
local_packet_in_array(2)(0).packet <= local_packet_in_6;
local_packet_in_array(2)(0).valid <= local_valid_in_6;
local_ready_out_6 <= local_ready_out_array(2)(0).ready;

local_packet_out_6 <= local_packet_out_array(2)(0).packet;
local_valid_out_6 <= local_packet_out_array(2)(0).valid;
local_ready_in_array(2)(0).ready <= local_ready_in_6;

--Router 7
local_packet_in_array(2)(1).packet <= local_packet_in_7;
local_packet_in_array(2)(1).valid <= local_valid_in_7;
local_ready_out_7 <= local_ready_out_array(2)(1).ready;

local_packet_out_7 <= local_packet_out_array(2)(1).packet;
local_valid_out_7 <= local_packet_out_array(2)(1).valid;
local_ready_in_array(2)(1).ready <= local_ready_in_7;

--Router 8
local_packet_in_array(2)(2).packet <= local_packet_in_8;
local_packet_in_array(2)(2).valid <= local_valid_in_8;
local_ready_out_8 <= local_ready_out_array(2)(2).ready;

local_packet_out_8 <= local_packet_out_array(2)(2).packet;
local_valid_out_8 <= local_packet_out_array(2)(2).valid;
local_ready_in_array(2)(2).ready <= local_ready_in_8;

noc_unit: noc
 port map(
  clk => clk,
  reset => rst,

  --Local packet/valid IN + Local ready OUT 
  local_packet_in => local_packet_in_array,
  local_ready_out => local_ready_out_array,
  --Local packet/valid OUT + Local ready IN 
  local_packet_out => local_packet_out_array,
  local_ready_in => local_ready_in_array
  );   
  
end noc_top_arch;