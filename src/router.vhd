library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use work.noc_types.all;

entity router is 
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
end router;

architecture router_arch of router is

--SIGNALS AND COMPONENTS

--North splitter/output_unit signals
signal north_splitter_east_north_packet, north_splitter_south_north_packet,
       north_splitter_west_north_packet, north_splitter_local_north_packet: packet_m_type;
signal north_splitter_east_north_ready, north_splitter_south_north_ready,
       north_splitter_west_north_ready, north_splitter_local_north_ready: packet_s_type;
       
--East splitter/output_unit signals
signal east_splitter_north_east_packet, east_splitter_south_east_packet,
       east_splitter_west_east_packet, east_splitter_local_east_packet: packet_m_type;
signal east_splitter_north_east_ready, east_splitter_south_east_ready,
       east_splitter_west_east_ready, east_splitter_local_east_ready: packet_s_type;
       
--South splitter/output_unit signals
signal south_splitter_north_south_packet, south_splitter_east_south_packet,
       south_splitter_west_south_packet, south_splitter_local_south_packet: packet_m_type;
signal south_splitter_north_south_ready, south_splitter_east_south_ready,
       south_splitter_west_south_ready, south_splitter_local_south_ready: packet_s_type;
       
--West splitter/output_unit signals
signal west_splitter_north_west_packet, west_splitter_east_west_packet,
       west_splitter_south_west_packet, west_splitter_local_west_packet: packet_m_type;
signal west_splitter_north_west_ready, west_splitter_east_west_ready,
       west_splitter_south_west_ready, west_splitter_local_west_ready: packet_s_type; 
       
--Local splitter/output_unit signals
signal local_splitter_north_local_packet, local_splitter_east_local_packet,
       local_splitter_south_local_packet, local_splitter_west_local_packet: packet_m_type;
signal local_splitter_north_local_ready, local_splitter_east_local_ready,
       local_splitter_south_local_ready, local_splitter_west_local_ready: packet_s_type;       
       

component splitter_top
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
          west_ready_in: in packet_s_type
);
end component;

component output_unit
    port( 
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
        mux_sReady_in: in packet_s_type
);
end component;

begin 
--Instantiate components

--------------------------------------SPLITTERS START--------------------------------------
north_splitter : splitter_top
	port map(
        rst => rst,
	    clk => clk,
	    mPacket_in => router_north_packet_in,
        sReady_out => router_north_ready_out,
        --Local output
        local_mPacket_out => north_splitter_local_north_packet,
        local_ready_in => north_splitter_local_north_ready,
        --North output
        north_mPacket_out => open,
        north_ready_in.ready => '0',
        --South output
        south_mPacket_out => north_splitter_south_north_packet,
        south_ready_in => north_splitter_east_north_ready,
        --East output
        east_mPacket_out => north_splitter_east_north_packet,
        east_ready_in => north_splitter_east_north_ready,
        --West output
        west_mPacket_out => north_splitter_west_north_packet,
        west_ready_in => north_splitter_west_north_ready
);

east_splitter : splitter_top
	port map(
	    rst => rst,
        clk => clk,
        --Unused ports
	    mPacket_in.packet => (others => '0'),
	    mPacket_in.valid => '0',
        sReady_out => open,
        --Local output
        local_mPacket_out => east_splitter_local_east_packet,
        local_ready_in => east_splitter_local_east_ready,
        --North output
        north_mPacket_out => east_splitter_north_east_packet,
        north_ready_in => east_splitter_north_east_ready,
        --East output
        east_mPacket_out => open,
        east_ready_in.ready => '0',
        --South output
        south_mPacket_out => east_splitter_south_east_packet,
        south_ready_in => east_splitter_south_east_ready,
        --West output
        west_mPacket_out => east_splitter_west_east_packet,
        west_ready_in => east_splitter_west_east_ready
);


south_splitter : splitter_top
	port map(
	    rst => rst,
        clk => clk,
	
	    --Unused ports
	    mPacket_in.packet => (others => '0'),
	    mPacket_in.valid => '0',
        sReady_out => open,
        --Local output
        local_mPacket_out => south_splitter_local_south_packet,
        local_ready_in => south_splitter_local_south_ready,
        --North output
        north_mPacket_out => south_splitter_north_south_packet,
        north_ready_in => south_splitter_north_south_ready,
        --East output
        east_mPacket_out => south_splitter_east_south_packet,
        east_ready_in => south_splitter_east_south_ready,
        --South output
        south_mPacket_out => open,
        south_ready_in.ready => '0',
        --West output
        west_mPacket_out => south_splitter_west_south_packet,
        west_ready_in => south_splitter_west_south_ready
);

west_splitter : splitter_top
	port map(
	    rst => rst,
        clk => clk,
	    mPacket_in => router_west_packet_in,
        sReady_out => router_west_ready_out,
        --Local output
        local_mPacket_out => west_splitter_local_west_packet,
        local_ready_in => west_splitter_local_west_ready,
        --North output
        north_mPacket_out => west_splitter_north_west_packet,
        north_ready_in => west_splitter_north_west_ready,
        --East output
        east_mPacket_out => west_splitter_east_west_packet,
        east_ready_in => west_splitter_east_west_ready,
        --South output
        south_mPacket_out => west_splitter_south_west_packet,
        south_ready_in => west_splitter_south_west_ready,
        --West output
        west_mPacket_out => open,
        west_ready_in.ready => '0'
);

