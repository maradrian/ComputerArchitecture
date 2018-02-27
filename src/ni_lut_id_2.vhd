-- Route look-up table for NoC-NI Id 2

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

-- LUT interface description
ENTITY ni_lut_id_2 IS
  PORT (
    dst_addr : in std_logic_vector (3 DOWNTO 0);      -- Destination address, 4-bit
    route    : out std_logic_vector (20 DOWNTO 0) );  -- Routing information, 21-bit
END ni_lut_id_2;

-- LUT architecture description
ARCHITECTURE ni_lut_id_2_arch OF ni_lut_id_2 IS

BEGIN

  route <= "001001100000000000000" WHEN dst_addr = "0000" else
           "001001001100000000000" WHEN dst_addr = "0001" else
           "100000000000000000000" WHEN dst_addr = "0010" else
           "001100000000000000000" WHEN dst_addr = "0011" else
           "001001010100000000000" WHEN dst_addr = "0100" else
           "001001001010100000000" WHEN dst_addr = "0101" else
           "010100000000000000000" WHEN dst_addr = "0110" else
           "001010100000000000000" WHEN dst_addr = "0111" else
           "001001010010100000000" WHEN dst_addr = "1000" else
           "001001001010010100000" WHEN dst_addr = "1001" else
           "010010100000000000000" WHEN dst_addr = "1010" else
           "001010010100000000000" WHEN dst_addr = "1011" else
           "001001010010010100000" WHEN dst_addr = "1100" else
           "001001001010010010100" WHEN dst_addr = "1101" else
           "010010010100000000000" WHEN dst_addr = "1110" else
           "001010010010100000000" WHEN dst_addr = "1111" else
           "100000000000000000000";

END ni_lut_id_2_arch;
