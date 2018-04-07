package NOC.NOC_chisel

import Chisel._


class NOC_chisel(packet_width: Int = 96, no_of_routers: Int = 9) extends BlackBox {
	val io = new Bundle() {
			//INPUT
			val local_packet_in = Vec(no_of_routers, Bits(OUTPUT, width = packet_width))
			val local_valid_in = Vec(no_of_routers, Bits(OUTPUT, width = 1))
			val local_ready_out = Vec(no_of_routers, Bits(INPUT, width = 1))
			//OUTPUT
			val local_packet_out = Vec(no_of_routers, Bits(INPUT, width = packet_width))
			val local_valid_out = Vec(no_of_routers, Bits(INPUT, width = 1))
			val local_ready_in = Vec(no_of_routers, Bits(OUTPUT, width = 1))
			val i = Bits(OUTPUT, width = 1)
		} 

	setModuleName("noc_top")

	renameClock(clock, "clk")
	reset.setName("rst")

	var i = 0


	for( a <- 0 until no_of_routers){
		//INPUT
		io.local_packet_in(i).setName(f"local_packet_in_$i")
		io.local_valid_in(i).setName(f"local_valid_in_$i")
		io.local_ready_out(i).setName(f"local_ready_out_$i")
		//OUTPUT
		io.local_packet_out(i).setName(f"local_packet_out_$i")
		io.local_valid_out(i).setName(f"local_valid_out_$i")
		io.local_ready_in(i).setName(f"local_ready_in_$i")
	}

}