local_splitter : splitter_top
	port map(
	    rst => rst,
        clk => clk,
	    mPacket_in => router_local_packet_in,
        sReady_out => router_local_ready_out,
        --Local output
        local_mPacket_out => open,
        local_ready_in.ready => '0',
        --West output
        west_mPacket_out => local_splitter_west_local_packet,
        west_ready_in => local_splitter_west_local_ready,
        --East output
        east_mPacket_out => local_splitter_east_local_packet,
        east_ready_in => local_splitter_east_local_ready,
        --North output
        north_mPacket_out => local_splitter_north_local_packet,
        north_ready_in => local_splitter_north_local_ready,
        --South output
        south_mPacket_out => local_splitter_south_local_packet,
        south_ready_in => local_splitter_south_local_ready
);
--------------------------------------SPLITTERS END--------------------------------------



------------------------------------OUTPUT_UNIT START------------------------------------
north_unit_out : output_unit
	port map(
	    clk => clk,
	    rst => rst,
    
        -- FIFO 1st in, 00 (EAST)
        first_fifo_mPacket_in => east_splitter_north_east_packet,
        first_fifo_sReady_out => east_splitter_north_east_ready,
        
        -- FIFO 2nd in, 01 (SOUTH)
        second_fifo_mPacket_in => south_splitter_north_south_packet,
        second_fifo_sReady_out => south_splitter_north_south_ready,
    
        -- FIFO 3rd in, 10 (WEST)
        third_fifo_mPacket_in => west_splitter_north_west_packet,
        third_fifo_sReady_out => west_splitter_north_west_ready,
    
        -- FIFO 4th in, 11 (LOCAL)
        fourth_fifo_mPacket_in => local_splitter_north_local_packet,
        fourth_fifo_sReady_out => local_splitter_north_local_ready,
    
        -- Mux out, Unused ports
        mux_mPacket_out => open,  
        mux_sReady_in.ready => '0'
);

east_unit_out : output_unit
	port map(
	    clk => clk,
	    rst => rst,
    
        -- FIFO 1st in, 00 (NORTH)
        first_fifo_mPacket_in => north_splitter_east_north_packet,
        first_fifo_sReady_out => north_splitter_east_north_ready,
        
        -- FIFO 2nd in, 01 (SOUTH)
        second_fifo_mPacket_in => south_splitter_east_south_packet,
        second_fifo_sReady_out => south_splitter_east_south_ready,
    
        -- FIFO 3rd in, 10 (WEST)
        third_fifo_mPacket_in => west_splitter_east_west_packet,
        third_fifo_sReady_out => west_splitter_east_west_ready,
    
        -- FIFO 4th in, 11 (LOCAL)
        fourth_fifo_mPacket_in => local_splitter_east_local_packet,
        fourth_fifo_sReady_out => local_splitter_east_local_ready,
    
        -- Mux out
        mux_mPacket_out => router_east_packet_out,  
        mux_sReady_in => router_east_ready_in
);

south_unit_out : output_unit
	port map(
	    clk => clk,
	    rst => rst,
    
        -- FIFO 1st in, 00 (NORTH)
        first_fifo_mPacket_in => north_splitter_south_north_packet,
        first_fifo_sReady_out => north_splitter_south_north_ready,
        
        -- FIFO 2nd in, 01 (EAST)
        second_fifo_mPacket_in => east_splitter_south_east_packet,
        second_fifo_sReady_out => east_splitter_south_east_ready,
    
        -- FIFO 3rd in, 10 (WEST)
        third_fifo_mPacket_in => west_splitter_south_west_packet,
        third_fifo_sReady_out => west_splitter_south_west_ready,
    
        -- FIFO 4th in, 11 (LOCAL)
        fourth_fifo_mPacket_in => local_splitter_south_local_packet,
        fourth_fifo_sReady_out => local_splitter_south_local_ready,
    
        -- Mux out
        mux_mPacket_out => router_south_packet_out,  
        mux_sReady_in => router_south_ready_in
);

west_unit_out : output_unit
	port map(
	    clk => clk,
	    rst => rst,
    
        -- FIFO 1st in, 00 (NORTH)
        first_fifo_mPacket_in => north_splitter_west_north_packet,
        first_fifo_sReady_out => north_splitter_west_north_ready,
        
        -- FIFO 2nd in, 01 (EAST)
        second_fifo_mPacket_in => east_splitter_west_east_packet,
        second_fifo_sReady_out => east_splitter_west_east_ready,
    
        -- FIFO 3rd in, 10 (SOUTH)
        third_fifo_mPacket_in => south_splitter_west_south_packet,
        third_fifo_sReady_out => south_splitter_west_south_ready,
    
        -- FIFO 4th in, 11 (LOCAL)
        fourth_fifo_mPacket_in => local_splitter_west_local_packet,
        fourth_fifo_sReady_out => local_splitter_west_local_ready,
    
        -- Mux out, Unused ports
        mux_mPacket_out => open,  
        mux_sReady_in.ready => '0'
);

local_unit_out : output_unit
	port map(
	    clk => clk,
	    rst => rst,
    
        -- FIFO 1st in, 00 (NORTH)
        first_fifo_mPacket_in => north_splitter_local_north_packet,
        first_fifo_sReady_out => north_splitter_local_north_ready,
        
        -- FIFO 2nd in, 01 (EAST)
        second_fifo_mPacket_in => east_splitter_local_east_packet,
        second_fifo_sReady_out => east_splitter_local_east_ready,
    
        -- FIFO 3rd in, 10 (SOUTH)
        third_fifo_mPacket_in => south_splitter_local_south_packet,
        third_fifo_sReady_out => south_splitter_local_south_ready,
    
        -- FIFO 4th in, 11 (WEST)
        fourth_fifo_mPacket_in => west_splitter_local_west_packet,
        fourth_fifo_sReady_out => west_splitter_local_west_ready,
    
        -- Mux out
        mux_mPacket_out => router_local_packet_out,  
        mux_sReady_in => router_local_ready_in
);

-------------------------------------OUTPUT_UNIT END-------------------------------------
end router_arch;