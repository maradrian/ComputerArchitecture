library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use work.noc_types.all;

entity arbiter is 
port( 
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
    sReady_in_arbiter : in packet_s_type
);
end arbiter;

architecture arbiter_arch of arbiter is

--Signals and components
signal grant_signal: std_logic_vector(2 downto 0):= (others => '0');

component round_robin_arbiter
    port( 
        --Arbiter takes clk and rst, four valid signals, ready signal, 
        clk, rst : in std_logic;
        sReady_in: in packet_s_type;
        --1st, 00
        first_valid_in : in std_logic;
        --2nd, 01
        second_valid_in : in std_logic;
        --3rd, 10
        third_valid_in : in std_logic;
        --4th, 11
        fourth_valid_in : in std_logic;
        --Arbiter passes grant signal to mux_arbiter
        grant: out std_logic_vector(2 downto 0)
);
end component;

component mux_arbiter
    port(
        clk, rst : in std_logic;
        grant : in std_logic_vector(2 downto 0);
    
        -- Mux 1st in, 00
        first_mPacket_in : in packet_m_type;
        first_sReady_out: out packet_s_type;

        -- Mux 2nd in, 01
        second_mPacket_in : in packet_m_type;
        second_sReady_out: out packet_s_type;

        -- Mux 3rd in, 10
        third_mPacket_in : in packet_m_type;
        third_sReady_out: out packet_s_type;

        -- Mux 4th in, 11
        fourth_mPacket_in : in packet_m_type;
        fourth_sReady_out: out packet_s_type;

        -- Mux out  
        mPacket_out : out packet_m_type;    
        sReady_in: in packet_s_type
        );
end component;


begin 
--Instantiate components
dut0 : round_robin_arbiter
	port map(
	      --Arbiter takes clk and rst, four valid signals, ready signal, 
          clk => clk_arbiter, 
          rst => rst_arbiter, 
          sReady_in.ready => sReady_in_arbiter.ready,
          --1st, 00
          first_valid_in => first_mPacket_in_arbiter.valid,
          --2nd, 01
          second_valid_in => second_mPacket_in_arbiter.valid,
          --3rd, 10
          third_valid_in => third_mPacket_in_arbiter.valid,
          --4th, 11
          fourth_valid_in => fourth_mPacket_in_arbiter.valid,
          --Arbiter passes grant signal to mux_arbiter
          grant => grant_signal
);

dut1 : mux_arbiter
	port map(
	    clk => clk_arbiter,
	    rst => rst_arbiter,
        grant => grant_signal,
        
        -- Mux 1st in, 00
        first_mPacket_in.packet => first_mPacket_in_arbiter.packet,
        first_mPacket_in.valid => first_mPacket_in_arbiter.valid,
        first_sReady_out.ready => first_sReady_out_arbiter.ready,
    
        -- Mux 2nd in, 01
        second_mPacket_in.packet => second_mPacket_in_arbiter.packet,
        second_mPacket_in.valid => second_mPacket_in_arbiter.valid,
        second_sReady_out.ready => second_sReady_out_arbiter.ready,
    
        -- Mux 3rd in, 10
        third_mPacket_in.packet => third_mPacket_in_arbiter.packet,
        third_mPacket_in.valid => third_mPacket_in_arbiter.valid,
        third_sReady_out.ready => third_sReady_out_arbiter.ready,
    
        -- Mux 4th in, 11
        fourth_mPacket_in.packet => fourth_mPacket_in_arbiter.packet,
        fourth_mPacket_in.valid => fourth_mPacket_in_arbiter.valid,
        fourth_sReady_out.ready => fourth_sReady_out_arbiter.ready,
    
        -- Mux out  
        mPacket_out.packet => mPacket_out_arbiter.packet, 
        mPacket_out.valid => mPacket_out_arbiter.valid,    
        sReady_in.ready => sReady_in_arbiter.ready
);

end arbiter_arch;