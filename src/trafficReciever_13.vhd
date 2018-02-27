----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 01/03/2018 03:13:33 PM
-- Design Name:
-- Module Name: trafficReciever - Behavioral
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
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;
use work.noc_types.all;

entity trafficReceiver_13 is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           master_in : in bus_master_type;
           slave_out : out bus_slave_type
            );
end trafficReceiver_13;

architecture Behavioral of trafficReceiver_13 is
    signal cnt : std_logic_vector(2 downto 0);
    signal ready_sig : std_logic := '0';
begin

WRITE_FILE: process (clk, master_in.valid)
  variable VEC_LINE : line;
  variable num : integer := 1;
  file cmdfile : text open write_mode is "testvecs13.out";
begin
--- ********* I HAVE A OFF-BY-ONE IN THE END OF THIS.
  if rising_edge(clk) then


    --if cnt = "011" or cnt = "010" then
        --slave_out.ready <='0'; -- you can play with this signal
        --ready_sig <= '0';
    --else
        slave_out.ready <= '1';
        ready_sig <= '1';
    --end if;
    --elsif (master_in.valid = '1' AND cnt = "11") then
    --elsif (master_in.valid = '1') then
    if (master_in.valid = '1' and ready_sig = '1') then
        write(VEC_LINE, string'("Num:"));
        write(VEC_LINE,num-1);
        write(VEC_LINE, string'(" "));
        write(VEC_LINE, string'("Data:"));
        hwrite(VEC_LINE, master_in.data,RIGHT,2);
        write(VEC_LINE, string'(" "));
        write(VEC_LINE, string'("Addr:"));
        hwrite(VEC_LINE, master_in.addr,RIGHT,2);
        writeline(cmdfile, VEC_LINE);
        num := num + 1;
    end if;
  end if;
  --FILE_CLOSE(cmdfile);
end process WRITE_FILE;

seq: process(clk, rst)
begin
    if (rst = '1') then
        --slave_out.ready <= '1';
        cnt <= (others => '0');
    elsif rising_edge(clk) then
        cnt <= cnt + '1';
    end if;
end process;
end Behavioral;
