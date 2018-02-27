----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/10/2018 08:39:11 AM
-- Design Name: 
-- Module Name: fifo - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fifo is
    generic (WIDTH: positive := 6);
    port( clk, rst : in std_logic;
          mPacket_in : in packet_m_type;
          mPacket_out : out packet_m_type;
          sReady_in: in packet_s_type;
          sReady_out: out packet_s_type
    );
end fifo;

architecture Behavioral of fifo is

signal wPtr, rPtr : integer range 0 to WIDTH-1 := 0;

type memory_type is array (0 to WIDTH-1) of std_logic_vector(95 downto 0);
signal memory : memory_type :=(others => (others => '0'));   --memory for queue

signal w_FULL  : std_logic;
signal w_EMPTY : std_logic;
signal num_elem : integer := 0; 

begin

process(clk)

begin
if(rising_edge(Clk)) then
    if(rst = '1') then
        rPtr <= 0;
        wPtr <= 0;
        num_elem <= 0;
    else
    -- Keeps track of the total number of words in the FIFO
    if mPacket_in.valid = sReady_in.ready and mPacket_in.valid = '1' and w_FULL = '0' and w_EMPTY = '0' then
         
    elsif (mPacket_in.valid = '1' and w_FULL = '0') then
         num_elem <= num_elem + 1;
    elsif (sReady_in.ready = '1' and w_EMPTY = '0') then
         num_elem <= num_elem - 1;
    end if;
    
    -- Keeps track of the write pointer (and controls roll-over)
    if (mPacket_in.valid = '1' and w_FULL = '0') then
        if wPtr = WIDTH-1 then
            wPtr <= 0;
        else
            wPtr <= wPtr + 1;
        end if;
    end if;
    
    -- Keeps track of the read pointer (and controls roll-over)        
    if (sReady_in.ready = '1' and w_EMPTY = '0') then
        if rPtr = WIDTH-1 then
            rPtr <= 0;
        else
            rPtr <= rPtr + 1;
        end if;
    end if;   
    
    -- Registers the input data when there is a write
    if (mPacket_in.valid = '1' and w_FULL = '0') then
        memory(wPtr) <= mPacket_in.packet;
    end if;
    
    end if;
end if;
end process;

  mPacket_out.packet <= memory(rPtr);
 
  w_FULL  <= '1' when num_elem = WIDTH else '0';
  w_EMPTY <= '1' when num_elem = 0 else '0';
 
  sReady_out.ready <= not(w_FULL);
  mPacket_out.valid <= not(w_EMPTY);


end Behavioral;
