library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.noc_types.all;

entity noc is
 generic (M,N : integer:= 3);
 port(
  clk : in std_logic;
  reset : in std_logic;
  
  local_packet_in  : in link_m_f;
  local_ready_out : out link_m_b;
  
  local_packet_out  : out link_m_f;
  local_ready_in : in link_m_b
  );   
end noc;

architecture struct of noc is

------------------------------Signal declarations----------------------------
 signal north_in_f  : link_m_f;
 signal north_out_b : link_m_b;
 signal east_out_f  : link_m_f;
 signal east_in_b   : link_m_b;
 signal south_out_f : link_m_f;
 signal south_in_b  : link_m_b;
 signal west_in_f   : link_m_f;
 signal west_out_b  : link_m_b;
------------------------------------------------------------

begin

  router_m : for i in 0 to M-1 generate
    router_n : for j in 0 to N-1 generate
      router : entity work.router
        port map (
          clk => clk,
          rst => reset,

          router_north_packet_in => north_in_f(i)(j),
          router_north_ready_out => north_out_b(i)(j),
          router_east_packet_out  => east_out_f(i)(j),
          router_east_ready_in  => east_in_b(i)(j),
          router_south_packet_out => south_out_f(i)(j),
          router_south_ready_in => south_in_b(i)(j),
          router_west_packet_in  => west_in_f(i)(j),
          router_west_ready_out  => west_out_b(i)(j),
          
           -- Local input
          router_local_packet_in => local_packet_in(i)(j),
          router_local_ready_out => local_ready_out(i)(j),         
           -- Local output
          router_local_packet_out => local_packet_out(i)(j),
          router_local_ready_in => local_ready_in(i)(j)
          );
    end generate router_n;
  end generate router_m;

  --Interconnections
  links_m : for i in 0 to M-1 generate
    links_n : for j in 0 to N-1 generate
      top : if (i = 0) generate
        north_in_f(i)(j)    <= south_out_f(M-1)(j);
        north_out_b(i)(j)   <= south_in_b(M-1)(j);
      end generate top;
      left : if (j = 0) generate
        west_in_f(i)(j)    <= east_out_f(i)(N-1);
        west_out_b(i)(j)   <= east_in_b(i)(N-1);
      end generate left;
      bottom : if (i = (M-1) and j < (N-1)) generate
        west_out_b(i)(j+1) <= east_in_b(i)(j);
        west_in_f(i)(j+1)  <= east_out_f(i)(j);
      end generate bottom;
      right : if (i < (M-1) and j = (N-1)) generate
        north_out_b(i+1)(j) <= south_in_b(i)(j);
        north_in_f(i+1)(j)  <= south_out_f(i)(j);
      end generate right;
      center : if (i < (M-1) and j < (N-1)) generate
        north_in_f(i+1)(j)  <= south_out_f(i)(j);
        north_out_b(i+1)(j) <= south_in_b(i)(j);
        west_in_f(i)(j+1)   <= east_out_f(i)(j);
        west_out_b(i)(j+1)  <= east_in_b(i)(j);
      end generate center;
    end generate links_n;
  end generate links_m;
  
end struct;