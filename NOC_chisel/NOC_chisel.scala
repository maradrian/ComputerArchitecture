package NOC_chisel


class NOC_chisel(packet_width: Int = 96) extends Blackbox{
	val io = new Bundle() {
			//INPUT
			val local_packet_in = Vec(9, BITS(OUTPUT, width = packet_width))
			val local_valid_in = Vec(9, BITS(OUTPUT, width = 1))
			val local_ready_out = Vec(9, BITS(INPUT, width = 1))
			//OUTPUT
			val local_packet_out = Vec(9, BITS(INPUT, width = packet_width))
			val local_valid_out = Vec (9, BITS(INPUT, width = 1))
			val local_ready_in = Vec(9, BITS(OUTPUT, width = 1))

		} with NOC_chisel.Pins

	setModuleName("noc_top")

	renameClock(clock, clk)
	reset.setName("rst")

	var i = 0;

	
	for( a <- 0 to 8){
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