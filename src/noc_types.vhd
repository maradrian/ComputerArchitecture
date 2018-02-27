library ieee;
use ieee.std_logic_1164.all;

package noc_types is

constant ADDR_WIDTH		: positive := 32;
constant DATA_WIDTH		: positive := 32;
constant PACKET_WIDTH	: positive := 96;


type packet_m_type is record
	packet 		: std_logic_vector(PACKET_WIDTH-1 downto 0); 
	valid		: std_logic;
end record packet_m_type;

type packet_s_type is record
	ready		: std_logic;
end record packet_s_type;


type bus_master_type is record
	addr      : STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
	data      : STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
	valid 	  :	STD_LOGIC;
end record bus_master_type;

type bus_slave_type is record
	ready 	: STD_LOGIC;
end record bus_slave_type;

end package noc_types;

