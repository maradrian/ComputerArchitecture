----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 01/13/2018 09:49:01 AM
-- Design Name:
-- Module Name: trafficGenerator - Behavioral
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
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use work.noc_types.all;
-- file-handling
use IEEE.std_logic_textio.all;
use STD.textio.all;

entity trafficGenerator_5 is
port (
  clk: in  STD_LOGIC;
  rst: in  STD_LOGIC;
  debug_next : out bus_master_type;
  debug_sig2 : out  std_logic_vector(2 downto 0);
  debug_sig : out  std_logic_vector(2 downto 0);
  slave_in : in bus_slave_type;
  master_out : out bus_master_type
 );
end trafficGenerator_5;

architecture Behavioral of trafficGenerator_5 is
    signal flag: std_logic := '0';
    signal cnt : std_logic_vector(2 downto 0);
    signal waitCC : std_logic_vector(2 downto 0);
    signal m_o_reg, m_o_next : bus_master_type := (data => (others => '0'), addr => (others => '0') ,valid => '0');
begin

debug_sig <= cnt;
debug_sig2 <= waitCC;
debug_next <= m_o_next;
master_out <= m_o_reg;

read_file: block
begin

    process
     file file_input : text;
     variable good: boolean; -- for verifing that read went well
     variable done_reading : boolean := false;
     variable c : integer := 1; -- for indexing values on displaying values
     variable line_in, line_out : line;
     variable fileIn_data, fileIn_addr : std_logic_vector(31 downto 0) := (others => '0');
     variable fileIn_timeStamp : std_logic_vector(2 downto 0) := (others => '0');
     variable fileIn_valid : std_logic := '0';
      begin
        file_open(file_input, "testvecs5.in", read_mode);

        wait until rst = '0' and rising_edge(clk);
        if (not done_reading) then
        done_reading := true;
              while not endfile(file_input) loop
                if (slave_in.ready = '1') then
                    readline(file_input,line_in);  -- Read a line from the file
                    next when line_in'length = 0;  -- Skip empty lines
                    hread(line_in,fileIn_data,good);
                    hread(line_in,fileIn_addr,good);
                    read(line_in,fileIn_timeStamp,good);
                    read(line_in,fileIn_valid,good);

                    m_o_next.data <= fileIn_data;
                    m_o_next.addr <= fileIn_addr;

                    if(fileIn_timeStamp = "000") then
                        m_o_next.valid <= fileIn_valid;
                        waitCC <= "000";
                        flag <= '1';
                    else
                        m_o_next.valid <= '0';
                        waitCC <= fileIn_timeStamp - 1;
                        flag <= '0';
                    end if;
                    wait until rst = '0' and rising_edge(clk);

                    if (flag = '1') then
                        -- do nothing
                    elsif (waitCC /= "000") then
                        while (waitCC /= "000") loop
                           waitCC <= waitCC - '1';
                           m_o_next.valid <= '0';
                         wait until rst = '0' and rising_edge(clk);
                        end loop;
                        --Counted down, set the data
                        m_o_next.valid <= fileIn_valid;
                        wait until rst = '0' and rising_edge(clk);
                    else
                        -- Do not need to wait
                        m_o_next.valid <= fileIn_valid;
                        wait until rst = '0' and rising_edge(clk);
                    end if;

                    --- *** Display what we just read
                    write(line_out, string'("Run:"));
                    write(line_out,c-1);
                    write(line_out, string'(" "));
                    write(line_out, string'("Data:"));
                    hwrite(line_out,fileIn_data,RIGHT,2);
                    write(line_out, string'(" "));
                    write(line_out, string'("Addr:"));
                    hwrite(line_out,fileIn_addr,RIGHT,2);
                    write(line_out, string'(" "));
                    write(line_out, string'("Valid:"));
                    write(line_out,fileIn_valid,RIGHT,2);
                    writeline(OUTPUT,line_out);
                    c := c + 1;
                 else
                   --exit;
                    wait until rst = '0' and rising_edge(clk);
             end if;
            end loop;
        end if;
        -- set everything to zero when end of file.
        m_o_next <= (data => (others => '0'), addr => (others => '0') ,valid => '0');
    --end if;
        file_close(file_input);
end process;
end block;

seq: process(clk, rst)
begin
    if (rst = '1') then
        m_o_reg <= (data => (others => '0'), addr => (others => '0') ,valid => '0');
        cnt <= (others => '0');
    elsif rising_edge(clk) then
        if (waitCC = cnt) then
            cnt <= (others => '0');
        else
            cnt <= cnt + '1';
        end if;
        m_o_reg <= m_o_next;
    end if;
end process;
end Behavioral;
